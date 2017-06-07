//
//  Photo_cell.h
//  Smatrimony
//
//  Created by INDOBYTES on 26/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Photo_cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIButton *SortListBtn;
@property (strong, nonatomic) IBOutlet UIButton *sendInterestBtn;
@property (strong, nonatomic) IBOutlet UILabel *plan;
@property (strong, nonatomic) IBOutlet UILabel *age;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UIImageView *imageOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *sendBtnImageOutlet;
@property (strong, nonatomic) IBOutlet UILabel *photoShortListLabel;
@property (weak, nonatomic) IBOutlet UIView *hideView;

@end
