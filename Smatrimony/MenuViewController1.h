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
@interface MenuViewController1 : UIViewController<searchTableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate,profileTable>
{
    BOOL isMenuActive;
    NSArray *leftMenuArray;
    CGRect leftmenuRect;
    NSIndexPath *path;
    int presentIndex;
    NSArray *tabsArray;
    UIView *cellSelectionBar;
}
@property (strong, nonatomic) IBOutlet UIView *profileTableBgView;
@property (strong, nonatomic) UIPageViewController      *pageController;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageVIew;

@property (strong, nonatomic) IBOutlet UIView *leftMenuContentView;
@property (strong, nonatomic) IBOutlet UIView *leftMenuBgView;
@property (strong, nonatomic) IBOutlet searchPopupVIew *leftMenuTable;

@end
