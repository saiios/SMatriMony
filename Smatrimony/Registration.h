//
//  Registration.h
//  Smatrimony
//
//  Created by INDOBYTES on 23/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feedback.h"
#import "CRToastView.h"
#import "STParsing.h"

@interface Registration : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSString *name_str,*email_str,*pwd_str,*mobile_str,*address_str,*country_str,*state_str,*city_str,*dis_str,*fran_id;
    NSString *matri_id,*change_img_name;
    NSUserDefaults *agent_inf;
    NSString *F_id,*F_Matri_id;
}
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet NSString *From;
@property (strong, nonatomic) IBOutlet NSString *Franc_id;

@property (strong, nonatomic) IBOutlet UIView *name_view;
@property (strong, nonatomic) IBOutlet UITextField *name_tf;

@property (strong, nonatomic) IBOutlet UIView *email_view;
@property (strong, nonatomic) IBOutlet UITextField *email_tf;

@property (strong, nonatomic) IBOutlet UIView *pwd_view;
@property (strong, nonatomic) IBOutlet UITextField *pwd_tf;

@property (strong, nonatomic) IBOutlet UIView *mobile_view;
@property (strong, nonatomic) IBOutlet UITextField *mobile_tf;
@property (strong, nonatomic) IBOutlet UIView *country_view;
@property (strong, nonatomic) IBOutlet UIView *state_view;
@property (strong, nonatomic) IBOutlet UIView *district_view;
@property (strong, nonatomic) IBOutlet UIView *city_view;
@property (strong, nonatomic) IBOutlet UIView *comment_view;
@property (strong, nonatomic) IBOutlet UIView *photo_view;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *table_height;
@property (strong, nonatomic) IBOutlet UIView *table_view;
@property (strong, nonatomic) IBOutlet UITableView *table;
- (IBAction)country_click:(id)sender;
- (IBAction)state_click:(id)sender;
- (IBAction)submit_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *reg_title;
- (IBAction)district_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *state;
- (IBAction)city_click:(id)sender;
- (IBAction)photo_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *country;
@property (strong, nonatomic) IBOutlet UIButton *disctrict;
@property (strong, nonatomic) IBOutlet UIButton *city;
@property (strong, nonatomic) IBOutlet UITextView *comment_tv;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mobile_top_constraint;

@end
