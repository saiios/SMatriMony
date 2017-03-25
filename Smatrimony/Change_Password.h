//
//  Change Password.h
//  Smatrimony
//
//  Created by INDOBYTES on 13/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"

@interface Change_Password : UIViewController<UITextFieldDelegate>
{
    BOOL keyboardIsShown;
    int scrollHeight;
    NSUserDefaults *user_inf;
}
@property (strong, nonatomic) IBOutlet UITextField *old_pwd;
@property (strong, nonatomic) IBOutlet UITextField *c_new_pwd;
@property (strong, nonatomic) IBOutlet UITextField *N_pwd;
- (IBAction)Submit_click:(id)sender;
- (IBAction)back_click:(id)sender;

@end
