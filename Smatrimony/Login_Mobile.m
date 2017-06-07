//
//  Login_Mobile.m
//  Smatrimony
//
//  Created by S s Vali on 5/2/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Login_Mobile.h"

@interface Login_Mobile ()
{
    NSUserDefaults *user_inf;
    NSString * matriId;
}

@end

@implementation Login_Mobile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString * shortNumbr = [self.mobileNumbr substringFromIndex:6];
    self.mobileLabel.text = [NSString stringWithFormat:@"(******%@)",shortNumbr];
    user_inf=[NSUserDefaults standardUserDefaults];
    matriId = [user_inf valueForKey:@"matri_id"];
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
- (IBAction)back_Action:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)send_OtpAction:(id)sender {
    
    NSDictionary * params = @{@"matri_id":matriId};
    
    [self popupServiceCall:@"services/api/sendOTP" params:params];
    
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
                 Otp_Controller *otpObj =[[Otp_Controller alloc]initWithNibName:@"Otp_Controller" bundle:nil];
                 otpObj.serverOtp = [res_dict valueForKey:@"otp_code"];
                 otpObj.matriID = matriId;
                 [self.navigationController pushViewController:otpObj animated:YES];
             }
             else
             {
                 ALERT_DIALOG(@"Alert", @"Something Went Wrong");
             }
             
         }
     }];
}


- (IBAction)cancelAction:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}
@end
