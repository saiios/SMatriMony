//
//  Otp_Controller.m
//  Smatrimony
//
//  Created by INDOBYTES on 02/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Otp_Controller.h"
#define kOFFSET_FOR_KEYBOARD 210.0

@interface Otp_Controller ()
{
    BOOL keyboardIsShown;
    int scrollHeight;
     NSInteger tagTF;
}
@end

@implementation Otp_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    keyboardIsShown = NO;
    self.enteredOtp.delegate= self;
   
   
}
//method to move the view up/down whenever the keyboard is shown/dismissed

-(void)setMovedUp:(BOOL)movedUP
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.view.frame;
    if(movedUP)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else{
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}

#pragma mark - UITextFieldDelegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    tagTF = textField.tag;
    //    if(textField.tag>=6)
    //    {
    if(self.view.frame.origin.y >= 0)
    {
        [self setMovedUp:YES];
    }
    // }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //    if(textField.tag>=6)
    //    {
    [self setMovedUp:NO];
    //   }
    [textField resignFirstResponder];
    return YES;
}



//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [self.enteredOtp resignFirstResponder];
//    return YES;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back_Action:(id)sender {
    LoginViewController * loginObj = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginObj animated:YES];
}
- (IBAction)cancelBtn_Action:(id)sender {
    LoginViewController * loginObj = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginObj animated:YES];
}

- (IBAction)submitBtnAction:(id)sender {
    if (!([_enteredOtp.text isEqualToString:_serverOtp])) {
        ALERT_DIALOG(@"Alert", @"Please Enter Valid OTP");
    }
    else{
    NSDictionary * params =@{@"matri_id":_matriID};
    [self popupServiceCall:@"services/api/verify_mobile" params:params];
    }
}


-(void)popupServiceCall:(NSString *)url params:(NSDictionary *)params
{
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict = data;
             
             NSString *status = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 MenuViewController * controller =[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
                 [self.navigationController pushViewController:controller animated:YES];
             }
             else
             {
                 ALERT_DIALOG(@"Alert", @"Something Went Wrong");
             }
             
         }
     }];
}

@end
