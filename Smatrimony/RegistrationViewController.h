//
//  RegistrationViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 03/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRToastView.h"



@interface RegistrationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITableView *RegisterTableView;

@property (strong, nonatomic) IBOutlet UITableView *PopUpTableView;
@property (strong, nonatomic) IBOutlet UIView *ViewPopUp;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIView *ViewDatePicker;


- (IBAction)ContinueBtnActn:(id)sender;
- (IBAction)backClick:(id)sender;
- (IBAction)datePicker_DoneBtnActn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *continueBtnOutlet;



//datepicker



@end
