//
//  educ_profsnl_Information_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 30/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface educ_profsnl_Information_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *educationOutlet;
@property (strong, nonatomic) IBOutlet UITextField *eduInDetailOutlet;
@property (strong, nonatomic) IBOutlet UITextField *occupationOutlet;
@property (strong, nonatomic) IBOutlet UITextField *deisgnationOutlet;
@property (strong, nonatomic) IBOutlet UITextField *employedInOutlet;
@property (strong, nonatomic) IBOutlet UITextField *annualIncomeOutlet;
// Buttons Outlet
@property (weak, nonatomic) IBOutlet UIButton *educationBtn;
@property (weak, nonatomic) IBOutlet UIButton *occupationBtn;
@property (weak, nonatomic) IBOutlet UIButton *designationBtn;
@property (weak, nonatomic) IBOutlet UIButton *employedInBtn;
@property (weak, nonatomic) IBOutlet UIButton *annualIncomeBtn;




@end
