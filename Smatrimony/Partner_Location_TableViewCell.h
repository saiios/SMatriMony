//
//  Partner_Location_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 30/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Partner_Location_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *partCountryOutlet;
//@property (strong, nonatomic) IBOutlet UITextField *partStateOutlet;
//@property (strong, nonatomic) IBOutlet UITextField *partDistrictOutlet;
//@property (strong, nonatomic) IBOutlet UITextField *partCityOutlet;
@property (strong, nonatomic) IBOutlet UITextField *partResidenceStatusOutlet;
//// Button Outlets
@property (weak, nonatomic) IBOutlet UIButton *partCountryBtn;
@property (weak, nonatomic) IBOutlet UIButton *partStateBtn;
@property (weak, nonatomic) IBOutlet UIButton *partDistrictBtn;
@property (weak, nonatomic) IBOutlet UIButton *partCityBtn;
@property (weak, nonatomic) IBOutlet UIButton *partResidenceBtn;

@property (strong, nonatomic) IBOutlet UITextView *partStateOutlet;
@property (strong, nonatomic) IBOutlet UITextView *partDistrictOutlet;
@property (strong, nonatomic) IBOutlet UITextView *partCityOutlet;
@end
