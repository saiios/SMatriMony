//
//  Login_Mobile.h
//  Smatrimony
//
//  Created by S s Vali on 5/2/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "Otp_Controller.h"

@interface Login_Mobile : UIViewController
- (IBAction)cancelAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;
@property (strong , nonatomic) NSString * mobileNumbr;


@end
