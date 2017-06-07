//
//  Agent_Dashboard.m
//  Smatrimony
//
//  Created by INDOBYTES on 10/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Agent_Dashboard.h"
#import "searchPopupVIew.h"
#import "JMOTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PageViewController.h"
#import "PageCollectionViewCell.h"
#import "ProfileViewController.h"
@interface Agent_Dashboard ()
{
    NSDictionary *recentMembers;
    NSString *enteredMatriId;
}
@end

@implementation Agent_Dashboard

-(void)viewWillAppear:(BOOL)animated
{
    agent_inf=[NSUserDefaults standardUserDefaults];
    F_id=[NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_id"]];
    F_Matri_id=[NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_matri_id"]];
    
    //image with cache
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/agent/img/uploaded/%@",[NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_pic"]]]];
    
    [manager downloadImageWithURL: imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         
         if(image)
         {
             _img_menu.image = image;
         }
     }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    leftMenuArray = @[@"Agent Home",@"Change password",@"Profile",@"Add Member",@"Members",@"Match Making",@"Sales Report",@"Assistants",@"Logout"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"Agent_Dashboard" forKey:@"Re_Open"];

    _leftMenuTable.delegate =self;
    [_leftMenuTable createView:_leftMenuTable.frame];
    
    _leftMenuBgView.frame = [UIScreen mainScreen].bounds;
    leftmenuRect = _leftMenuContentView.frame;
    cellSelectionBar = [[UIView alloc] init];
    cellSelectionBar.tag = 50;
    tabsArray =@[@"My Matches",@"Mailbox",@"Daily Recommendations",@"Edit Profile",@"Upgrade Account",@"Settings",@"Feedback",@"Rate Us",@"Success Stories",@"Messages",@"Logout"];
   
    agent_inf=[NSUserDefaults standardUserDefaults];
    _name_menu.text=[NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_name"]];
    _id_menu.text=[NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_matri_id"]];
    
    
    
    self.one.layer.borderColor = [UIColor blackColor].CGColor;
    self.one.layer.borderWidth = 1;
    self.one.layer.cornerRadius=5;
    
    self.two.layer.borderColor = [UIColor blackColor].CGColor;
    self.two.layer.borderWidth = 1;
    self.two.layer.cornerRadius=5;
    
    self.three.layer.borderColor = [UIColor blackColor].CGColor;
    self.three.layer.borderWidth = 1;
    self.three.layer.cornerRadius=5;
    
    self.four.layer.borderColor = [UIColor blackColor].CGColor;
    self.four.layer.borderWidth = 1;
    self.four.layer.cornerRadius=5;
    
    [self dashboard_service];
}

-(void)viewDidAppear:(BOOL)animated
{
    [_leftMenuTable updateInstaceFrame:CGRectMake(_leftMenuTable.frame.origin.x,_leftMenuTable.frame.origin.y,_leftMenuTable.frame.size.width,_leftMenuTable.frame.size.height)];
}

-(void)dashboard_service
{
    NSDictionary *params = @{@"franchise_id": [NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_matri_id"]]};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"agent/agentDashboard" parameters:params requestNumber:WUS_FPwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         NSDictionary *res_dict=data;
         
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             NSDictionary *mem_list=[res_dict valueForKey:@"memberlist"];
             recentMembers=[mem_list valueForKey:@"recentMembers"];
             
             if ([status isEqualToString:@"1"])
             {
                 _all_members.text=[NSString stringWithFormat:@"%@",[mem_list valueForKey:@"allMembers_count"]];
                 _active_members.text=[NSString stringWithFormat:@"%@",[mem_list valueForKey:@"activeMembers_count"]];
                 _inactive_members.text=[NSString stringWithFormat:@"%@",[mem_list valueForKey:@"inactiveMembers_count"]];
                 _paid_members.text=[NSString stringWithFormat:@"%@",[mem_list valueForKey:@"paidMembers_count"]];
                 
                 
                 [_recent_table reloadData];
                 
                 
             }
             else
             {
                 [self Alert:result];
             }
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

#pragma mark recent table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return recentMembers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Recent_Members_Cell";
    Recent_Members_Cell  *cell = (Recent_Members_Cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Recent_Members_Cell" owner:self options:nil];
        cell = (Recent_Members_Cell *)[nib objectAtIndex:0];
    }
    cell.m_id.text=[NSString stringWithFormat:@"%@",[[recentMembers valueForKey:@"matri_id"]objectAtIndex:indexPath.row]];
    cell.name.text=[NSString stringWithFormat:@"%@",[[recentMembers valueForKey:@"username"]objectAtIndex:indexPath.row]];
    cell.gender.text=[NSString stringWithFormat:@"%@",[[recentMembers valueForKey:@"gender"]objectAtIndex:indexPath.row]];
    cell.date.text=[NSString stringWithFormat:@"%@",[[recentMembers valueForKey:@"reg_date"]objectAtIndex:indexPath.row]];
    cell.years.text=[NSString stringWithFormat:@"%@",[[recentMembers valueForKey:@"birthdate"]objectAtIndex:indexPath.row]];
    NSString *pic=[NSString stringWithFormat:@"%@",[[recentMembers valueForKey:@"photo1"]objectAtIndex:indexPath.row]];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    NSDate* birthday = [dateFormatter dateFromString:cell.years.text];
    
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthday
                                       toDate:now
                                       options:0];
    NSInteger age = [ageComponents year];
    cell.years.text=[NSString stringWithFormat:@"%d Yrs",age];
    
    //image with cache
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",pic]];
    
    [manager downloadImageWithURL: imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         
         if(image)
         {
             cell.img.image = image;
         }
     }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileViewController *profile = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    profile.From=@"Agent";
    profile.ClickedmatriId=[[recentMembers valueForKey:@"matri_id"]objectAtIndex:indexPath.row ];
    [self.navigationController pushViewController:profile animated:YES];
}

-(void)closeMenu
{
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



- (IBAction)closeLeftMenu:(id)sender
{
    [self closeMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark LeftMenu Delegates

-(float)setHeighForSearchTable:(UITableView *)tableView{
    
    return 40;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    cell.labelName.text =[leftMenuArray objectAtIndex:index.row];
    
    return cell;
}

-(void)searchTableViewSelected:(UITableView *)table IndexPath:(NSIndexPath * )indexPath
{
    if (indexPath.row==0)
    {
    }
    else if (indexPath.row==1)
    {
        NSLog(@"Change Password");
        Change_Password *menuController  =[[Change_Password alloc]initWithNibName:@"Change_Password" bundle:nil];
        menuController.From=@"Agent";
        [self.navigationController pushViewController:menuController animated:YES];
    }
    else if (indexPath.row==2)
    {
        NSLog(@"Edit Profile");
        
        Registration *menuController  =[[Registration alloc]initWithNibName:@"Registration" bundle:nil];
        menuController.From=@"Profile";
        [self.navigationController pushViewController:menuController animated:YES];

        /*
        Agent_EditProfile *menuController  =[[Agent_EditProfile alloc]initWithNibName:@"Agent_EditProfile" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
         */
    }
    else if (indexPath.row==3)
    {
        NSLog(@"Add Member");
        Add_Member *menuController  =[[Add_Member alloc]initWithNibName:@"Add_Member" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
    }
    else if (indexPath.row==4)
    {
        NSLog(@"Members");
    }
    else if (indexPath.row==5)
    {
        NSLog(@"Match Making");
    }
    else if (indexPath.row==6)
    {
        NSLog(@"Sales Report");
        Report *menuController  =[[Report alloc]initWithNibName:@"Report" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
    }
    else if (indexPath.row==7)
    {
        NSLog(@"Assistants");
        Assistants *menuController  =[[Assistants alloc]initWithNibName:@"Assistants" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
    }
    else if (indexPath.row==8)
    {
        NSLog(@"Logout");
        [agent_inf setValue:@"" forKey:@"F_matri_id"];
        
        Login_Agent *menuController  =[[Login_Agent alloc]initWithNibName:@"Login_Agent" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
    }
    [self closeMenu];
}

#pragma mark ID Search
-(void)search_click:(UIButton *)sender
{
   
    enteredMatriId = _search_tf.text;
    
    if ([enteredMatriId isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"Please Enter MATRI ID");
    }
    else
    {
        NSDictionary *param = @{@"matri_id":enteredMatriId};
        [self validMatriId:@"api/searchbyId" params:param enteredId:enteredMatriId indexPath:nil];
    }
}

-(void)validMatriId:(NSString *)url params:(NSDictionary *)params enteredId:(NSString *)Id indexPath:(NSIndexPath *)myip
{
    //raviratna5566@gmail.com
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WS_MAIN showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *sortDIct = data;
             NSString *status=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 ProfileViewController *profile = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
                 profile.From=@"Agent";
                 profile.ClickedmatriId = Id;
                 [self.navigationController pushViewController:profile animated:YES];
             }
                        else
             {
                 ALERT_DIALOG(@"Alert", result);
             }
         }
         
         else
         {
             ALERT_DIALOG(@"Alert", @"Something went wrong");
             
         }
         
     }];
}


@end
