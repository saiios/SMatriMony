//
//  PaymentType_ViewController.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 03/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"
#import "offline_payment.h"
#import "CCWebViewController.h"

@interface PaymentType_ViewController : UIViewController
{
    NSUserDefaults *user_data;
    NSString *user_id;
}
@property (strong, nonatomic) IBOutlet UIView *payment_subview;
@property (strong, nonatomic) IBOutlet UIButton *onlinePayBtn;
@property (strong, nonatomic) IBOutlet UIButton *cashOnDeliveryBtn;
@property (strong, nonatomic) IBOutlet UIButton *sub_OnlinePayBtn;
@property (strong, nonatomic) IBOutlet UIButton *sub_OflinePayBtn;
@property (strong, nonatomic)NSMutableArray *shippingAddress;
@property (strong, nonatomic)NSString *methodType;


@property (strong, nonatomic) IBOutlet NSDictionary *payment_dict;

- (IBAction)onlinePayBtnAction:(id)sender;
- (IBAction)cashOnDelivryBtnAction:(id)sender;

- (IBAction)sub_OnlinePayBtnAction:(id)sender;
- (IBAction)sub_offlinePayBtnAction:(id)sender;
- (IBAction)makePaymentBtnActn:(id)sender;
- (IBAction)backBtnActn:(id)sender;
/*
 -(void)payment_service:(NSDictionary *)Dict
 {
 NSData *rsaKeyDataStr = [NSKeyedArchiver archivedDataWithRootObject:Dict];
 NSData *requestData = [NSData dataWithBytes: (__bridge const void * _Nullable)(rsaKeyDataStr) length: [rsaKeyDataStr length]];
 
 NSMutableURLRequest *rsaRequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://smatrimony.com/services/api/membershipPayments"]];
 [rsaRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
 [rsaRequest setHTTPMethod: @"POST"];
 [rsaRequest setHTTPBody: requestData];
 
 NSData *response_data = [NSURLConnection sendSynchronousRequest: rsaRequest returningResponse: nil error: nil];
 NSError* error;
 NSDictionary* json = [NSJSONSerialization JSONObjectWithData:response_data
 options:kNilOptions
 error:&error];
 
 NSString *status=[NSString stringWithFormat:@"%@",[json valueForKey:@"status"]];
 NSString *result=[NSString stringWithFormat:@"%@",[json valueForKey:@"result"]];
 if ([status isEqualToString:@"1"])
 {
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
 myNewVC.orderId = [json valueForKey:@"order_inc_id"];
 
 [self.navigationController pushViewController:myNewVC animated:YES];
 }
 }
 else
 {
 [self Alert:@"Something went wrong"];
 }
 }

 */

@end
