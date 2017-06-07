//
//  ProfileTableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 02/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *MatriIDLbl;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *heightLbl;
@property (strong, nonatomic) IBOutlet UILabel *AddressLbl;
@property (strong, nonatomic) IBOutlet UILabel *casteLbl;
@property (strong, nonatomic) IBOutlet UILabel *AccountLbl;

@property (strong, nonatomic) IBOutlet UIButton *SortListBtn;
@property (strong, nonatomic) IBOutlet UIButton *sendInterestBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imageOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *btnImageOutlet;
@property (strong, nonatomic) IBOutlet UILabel *shortlistLabel;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;


@end
