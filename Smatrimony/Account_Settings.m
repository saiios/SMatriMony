//
//  Account_Settings.m
//  Smatrimony
//
//  Created by INDOBYTES on 13/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Account_Settings.h"

@interface Account_Settings ()

@end

@implementation Account_Settings

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    user_inf=[NSUserDefaults standardUserDefaults];
    matri_id=[user_inf valueForKey:@"matri_id"];
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
        [self call_prefer:[[alertView textFieldAtIndex:0] text]];
    }
}

-(void)call_prefer:(NSString *)str
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:str forKey:@"time_to_call"];
    [dict setObject:matri_id forKey:@"matri_id"];
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/editProfile" parameters:dict requestNumber:WUS_unblock showProgress:YES withHandler:^(BOOL success, id data)
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
- (IBAction)Delete_Ac:(id)sender
{
    Delete_ACCOUNT *menuController  =[[Delete_ACCOUNT alloc]initWithNibName:@"Delete_ACCOUNT" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)Logout:(id)sender
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/logout" parameters:dict requestNumber:WUS_logout showProgress:YES withHandler:^(BOOL success, id data)
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
         user_inf=[NSUserDefaults standardUserDefaults];
         [user_inf setValue:@"" forKey:@"matri_id"];
         [user_inf setValue:@"" forKey:@"email_id"];
         
         LoginViewController *menuController  =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
         [self.navigationController pushViewController:menuController animated:YES];
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

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
