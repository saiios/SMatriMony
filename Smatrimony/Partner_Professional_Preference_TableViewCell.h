//
//  Partner_Professional_Preference_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 30/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Partner_Professional_Preference_TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *partIncomeOutlet;
@property (strong, nonatomic) IBOutlet UITextView *partEducationOutlet;
@property (strong, nonatomic) IBOutlet UITextView *partOccupationOutlet;
@property (strong, nonatomic) IBOutlet UITextView *partDesignationOutlet;
@property (strong, nonatomic) IBOutlet UITextView *PartEmployedInOutlet;


//// Button Outlets
@property (weak, nonatomic) IBOutlet UIButton *partEducationBtn;
@property (weak, nonatomic) IBOutlet UIButton *partOccupationBtn;
@property (weak, nonatomic) IBOutlet UIButton *partDesignationBtn;
@property (weak, nonatomic) IBOutlet UIButton *partEmplydInBtn;
@property (weak, nonatomic) IBOutlet UIButton *partAnnualIncmBtn;




@end
