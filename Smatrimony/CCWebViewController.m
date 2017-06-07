//
//  CCPOViewController.m
//  CCIntegrationKit
//
//  Created by test on 5/12/14.
//  Copyright (c) 2014 Avenues. All rights reserved.
//

#import "CCWebViewController.h"
#import "SuccessOrderViewController.h"
#import "CCTool.h"
#import "STParsing.h"

@interface CCWebViewController ()
{
    NSDictionary *dicOfRespo;
    NSString *transStatus;
}


@end

@implementation CCWebViewController

@synthesize rsaKeyUrl;@synthesize accessCode;@synthesize merchantId;@synthesize orderId;
@synthesize amount;
@synthesize currency;
@synthesize redirectUrl;
@synthesize cancelUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.viewWeb.delegate = self;
    
    accessCode = @"AVDL69EC48AB07LDBA";
    currency   = @"INR";
    NSLog(@"amount %@",amount);
    merchantId = @"104981";
    
    int r = arc4random() % 1000000000;
    printf("Random number: %u", r);
    orderId = [NSString stringWithFormat:@"%d",r];// from
    
    redirectUrl = @"http://smatrimony.com/ccavenuemobile/ccavResponseHandlerios";
    cancelUrl= @"http://smatrimony.com/ccavenuemobile/ccavResponseHandlerios";
    rsaKeyUrl = @"http://smatrimony.com/ccavenuemobile/GetRSA";
    
    //redirectUrl = @"http://52.66.50.106/ccavenuemobile/ccavResponseHandler";
    //cancelUrl= @"http://52.66.50.106/ccavenuemobile/ccavResponseHandler";
    //rsaKeyUrl = @"http://52.66.50.106/ccavenuemobile/GetRSA";
    
    //Getting RSA Key
    NSString *rsaKeyDataStr = [NSString stringWithFormat:@"order_id=%@",orderId];
    NSData *requestData = [NSData dataWithBytes: [rsaKeyDataStr UTF8String] length: [rsaKeyDataStr length]];
    NSMutableURLRequest *rsaRequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: rsaKeyUrl]];
    [rsaRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [rsaRequest setHTTPMethod: @"POST"];
    [rsaRequest setHTTPBody: requestData];
    NSData *rsaKeyData = [NSURLConnection sendSynchronousRequest: rsaRequest returningResponse: nil error: nil];
    NSString *rsaKey = [[NSString alloc] initWithData:rsaKeyData encoding:NSASCIIStringEncoding];
    rsaKey = [rsaKey stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    rsaKey = [NSString stringWithFormat:@"-----BEGIN PUBLIC KEY-----\n%@\n-----END PUBLIC KEY-----\n",rsaKey];
    NSLog(@"%@",rsaKey);
    
    //Billing info
    //Encrypting Card Details
    NSString *myRequestString = [NSString stringWithFormat:@"amount=%@&currency=%@",amount,currency];
    CCTool *ccTool = [[CCTool alloc] init];
    NSString *encVal = [ccTool encryptRSA:myRequestString key:rsaKey];
    encVal = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                        (CFStringRef)encVal,
                                                                        NULL,
                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                        kCFStringEncodingUTF8 ));
    
    //Preparing for a webview call
    NSString *urlAsString = [NSString stringWithFormat:@"https://secure.ccavenue.com/transaction/initTrans"];
    NSString *encryptedStr = [NSString stringWithFormat:@"merchant_id=%@&order_id=%@&redirect_url=%@&cancel_url=%@&enc_val=%@&access_code=%@",merchantId,orderId,redirectUrl,cancelUrl,encVal,accessCode];
    
    NSData *myRequestData = [NSData dataWithBytes: [encryptedStr UTF8String] length: [encryptedStr length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlAsString]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setValue:urlAsString forHTTPHeaderField:@"Referer"];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: myRequestData];
    [_viewWeb loadRequest:request];
}

-(void)viewWillAppear:(BOOL)animated
{
    accessCode = @"AVDL69EC48AB07LDBA";
    currency   = @"INR";
    NSLog(@"amount %@",amount);
    merchantId = @"104981";
    
    int r = arc4random() % 1000000000;
    printf("Random number: %u", r);
    orderId = [NSString stringWithFormat:@"%d",r];// from
    
    // orderId = @"124784664";// from
    
    redirectUrl = @"http://smatrimony.com/ccavenuemobile/ccavResponseHandlerios";
    cancelUrl= @"http://smatrimony.com/ccavenuemobile/ccavResponseHandlerios";
    rsaKeyUrl = @"http://smatrimony.com/ccavenuemobile/GetRSA";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *string = webView.request.URL.absoluteString;
    NSLog(@"%@",string);
    
    if ([string rangeOfString:@"/ccavResponseHandler"].location != NSNotFound)
    {
        NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
        NSLog(@"%@",html);
        
        transStatus = @"Not Known";
        if (([html rangeOfString:@"Aborted"].location != NSNotFound) ||
            ([html rangeOfString:@"Cancel"].location != NSNotFound))
        {
            transStatus = @"Transaction Cancelled";
            
        }else if (([html rangeOfString:@"Success"].location != NSNotFound)) {
            
            transStatus = @"Transaction Successful";
            
            
        }else if (([html rangeOfString:@"Fail"].location != NSNotFound)) {
            transStatus = @"Transaction Failed";
        }

        NSRange r1 = [html rangeOfString:@"<body>"];
        NSRange r2 = [html rangeOfString:@"</body>"];
        NSRange rSub = NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length);
        NSString *sub = [html substringWithRange:rSub];//json send to service
        
        NSData *data = [sub dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"%@",[json valueForKey:@"result"]);
        
        dicOfRespo = [[NSDictionary alloc]init];
        dicOfRespo = [json valueForKey:@"result"];
        [self sendRespotoService:json];
    }
}

-(void)sendRespotoService:(id)json
{
    //paymentResponse
    NSString *jsonString;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicOfRespo
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    
    NSUserDefaults *user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:@"Online" forKey:@"paymode"];
    [dict setObject:[NSString stringWithFormat:@"%@",[[json valueForKey:@"result"]valueForKey:@"order_id"]] forKey:@"order_id"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"profile"]] forKey:@"profile"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_name"]] forKey:@"p_plan"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_duration"]] forKey:@"plan_duration"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"video"]] forKey:@"video"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"chat"]] forKey:@"chat"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_id"]] forKey:@"planid"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_contacts"]] forKey:@"p_no_contacts"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_amount"]] forKey:@"p_amount"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_payment_dict valueForKey:@"plan_msg"]] forKey:@"p_msg"];
    [dict setObject:json forKey:@"ccavenue_response"];

    /*
     {
     chat = No;
     "discount_amount" = 0;
     id = 1;
     "package_type" = Classic;
     "plan_amount" = 3800;
     "plan_amount_type" = "Rs.";
     "plan_astro" = No;
     "plan_astro_val" = 0;
     "plan_contacts" = 60;
     "plan_duration" = "0 Months";
     "plan_horo" = 60;
     "plan_id" = 18;
     "plan_msg" = 60;
     "plan_name" = Platinum;
     "plan_offers" = "This is platinum plan..";
     "plan_type" = PAID;
     profile = 0;
     status = APPROVED;
     video = No;
     }
     */
    
    /*
  matri_id,paymode,p_plan,plan_duration,profile,video,chat,p_no_contacts,p_amount,p_msg,order_id,planid
     */
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/membershipPayments" parameters:dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 SuccessOrderViewController *myControllerHastag = [[SuccessOrderViewController alloc]initWithNibName:@"SuccessOrderViewController" bundle:nil];
                 myControllerHastag.CCAvenueResponse = dicOfRespo;
                 myControllerHastag.From = @"ccavenue";
                 myControllerHastag.statusFromCCavenue = transStatus;
                 myControllerHastag.payment_dict=_payment_dict;
                 [self.navigationController pushViewController:myControllerHastag animated:YES];
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

- (IBAction)DissmisView:(id)sender {
    
//    UIAlertView *alertView = [[UIAlertView alloc]
//                              initWithTitle:JJLocalizedString(@"Warning", nil)
//                              
//                              message:JJLocalizedString(@"If_you_Close_the", nil)
//                              delegate:self
//                              cancelButtonTitle:JJLocalizedString(@"CANCEL", nil)
//                              otherButtonTitles:@"OK", nil];
//    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
      
        
        [_viewWeb stopLoading];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)backBtnActn:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are you sure want to cancel payment processes" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
      //  [self.navigationController popViewControllerAnimated:YES];
         NSArray *currentControllers = self.navigationController.viewControllers;
        BOOL ischeck = false;
        
        for (UIViewController *view in currentControllers )
        {
            if ([view isKindOfClass:[MenuViewController class]]) {
                ischeck =YES;
                [self.navigationController popToViewController:view animated:YES];
                break;
                
            }
        }
        
        if (!ischeck)
        {
            MenuViewController *con = [[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
            /* Create a mutable array out of this array */
            NSMutableArray *newControllers = [NSMutableArray
                                              arrayWithArray:@[con]];
            
            /* Remove the last object from the array */
            
            
            /* Assign this array to the Navigation Controller */
            self.navigationController.viewControllers = newControllers;
            [self.navigationController pushViewController:con animated:YES];
            
            
        }
        
    }]];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self presentViewController:alertController animated:YES completion:nil];
    });
    
    
}
@end
