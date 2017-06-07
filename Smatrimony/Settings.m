//
//  Settings.m
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Settings.h"

@interface Settings ()
{
    NSString *resultValue;
}
@end

@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[NSUserDefaults standardUserDefaults];
    NSString *check = [defaults valueForKey:@"resultView"];
    if ([check isEqualToString:@"listView"]) {
        [self.listViewBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    }
    else
    {
        [self.photoViewBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    }
    resultValue=[[NSString alloc]init];
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

- (IBAction)privacy_click:(id)sender {
    Call_Preferences *menuController  =[[Call_Preferences alloc]initWithNibName:@"Call_Preferences" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)listViewAction:(id)sender {
    [self.listViewBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
     [self.photoViewBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
   resultValue=@"listView";
    [defaults setValue:resultValue forKey:@"resultView"];
}

- (IBAction)photoViewAction:(id)sender {
    [self.listViewBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.photoViewBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    resultValue=@"photoView";
    [defaults setValue:resultValue forKey:@"resultView"];
}

@end
