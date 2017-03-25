//
//  PaymentType_ViewController.m
//  steelonCallThree
//
//  Created by nagaraj  kumar on 03/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import "PaymentType_ViewController.h"

@interface PaymentType_ViewController ()
{
    NSString *paymentTypeIs;
}

@end

@implementation PaymentType_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.payment_subview.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden =YES;
    // self.automaticallyAdjustsScrollViewInsets = NO;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onlinePayBtnAction:(id)sender
{
    [_onlinePayBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [_cashOnDeliveryBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    self.payment_subview.hidden = YES;
    paymentTypeIs = @"1";
}

- (IBAction)cashOnDelivryBtnAction:(id)sender
{
    if ([_methodType isEqualToString:@"1"])
    {
        
    }
    else
    {
    //self.payment_subview.hidden = false;
    paymentTypeIs = @"";
    }
    
    [_onlinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [_cashOnDeliveryBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
}

- (IBAction)sub_OnlinePayBtnAction:(id)sender {
    paymentTypeIs = @"21";
    
    [_onlinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [_cashOnDeliveryBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    
    [_sub_OnlinePayBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [_sub_OflinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
}

- (IBAction)sub_offlinePayBtnAction:(id)sender
{
    paymentTypeIs = @"22";
    
    [_onlinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [_cashOnDeliveryBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    
    [_sub_OnlinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [_sub_OflinePayBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
}

- (IBAction)makePaymentBtnActn:(id)sender
{
    if ([paymentTypeIs isEqualToString:@"1"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        CCWebViewController *myNewVC = (CCWebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CCWebViewControllerId"];
        myNewVC.amount = @"0.001";
        myNewVC.payment_dict=_payment_dict;
        [self.navigationController pushViewController:myNewVC animated:YES];
    }
    else
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
             
             if (![paymentTypeIs isEqualToString:@"1"])
             {
                 offline_payment *menuController  =[[offline_payment alloc]initWithNibName:@"offline_payment" bundle:nil];
                 [self.navigationController pushViewController:menuController animated:YES];
             }
             else
             {
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 
                 
                 CCWebViewController *myNewVC = (CCWebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CCWebViewControllerId"];
                 myNewVC.amount = @"0.001";
                 myNewVC.payment_dict=_payment_dict;
                 myNewVC.orderId = [data valueForKey:@"order_inc_id"];
                 
                 [self.navigationController pushViewController:myNewVC animated:YES];
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

- (IBAction)backBtnActn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
