//
//  LoginViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 03/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 150.0
#import "LoginViewController.h"
#import "MenuViewController.h"
#import "RegistrationViewController.h"
#import "Home_VC.h"
@interface LoginViewController ()
{
    NSInteger tagTF;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults]setObject:@"User_Login" forKey:@"Re_Open"];
   self.email.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
     self.password.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
//    _submitBtnOutlet.layer.cornerRadius = 10; // this value vary as per your desire
//    _submitBtnOutlet.clipsToBounds = YES;
    self.navigationController.navigationBar.hidden =YES;
    // Do any additional setup after loading the view from its nib.
    for (UITextField *field in _textFields) {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        field.leftView = paddingView;
        field.leftViewMode = UITextFieldViewModeAlways;
    }
    //FB
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
 
    self.email.delegate = self;
    self.password.delegate = self;
}


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

//-(BOOL) textFieldShouldReturn:(UITextField *)textField{
//    
//    [textField resignFirstResponder];
//    return YES;
//}
- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error)
         {
             // Process error
         }
         else if (result.isCancelled)
         {
             // Handle cancellations
         }
         else
         {
             if ([result.grantedPermissions containsObject:@"email"])
             {
                loginButton.titleLabel.text = @"Login with Facebook";
                 NSLog(@"result is:%@",result);
                 [self getFBResult];
             }
         }
     }];
}

-(void)getFBResult
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, first_name, last_name, picture.type(large), email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"fb user info : %@",result);
                 
                 NSString *firstname=[result valueForKey:@"first_name"];
                 NSString *lastname=[result valueForKey:@"last_name"];
                 NSString *email=[result valueForKey:@"email"];
                 NSString *fb_id=[result valueForKey:@"id"];
                 NSString *picture=[result valueForKey:@"picture"];
                 NSString *dic=[picture valueForKey:@"data"];
                 NSString *img_url=[dic valueForKey:@"url"];
                 NSString *gender=[result valueForKey:@"gender"];


                 NSMutableDictionary *dict = [NSMutableDictionary new];
                 [dict setObject:[NSString stringWithFormat:@"%@",firstname] forKey:@"firstname"];
                 [dict setObject:[NSString stringWithFormat:@"%@",lastname] forKey:@"lastname"];
                 [dict setObject:[NSString stringWithFormat:@"%@",email] forKey:@"email"];
                 [dict setObject:[NSString stringWithFormat:@"male"] forKey:@"gender"];
                 [dict setObject:[NSString stringWithFormat:@"%@",fb_id] forKey:@"fb_id"];
                 [dict setObject:[NSString stringWithFormat:@"%@",img_url] forKey:@"photo1"];
                 [dict setObject:[NSString stringWithFormat:@"224214234r21r4"] forKey:@"device_token"];
                 [dict setObject:[NSString stringWithFormat:@"ios"] forKey:@"device_type"];
                 NSLog(@"%@",dict);
                 
                 [self FB_Login_Service:dict];
             }
             else
             {
                 NSLog(@"error : %@",error);
             }
         }];
    }
}

-(void)FB_Login_Service:(NSDictionary *)Dict
{
        [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/socialLogin" parameters:Dict requestNumber:WUS_Login showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             
             if ([status isEqualToString:@"1"])
             {
                 NSDictionary *user_info=[res_dict valueForKey:@"userinfo"];
                 NSString *matri_id=[user_info valueForKey:@"matri_id"];
                 NSString *email_id=[user_info valueForKey:@"email"];
                 NSString *profile_pic=[user_info valueForKey:@"photo1"];
                 NSString *gender_str=[user_info valueForKey:@"gender"];
                 NSString *status_str=[user_info valueForKey:@"status"];
                
                 if ([matri_id isEqualToString:@""]||[matri_id isEqualToString:@"0"])
                 {
                     [self Alert:@"Something went wrong!"];
                 }
                 else
                 {
                     user_inf=[NSUserDefaults standardUserDefaults];
                     
                     [user_inf setValue:matri_id forKey:@"matri_id"];
                     [user_inf setValue:email_id forKey:@"email_id"];
                     [user_inf setValue:profile_pic forKey:@"profile_pic"];
                     [user_inf setValue:gender_str forKey:@"gender"];
                     [user_inf setValue:status_str forKey:@"status"];
                    
                     MenuViewController *menuController  =[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
                     menuController.user_name_str=[user_info valueForKey:@"username"];
                     [self.navigationController pushViewController:menuController animated:YES];
                 }
             }
             else
             {
                 //fb
                 FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
                 [loginManager logOut];
                 [self Alert:result];
             }
             }
     }];
}

- (IBAction)submitActionm:(id)sender
{
//     [self setMovedUp:NO];
//    [self.view endEditing:YES];
    
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
        [self Login_Dict];
    }
}

-(BOOL)valide_Data
{
    NSString *email_str = [_email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd_str=_password.text;
    
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
    [dict setObject:[_email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
    [dict setObject:[_password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"password"];
    
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
    NSDictionary *params = @{@"username": _email.text,@"password": _password.text,@"device_token":@"dfsdf",@"device_type":@"android"};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/login" parameters:params requestNumber:WUS_Login showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];

            if ([status isEqualToString:@"1"])
             {
                 NSDictionary *user_info=[res_dict valueForKey:@"userinfo"];
                 NSString *matri_id=[user_info valueForKey:@"matri_id"];
                 NSString *email_id=[user_info valueForKey:@"email"];
                 NSString *profile_pic=[user_info valueForKey:@"photo1"];
                 NSString *gender_str=[user_info valueForKey:@"gender"];
                 NSString *status_str=[user_info valueForKey:@"status"];
                 NSString * mobileNum = [user_info valueForKey:@"mobile"];
                 NSString * name = [user_info valueForKey:@"username"];
                
                 if ([matri_id isEqualToString:@""]||[matri_id isEqualToString:@"0"])
                 {
                     [self Alert:@"Something went wrong!"];
                 }
                 else
                 {
                     user_inf=[NSUserDefaults standardUserDefaults];
                     [user_inf setValue:matri_id forKey:@"matri_id"];
                     [user_inf setValue:email_id forKey:@"email_id"];
                     [user_inf setValue:profile_pic forKey:@"profile_pic"];
                     [user_inf setValue:gender_str forKey:@"gender"];
                     [user_inf setValue:status_str forKey:@"status"];
                     [user_inf setValue:name forKey:@"userName"];
                     
                     NSString * mobileVerificationStatus = [user_info valueForKey:@"mobile_verify_status"];
                     if ([mobileVerificationStatus isEqualToString:@"Yes"]) {
                        MenuViewController *menuController  =[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
                         menuController.user_name_str=[user_info valueForKey:@"username"];
                         [self.navigationController pushViewController:menuController animated:YES];
                     }
                     else
                     {
                    MenuViewController *menuController  =[[MenuViewController alloc]init];
                       menuController.user_name_str=[user_info valueForKey:@"username"];
               
                     Login_Mobile *loginMobileObj  =[[Login_Mobile alloc]initWithNibName:@"Login_Mobile" bundle:nil];
                     loginMobileObj.mobileNumbr = mobileNum;
                     [self.navigationController pushViewController:loginMobileObj animated:YES];
                     }
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

- (IBAction)register_click:(id)sender
{
    RegistrationViewController *registrationViewController = [[RegistrationViewController alloc]initWithNibName:@"RegistrationViewController" bundle:nil];
    // myControllerHastag.responce = data;
    
    [self.navigationController pushViewController:registrationViewController animated:YES];
}

- (IBAction)fpwd_click:(id)sender
{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"Please Enter Mobile Number"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@"Submit", nil];
    
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField * alertTextField1 = [alert textFieldAtIndex:0];
        alertTextField1.keyboardType = UIKeyboardTypeDefault;
        alertTextField1.placeholder = @"Enter Your Mobile Number";
        
        [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   // NSLog(@"1 %@", [alertView textFieldAtIndex:0].text);
    if (buttonIndex ==1)
    {
        Fpwd_text=[alertView textFieldAtIndex:0].text;
        [self.view endEditing:YES];
        
//        if ([self valide_Email] == YES)
//        { // checking if the either of the string is empty and other validations
            [self Fpwd_service];
//        }
    }
}

-(void)Fpwd_service
{
    NSDictionary *params = @{@"mobile": Fpwd_text};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/forgotPassword" parameters:params requestNumber:WUS_FPwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         NSDictionary *res_dict=data;

         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 NSString *User_Id=[NSString stringWithFormat:@"%@",[[res_dict valueForKey:@"userinfo"] valueForKey:@"matri_id"]];
                 if ([User_Id isEqualToString:@""]||[User_Id isEqualToString:@"0"])
                 {
                     [self Alert:@"Something went wrong!"];
                 }
                 else
                 {
                     [self Alert:result];
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
-(BOOL)valide_Email
{
    NSString *email_str = [Fpwd_text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if  ( [email_str length]==0)
    {
        [self Alert :@"Email should not be empty."];
        return NO;
    }
        else if ([self NSStringIsValidEmail:email_str]== NO)
        {
            [self Alert :@"Email should be valid."];
            return NO;
        }
    return YES;
}

- (IBAction)FB_click:(id)sender
{
}

- (IBAction)backHomePageAction:(id)sender {
    Home_VC *homePageController = [[Home_VC alloc]initWithNibName:@"Home_VC" bundle:nil];
    [self.navigationController pushViewController:homePageController animated:YES];
}
- (IBAction)passwordVisibleAction:(id)sender {
    if (self.password.secureTextEntry == YES) {
        self.password.secureTextEntry = NO;
    }
    else
    {
        self.password.secureTextEntry = YES;
    }
    
    
}


@end
