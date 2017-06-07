//
//  age_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 17/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface age_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *ageFromBtn;
@property (strong, nonatomic) IBOutlet UIButton *ageToBtn;

@property (strong, nonatomic) IBOutlet UILabel *ageFromLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageToLabel;

@end
