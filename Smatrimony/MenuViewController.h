//
//  MenuViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 02/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchPopupVIew.h"
#import "JMOTableViewCell.h"
#import "PageViewController.h"
#import "Settings.h"
#import "Feedback.h"
#import "Mail.h"
#import "Success_Stories.h"
#import "LoginViewController.h"
#import "Messages.h"
#import "DailyRecommendations.h"
#import "All_photos.h"
#import "current_plan.h"
#import "FAQ.h"
#import "contact_us.h"
#import "upgrade.h"

@interface MenuViewController : UIViewController<searchTableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate,profileTable>
{
    BOOL isMenuActive;
    NSArray *leftMenuArray,*menu_ary,*leftMenu_imgs;
    CGRect leftmenuRect;
    NSIndexPath *path;
    int presentIndex;
    NSArray *tabsArray;
    UIView *cellSelectionBar;
    NSUserDefaults *user_inf;
    NSString *matri_id,*profile_pic,*pay_status;
}
@property (strong, nonatomic) IBOutlet UIView *profileTableBgView;
@property (strong, nonatomic) UIPageViewController      *pageController;
@property (strong, nonatomic) IBOutlet UICollectionView *tabsView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageVIew;
@property (strong, nonatomic) IBOutlet NSString *user_name_str;

@property (strong, nonatomic) IBOutlet UIView *leftMenuContentView;
@property (strong, nonatomic) IBOutlet UIView *leftMenuBgView;
@property (strong, nonatomic) IBOutlet searchPopupVIew *leftMenuTable;
- (IBAction)profile_click:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *mat_id;

@end
