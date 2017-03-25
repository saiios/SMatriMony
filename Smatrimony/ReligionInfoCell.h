//
//  ReligionInfoCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 16/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReligionInfoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *religionLbl;
@property (strong, nonatomic) IBOutlet UILabel *casteLbl;
@property (strong, nonatomic) IBOutlet UILabel *gotramLbl;
@property (strong, nonatomic) IBOutlet UILabel *starLbl;
@property (strong, nonatomic) IBOutlet UILabel *manglikLbl;
@property (strong, nonatomic) IBOutlet UILabel *horoscope;
@property (strong, nonatomic) IBOutlet UILabel *MoonsingLbl;

//professional

@property (strong, nonatomic) IBOutlet UILabel *educationLbl;
@property (strong, nonatomic) IBOutlet UILabel *designationLbl;
@property (strong, nonatomic) IBOutlet UILabel *occupationLbl;
@property (strong, nonatomic) IBOutlet UILabel *employedInLbl;
@property (strong, nonatomic) IBOutlet UILabel *annualIncomeLbl;

//locaton

@property (strong, nonatomic) IBOutlet UILabel *stateLbl;
@property (strong, nonatomic) IBOutlet UILabel *districtLbl;
@property (strong, nonatomic) IBOutlet UILabel *citizenShip;
@property (strong, nonatomic) IBOutlet UILabel *country;

// family
@property (strong, nonatomic) IBOutlet UILabel *familyTypeLbl;
@property (strong, nonatomic) IBOutlet UILabel *familyStatusLbl;
@property (strong, nonatomic) IBOutlet UILabel *fatherNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *motherNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *FatherOccupationLbl;
@property (strong, nonatomic) IBOutlet UILabel *MotherOccupationLbl;
@property (strong, nonatomic) IBOutlet UILabel *noOfBrothersLbl;
@property (strong, nonatomic) IBOutlet UILabel *noOfSistersLbl;
@property (strong, nonatomic) IBOutlet UILabel *marriedBrothersLbl;
@property (strong, nonatomic) IBOutlet UILabel *marriedsistersLbl;
@property (strong, nonatomic) IBOutlet UILabel *AboutMyFamLbl;



@end
