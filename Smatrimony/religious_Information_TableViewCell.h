//
//  religious_Information_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 30/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface religious_Information_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *motherTongueOutlet;
@property (strong, nonatomic) IBOutlet UITextField *religionOutlet;
@property (strong, nonatomic) IBOutlet UITextField *casteOutlet;
@property (strong, nonatomic) IBOutlet UITextField *subCasteOutlet;
@property (strong, nonatomic) IBOutlet UITextField *gothramOutlet;
@property (strong, nonatomic) IBOutlet UITextField *manglikOutlet;
@property (strong, nonatomic) IBOutlet UITextField *starOutlet;
@property (strong, nonatomic) IBOutlet UITextField *padamOutlet;
@property (strong, nonatomic) IBOutlet UITextField *horoscopeOutlet;
@property (strong, nonatomic) IBOutlet UITextField *moonsignOutlet;


// button outlets
@property (strong, nonatomic) IBOutlet UIButton *religiousMTongueBtn;
@property (strong, nonatomic) IBOutlet UIButton *religionBtn;
@property (weak, nonatomic) IBOutlet UIButton *casteBtn;
@property (weak, nonatomic) IBOutlet UIButton *subCasteBtn;
@property (strong, nonatomic) IBOutlet UIButton *manglikBtn;
@property (strong, nonatomic) IBOutlet UIButton *starBtn;
@property (strong, nonatomic) IBOutlet UIButton *horoscopeBtn;
@property (strong, nonatomic) IBOutlet UIButton *moonsignBtn;

@end
