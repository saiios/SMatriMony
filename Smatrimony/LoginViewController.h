//
//  LoginViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 03/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRToastView.h"
#import "STParsing.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface LoginViewController : UIViewController<FBSDKLoginButtonDelegate>
{
    NSString *Fpwd_text;
    NSUserDefaults *user_inf;
}
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property(weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

- (IBAction)register_click:(id)sender;
- (IBAction)fpwd_click:(id)sender;
- (IBAction)FB_click:(id)sender;

@end
