//
//  annualIncome_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 18/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface annualIncome_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *incomeFromBtn;
@property (strong, nonatomic) IBOutlet UIButton *incomeToBtn;
@property (strong, nonatomic) IBOutlet UILabel *incomeToLabel;
@property (strong, nonatomic) IBOutlet UILabel *incomeFromLabel;

@end
