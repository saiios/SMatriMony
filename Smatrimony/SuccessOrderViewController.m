//
//  SuccessOrderViewController.m
//  steelonCallThree
//
//  Created by nagaraj  kumar on 05/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import "SuccessOrderViewController.h"

@interface SuccessOrderViewController ()

@end

@implementation SuccessOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_From isEqualToString:@"ccavenue"])
    {
        
        _orderStatusMessageLbl.text = _statusFromCCavenue;
        _orderIdLbl.text = [NSString stringWithFormat:@"order_id :#%@",[_CCAvenueResponse valueForKey:@"order_id"]];
        
       // user_data=[NSUserDefaults standardUserDefaults];
        //user_id=[user_data valueForKey:@"user_id"];
         //[user_data setValue:@"0" forKey:@"cart_count"];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"cart_count"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
       // [user_data synchronize];
        
        
    }
    else
{
    
    if (_responce.count>0)
    {
        
         _orderIdLbl.text = [NSString stringWithFormat:@"order_id :#%@",[_responce valueForKey:@"order_inc_id"]];
        _orderStatusMessageLbl.text = [_responce valueForKey:@"response"];
    }
}//else
   
    // Do any additional setup after loading the view from its nib.
    [self success_service];
}
-(void)success_service
{
    NSUserDefaults *user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:@"Offline" forKey:@"paymode"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"id"]] forKey:@"order_id"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"profile"]] forKey:@"profile"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_name"]] forKey:@"p_plan"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_duration"]] forKey:@"plan_duration"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"video"]] forKey:@"video"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"chat"]] forKey:@"chat"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_id"]] forKey:@"planid"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_contacts"]] forKey:@"p_no_contacts"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_amount"]] forKey:@"p_amount"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_msg"]] forKey:@"p_msg"];
    [self payment_service:dict];
}

-(void)payment_service:Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/membershipPayments" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
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

- (IBAction)view_yourOrdrsBtnActn:(id)sender
{
    NSLog(@"view orders clicked");
    /*
    YourOrdersViewController *define = [[YourOrdersViewController alloc]initWithNibName:@"YourOrdersViewController" bundle:nil];
    define.From = @"Login";
    [self.navigationController pushViewController:define animated:YES];
     */
}
@end
