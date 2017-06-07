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
#import "Call_Preferences.h"
//#import "PageViewController.h"

@interface Settings : UIViewController
{
    NSUserDefaults *defaults;
}

- (IBAction)back_click:(id)sender;
- (IBAction)notif_click:(id)sender;
- (IBAction)account_click:(id)sender;
- (IBAction)change_pwd_click:(id)sender;
- (IBAction)privacy_click:(id)sender;
- (IBAction)listViewAction:(id)sender;
- (IBAction)photoViewAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *listViewBtn;
@property (strong, nonatomic) IBOutlet UIButton *photoViewBtn;


@end
