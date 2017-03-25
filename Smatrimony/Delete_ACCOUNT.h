//
//  Delete_ACCOUNT.h
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"
@interface Delete_ACCOUNT : UIViewController
{
    NSString *reason_str;
    NSUserDefaults *user_inf;
}
- (IBAction)back_click:(id)sender;
- (IBAction)delete_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *reason;

@end
