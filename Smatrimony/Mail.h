//
//  Mail.h
//  Smatrimony
//
//  Created by INDOBYTES on 15/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PageViewController.h"
#import "view_controller.h"
#import "PageCollectionViewCell.h"
#import "CRToastView.h"

#import "PageCollectionViewCell.h"
#import "searchPopupVIew.h"
#import "JMOTableViewCell.h"
#import "PageViewController.h"
@interface Mail : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>
{
    NSArray *inbox_ary,*sent_ary;
    int presentIndex;
    UIView *cellSelectionBar;
    NSIndexPath *path;
    NSString *Mail_tag;
    NSUserDefaults *user_inf;
    NSArray *tabsArray;
}
@property (strong, nonatomic) IBOutlet UILabel *titlee;

- (IBAction)title_click:(id)sender;
@property (strong, nonatomic) UIPageViewController      *pageController;
@property (strong, nonatomic) IBOutlet UICollectionView *tabsView;
- (IBAction)SENT_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *profileTableBgView;
- (IBAction)inbox_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mail_view;
- (IBAction)back_click:(id)sender;

@end
