//
//  ProfileViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 04/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDetailViewCell.h"
#import "PageViewController.h"
#import "msg_send.h"
#import "upgrade.h"

@protocol upgradeTable <NSObject>
@optional
-(void)gotoUpgrade:(NSString *)selectedMatriId;

@end


@interface ProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *imageView;
    NSMutableArray *profileInfoAarray;
}
@property (strong, nonatomic) IBOutlet UITableView *profileTableVIew;
@property (strong,nonatomic) NSString *ClickedmatriId;
@property (strong,nonatomic) NSString *From;

@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UILabel *matriIdLabel;


- (IBAction)viewHoroscope:(id)sender;
- (IBAction)BlockBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *upgradeView;
@property (strong, nonatomic) IBOutlet UILabel *upgradeName;
@property (strong, nonatomic) IBOutlet UIImageView *upgradeImage;

@property (nonatomic, weak) id <upgradeTable> upgradeDelegate;
- (IBAction)upgradeCloseAction:(id)sender;
- (IBAction)upgradeNowAction:(id)sender;


@end
