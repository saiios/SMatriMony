//
//  basic_Detail_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 28/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface basic_Detail_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *firstNameOutlet;
@property (strong, nonatomic) IBOutlet UITextField *lastNameOutlet;
@property (strong, nonatomic) IBOutlet UITextField *genderOutlet;
@property (strong, nonatomic) IBOutlet UITextField *physicalStatusOutlet;
@property (strong, nonatomic) IBOutlet UITextField *dobOutlet;
@property (strong, nonatomic) IBOutlet UITextField *heightOutlet;
@property (strong, nonatomic) IBOutlet UITextField *weightOutlet;
@property (strong, nonatomic) IBOutlet UITextField *maritalStatusOutlet;
@property (strong, nonatomic) IBOutlet UITextField *motherTongueStatus;
@property (strong, nonatomic) IBOutlet UITextField *skinToneStatus;
@property (strong, nonatomic) IBOutlet UITextField *bodyTypeOutlet;
@property (strong, nonatomic) IBOutlet UITextField *profileCreatedByOutlet;
@property (strong, nonatomic) IBOutlet UITextField *eatingHabitsOutlet;
@property (strong, nonatomic) IBOutlet UITextField *drinkingHabitOutlet;
@property (strong, nonatomic) IBOutlet UITextField *smokingHabitOutlet;
@property (strong, nonatomic) IBOutlet UITextField *otherKnownLangOutlet;
@property (strong, nonatomic) IBOutlet UITextField *hobbiesOutlet;
@property (strong, nonatomic) IBOutlet UITextField *bloodGroupOutlet;
@property (strong, nonatomic) IBOutlet UITextField *birthPlaceOutlet;
@property (strong, nonatomic) IBOutlet UITextField *birthTimeOutlet;
@property (strong, nonatomic) IBOutlet UITextField *referencedByOutlet;
@property (strong, nonatomic) IBOutlet UILabel *DOBinvalidLbl;

// buttonOutlets

@property (strong, nonatomic) IBOutlet UIButton *physicalStatusBtn;
@property (strong, nonatomic) IBOutlet UIButton *dateOfBirthBtn;

@property (strong, nonatomic) IBOutlet UIButton *heightBtn;
@property (strong, nonatomic) IBOutlet UIButton *weightBtn;
@property (strong, nonatomic) IBOutlet UIButton *maritualStatusBtn;
@property (strong, nonatomic) IBOutlet UIButton *MToungeBtn;

@property (strong, nonatomic) IBOutlet UIButton *skintoneBtn;
@property (strong, nonatomic) IBOutlet UIButton *bodyTypeBtn;
@property (strong, nonatomic) IBOutlet UIButton *profileCreatedByBtn;
@property (strong, nonatomic) IBOutlet UIButton *eatingBtn;
@property (strong, nonatomic) IBOutlet UIButton *drinkingBtn;
@property (strong, nonatomic) IBOutlet UIButton *smokingBtn;
@property (strong, nonatomic) IBOutlet UIButton *otherLanguesBtn;
@property (strong, nonatomic) IBOutlet UIButton *bloodGroupBtn;
@property (strong, nonatomic) IBOutlet UIButton *referencedByBtn;










@end
