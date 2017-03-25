//
//  Register_3.h
//  Smatrimony
//
//  Created by INDOBYTES on 15/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register_3 : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *educationTF;
@property (strong, nonatomic) IBOutlet UITextField *employedTF;
@property (strong, nonatomic) IBOutlet UITextField *ocupationTF;
@property (strong, nonatomic) IBOutlet UITextField *designationTF;

@property (strong, nonatomic) IBOutlet UITextField *annualIncomeTF;

@property (strong, nonatomic) IBOutlet UITextField *familyTF;
@property (strong, nonatomic) IBOutlet UITextField *familyStatusTF;
@property (strong, nonatomic) IBOutlet UITextField *fatherNameTF;
@property (strong, nonatomic) IBOutlet UITextField *fatherOccupationTF;
@property (strong, nonatomic) IBOutlet UITextField *motherNameTF;
@property (strong, nonatomic) IBOutlet UITextField *motherOccupationTF;

//button outlet
@property (strong, nonatomic) IBOutlet UIButton *educationBtn;
@property (strong, nonatomic) IBOutlet UIButton *employedIn_Btn;
@property (strong, nonatomic) IBOutlet UIButton *occupationBtn;
@property (strong, nonatomic) IBOutlet UIButton *designationBtn;
@property (strong, nonatomic) IBOutlet UIButton *incomeBtn;
@property (strong, nonatomic) IBOutlet UIButton *familyTypeBtn;
@property (strong, nonatomic) IBOutlet UIButton *familyStatusBtn;
@property (strong, nonatomic) IBOutlet UIButton *fatherOccupationBtn;
@property (strong, nonatomic) IBOutlet UIButton *motherOccupationBtn;



@end
