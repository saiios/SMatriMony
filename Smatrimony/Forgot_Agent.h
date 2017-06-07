//
//  Forgot_Agent.h
//  Smatrimony
//
//  Created by INDOBYTES on 22/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"
@interface Forgot_Agent : UIViewController<UITextFieldDelegate>
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *email_tf;
- (IBAction)submit_click:(id)sender;

@end
