//
//  offline_payment.m
//  Smatrimony
//
//  Created by INDOBYTES on 21/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "offline_payment.h"

@interface offline_payment ()


@end

@implementation offline_payment

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _ThankYouMessageLbl.text = [NSString stringWithFormat:@"Thank you for choosing the %@ Plan. Admin will contact you shortly",_PlanType];
    [self membership_duration];
    _name = @"hello";
   }

-(void)membership_duration
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"api/bankDetails" requestNumber:WUS_S_story showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)// office no 401776999
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
                          if ([status isEqualToString:@"1"])
             {
                 NSDictionary *test_dict=[res_dict valueForKey:@"details"];
                 
                 NSMutableString *add_str=[[NSMutableString alloc]initWithFormat:@"%@",[test_dict valueForKey:@"bank_detail"]];
                 [add_str replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSLiteralSearch range:NSMakeRange(0, [add_str length])];
                 [add_str replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSLiteralSearch range:NSMakeRange(0, [add_str length])];
                 

                 NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                         initWithData: [add_str dataUsingEncoding:NSUnicodeStringEncoding]
                                                         options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                         documentAttributes: nil
                                                         error: nil
                                                         ];
                 _txt_view.attributedText = attributedString;
                 
                 [_web_view setBackgroundColor:[UIColor clearColor]];
                 [_web_view loadHTMLString:[add_str description] baseURL:nil];
                 [_web_view setHidden:YES];
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

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)home_click:(id)sender
{
    MenuViewController *menuController  =[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    NSUserDefaults *user_inf=[NSUserDefaults standardUserDefaults];
    menuController.user_name_str=[user_inf valueForKey:@"username"];
    [self.navigationController pushViewController:menuController animated:YES];
}
@end
