//
//  HoroscopeController.h
//  Smatrimony
//
//  Created by INDOBYTES on 24/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "horoscope_TableViewCell.h"
#import "STParsing.h"
@interface HoroscopeController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *popUpTable;
@property (strong, nonatomic) IBOutlet UITableView *miniTable;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSString *Dob;

@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerOutlet;
- (IBAction)datePickerDOneAction:(id)sender;

@end
