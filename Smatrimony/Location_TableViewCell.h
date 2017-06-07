//
//  Location_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 30/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Location_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *adressOutlet;
@property (strong, nonatomic) IBOutlet UITextField *countryOutlet;
@property (strong, nonatomic) IBOutlet UITextField *stateOutlet;
@property (strong, nonatomic) IBOutlet UITextField *districtOutlet;
@property (strong, nonatomic) IBOutlet UITextField *cityOutlet;
@property (strong, nonatomic) IBOutlet UITextField *residenceStatusOutlet;

// Buttons Outlet

@property (weak, nonatomic) IBOutlet UIButton *countryBtn;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UIButton *districtBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *residenceStatusBtn;

@end
