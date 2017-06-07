//
//  Login_Agent.m
//  Smatrimony
//
//  Created by INDOBYTES on 22/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Login_Agent.h"

@interface Login_Agent ()

@end

@implementation Login_Agent

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSUserDefaults standardUserDefaults]setObject:@"Agent_Login" forKey:@"Re_Open"];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
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

- (IBAction)submit_click:(id)sender
{
    [self.view endEditing:YES];
    
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
        [self Login_Dict];
    }

}
-(BOOL)valide_Data
{
    NSString *email_str = [_username_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd_str=_pwd_tf.text;
    
    if  ( [email_str length]==0)
    {
        [self Alert :@"Email should not be empty."];
        return NO;
    }
    //    else if ([self NSStringIsValidEmail:email_str]== NO)
    //    {
    //        [self Alert :@"Email should be valid."];
    //        return NO;
    //    }
    else if ([pwd_str length] == 0)
    {
        [self Alert :@"Password should not be empty."];
        return NO;
    }
    //    else if ([pwd_str length] < 6)
    //    {
    //        [self Alert :@"Password must be atleast 6 characters long."];
    //        return NO;
    //    }
    return YES;
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

-(void)Login_Dict
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[_username_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
    [dict setObject:[_pwd_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"password"];
    
    NSLog(@"%@",dict);
    
    
    
    [self Login_Service:dict];
}
-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)Login_Service:(NSDictionary *)Dict
{
    //raviratna5566@gmail.com
    NSDictionary *params = @{@"username": _username_tf.text,@"password": _pwd_tf.text};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"agent/login" parameters:params requestNumber:WUS_Login showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             
             if ([status isEqualToString:@"1"])
             {
                 NSDictionary *user_info=[res_dict valueForKey:@"agentinfo"];
                 NSString *matri_id=[user_info valueForKey:@"f_matri_id"];
                 NSString *name=[user_info valueForKey:@"franchise_name"];
                 NSString *F_id=[user_info valueForKey:@"franchise_id"];
                 NSString *email_id=[user_info valueForKey:@"franchise_email"];
                 NSString *profile_pic=[user_info valueForKey:@"upload_photo"];
                // NSString *gender_str=[user_info valueForKey:@"gender"];
                 NSString *status_str=[user_info valueForKey:@"franchise_status"];
                 
                 if ([matri_id isEqualToString:@""]||[matri_id isEqualToString:@"0"]||[matri_id isEqualToString:@"<nil>"])
                 {
                     [self Alert:@"Something went wrong!"];
                 }
                 else
                 {
                     NSUserDefaults  *agent_inf=[NSUserDefaults standardUserDefaults];
                     [agent_inf setValue:matri_id forKey:@"F_matri_id"];
                     [agent_inf setValue:email_id forKey:@"F_email_id"];
                     [agent_inf setValue:profile_pic forKey:@"F_pic"];
                     [agent_inf setValue:F_id forKey:@"F_id"];
                     [agent_inf setValue:name forKey:@"F_name"];
                     [agent_inf setValue:status_str forKey:@"F_status"];
                     
                     Agent_Dashboard *menuController  =[[Agent_Dashboard alloc]initWithNibName:@"Agent_Dashboard" bundle:nil];
                    // menuController.user_name_str=[user_info valueForKey:@"franchise_email"];
                   //  menuController.agent_id_str=[user_info valueForKey:@"f_matri_id"];
                     [self.navigationController pushViewController:menuController animated:YES];
                 }
             }
             else if ([status isEqualToString:@"0"]||[status isEqualToString:@"3"])
             {
                 [self Alert:result];
             }
             else if ([status isEqualToString:@"2"])
             {
                 [self Alert:@"Under Review!"];
             }
             else
             {
                 [self Alert:@"Login failed!"];
             }
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

- (IBAction)register_click:(id)sender
{
    Registration *menuController  =[[Registration alloc]initWithNibName:@"Registration" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)fwd_click:(id)sender
{
    Forgot_Agent *menuController  =[[Forgot_Agent alloc]initWithNibName:@"Forgot_Agent" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)back_click:(id)sender
{
    Home_VC *menuController  =[[Home_VC alloc]initWithNibName:@"Home_VC" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
   // [self.navigationController popViewControllerAnimated:YES];
}

@end
