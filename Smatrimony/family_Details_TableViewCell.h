//
//  family_Details_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 30/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface family_Details_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *familyTypeOutlet;
@property (strong, nonatomic) IBOutlet UITextField *familyStatusOutlet;
@property (strong, nonatomic) IBOutlet UITextField *fatherNameOutlet;
@property (strong, nonatomic) IBOutlet UITextField *fathersOccupOutlet;
@property (strong, nonatomic) IBOutlet UITextField *motherNameOutlet;
@property (strong, nonatomic) IBOutlet UITextField *mothersOccupOutlet;
@property (strong, nonatomic) IBOutlet UITextField *sistersOutlet;
@property (strong, nonatomic) IBOutlet UITextField *marriedSisOutlet;
@property (strong, nonatomic) IBOutlet UITextField *brothersOutlet;
@property (strong, nonatomic) IBOutlet UITextField *marriedBrotherOutlet;

// Buttons Outlet
@property (weak, nonatomic) IBOutlet UIButton *familyTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *familyStatusBtn;
@property (weak, nonatomic) IBOutlet UIButton *sisterBtn;
@property (weak, nonatomic) IBOutlet UIButton *marriedSisBtn;
@property (weak, nonatomic) IBOutlet UIButton *brotherBtn;
@property (weak, nonatomic) IBOutlet UIButton *MarriedBroBtn;




@end
