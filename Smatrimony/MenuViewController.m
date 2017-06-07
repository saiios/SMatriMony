//
//  MenuViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 02/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "MenuViewController.h"
#import "searchPopupVIew.h"
#import "JMOTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PageViewController.h"
#import "PageCollectionViewCell.h"
#import "ProfileViewController.h"
#import "EditProfileViewController.h"
#import "id_search_ViewController.h"
#import "Assisted_Services_ViewController.h"
#import "Safe_Matrimony_ViewController.h"

@interface MenuViewController ()<profileTable>
{
    float lat;
    float lon;
    NSString *nearBycity;
    NSString * genderStatus;
}

@end

@implementation MenuViewController
-(void)viewWillAppear:(BOOL)animated
{
    user_inf=[NSUserDefaults standardUserDefaults];
    matri_id=[user_inf valueForKey:@"matri_id"];
    profile_pic=[user_inf valueForKey:@"profile_pic"];
   
    
    if ([profile_pic isEqual:[NSNull null]]|| [profile_pic isEqualToString:@""])
    {
        if ([genderStatus isEqualToString:@"Groom"]) {
            _profileImageVIew.image = [UIImage imageNamed:@"male"];
        }
        else
        {
            _profileImageVIew.image = [UIImage imageNamed:@"female"];
        }
    }
    else
    {
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",profile_pic]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               _profileImageVIew.image = [UIImage imageWithData:imageData];
                               _profileImageVIew.contentMode = UIViewContentModeScaleToFill;
                           });
        });
    }
    _mat_id.text=matri_id;
    _username.text=_user_name_str;
   // [self viewDidLoad];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
     [[NSUserDefaults standardUserDefaults]setObject:@"User_Dashboard" forKey:@"Re_Open"];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    [self getLocationCity];
    
    self.navigationController.navigationBar.hidden =YES;
    leftMenuArray = @[@"My Matches",@"Mailbox",@"Daily Recommendations",@"Edit Profile",@"Upgrade Account",@"Settings",@"Feedback",@"Rate Us",@"Success Stories",@"Messages",@"Logout"];
    
    user_inf=[NSUserDefaults standardUserDefaults];
    pay_status=[user_inf valueForKey:@"status"];
    genderStatus = [user_inf valueForKey:@"gender"];
    
    //FB
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    if ([pay_status isEqualToString:@"Paid"])
    {
        leftMenuArray = @[@"My Matches",@"Mailbox",@"Daily Recommendations",@"Edit Profile",@"Upgrade Account",@"Current Plan",@"Settings",@"Feedback",@"Rate Us",@"Success Stories",@"Messages",@"Logout"];
        leftMenu_imgs = @[@"My_Matches",@"Mail_Box",@"Daily_Recomendations",@"Edit_Profile",@"upgrade",@"Current_Plan",@"Settings",@"Feedback",@"Rate_us",@"Success_Story",@"Messages",@"logout"];
    }
    else
    {
        leftMenuArray = @[@"My Matches",@"Mailbox",@"Daily Recommendations",@"Edit Profile",@"Upgrade Account",@"Settings",@"Feedback",@"Rate Us",@"Success Stories",@"Messages",@"Logout"];
         leftMenu_imgs = @[@"My_Matches",@"Mail_Box",@"Daily_Recomendations",@"Edit_Profile",@"upgrade",@"Settings",@"Feedback",@"Rate_us",@"Success_Story",@"Messages",@"logout"];
    }
    
    menu_ary=@[@"Help Center",@"Contact Us",@"Assisted Services",@"Safe Matrimony"];
    _leftMenuTable.delegate =self;
    [_leftMenuTable createView:_leftMenuTable.frame];
    
    
    _leftMenuBgView.frame = [UIScreen mainScreen].bounds;
    leftmenuRect = _leftMenuContentView.frame;
    cellSelectionBar = [[UIView alloc] init];
    cellSelectionBar.tag = 50;
    
    tabsArray =@[@"Matches",@"Recently Joined",@"Short Listed", @"Viewed Profiles",@" Profile Views",@"I Viewed",@"Viewed Contacts",@"Near You",@"ID Search"];
    [self createTabsView];
    [self updatePage];

    // Do any additional setup after loading the view from its nib.
}


-(void)getLocationCity{
    
    lat =   locationManager.location.coordinate.latitude;
    lon =   locationManager.location.coordinate.longitude;
    
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:lat longitude:lon]; //insert your coordinates
    
    [ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
                  if (placemark) {
                      
                      
                      NSLog(@"placemark %@",placemark);
                      //String to hold address
                      NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                      NSLog(@"addressDictionary %@", placemark.addressDictionary);
                      
                      NSLog(@"placemark %@",placemark.region);
                      NSLog(@"placemark %@",placemark.country);  // Give Country Name
                      NSLog(@"placemark %@",placemark.locality); // Extract the city name
                      NSLog(@"location %@",placemark.name);
                      NSLog(@"location %@",placemark.ocean);
                      NSLog(@"location %@",placemark.postalCode);
                      NSLog(@"location %@",placemark.subLocality);
                      
                      NSLog(@"location %@",placemark.location);
                      nearBycity = [NSString stringWithFormat:@"%@",placemark.subLocality];
                      //Print the location to console
                      NSLog(@"I am currently at %@",locatedAt);
                  }
                  else {
                      NSLog(@"Could not locate");
                  }
              }
     ];
}


-(void)viewDidAppear:(BOOL)animated{
    [_leftMenuTable updateInstaceFrame:CGRectMake(_leftMenuTable.frame.origin.x,_leftMenuTable.frame.origin.y,_leftMenuTable.frame.size.width,_leftMenuTable.frame.size.height)];
    
    
}


-(void)closeMenu{
    isMenuActive = NO;
  
    
    [UIView animateWithDuration:0.5 animations:^{
        _leftMenuContentView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width,0, leftmenuRect.size.width, leftmenuRect.size.height);
        
        _leftMenuBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
    } completion:^(BOOL finished) {
        [_leftMenuBgView removeFromSuperview];
        
    }];

    
}
- (IBAction)openLeftMenu:(id)sender {
    isMenuActive =YES;
    _leftMenuBgView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_leftMenuBgView];
    _leftMenuBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    _leftMenuContentView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width,0, leftmenuRect.size.width, leftmenuRect.size.height);
      [_leftMenuTable updateInstaceFrame:CGRectMake(_leftMenuTable.frame.origin.x,_leftMenuTable.frame.origin.y,_leftMenuTable.frame.size.width,_leftMenuTable.frame.size.height)];

    
   
    [UIView animateWithDuration:0.5 animations:^{
        _leftMenuContentView.frame =CGRectMake(0,0, leftmenuRect.size.width, leftmenuRect.size.height);
        _leftMenuBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
    
}



- (IBAction)closeLeftMenu:(id)sender {
    [self closeMenu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark LeftMenu Delegates
-(float)setHeighForSearchTable:(UITableView *)tableView
{
    return 50;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger )numberOffRowsInSearchTableView:(UITableView *)tableView
{
    return leftMenuArray.count;
}

- (JMOTableViewCell *)cellforRowAtSearchINdex:(UITableView*)tableVIew viewAtIndex:(NSIndexPath *)index
{
    
    JMOTableViewCell *cell = [tableVIew dequeueReusableCellWithIdentifier:@"searchCell"];
    if (cell==nil)
    {
        [tableVIew registerNib:[UINib nibWithNibName:@"JMOTableViewCell" bundle:nil] forCellReuseIdentifier:@"searchCell"];
        cell = [tableVIew dequeueReusableCellWithIdentifier:@"searchCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //text
    if (index.section==1)
    {
        cell.labelName.text =[menu_ary objectAtIndex:index.row];
    }
    else
    cell.labelName.text =[leftMenuArray objectAtIndex:index.row];
    
    //images
    if (index.section==1)
    {
       
            
            cell.img.image=[UIImage imageNamed:[ leftMenu_imgs objectAtIndex:index.row]];
   }
    else
        
        cell.img.image=[UIImage imageNamed:[leftMenu_imgs objectAtIndex:index.row]];
   return cell;
    
}
-(void)searchTableViewSelected:(UITableView *)table IndexPath:(NSIndexPath * )indexPath
{

    if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            [self faq];
        }
        else if (indexPath.row==1)
        {
            [self contact_us];
        }
        else if(indexPath.row == 2)
        {
            [self assisted_Services];
        }
        else if (indexPath.row == 3)
        {
            [self safe_matrimony];
        }
    }
    else{
    if (indexPath.row==0)
    {
    }
    else if (indexPath.row==1)
    {
        Mail *menuController  =[[Mail alloc]initWithNibName:@"Mail" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
    }
    else if (indexPath.row==2)
    {
        NSLog(@"DailyRecommendations");
        DailyRecommendations *menuController  =[[DailyRecommendations alloc]initWithNibName:@"DailyRecommendations" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
    }
    else if (indexPath.row==3)
    {
        [self edit_profile];
    }
    else if (indexPath.row==4)
    {
        NSLog(@"Update Account");
        [self upgrade_account];
    }
    if ([pay_status isEqualToString:@"Paid"])
    {
        if (indexPath.row==5)//current plan
        {
            [self current_plan];
        }
        else if (indexPath.row==6)//settings
        {
            [self settings];
        }
        else if (indexPath.row==7)//feedback
        {
            [self feedback];
        }
        else if (indexPath.row==8)//rate us
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/app/viewContentsUserReviews?id=1155115857"]];
        }
        else if (indexPath.row==9)
        {
            [self Success_Stories];
        }
        else if (indexPath.row==10)
        {
            [self Messages];
        }
        else if (indexPath.row==11)
        {
            [self logout];
        }
    }
    else
    {
    if (indexPath.row==5)//settings
    {
        [self settings];
    }
    else if (indexPath.row==6)//feedback
    {
        [self feedback];
    }
    else if (indexPath.row==7)//rate us
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/app/viewContentsUserReviews?id=1155115857"]];
    }
    else if (indexPath.row==8)
    {
        [self Success_Stories];
    }
    else if (indexPath.row==9)
    {
        [self Messages];
    }
    else if (indexPath.row==10)
    {
        [self logout];
    }
    }
    }
    [self closeMenu];
}
-(void)faq
{
    FAQ *menuController  =[[FAQ alloc]initWithNibName:@"FAQ" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

-(void)current_plan
{
    current_plan *menuController  =[[current_plan alloc]initWithNibName:@"current_plan" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];   
}
-(void)edit_profile
{
    EditProfileViewController *editProfileViewController  =[[EditProfileViewController alloc]initWithNibName:@"EditProfileViewController" bundle:nil];
    [self.navigationController pushViewController:editProfileViewController animated:YES];
}


-(void)upgrade_account
{
    upgrade *menuController  =[[upgrade alloc]initWithNibName:@"upgrade" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}
-(void)feedback
{
    Feedback *menuController  =[[Feedback alloc]initWithNibName:@"Feedback" bundle:nil];
    menuController.username=_user_name_str;
    [self.navigationController pushViewController:menuController animated:YES];
}

-(void)contact_us
{
    contact_us *menuController  =[[contact_us alloc]initWithNibName:@"contact_us" bundle:nil];
    menuController.From=@"Contact Us";
    [self.navigationController pushViewController:menuController animated:YES];
}
-(void)assisted_Services
{
    Assisted_Services_ViewController *menuController  =[[Assisted_Services_ViewController alloc]initWithNibName:@"Assisted_Services_ViewController" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}
-(void)safe_matrimony
{
    contact_us *menuController  =[[contact_us alloc]initWithNibName:@"contact_us" bundle:nil];
    menuController.From=@"Safe Matrimony";
    [self.navigationController pushViewController:menuController animated:YES];

}
-(void)settings
{
    Settings *menuController  =[[Settings alloc]initWithNibName:@"Settings" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

-(void)Success_Stories
{
    Success_Stories *menuController  =[[Success_Stories alloc]initWithNibName:@"Success_Stories" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

-(void)Messages
{
    Messages *menuController  =[[Messages alloc]initWithNibName:@"Messages" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

-(void)logout
{
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    //fb
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/logout" parameters:dict requestNumber:WUS_logout showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             [self Alert:result];
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
         user_inf=[NSUserDefaults standardUserDefaults];
         [user_inf setValue:@"" forKey:@"matri_id"];
         [user_inf setValue:@"" forKey:@"email_id"];
         
         LoginViewController *menuController  =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
         [self.navigationController pushViewController:menuController animated:YES];
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
                                   // NSLog(@"Completed");
                                }];
}

#pragma mark TabsView
-(void)clickedProfileTable:(NSIndexPath *)index selectedMatriId:(NSString *)selectedMatriId

{
    ProfileViewController *profile = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    NSString *clickedIndex = [NSString stringWithFormat:@"%ld",(long)index.row];
    
    //profile.ClickedmatriId = clickedIndex; // CHANGE
    profile.ClickedmatriId = selectedMatriId;
    [self.navigationController pushViewController:profile animated:YES];
}


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
    
    PageViewController *initialViewController = [self viewControllerAtIndex:0];
    
   initialViewController.delegate =self;
    initialViewController.contentArray = @[@"test",@"tets"];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [_profileTableBgView addSubview:self.pageController.view];
    [self.pageController.view setFrame:CGRectMake(0,0,_profileTableBgView.bounds.size.width, _profileTableBgView.bounds.size.height)];
    
    [self.pageController didMoveToParentViewController:self];
    
}

- (PageViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    PageViewController *childViewController = [[PageViewController alloc] initWithNibName:@"PageViewController" bundle:nil];
     childViewController.delegate =self;
    //  NSLog(@"test :%@",[newsContentDic objectForKey:[[newsArray objectAtIndex:index] valueForKey:@"name"]]);
    childViewController.contentArray =@[@"",@""];
    childViewController.index = index;
    childViewController.city = nearBycity;
      //childViewController.city = @"Guntur";//test
    childViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.pageController.view.frame.size.height);
    
    return childViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PageViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PageViewController *)viewController index];
    
    index++;
    if (index == [tabsArray count])
    {
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
        
        
        if (presentIndex <= tabsArray.count-1) {
            
            
            [self.tabsView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            [self.tabsView reloadData];
            
        }
    }
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
   // cell.categoryTitle.textColor = [UIColor greenColor];
    
    if (presentIndex == indexPath.row) {
        NSLog(@"%ld",(long)indexPath.row);
        float kk = self.view.frame.size.width/3;
        cellSelectionBar.frame = CGRectMake(5, collectionView.frame.size.height-2,150,3);
        
        cellSelectionBar.backgroundColor = [UIColor colorWithRed:172/255.0f green:0/255.0f blue:21/255.0f alpha:1.0];
        cellSelectionBar.tag = 500;
        [cell.contentView addSubview:cellSelectionBar];
        cell.categoryTitle.textColor = [UIColor blackColor];
        cell.categoryTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        cell.categoryTitle.font = [UIFont boldSystemFontOfSize:12];
        cell.categoryTitle.textAlignment = NSTextAlignmentCenter;
        
    }
    else
    {
        for (UIView *vi in cell.contentView.subviews) {
            if (vi.tag == 50) {
                [vi removeFromSuperview];
                
            }
        }
        
        cell.categoryTitle.textColor = [UIColor whiteColor];
        cell.categoryTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        cell.categoryTitle.font = [UIFont boldSystemFontOfSize:12];
        
    }
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(150, 50);
}

-(void)clicked:(UIButton *)sender{
        
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PageViewController *initialViewController = [self viewControllerAtIndex:indexPath.row];
    initialViewController.delegate =self;
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
// [self loadNewsForCat:[[newsArray objectAtIndex:index]valueForKey:@"url"]];

- (IBAction)profile_click:(id)sender
{
    All_photos *profile = [[All_photos alloc]initWithNibName:@"All_photos" bundle:nil];
    [self.navigationController pushViewController:profile animated:YES];
}
- (IBAction)idSearchAction:(id)sender {
    id_search_ViewController *menuController  =[[id_search_ViewController alloc]initWithNibName:@"id_search_ViewController" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];

}

- (IBAction)editAction:(id)sender {
    [self edit_profile];
   
}
-(void)gotoUpgrade:(NSString *)selectedMatriId
{
    upgrade *pgrade = [[upgrade alloc]initWithNibName:@"upgrade" bundle:nil];
    [self.navigationController pushViewController:pgrade animated:YES];
}
-(void)gotoUpgradeAcc:(NSDictionary *)upGradeDictonary
{
    upgrade *pgrade = [[upgrade alloc]initWithNibName:@"upgrade" bundle:nil];
    [self.navigationController pushViewController:pgrade animated:YES];
    
}
- (IBAction)chatAction:(id)sender {
    MembersMainControllerViewController * Obj = [[MembersMainControllerViewController alloc]initWithNibName:@"MembersMainControllerViewController" bundle:nil];
    [self.navigationController pushViewController:Obj animated:YES];
}
@end
