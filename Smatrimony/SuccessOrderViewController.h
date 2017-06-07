//
//  SuccessOrderViewController.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 05/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"
#import "MenuViewController.h"
@interface SuccessOrderViewController : UIViewController
{
    NSUserDefaults *user_data;
    NSString *user_id;
}
@property (strong, nonatomic) IBOutlet UILabel *orderStatusMessageLbl;
- (IBAction)view_yourOrdrsBtnActn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *orderIdLbl;
@property(nonatomic,strong)NSDictionary *responce;
@property(strong, nonatomic)NSDictionary *CCAvenueResponse;

@property(nonatomic,strong)NSString *From;
@property(nonatomic,strong)NSString *statusFromCCavenue;// only status
@property (strong, nonatomic) IBOutlet NSDictionary *payment_dict;

@end
