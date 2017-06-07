//
//  AgentBasicDetailCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 07/06/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentBasicDetailCell : UITableViewCell

// TextField Outlets

@property (strong, nonatomic) IBOutlet UITextView *aboutprofileTextView;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBirth;
@property (strong, nonatomic) IBOutlet UITextField *height;
@property (strong, nonatomic) IBOutlet UITextField *weight;
@property (strong, nonatomic) IBOutlet UITextField *maritalStatus;
@property (strong, nonatomic) IBOutlet UITextField *birthPlace;
@property (strong, nonatomic) IBOutlet UITextField *birthTime;
@property (strong, nonatomic) IBOutlet UITextField *skinTone;
@property (strong, nonatomic) IBOutlet UITextField *bodyType;
@property (strong, nonatomic) IBOutlet UITextField *profileCreatedBy;
@property (strong, nonatomic) IBOutlet UITextField *referencedBy;
@property (strong, nonatomic) IBOutlet UITextField *bloodGroup;
@property (strong, nonatomic) IBOutlet UITextField *diet;
@property (strong, nonatomic) IBOutlet UITextField *drinkingHabits;
@property (strong, nonatomic) IBOutlet UITextField *smokingHabits;
@property (strong, nonatomic) IBOutlet UITextField *otherKownLanguages;
@property (strong, nonatomic) IBOutlet UITextField *hobby;


// Button Outlets
@property (strong, nonatomic) IBOutlet UIButton *genderBtn;
@property (strong, nonatomic) IBOutlet UIButton *dateOfBirthBtn;
@property (strong, nonatomic) IBOutlet UIButton *heightBtn;
@property (strong, nonatomic) IBOutlet UIButton *weightBtn;
@property (strong, nonatomic) IBOutlet UIButton *maritalStatusBtn;
@property (strong, nonatomic) IBOutlet UIButton *skinToneBtn;
@property (strong, nonatomic) IBOutlet UIButton *bodyTypeBtn;
@property (strong, nonatomic) IBOutlet UIButton *profileCreatedByBtn;
@property (strong, nonatomic) IBOutlet UIButton *referencedByBtn;
@property (strong, nonatomic) IBOutlet UIButton *bloodGroupBtn;
@property (strong, nonatomic) IBOutlet UIButton *dietBtn;
@property (strong, nonatomic) IBOutlet UIButton *drinkingHabitsBtn;
@property (strong, nonatomic) IBOutlet UIButton *smokingHabitsBtn;
@property (strong, nonatomic) IBOutlet UIButton *otherKnownLanguagesBtn;














@end
