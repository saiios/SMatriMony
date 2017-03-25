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

@interface Agent_Dashboard : UIViewController<searchTableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate,profileTable,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isMenuActive;
    NSArray *leftMenuArray;
    CGRect leftmenuRect;
    NSIndexPath *path;
    int presentIndex;
    NSArray *tabsArray;
    UIView *cellSelectionBar;
}
@property (strong, nonatomic) IBOutlet UITableView *recent_table;

@property (strong, nonatomic) IBOutlet UIView *profileTableBgView;
@property (strong, nonatomic) UIPageViewController      *pageController;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageVIew;

@property (strong, nonatomic) IBOutlet UIView *leftMenuContentView;
@property (strong, nonatomic) IBOutlet UIView *leftMenuBgView;
@property (strong, nonatomic) IBOutlet searchPopupVIew *leftMenuTable;
@end
