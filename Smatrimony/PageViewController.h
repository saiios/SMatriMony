//
//  PageViewController.h
//  Mews
//
//  Created by way2online on 22/04/16.
//  Copyright © 2016 venkat. All rights reserved.

#import <UIKit/UIKit.h>
#import "Photo_cell.h"
#import "Id_SearchCell.h"
#import "ProfileViewController.h"


@protocol profileTable <NSObject>
@optional
-(void)clickedProfileTable:(NSIndexPath *)index selectedMatriId:(NSString *)selectedMatriId;
-(void)gotoUpgradeAcc:(NSDictionary *)upGradeDictonary;
@end

@interface PageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *checkimg;
    BOOL isCheck;
    NSUserDefaults *user_inf;
    BOOL isPhotoView;
    
}

@property (strong, nonatomic) IBOutlet UITableView *newsTableView;
@property(strong,nonatomic)    NSMutableArray *contentArray;
@property (nonatomic, weak) id <profileTable> delegate;


-(void)reloadController:(NSArray *)news;

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) IBOutlet UIView *popUpView;
@property (strong , nonatomic) NSString *genderStrng;
@property (strong , nonatomic) NSString *city;

//@property (strong, nonatomic) IBOutlet UIView *upgradeView;
@property (strong, nonatomic) IBOutlet UILabel *upgradeName;
@property (strong, nonatomic) IBOutlet UIImageView *upgradeImage;

@property (strong, nonatomic) IBOutlet UIButton *closeBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *upgradeNowOutlet;

@property (strong, nonatomic) IBOutlet UIView *upgradeView;

@end
