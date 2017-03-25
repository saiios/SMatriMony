//
//  Messages.m
//  Smatrimony
//
//  Created by INDOBYTES on 16/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "upgrade.h"

@interface upgrade ()
@end

@implementation upgrade

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tabsArray=[[NSMutableArray alloc]init];
    //tabsArray =@[@"INBOX",@"SENT",@"DRAFT",@"TRASH",@"IMPORTANT"];
    [self membership_duration];
}

-(void)membership_duration
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"api/membershipDurations" requestNumber:WUS_S_story showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
            
             if ([status isEqualToString:@"1"])
             {
                 NSArray *test_dict=[res_dict valueForKey:@"durationList"];
                 for (int i=0;i<test_dict.count ; i++)
                 {
                     NSString *duration=[[test_dict objectAtIndex:i]valueForKey:@"plan_duration"];
                     [tabsArray addObject:duration];
                 }
                 //tabsArray =@[@"0 months",@"1 months"];

                 user_inf=[NSUserDefaults standardUserDefaults];
                 NSString *matri_id=[user_inf valueForKey:@"matri_id"];
                 NSString *mail_id=[user_inf valueForKey:@"email_id"];
                 
                 NSMutableDictionary *dict = [NSMutableDictionary new];
                 [dict setObject:@"0 Months" forKey:@"plan_duration"];
                 
                 cellSelectionBar = [[UIView alloc] init];
                 cellSelectionBar.tag = 50;

                 [_tabsView registerNib:[UINib nibWithNibName:@"PageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PagecollectionviewCell"];
                 [_tabsView reloadData];
                 
                 [self createTabsView];
                 [self updatePage];

                 //[self inbox_msg:dict];
             }
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}
//
//-(void)inbox_msg:(NSDictionary *)Dict
//{
//    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/membershipPlans" parameters:Dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
//     {
//         if (success)
//         {
//             NSDictionary *res_dict=data;
////             NSDictionary *res_dict=[data valueForKey:@"dailymatches"];
//
//             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
//             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
//             
//             [self createTabsView];
//             [self updatePage];
//             
//         }
//         else
//         {
//             [self Alert:@"Something went wrong"];
//         }
//     }];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark paging
-(void)createTabsView
{
    [self.tabsView registerClass:[PageCollectionViewCell class] forCellWithReuseIdentifier:@"PagecollectionviewCell"];
    self.tabsView.backgroundColor = [UIColor clearColor];
    self.tabsView.showsHorizontalScrollIndicator =NO;
    
    //  self.tabsView.pagingEnabled =YES;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:10];
     
    // not iPad pro
    float kk = self.view.frame.size.width/3;
    [flowLayout setItemSize:CGSizeMake(kk+10,44)];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0,0,0)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.tabsView setCollectionViewLayout:flowLayout];
    [self.tabsView reloadData];
}

#pragma mark - PagerViewDataSource
-(void)updatePage
{
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.view.autoresizesSubviews =YES;
    
    //self.pageController.view.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    upgrade_vc *initialViewController = [self viewControllerAtIndex:0];
    
    // initialViewController.delegate =self;
    initialViewController.contentArray = @[@"test",@"tets"];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [_profileTableBgView addSubview:self.pageController.view];
    [self.pageController.view setFrame:CGRectMake(0,0,_profileTableBgView.bounds.size.width, _profileTableBgView.bounds.size.height)];
    
    [self.pageController didMoveToParentViewController:self];
}

- (upgrade_vc *)viewControllerAtIndex:(NSUInteger)index
{
    upgrade_vc *childViewController = [[upgrade_vc alloc] initWithNibName:@"upgrade_vc" bundle:nil];
    childViewController.contentArray =@[@"",@""];
    childViewController.upgrade_delegate=self;
    childViewController.index = index;
    childViewController.duration=[tabsArray objectAtIndex:index];
    childViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.pageController.view.frame.size.height);
    
    return childViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [(upgrade_vc *)viewController index];
    if (index == 0)
    {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(upgrade_vc *)viewController index];
    
    index++;
        if (index == [tabsArray count]) {
            return nil;
        }
    return [self viewControllerAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed)
    {
        NSUInteger currentIndex = [[self.pageController.viewControllers lastObject] index];
        path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        presentIndex = (int)currentIndex;
        
            if (presentIndex <= tabsArray.count-1)
            {
                [self.tabsView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
                [self.tabsView reloadData];
            }
    }
}

-(void)sent_service
{
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    NSString *email_id=[user_inf valueForKey:@"email_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:email_id forKey:@"email"];
    
    [self Sent_list:dict];
}

-(void)Sent_list:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/sentMailsList" parameters:Dict requestNumber:WUS_Sent_mail showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             [self.tabsView reloadData];
             
             [self Alert:result];
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)Alert:(NSString *)Msg
{
    NSDictionary *options = @{kCRToastNotificationTypeKey:@(CRToastTypeNavigationBar),
                              
                              kCRToastTextKey : Msg,
                              
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              
                              kCRToastBackgroundColorKey : [UIColor colorWithRed:13.0/255.0 green:147.0/255.0 blue:68.0/255.0 alpha:1],
                              kCRToastTimeIntervalKey: @(2),
                              //                              kCRToastFontKey:[UIFont fontWithName:@"PT Sans Narrow" size:23],
                              kCRToastInteractionRespondersKey:@[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeSwipeUp
                                                                  
                                                                                                                 automaticallyDismiss:YES
                                                                  
                                                                                                                                block:^(CRToastInteractionType interactionType){
                                                                                                                                    
                                                                                                                                    NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
                                                                                                                                }]],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              };
    
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                    NSLog(@"Completed");
                                }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)compose_click:(id)sender
{
     PaymentType_ViewController *menuController  =[[PaymentType_ViewController alloc]initWithNibName:@"PaymentType_ViewController" bundle:nil];
   // offline_payment *menuController  =[[offline_payment alloc]initWithNibName:@"offline_payment" bundle:nil];
    // payment_type *menuController  =[[payment_type alloc]initWithNibName:@"payment_type" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
    
//    msg_send *menuController  =[[msg_send alloc]initWithNibName:@"msg_send" bundle:nil];
//    [self.navigationController pushViewController:menuController animated:YES];
}

-(void)payment_click:(NSDictionary *)payment_dict
{
    PaymentType_ViewController *menuController  =[[PaymentType_ViewController alloc]initWithNibName:@"PaymentType_ViewController" bundle:nil];
    menuController.payment_dict=payment_dict;
    [self.navigationController pushViewController:menuController animated:YES];
}
-(void)reply_click:(id)sender
{
    Notifications *menuController  =[[Notifications alloc]initWithNibName:@"Notifications" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

#pragma mark - CollectionView
- (NSInteger)numberOfColumnsInFlowLayout:(UICollectionViewFlowLayout *)flowlayout
{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return tabsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PagecollectionviewCell";
    
    PageCollectionViewCell   *cell =(PageCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.categoryTitle.text = [tabsArray objectAtIndex:indexPath.row];
    
    if (presentIndex == indexPath.row)
    {
        NSLog(@"%ld",(long)indexPath.row);
        float kk = self.view.frame.size.width/3;
        cellSelectionBar.frame = CGRectMake(5, collectionView.frame.size.height-2,150,3);
        
        cellSelectionBar.backgroundColor = [UIColor colorWithRed:172/255.0f green:0/255.0f blue:21/255.0f alpha:1.0];
        cellSelectionBar.tag = 500;
        [cell.contentView addSubview:cellSelectionBar];
        cell.categoryTitle.textColor = [UIColor blackColor];
        //cell.categoryTitle.textAlignment = NSTextAlignmentCenter;
        
    }
    else
    {
        for (UIView *vi in cell.contentView.subviews) {
            if (vi.tag == 50) {
                [vi removeFromSuperview];
                
            }
        }
        
        cell.categoryTitle.textColor = [UIColor whiteColor];
        
        
    }
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 50);
}

-(void)clicked:(UIButton *)sender
{
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    upgrade_vc *initialViewController = [self viewControllerAtIndex:indexPath.row];
   // initialViewController.delegate =self;
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    initialViewController.contentArray =@[@"",@""];
    
    //initialViewController.currentIndex =presentIndex;
    if(presentIndex != indexPath.row)
    {
        if (presentIndex < indexPath.row)
        {
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
        else{
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
        }
        
    }
    presentIndex =(int)indexPath.row;
    
    [self.tabsView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [collectionView reloadData];
    
}

@end
