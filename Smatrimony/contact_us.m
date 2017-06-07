//
//  contact_us.m
//  Smatrimony
//
//  Created by INDOBYTES on 11/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "contact_us.h"

@interface contact_us ()

@end

@implementation contact_us

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if ([_From isEqualToString:@"Safe Matrimony"])
    {
        [dict setObject:@"6" forKey:@"cms_id"];
        _page_title.text=@"Safe Matrimony";
    }
    else
        [dict setObject:@"9" forKey:@"cms_id"];
    [self contact_us:dict];
}

-(void)contact_us:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/cmsPages" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSDictionary *cmsPages_dict=[res_dict valueForKey:@"cmsPages"];
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                // NSString *add_str=@"<h4>Sharavana Technologies Private Limited</h4><div class=\"address_left\"><p>H.No:13-1-64/1, Prabhat Nagar,<br />Chaitanyapuri,<br />Hyderabad,<br />Telangana-500060</p><p>&nbsp;</p><p>Tel: 9393394394, 9392179392,<br />9392279392, 9392379392,<br /> 9392679392<br />Email: <strong>info@smatrimony.com</strong></p><p>&nbsp;</p> <p>&nbsp;</p></div><div class=\"address_right\"><div id=\"map_canvas1\"><iframe frameborder=\"0\" src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3807.741264475689!2d78.53526711471608!3d17.376178807702246!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bcb98e5d8cfff69%3A0x353fee2fb2df7de8!2sChaitanyapuri+Rd%2C+Hyderabad%2C+Telangana+500060!5e0!3m2!1sen!2sin!4v1471417351821\" style=\"min-height:230px!important;border:0\" width=\"100%\"></iframe></div></div><p>&nbsp;</p>";
                 NSString *add_str=[NSString stringWithFormat:@"%@",[cmsPages_dict valueForKey:@"cms_content"]];
                 //[[NSMutableString alloc]initWithFormat:@"%@",[cmsPages_dict valueForKey:@"cms_content"]];
                // [add_str replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSLiteralSearch range:NSMakeRange(0, [add_str length])];
                // [add_str replaceOccurrencesOfString:@"<iframe frameborder=\"0\" src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3807.741264475689!2d78.53526711471608!3d17.376178807702246!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bcb98e5d8cfff69%3A0x353fee2fb2df7de8!2sChaitanyapuri+Rd%2C+Hyderabad%2C+Telangana+500060!5e0!3m2!1sen!2sin!4v1471417351821\" style=\"min-height:230px!important;border:0\" width=\"100%\"></iframe>" withString:@"<iframe width=\"300\" height=\"250\" src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3807.741264475689!2d78.53526711471608!3d17.376178807702246!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bcb98e5d8cfff69%3A0x353fee2fb2df7de8!2sChaitanyapuri+Rd%2C+Hyderabad%2C+Telangana+500060!5e0!3m2!1sen!2sin!4v1471417351821\" allowfullscreen></iframe>" options:NSLiteralSearch range:NSMakeRange(0, [add_str length])];
                // NSString *strippedTextForBlog = [self stringByStrippingHTMLFromString:add_str];
                 [_webview loadHTMLString:add_str baseURL:nil];
                 
//                 NSString *str = @"This is <font color='red'>simple</font>";
//                 [_txt_view setValue:add_str forKey:@"contentToHTMLString"];
//                 _txt_view.textAlignment = NSTextAlignmentLeft;
//                 _txt_view.editable = NO;
//                 _txt_view.font = [UIFont fontWithName:@"vardana" size:20.0];
                 
             }
             else
             {
                 [self Alert:result];
             }
         }
     }];
}

- (NSString *)stringByStrippingHTMLFromString:(NSString *)str
{
    NSMutableString *html = [NSMutableString stringWithCapacity:[str length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    scanner.charactersToBeSkipped = NULL;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:tempText];
        
        [scanner scanUpToString:@">" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
    }
    
    return html;
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
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *URL = [request URL];
    if ([[URL scheme] isEqualToString:@"r"])
    {
        [self recordButtonMethod];
        return NO;
    }
    if ([[URL scheme] isEqualToString:@"s"])
    {
        [self stopButtonMethod];
        return NO;
    }
    if ([[URL scheme] isEqualToString:@"p"])
    {
        [self playButtonMethod];
        return NO;
    }
    return YES;
}
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
