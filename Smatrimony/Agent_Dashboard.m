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

@end

@implementation Agent_Dashboard

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    leftMenuArray = @[@"Agent Home",@"Change password",@"Profile",@"Add Member",@"Members",@"Match Making",@"Sales Report",@"Assistants",@"Logout"];
    
    _leftMenuTable.delegate =self;
    [_leftMenuTable createView:_leftMenuTable.frame];
    
    _leftMenuBgView.frame = [UIScreen mainScreen].bounds;
    leftmenuRect = _leftMenuContentView.frame;
    cellSelectionBar = [[UIView alloc] init];
    cellSelectionBar.tag = 50;
    tabsArray =@[@"My Matches",@"Mailbox",@"Daily Recommendations",@"Edit Profile",@"Upgrade Account",@"Settings",@"Feedback",@"Rate Us",@"Success Stories",@"Messages",@"Logout"];
}
-(void)viewDidAppear:(BOOL)animated{
    
    [_leftMenuTable updateInstaceFrame:CGRectMake(_leftMenuTable.frame.origin.x,_leftMenuTable.frame.origin.y,_leftMenuTable.frame.size.width,_leftMenuTable.frame.size.height)];
    
    
}

#pragma mark recent table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
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

-(float)setHeighForSearchTable:(UITableView *)tableView{
    
    return 40;
}

-(NSInteger )numberOffRowsInSearchTableView:(UITableView *)tableView
{
    return leftMenuArray.count;
}

- (JMOTableViewCell *)cellforRowAtSearchINdex:(UITableView*)tableVIew viewAtIndex:(NSIndexPath *)index{
    
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
    }
    else if (indexPath.row==2)
    {
        NSLog(@"Edit Profile");
        Agent_EditProfile *menuController  =[[Agent_EditProfile alloc]initWithNibName:@"Agent_EditProfile" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
    }
    else if (indexPath.row==3)
    {
        NSLog(@"Add Member");
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
    }
    [self closeMenu];
}

#pragma mark TabsView
-(void)clickedProfileTable:(NSIndexPath *)index
{
    ProfileViewController *profile = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    [self.navigationController pushViewController:profile animated:YES];
}

-(void)clicked:(UIButton *)sender
{
    
}


@end
