//
//  Login_Agent.h
//  Smatrimony
//
//  Created by INDOBYTES on 22/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.

#import <UIKit/UIKit.h>
#import "Forgot_Agent.h"
#import "Agent_Dashboard.h"
#import "Home_VC.h"

@interface Login_Agent : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *pwd_tf;
@property (strong, nonatomic) IBOutlet UITextField *username_tf;
- (IBAction)submit_click:(id)sender;
- (IBAction)register_click:(id)sender;
- (IBAction)fwd_click:(id)sender;
- (IBAction)back_click:(id)sender;

@end
