//
//  Otp_Controller.h
//  Smatrimony
//
//  Created by INDOBYTES on 02/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "MenuViewController.h"
@interface Otp_Controller : UIViewController<UITextFieldDelegate>

@property (strong , nonatomic) NSString * serverOtp;

@property (strong, nonatomic) IBOutlet UITextField *enteredOtp;
@property (strong, nonatomic) NSString *matriID;

- (IBAction)back_Action:(id)sender;
- (IBAction)cancelBtn_Action:(id)sender;
- (IBAction)submitBtnAction:(id)sender;

@end
