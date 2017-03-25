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
@synthesize amount;@synthesize currency;@synthesize redirectUrl;@synthesize cancelUrl;

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

    /*
     String access_code = "AVDL69EC48AB07LDBA";
     String merchant_id = "104981";
     String redirectUrl="ccavenuemobile/ccavResponseHandler";
     String cancelUrl="ccavenuemobile/ccavResponseHandler";
     String rsaKeyUrl="ccavenuemobile/GetRSA";
     String currency = "INR";
     */
    
    self.viewWeb.delegate = self;
    
    accessCode = @"AVDL69EC48AB07LDBA";
    currency   = @"INR";
    //amount = @"0.001";//from
    amount = @"1";//from
    merchantId = @"104981";
    orderId = @"124432464";// from
    redirectUrl = @"http://www.smatrimony.com/ccavenueios/ccavResponseHandler";
    cancelUrl= @"http://www.smatrimony.com/ccavenueios/ccavResponseHandler";
    rsaKeyUrl = @"http://www.smatrimony.com/ccavenueios/GetRSA";
    
    //Getting RSA Key
    NSString *rsaKeyDataStr = [NSString stringWithFormat:@"access_code=%@&order_id=%@",accessCode,orderId];
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
    accessCode = @"AVLC64DC55BU28CLUB";
    currency   = @"INR";
     //amount = @"1";//from
    merchantId = @"94188";
    orderId = @"1234"; //from
    redirectUrl = @"https://steeloncall.com/ccavenueios/ccavResponseHandler.php";
    cancelUrl= @"https://steeloncall.com/ccavenueios/ccavResponseHandler.php";
    rsaKeyUrl = @"https://steeloncall.com/ccavenueios/GetRSA.php";


}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    
    NSString *string = webView.request.URL.absoluteString;
    NSLog(@"%@",string);
    
    if ([string rangeOfString:@"/ccavResponseHandler.php"].location != NSNotFound) {
        NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
        
        
        NSLog(@"%@",html);
        
        transStatus = @"Not Known";
        
        if (([html rangeOfString:@"Aborted"].location != NSNotFound) ||
            ([html rangeOfString:@"Cancel"].location != NSNotFound)) {
            
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
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
        NSDictionary *parameters=@{@"ccavenue_response":json};
    
    
    NSUserDefaults *user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:@"Offline" forKey:@"paymode"];
    [dict setObject:[NSString stringWithFormat:@"6"] forKey:@"order_id"];
    [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"profile"];
    [dict setObject:[NSString stringWithFormat:@"Premium"] forKey:@"p_plan"];
    [dict setObject:[NSString stringWithFormat:@"0 Months"] forKey:@"plan_duration"];
    [dict setObject:[NSString stringWithFormat:@"No"] forKey:@"video"];
    [dict setObject:[NSString stringWithFormat:@"No"] forKey:@"chat"];
    [dict setObject:[NSString stringWithFormat:@"17"] forKey:@"planid"];
    [dict setObject:[NSString stringWithFormat:@"30"] forKey:@"p_no_contacts"];
    [dict setObject:[NSString stringWithFormat:@"1999"] forKey:@"p_amount"];
    [dict setObject:[NSString stringWithFormat:@"30"] forKey:@"p_msg"];
    
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
