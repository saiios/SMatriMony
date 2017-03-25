//
//  DailyRecommendations.m
//  Smatrimony
//
//  Created by INDOBYTES on 16/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "DailyRecommendations.h"

@interface DailyRecommendations ()

@end

@implementation DailyRecommendations

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    inbox_ary =@[@"INBOX",@"SENT",@"DROP",@"IMPORTANT",@"TRASH"];
    
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
           
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    
    [self daily_matches:dict];
}

-(void)daily_matches:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/dailyMatches" parameters:Dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             daily_matches=[res_dict valueForKey:@"dailymatches"];
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             if (daily_matches.count!=0)
             {
                 [self updatePage];
             }
             else
                 [self Alert:@"No Recommendations Found!"];
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PagerViewDataSource
-(void)updatePage
{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.view.autoresizesSubviews =YES;
    
    //self.pageController.view.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    DR_vc *initialViewController = [self viewControllerAtIndex:s_index];
    
    // initialViewController.delegate =self;
    initialViewController.contentArray = @[@"test"];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [_profileTableBgView addSubview:self.pageController.view];
    [self.pageController.view setFrame:CGRectMake(0,0,_profileTableBgView.bounds.size.width, _profileTableBgView.bounds.size.height)];
    
    [self.pageController didMoveToParentViewController:self];
}

- (DR_vc *)viewControllerAtIndex:(NSUInteger)index
{
    if (daily_matches.count>index)
    {
    NSString *dob=[NSString stringWithFormat:@"%@",[[daily_matches valueForKey:@"birthdate"]objectAtIndex:index]];
    s_index=index;
    DR_vc *childViewController = [[DR_vc alloc] initWithNibName:@"msg_vc" bundle:nil];
        childViewController.Daily_delegate=self;
    childViewController.contentArray =@[@""];
    childViewController.name=[[daily_matches valueForKey:@"username"]objectAtIndex:index];
    childViewController.str=[[daily_matches valueForKey:@"birthdate"]objectAtIndex:index];
    childViewController.m_id=[[daily_matches valueForKey:@"matri_id"]objectAtIndex:index];
    
    childViewController.height=[[daily_matches valueForKey:@"height"]objectAtIndex:index];
    childViewController.img=[[daily_matches valueForKey:@"photo1"]objectAtIndex:index];;
    childViewController.address=[[daily_matches valueForKey:@"address"]objectAtIndex:index];
    childViewController.index = index;
    childViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.pageController.view.frame.size.height);
    return childViewController;
    }
    return NULL;
}

#pragma mark TabsView
-(void)Daily_Detail:(int)tag
{
    ProfileViewController *profile = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    NSString *clickedIndex = [NSString stringWithFormat:@"%ld",tag];
    profile.ClickedmatriId = clickedIndex;
    [self.navigationController pushViewController:profile animated:YES];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [(DR_vc *)viewController index];
    if (index == 0)
    {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(DR_vc *)viewController index];
    
    index++;
    if (index == [inbox_ary count]) {
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
        
        if (presentIndex <= inbox_ary.count-1)
        {
            //            [self.tabsView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            //            [self.tabsView reloadData];
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
             // [self.tabsView reloadData];
             
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
@end
