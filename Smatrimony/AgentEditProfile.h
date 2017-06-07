//
//  AgentEditProfile.h
//  Smatrimony
//
//  Created by INDOBYTES on 07/06/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgentDetailTitleCell.h"
#import "AgentEditProfilePageView.h"

@interface AgentEditProfile : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewOutlet;
@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) IBOutlet UIView *pageViewOutlet;
@end
