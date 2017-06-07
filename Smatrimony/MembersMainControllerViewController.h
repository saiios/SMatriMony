//
//  MembersMainControllerViewController.h
//  Smatrimony
//
//  Created by S s Vali on 5/31/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleCell.h"
#import "MembersPageView.h"
#import "AgentEditProfile.h"
@interface MembersMainControllerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewOutlet;
@property (strong, nonatomic) IBOutlet UIView *pageViewOutlet;
@property (strong, nonatomic) UIPageViewController *pageController;

@end
