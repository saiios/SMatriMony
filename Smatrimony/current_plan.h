//
//  current_plan.h
//  Smatrimony
//
//  Created by INDOBYTES on 10/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"

@interface current_plan : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *plan;
@property (strong, nonatomic) IBOutlet UILabel *amount;
@property (strong, nonatomic) IBOutlet UILabel *duration;
@property (strong, nonatomic) IBOutlet UILabel *contacts;
@property (strong, nonatomic) IBOutlet UILabel *view_profile;
@property (strong, nonatomic) IBOutlet UILabel *exp_date;
@property (strong, nonatomic) IBOutlet UILabel *personal_msg;
@property (strong, nonatomic) IBOutlet UILabel *d;
@property (strong, nonatomic) IBOutlet UILabel *c;
@property (strong, nonatomic) IBOutlet UILabel *v;
@property (strong, nonatomic) IBOutlet UILabel *p;
@property (strong, nonatomic) IBOutlet UILabel *e;
@property (strong, nonatomic) IBOutlet UILabel *h;
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *horo;

@end
