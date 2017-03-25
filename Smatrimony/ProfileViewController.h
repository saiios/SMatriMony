//
//  ProfileViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 04/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDetailViewCell.h"
@interface ProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *imageView;
    NSMutableArray *profileInfoAarray;
}
@property (strong, nonatomic) IBOutlet UITableView *profileTableVIew;
@property (strong,nonatomic) NSString *ClickedmatriId;

@property (strong, nonatomic) IBOutlet UIView *menuView;
- (IBAction)viewHoroscope:(id)sender;
- (IBAction)BlockBtn:(id)sender;


@end
