//
//  contact_us.h
//  Smatrimony
//
//  Created by INDOBYTES on 11/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"

@interface contact_us : UIViewController<UIWebViewDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UITextView *txt_view;
@property (strong, nonatomic) IBOutlet NSString  *From;
@property (strong, nonatomic) IBOutlet UILabel *page_title;

@end
