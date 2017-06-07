//
//  PartnerPreferenceTableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 21/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnerPreferenceTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *matchCount;

@property (strong, nonatomic) IBOutlet UILabel *lookingForLbl;

@property (strong, nonatomic) IBOutlet UILabel *agePreferenceLbl;
@property (strong, nonatomic) IBOutlet UILabel *heightPreferenceLbl;
@property (strong, nonatomic) IBOutlet UILabel *MotherToungeLbl;
@property (strong, nonatomic) IBOutlet UILabel *bodyTypeLbl;
@property (strong, nonatomic) IBOutlet UILabel *eatingHabitsLbl;
@property (strong, nonatomic) IBOutlet UILabel *smokingLbl;
@property (strong, nonatomic) IBOutlet UILabel *drinkingLbl;
@property (strong, nonatomic) IBOutlet UILabel *skinToneLbl;
@property (strong, nonatomic) IBOutlet UIImageView *profilePreferenceImage;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;


//religion

@property (strong, nonatomic) IBOutlet UILabel *ReligionLbl;
@property (strong, nonatomic) IBOutlet UILabel *casteLbl;
@property (strong, nonatomic) IBOutlet UILabel *starLbl;
@property (strong, nonatomic) IBOutlet UILabel *manglik;
// profrssional

@property (strong, nonatomic) IBOutlet UILabel *educationLbl;
@property (strong, nonatomic) IBOutlet UILabel *DesignationLbl;
@property (strong, nonatomic) IBOutlet UILabel *occupationLbl;
@property (strong, nonatomic) IBOutlet UILabel *EmployedInLbl;
@property (strong, nonatomic) IBOutlet UILabel *AnnualIncomeLbl;

//Location
@property (strong, nonatomic) IBOutlet UILabel *counrtyLbl;
@property (strong, nonatomic) IBOutlet UILabel *stateLbl;
@property (strong, nonatomic) IBOutlet UILabel *cityLbl;
@property (strong, nonatomic) IBOutlet UILabel *citizenShip;


//img

@property (strong, nonatomic) IBOutlet UIImageView *imgLookFor;
@property (strong, nonatomic) IBOutlet UIImageView *imgAgePreference;
@property (strong, nonatomic) IBOutlet UIImageView *imgHeight;
@property (strong, nonatomic) IBOutlet UIImageView *imgM_Tounge;
@property (strong, nonatomic) IBOutlet UIImageView *imgBobyType;
@property (strong, nonatomic) IBOutlet UIImageView *imgEatingHabbits;
@property (strong, nonatomic) IBOutlet UIImageView *imgSmoking;
@property (strong, nonatomic) IBOutlet UIImageView *imgDrink;
@property (strong, nonatomic) IBOutlet UIImageView *imgSkinTone;
@property (strong, nonatomic) IBOutlet UIImageView *Imgreligion;

@property (strong, nonatomic) IBOutlet UIImageView *ImgCaste;

@property (strong, nonatomic) IBOutlet UIImageView *ImgStar;

@property (strong, nonatomic) IBOutlet UIImageView *ImgManglik;



@property (strong, nonatomic) IBOutlet UIImageView *ImgEducation;
@property (strong, nonatomic) IBOutlet UIImageView *ImgDesignation;
@property (strong, nonatomic) IBOutlet UIImageView *ImgOccupation;
@property (strong, nonatomic) IBOutlet UIImageView *ImgEmployedIn;
@property (strong, nonatomic) IBOutlet UIImageView *ImgAnnualIncome;

@property (strong, nonatomic) IBOutlet UIImageView *Imgcountry;
@property (strong, nonatomic) IBOutlet UIImageView *ImgState;
@property (strong, nonatomic) IBOutlet UIImageView *ImgCity;
@property (strong, nonatomic) IBOutlet UIImageView *ImgCitizenShip;

@property (weak, nonatomic) IBOutlet UILabel *preferenceLabel;

@end
