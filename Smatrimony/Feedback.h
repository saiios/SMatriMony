//
//  Feedback.h
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feedback_cell.h"
#import "CRToastView.h"
#import "STParsing.h"
@interface Feedback : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    NSArray *Cat_ary,*priority_ary;
    NSString *table_tag;
    UITapGestureRecognizer *singleFingerTap;
    NSUserDefaults *user_inf;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableTopConstraintOutlet;
- (IBAction)call_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UILabel *category_lbl;
- (IBAction)category_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cat_btn;
@property (strong, nonatomic) IBOutlet UILabel *Priority_lbl;
@property (strong, nonatomic) IBOutlet UIButton *pri_btn;
- (IBAction)priority_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *feedback_textview;
- (IBAction)submit_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *name_view;
@property (strong, nonatomic) IBOutlet UIView *cat_view;
@property (strong, nonatomic) IBOutlet UIView *priority_view;
@property (strong, nonatomic) IBOutlet NSString *username;
@property (strong, nonatomic) IBOutlet UIButton *submitBtnLabel;

@property (strong, nonatomic) IBOutlet UITextField *matriIDLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *categoryPriorityoutlet;


@end
