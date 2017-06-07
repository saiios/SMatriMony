//
//  Add_Member.h
//  Smatrimony
//
//  Created by INDOBYTES on 24/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feedback_cell.h"
#import "STParsing.h"
#import "CRToastView.h"

@interface Add_Member : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSString *name_str,*email_str,*pwd_str,*mobile_str,*dob_str,*relation_str,*religion_str,*language_str,*country_str;
    bool age_tag;
}
@property (strong, nonatomic) IBOutlet UIView *picker_view;
@property (strong, nonatomic) IBOutlet UIDatePicker *date_picker;
- (IBAction)date_done_click:(id)sender;
- (IBAction)dob_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *dateofbirth;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *table_view;
@property (strong, nonatomic) IBOutlet UIView *name_view;
@property (strong, nonatomic) IBOutlet UITextField *name_tf;
@property (strong, nonatomic) IBOutlet UIView *mobile_view;
@property (strong, nonatomic) IBOutlet UITextField *mobile_number;
@property (strong, nonatomic) IBOutlet UIView *relation_view;
- (IBAction)relation_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mother_view;
- (IBAction)mother_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *religion_view;
@property (strong, nonatomic) IBOutlet UIView *country_view;
- (IBAction)religion_click:(id)sender;
- (IBAction)country_click:(id)sender;
- (IBAction)submit_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *email_view;
@property (strong, nonatomic) IBOutlet UITextField *email_tf;
@property (strong, nonatomic) IBOutlet UIView *password_view;
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *password_tf;
@property (strong, nonatomic) IBOutlet UIView *dob_view;
@property (strong, nonatomic) IBOutlet UIView *gender_view;
@property (strong, nonatomic) IBOutlet UIButton *male;
- (IBAction)male_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *female;
- (IBAction)female_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *relation;
@property (strong, nonatomic) IBOutlet UIButton *language;
@property (strong, nonatomic) IBOutlet UIButton *religion;
@property (strong, nonatomic) IBOutlet UIButton *country;

@end
