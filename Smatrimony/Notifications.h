//
//  Notifications.h
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"

@interface Notifications : UIViewController
{
    NSString *matri_id;
    NSUserDefaults *user_inf;
}
@property (strong, nonatomic) IBOutlet UISwitch *one;
@property (strong, nonatomic) IBOutlet UISwitch *two;
@property (strong, nonatomic) IBOutlet UISwitch *three;
@property (strong, nonatomic) IBOutlet UISwitch *four;
@property (strong, nonatomic) IBOutlet UISwitch *five;
- (IBAction)back_click:(id)sender;
- (IBAction)one_click:(id)sender;
- (IBAction)two_click:(id)sender;
- (IBAction)three_click:(id)sender;
- (IBAction)four_click:(id)sender;
- (IBAction)five_click:(id)sender;

@end
