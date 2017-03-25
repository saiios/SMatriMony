//
//  Settings.h
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notifications.h"
#import "Account_Settings.h"
#import "Change_Password.h"

@interface Settings : UIViewController
- (IBAction)back_click:(id)sender;
- (IBAction)notif_click:(id)sender;
- (IBAction)account_click:(id)sender;
- (IBAction)change_pwd_click:(id)sender;

@end
