//
//  Forgot_Agent.m
//  Smatrimony
//
//  Created by INDOBYTES on 22/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Forgot_Agent.h"

@interface Forgot_Agent ()

@end

@implementation Forgot_Agent

- (void)viewDidLoad
{
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

- (IBAction)submit_click:(id)sender
{
    NSString *email_str=_email_tf.text;
    if (email_str.length!=0)
    {
        [self Fpwd_service];
    }
    else
        [self Alert:@"Email Should Not Be Empty!"];
}

-(void)Fpwd_service
{
    NSDictionary *params = @{@"email": _email_tf.text};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"agent/forgotPassword" parameters:params requestNumber:WUS_FPwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         NSDictionary *res_dict=data;
         
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 [self Alert:result];
                 [self.navigationController popViewControllerAnimated:YES];
                 /*
                 NSString *User_Id=[res_dict valueForKey:@"seller_id"];
                 if ([User_Id isEqualToString:@""]||[User_Id isEqualToString:@"0"])
                 {
                     [self Alert:@"Something went wrong!"];
                 }
                 else
                 {
                     //                     user_data=[NSUserDefaults standardUserDefaults];
                     //                     [user_data setValue:User_Id forKey:@"user_id"];
                 }*/
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

@end
