//
//  Detail_Edit_Profile_ViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 28/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detail_Edit_Profile_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
      NSMutableArray *img_select_ary;
    NSDateFormatter *dateFormat;
}
@property (strong, nonatomic) IBOutlet UIButton *backClick;
- (IBAction)backClickActn:(id)sender;


@property (strong, nonatomic) IBOutlet UITableView *editProfileTableView;
@property (strong, nonatomic) IBOutlet UITableView *popUpTableView;

- (IBAction)submmitBtnActn:(id)sender;

@property (strong, nonatomic)NSString *Clicked;
@property (strong, nonatomic) IBOutlet UIView *viewForTabie;
@property (strong, nonatomic) IBOutlet UIView *viewForDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIButton *ok;
@property (strong, nonatomic) IBOutlet UIButton *cancel;


- (IBAction)OkBtnActn:(id)sender;

- (IBAction)cancelBtnActn:(id)sender;

- (IBAction)datePickerDoneBtn:(id)sender;
- (IBAction)submitAction:(id)sender;

@end
