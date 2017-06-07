//
//  Call_Preferences.m
//  Smatrimony
//
//  Created by INDOBYTES on 25/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Call_Preferences.h"

@interface Call_Preferences ()

@end

@implementation Call_Preferences

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

- (IBAction)backAction:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)callPreferenceAction:(id)sender {
    Detail_Call_Preferences *menuController  =[[Detail_Call_Preferences alloc]initWithNibName:@"Detail_Call_Preferences" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];

}

- (IBAction)blockedProfilesAction:(id)sender {
    Block_list *menuController  =[[Block_list alloc]initWithNibName:@"Block_list" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}
@end
