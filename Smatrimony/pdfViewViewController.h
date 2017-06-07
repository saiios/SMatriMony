//
//  pdfViewViewController.h
//  Steeloncall_Seller
//
//  Created by INDOBYTES on 10/01/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface pdfViewViewController : UIViewController<UIWebViewDelegate, UIScrollViewDelegate>
{
    NSString *filePath;
    BOOL     keyboardIsShown;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *pdfView;
@property (strong, nonatomic) IBOutlet UIView *activityView;
@property (strong, nonatomic)  NSString *orderUrl;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;


@end
