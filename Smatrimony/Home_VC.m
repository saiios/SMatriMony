//
//  Home_VC.m
//  Smatrimony
//
//  Created by INDOBYTES on 10/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Home_VC.h"

@interface Home_VC ()

@end

@implementation Home_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
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

- (IBAction)agentlogin_click:(id)sender
{
    Agent_Dashboard *menuController  =[[Agent_Dashboard alloc]initWithNibName:@"Agent_Dashboard" bundle:nil];
    
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)userlogin_click:(id)sender
{
    LoginViewController *menuController  =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}
@end
