//
//  HeaderTitleTableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 28/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTitleTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) IBOutlet UIImageView *profile_pic;
@property (strong, nonatomic) IBOutlet UIImageView *horoscope;
@property (strong, nonatomic) IBOutlet UIImageView *contact_info;
@property (strong, nonatomic) IBOutlet UIView *horo_view;
@property (strong, nonatomic) IBOutlet UIView *pic_view;
@property (strong, nonatomic) IBOutlet UIView *info_view;
@property (strong, nonatomic) IBOutlet UILabel *progress_lbl;

@end
