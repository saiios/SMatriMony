//
//  DailyRecommendations.h
//  Smatrimony
//
//  Created by INDOBYTES on 16/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageCollectionViewCell.h"
#import "DR_vc.h"
#import "ProfileViewController.h"
@interface DailyRecommendations : UIViewController
{
    NSArray *inbox_ary,*sent_ary;
    int presentIndex;
    UIView *cellSelectionBar;
    NSIndexPath *path;
    NSUserDefaults *user_inf;
    NSDictionary *daily_matches;
    NSUInteger s_index;
}
- (IBAction)back_click:(id)sender;
-(UIViewController *)viewControllerAtIndex:(NSUInteger) index;

@property (strong, nonatomic) UIPageViewController      *pageController;
@property (strong, nonatomic) IBOutlet UIView *profileTableBgView;
@end
