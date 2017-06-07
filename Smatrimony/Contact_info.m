//
//  Contact_info.m
//  Smatrimony
//
//  Created by INDOBYTES on 20/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Contact_info.h"

@interface Contact_info ()

@end

@implementation Contact_info

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Email.text = self.emailId;
    self.phone_number.text = self.phn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
