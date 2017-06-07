//
//  Mail.m
//  Smatrimony
//
//  Created by INDOBYTES on 15/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Mail.h"

@interface Mail ()

@end

@implementation Mail

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    inbox_ary =@[@"PENDING",@"ACCEPTED",@"DECLINED"];
    sent_ary =@[@"ALL",@"AWAITING REPLY"];

    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    Mail_tag=@"INBOX";
    
    cellSelectionBar = [[UIView alloc] init];
    cellSelectionBar.tag = 50;
    [_tabsView registerNib:[UINib nibWithNibName:@"PageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PagecollectionviewCell"];
    
    tabsArray =@[@"INBOX",@"SENT",@"DRAFT",@"TRASH",@"IMPORTANT"];
    
    [self createTabsView];
    [self updatePage];
}



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
    
    view_controller *initialViewController = [self viewControllerAtIndex:0];
    
   // initialViewController.delegate =self;
//    initialViewController.contentArray = @[@"test",@"tets"];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [_profileTableBgView addSubview:self.pageController.view];
    [self.pageController.view setFrame:CGRectMake(0,0,_profileTableBgView.bounds.size.width, _profileTableBgView.bounds.size.height)];
    
    [self.pageController didMoveToParentViewController:self];
}

- (view_controller *)viewControllerAtIndex:(NSUInteger)index
{
    view_controller *childViewController = [[view_controller alloc] initWithNibName:@"view_controller" bundle:nil];
    childViewController.msgSendObj_delegate = self;    //  NSLog(@"test :%@",[newsContentDic objectForKey:[[newsArray objectAtIndex:index] valueForKey:@"name"]]);
    childViewController.index = index;
    childViewController.mail_tag = Mail_tag;
    childViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.pageController.view.frame.size.height);
    
    return childViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [(view_controller *)viewController index];
    if (index == 0)
    {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [(view_controller *)viewController index];
    index++;
    
    if ([Mail_tag isEqualToString:@"SENT"])
    {
        if (index == [sent_ary count])
        {
            return nil;
        }
    }
    else
    {
        if (index == [inbox_ary count])
        {
            return nil;
        }
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
        
        if ([Mail_tag isEqualToString:@"SENT"])
        {
            if (presentIndex <= sent_ary.count-1)
            {
                [self.tabsView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
                [self.tabsView reloadData];
            }
        }
        else
        {
        if (presentIndex <= inbox_ary.count-1)
        {
            [self.tabsView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            [self.tabsView reloadData];
        }
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SENT_click:(id)sender
{
    _mail_view.hidden=YES;
    _titlee.text=@"SENT";
    Mail_tag=@"SENT";
    [_tabsView reloadData];
    //[self viewControllerAtIndex:0];
    presentIndex=0;
    [self.tabsView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [_tabsView reloadData];
    [self createTabsView];
    [self updatePage];
}

- (IBAction)inbox_click:(id)sender
{
    _mail_view.hidden=YES;
    _titlee.text=@"INBOX";
    Mail_tag=@"INBOX";
    [_tabsView reloadData];
    //[self viewControllerAtIndex:0];
    presentIndex=0;

     [self.tabsView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [_tabsView reloadData];
    [self createTabsView];
    [self updatePage];
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

- (IBAction)title_click:(id)sender
{
    _mail_view.hidden=NO;
}

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - CollectionView
- (NSInteger)numberOfColumnsInFlowLayout:(UICollectionViewFlowLayout *)flowlayout
{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([Mail_tag isEqualToString:@"INBOX"])
    {
    return inbox_ary.count;
    }
    else if ([Mail_tag isEqualToString:@"SENT"])
    {
        return sent_ary.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PagecollectionviewCell";
    
    PageCollectionViewCell   *cell =(PageCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ([Mail_tag isEqualToString:@"INBOX"])
    {
        cell.categoryTitle.text = [inbox_ary objectAtIndex:indexPath.row];
    }
    else if ([Mail_tag isEqualToString:@"SENT"])
    {
        cell.categoryTitle.text = [sent_ary objectAtIndex:indexPath.row];
    }

    
    if (presentIndex == indexPath.row) {
        NSLog(@"%ld",(long)indexPath.row);
        float kk = self.view.frame.size.width/3;
        cellSelectionBar.frame = CGRectMake(5, collectionView.frame.size.height-2,100,3);
        
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 50);
}

-(void)clicked:(UIButton *)sender{
    
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    view_controller *initialViewController = [self viewControllerAtIndex:indexPath.row];
    // initialViewController.delegate =self;
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
   // initialViewController.contentArray =@[@"",@""];
    
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

// delegate



-(void)sendmail_click:(NSIndexPath *)index
{
    msg_send *menuController  =[[msg_send alloc]initWithNibName:@"msg_send" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
    
}


@end
