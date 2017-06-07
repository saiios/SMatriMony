//
//  horoscope_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 20/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface horoscope_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *horoscopeBtn;
@property (strong, nonatomic) IBOutlet UIButton *backLabel;

// Labels
@property (weak, nonatomic) IBOutlet UILabel *dobLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeOfBirthLabel;
@property (strong, nonatomic) IBOutlet UILabel *countryBirthLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateBirthLabel;
@property (strong, nonatomic) IBOutlet UILabel *districtBirthLabel;
@property (strong, nonatomic) IBOutlet UILabel *citryBirthLabel;
@property (strong, nonatomic) IBOutlet UILabel *languageLabel;

@property (strong, nonatomic) IBOutlet UILabel *chartStyleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeOfCorrectionLabel;

// Button Outlets

@property (strong, nonatomic) IBOutlet UIButton *timeOfCorrectionOutlet;
@property (strong, nonatomic) IBOutlet UIButton *chartStyleOutlet;
@property (strong, nonatomic) IBOutlet UIButton *languageOutlet;
@property (strong, nonatomic) IBOutlet UIButton *cityOutlet;
@property (strong, nonatomic) IBOutlet UIButton *districtOutlet;
@property (strong, nonatomic) IBOutlet UIButton *stateOutlet;
@property (strong, nonatomic) IBOutlet UIButton *countryOutlet;

@property (strong, nonatomic) IBOutlet UIButton *timeOfBirthOutlet;




@end
