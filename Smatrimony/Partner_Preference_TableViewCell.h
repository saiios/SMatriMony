//
//  Partner_Preference_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 27/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Partner_Preference_TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *agePreferencesLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UILabel *annualIncomeLabel;

@property (strong, nonatomic) IBOutlet UILabel *manglikLabel;

@property (strong, nonatomic) IBOutlet UILabel *citizenShipLabel;
@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;
@property (strong, nonatomic) IBOutlet UITextView *educationLabel;
@property (strong, nonatomic) IBOutlet UITextView *designationLabel;
@property (strong, nonatomic) IBOutlet UITextView *occupationLabel;
@property (strong, nonatomic) IBOutlet UITextView *employedInLabel;
@property (strong, nonatomic) IBOutlet UITextView *lookigForLabel;
@property (strong, nonatomic) IBOutlet UITextView *physicalStatusLabel;
@property (strong, nonatomic) IBOutlet UITextView *expecationsLabel;
@property (strong, nonatomic) IBOutlet UITextView *bodyTypesLabel;
@property (strong, nonatomic) IBOutlet UITextView *eatingHabitsLabel;
@property (strong, nonatomic) IBOutlet UITextView *smokingHabitsLabel;
@property (strong, nonatomic) IBOutlet UITextView *drinkingHabitsLabel;
@property (strong, nonatomic) IBOutlet UITextView *skinToneLabel;
@property (strong, nonatomic) IBOutlet UITextView *partMtongueLabel;
@property (strong, nonatomic) IBOutlet UITextView *religionLabel;
@property (strong, nonatomic) IBOutlet UITextView *casteLabel;
@property (strong, nonatomic) IBOutlet UITextView *starLabel;
@property (strong, nonatomic) IBOutlet UITextView *countryLabel;
@property (strong, nonatomic) IBOutlet UITextView *residingStateLabel;
@property (strong, nonatomic) IBOutlet UITextView *residingCityLabel;



@property (strong, nonatomic) IBOutlet UIButton *partnerBasicBtn;
@property (strong, nonatomic) IBOutlet UIButton *partnerProfessionalBtn;
@property (strong, nonatomic) IBOutlet UIButton *partnerReligiousBtn;
@property (strong, nonatomic) IBOutlet UIButton *partnerLocationBtn;
@property (strong, nonatomic) IBOutlet UITextView *partDistrictLabel;






@end
