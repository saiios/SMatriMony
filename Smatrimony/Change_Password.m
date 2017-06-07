//
//  Change Password.m
//  Smatrimony
//
//  Created by INDOBYTES on 13/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Change_Password.h"

@interface Change_Password ()

@end

@implementation Change_Password

-(void)viewDidAppear:(BOOL)animated
{
    
    scrollHeight = self.view.frame.size.height;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([_old_pwd isFirstResponder])
    {
        [_N_pwd becomeFirstResponder];
    }
    else if([_N_pwd isFirstResponder])
    {
        [_c_new_pwd becomeFirstResponder];
    }
    else if([_c_new_pwd isFirstResponder])
    {
        [_c_new_pwd resignFirstResponder];
    }
    return YES;
}
- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.view.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - 0);
    if (viewFrame.size.height <scrollHeight) {
        viewFrame.size.height = scrollHeight;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.view.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - 0);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
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

- (IBAction)Submit_click:(id)sender
{
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
        [self Feedback_Dict];
    }
}
-(void)Feedback_Dict
{
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if ([_From isEqualToString:@"Agent"])
    {
        [dict setObject:@"sap204" forKey:@"franchise_id"];
    }
    else
        [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:[_old_pwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"old_password"];
    [dict setObject:[_N_pwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"new_password"];
    
    NSLog(@"%@",dict);
    [self Change_Pwd_Service:dict];
}

-(void)Change_Pwd_Service:(NSDictionary *)Dict
{
    NSString *s_url=@"api/changePassword";
    if ([_From isEqualToString:@"Agent"])
    {
        s_url=@"agent/changePassword";
    }
    
        
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:s_url parameters:Dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             [self Alert:result];
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(BOOL)valide_Data
{
    NSString *old_str=_old_pwd.text;
    NSString *new_str=_N_pwd.text;
    NSString *c_new_str=_c_new_pwd.text;
    
    if ([old_str length] == 0)
    {
        [self Alert :@"Old Password should not be empty."];
        return NO;
    }
    else if ([new_str length] == 0||[c_new_str length]==0)
    {
        [self Alert :@"New Password should not be empty."];
        return NO;
    }
    else  if (![new_str isEqualToString:c_new_str])
    {
        [self Alert :@"Password mismatched."];
        return NO;
    }
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

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
