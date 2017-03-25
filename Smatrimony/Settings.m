//
//  Settings.m
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Settings.h"

@interface Settings ()

@end

@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)notif_click:(id)sender
{
    Notifications *menuController  =[[Notifications alloc]initWithNibName:@"Notifications" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)account_click:(id)sender
{
    Account_Settings *menuController  =[[Account_Settings alloc]initWithNibName:@"Account_Settings" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)change_pwd_click:(id)sender
{
    Change_Password *menuController  =[[Change_Password alloc]initWithNibName:@"Change_Password" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}
@end
