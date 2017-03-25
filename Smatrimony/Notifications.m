//
//  Notifications.m
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Notifications.h"

@interface Notifications ()

@end

@implementation Notifications

- (void)viewDidLoad {
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
- (void)setState:(id)sender
{
    BOOL state = [sender isOn];
    NSString *rez = state == YES ? @"YES" : @"NO";
    NSLog(rez);
}
- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)one_click:(id)sender
{
    BOOL state = [sender isOn];
    NSString *res = state == YES ? @"1" : @"0";
    NSLog(@"Daily Recommendations %@",res);
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:res forKey:@"daily_status"];
    
    NSLog(@"%@",dict);
    [self Notif_service:dict];
}

- (IBAction)two_click:(id)sender
{
    BOOL state = [sender isOn];
    NSString *res = state == YES ? @"1" : @"0";
    NSLog(@"Who viewed my profile %@",res);
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:res forKey:@"viewprof_status"];
    
    NSLog(@"%@",dict);
    [self Notif_service:dict];
}

- (IBAction)three_click:(id)sender
{
    BOOL state = [sender isOn];
    NSString *res = state == YES ? @"1" : @"0";
    NSLog(@"Interest sent profiles %@",res);
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:res forKey:@"interest_status"];
    
    NSLog(@"%@",dict);
    [self Notif_service:dict];
}

- (IBAction)four_click:(id)sender
{
    BOOL state = [sender isOn];
    NSString *res = state == YES ? @"1" : @"0";
    NSLog(@"Who shortlisted me %@",res);
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:res forKey:@"shortlist_status"];
    
    NSLog(@"%@",dict);
    [self Notif_service:dict];
}

- (IBAction)five_click:(id)sender
{
    BOOL state = [sender isOn];
    NSString *res = state == YES ? @"1" : @"0";
    NSLog(@"Blocked List profiles %@",res);
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:res forKey:@"blocklist_status"];
    
    NSLog(@"%@",dict);
    [self Notif_service:dict];
}

-(void)Notif_service:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/editProfile" parameters:Dict requestNumber:WUS_editProfile showProgress:YES withHandler:^(BOOL success, id data)
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

@end
