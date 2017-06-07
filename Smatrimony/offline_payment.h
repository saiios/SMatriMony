//
//  offline_payment.h
//  Smatrimony
//
//  Created by INDOBYTES on 21/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"
#import "MenuViewController.h"

@interface offline_payment : UIViewController<UITextViewDelegate>
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *web_view;
@property (strong, nonatomic) IBOutlet UITextView *txt_view;
- (IBAction)home_click:(id)sender;
@property (assign)NSString *name;
@property (strong, nonatomic) NSString *PlanType;
@property (strong, nonatomic) IBOutlet UILabel *ThankYouMessageLbl;

@end
