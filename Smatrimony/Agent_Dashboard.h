//
//  Agent_Dashboard.h
//  Smatrimony
//
//  Created by INDOBYTES on 10/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchPopupVIew.h"
#import "JMOTableViewCell.h"
#import "PageViewController.h"
#import "Recent_Members_Cell.h"
#import "Assistants.h"
#import "Agent_EditProfile.h"
#import "STParsing.h"
#import "CRToastView.h"
#import "UIImageView+WebCache.h"
#import "Change_Password.h"
#import "Report.h"
#import "Registration.h"
#import "Add_Member.h"
#import "Login_Agent.h"

@interface Agent_Dashboard : UIViewController<searchTableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate,profileTable,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    BOOL isMenuActive;
    NSArray *leftMenuArray;
    CGRect leftmenuRect;
    NSIndexPath *path;
    int presentIndex;
    NSArray *tabsArray;
    UIView *cellSelectionBar;
    NSUserDefaults *agent_inf;
    NSString *F_id,*F_Matri_id;
}
@property (strong, nonatomic) IBOutlet UITableView *recent_table;

@property (strong, nonatomic) IBOutlet UIView *profileTableBgView;
@property (strong, nonatomic) UIPageViewController      *pageController;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageVIew;
@property (strong, nonatomic) IBOutlet NSString *user_name_str;
@property (strong, nonatomic) IBOutlet NSString *agent_id_str;
@property (strong, nonatomic) IBOutlet UITextField *search_tf;

@property (strong, nonatomic) IBOutlet UIView *leftMenuContentView;
@property (strong, nonatomic) IBOutlet UIView *leftMenuBgView;
@property (strong, nonatomic) IBOutlet UILabel *id_menu;
@property (strong, nonatomic) IBOutlet UILabel *name_menu;
@property (strong, nonatomic) IBOutlet UILabel *all_members;
@property (strong, nonatomic) IBOutlet UILabel *active_members;
@property (strong, nonatomic) IBOutlet UIView *two;
@property (strong, nonatomic) IBOutlet UILabel *paid_members;
@property (strong, nonatomic) IBOutlet UIView *three;
@property (strong, nonatomic) IBOutlet UIView *four;
@property (strong, nonatomic) IBOutlet UILabel *inactive_members;
@property (strong, nonatomic) IBOutlet UIImageView *img_menu;
@property (strong, nonatomic) IBOutlet UIView *one;
- (IBAction)search_click:(id)sender;
@property (strong, nonatomic) IBOutlet searchPopupVIew *leftMenuTable;
@end
