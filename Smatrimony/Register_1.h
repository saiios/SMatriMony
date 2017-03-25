//
//  Register_1.h
//  Smatrimony
//
//  Created by INDOBYTES on 15/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register_1 : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *firstNameTF;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTF;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *mobileNoTF;
@property (strong, nonatomic) IBOutlet UITextField *DOBtF;
@property (strong, nonatomic) IBOutlet UITextField *religionTF;
@property (strong, nonatomic) IBOutlet UITextField *castTF;
@property (strong, nonatomic) IBOutlet UITextField *subCasteTF;

@property (strong, nonatomic) IBOutlet UITextField *profileForTF;
@property (strong, nonatomic) IBOutlet UITextField *motherToungeTF;

@property (strong, nonatomic) IBOutlet UIButton *religionBtnOutlet;

@property (strong, nonatomic) IBOutlet UIButton *motherToung;
@property (strong, nonatomic) IBOutlet UIButton *caste;

@property (strong, nonatomic) IBOutlet UIButton *profileFor;
@property (strong, nonatomic) IBOutlet UIButton *dateOfBirth;
@property (strong, nonatomic) IBOutlet UIButton *subCaste;

@property (strong, nonatomic) IBOutlet UIButton *passwordShowBtn;

@property (strong, nonatomic) IBOutlet UILabel *DOBinvalidLbl;


@end
