//
//  current_plan.m
//  Smatrimony
//
//  Created by INDOBYTES on 10/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "current_plan.h"

@interface current_plan ()

@end

@implementation current_plan

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   NSUserDefaults *user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    
    _duration.layer.borderColor = [UIColor whiteColor].CGColor;
    _duration.layer.borderWidth = 1.0;
    _contacts.layer.borderColor = [UIColor whiteColor].CGColor;
    _contacts.layer.borderWidth = 1.0;
    _view_profile.layer.borderColor = [UIColor whiteColor].CGColor;
    _view_profile.layer.borderWidth = 1.0;
    _personal_msg.layer.borderColor = [UIColor whiteColor].CGColor;
    _personal_msg.layer.borderWidth = 1.0;
    _exp_date.layer.borderColor = [UIColor whiteColor].CGColor;
    _exp_date.layer.borderWidth = 1.0;
    _horo.layer.borderColor = [UIColor whiteColor].CGColor;
    _horo.layer.borderWidth = 1.0;

    _d.layer.borderColor = [UIColor whiteColor].CGColor;
    _d.layer.borderWidth = 1.0;
    _c.layer.borderColor = [UIColor whiteColor].CGColor;
    _c.layer.borderWidth = 1.0;
    _v.layer.borderColor = [UIColor whiteColor].CGColor;
    _v.layer.borderWidth = 1.0;
    _p.layer.borderColor = [UIColor whiteColor].CGColor;
    _p.layer.borderWidth = 1.0;
    _e.layer.borderColor = [UIColor whiteColor].CGColor;
    _e.layer.borderWidth = 1.0;
    _h.layer.borderColor = [UIColor whiteColor].CGColor;
    _h.layer.borderWidth = 1.0;
    [self current_plan:dict];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)current_plan:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/currentPlan" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSDictionary *current_plan=[res_dict valueForKey:@"currentplan"];

             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if (![status isEqualToString:@"1"])
             {
                 [self Alert:result];
             }
             else
             {
                 _plan.text=[NSString stringWithFormat:@" %@ PLAN",[current_plan valueForKey:@"p_plan"]];
                 _amount.text=[NSString stringWithFormat:@" %@",[current_plan valueForKey:@"p_amount"]];
                 NSString *duration_str=[NSString stringWithFormat:@" %@",[current_plan valueForKey:@"plan_duration"]];
                 if ([duration_str isEqualToString:@" 0 months"])
                 {
                     _duration.text=@" Unlimited";
                     _exp_date.text=@" Unlimited";
                 }
                 else{
                     _exp_date.text=[NSString stringWithFormat:@" %@",[current_plan valueForKey:@"exp_date"]];
                     _duration.text=duration_str;
                 }
                 NSString *contacts_str=[NSString stringWithFormat:@"%@",[current_plan valueForKey:@"p_no_contacts"]];
                 if ([contacts_str isEqualToString:@"0"])
                 {
                     _contacts.text=@"Unlimited";
                 }
                 else
                 _contacts.text=[NSString stringWithFormat:@"%@ (%@ Uses)",contacts_str,[current_plan valueForKey:@"r_cnt"]];
                 
                 NSString *pro_str=[NSString stringWithFormat:@"%@",[current_plan valueForKey:@"profile"]];
                 if ([pro_str isEqualToString:@"0"])
                 {
                     _view_profile.text=@"Unlimited";
                 }
                 else
                     _view_profile.text=[NSString stringWithFormat:@"%@ (%@ Uses)",pro_str,[current_plan valueForKey:@"r_profile"]];

                 NSString *msg_str=[NSString stringWithFormat:@"%@",[current_plan valueForKey:@"p_msg"]];
                 if ([msg_str isEqualToString:@"0"])
                 {
                     _personal_msg.text=@"Unlimited";
                 }
                 else
                     _personal_msg.text=[NSString stringWithFormat:@"%@ (%@ Uses)",msg_str,[current_plan valueForKey:@"r_sms"]];
                 NSString *hor_str=[NSString stringWithFormat:@"%@",[current_plan valueForKey:@"p_horo"]];
                 if ([hor_str isEqualToString:@"0"])
                 {
                     _horo.text=@"Unlimited";
                 }
                 else
                     _horo.text=[NSString stringWithFormat:@"%@ (%@ Uses)",hor_str,[current_plan valueForKey:@"r_horo"]];
                 
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

@end
