//
//  search_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 13/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface search_TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *ageLabel;
@property (strong, nonatomic) IBOutlet UITextField *heightLabel;
@property (strong, nonatomic) IBOutlet UITextField *maritalStatusLabel;

@property (strong, nonatomic) IBOutlet UITextField *religionLabel;
@property (strong, nonatomic) IBOutlet UITextField *MTongueLabel;
@property (strong, nonatomic) IBOutlet UITextField *starLabel;
@property (strong, nonatomic) IBOutlet UITextField *countryLabel;
@property (strong, nonatomic) IBOutlet UITextField *stateLabel;
@property (strong, nonatomic) IBOutlet UITextField *eatingLabel;
@property (strong, nonatomic) IBOutlet UITextField *drinkingLabel;
@property (strong, nonatomic) IBOutlet UITextField *smokingLabel;
@property (strong, nonatomic) IBOutlet UITextField *annualIncomeLabel;

@property (weak, nonatomic) IBOutlet UILabel *casteLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *occupationLabel;

@property (weak, nonatomic) IBOutlet UILabel *educationLAbel;
@property (weak, nonatomic) IBOutlet UILabel *physicalStatusLabel;



//button outlets
@property (strong, nonatomic) IBOutlet UIButton *ageBtn;
@property (strong, nonatomic) IBOutlet UIButton *heightBtn;
@property (strong, nonatomic) IBOutlet UIButton *maritalStatusBtn;
@property (strong, nonatomic) IBOutlet UIButton *religionBtn;
@property (strong, nonatomic) IBOutlet UIButton *castebtn;
@property (strong, nonatomic) IBOutlet UIButton *MTongueBtn;
@property (strong, nonatomic) IBOutlet UIButton *starBtn;
@property (strong, nonatomic) IBOutlet UIButton *CountryBtn;
@property (strong, nonatomic) IBOutlet UIButton *DistrictBtn;
@property (strong, nonatomic) IBOutlet UIButton *stateBtn;
@property (strong, nonatomic) IBOutlet UIButton *cityBtn;
@property (strong, nonatomic) IBOutlet UIButton *educationBtn;
@property (strong, nonatomic) IBOutlet UIButton *occupationBtn;
@property (strong, nonatomic) IBOutlet UIButton *physicalStatusBtn;
@property (strong, nonatomic) IBOutlet UIButton *eatingBtn;
@property (strong, nonatomic) IBOutlet UIButton *drinkingBtn;
@property (strong, nonatomic) IBOutlet UIButton *smokingBtn;
@property (strong, nonatomic) IBOutlet UIButton *annualIncomeBtn;

@end
