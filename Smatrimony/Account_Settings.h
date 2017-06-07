//
//  Account_Settings.h
//  Smatrimony
//
//  Created by INDOBYTES on 13/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Change_Password.h"
#import "Delete_ACCOUNT.h"
#import "LoginViewController.h"
#import "CRToastView.h"
#import "Block_list.h"

@interface Account_Settings : UIViewController
{
    NSUserDefaults *user_inf;
    NSString *matri_id;
}

- (IBAction)Delete_Ac:(id)sender;
- (IBAction)Logout:(id)sender;
- (IBAction)back_click:(id)sender;

@end
