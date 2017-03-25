//
//  Agent_EditProfile.m
//  Smatrimony
//
//  Created by INDOBYTES on 13/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Agent_EditProfile.h"

@interface Agent_EditProfile ()

@end

@implementation Agent_EditProfile

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //leftmenu
    leftMenuArray = @[@"Agent Home",@"Change password",@"Profile",@"Add Member",@"Members",@"Match Making",@"Sales Report",@"Assistants",@"Logout"];
    
    _leftMenuTable.delegate =self;
    [_leftMenuTable createView:_leftMenuTable.frame];
    
    _leftMenuBgView.frame = [UIScreen mainScreen].bounds;
    leftmenuRect = _leftMenuContentView.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Left Menu
- (IBAction)openLeftMenu:(id)sender
{
    isMenuActive =YES;
    _leftMenuBgView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_leftMenuBgView];
    _leftMenuBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    _leftMenuContentView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width,0, leftmenuRect.size.width, leftmenuRect.size.height);
    [_leftMenuTable updateInstaceFrame:CGRectMake(_leftMenuTable.frame.origin.x,_leftMenuTable.frame.origin.y,_leftMenuTable.frame.size.width,_leftMenuTable.frame.size.height)];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        _leftMenuContentView.frame =CGRectMake(0,0, leftmenuRect.size.width, leftmenuRect.size.height);
        _leftMenuBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
    } completion:^(BOOL finished)
    {
    }];
}

- (IBAction)closeLeftMenu:(id)sender
{
    [self closeMenu];
}

-(void)closeMenu
{
    isMenuActive = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _leftMenuContentView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width,0, leftmenuRect.size.width, leftmenuRect.size.height);
        
        _leftMenuBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
    } completion:^(BOOL finished)
    {
        [_leftMenuBgView removeFromSuperview];
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
