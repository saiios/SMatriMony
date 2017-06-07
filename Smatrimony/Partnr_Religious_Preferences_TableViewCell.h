//
//  Partnr_Religious_Preferences_TableViewCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 30/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Partnr_Religious_Preferences_TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *partManglikOutlet;


@property (strong, nonatomic) IBOutlet UITextView *partnerMTongueTF;
@property (strong, nonatomic) IBOutlet UITextView *partStarOutlet;
@property (strong, nonatomic) IBOutlet UITextView *partcasteOutlet;
@property (strong, nonatomic) IBOutlet UITextView *partReligionOutlet;

// Button Outlets

@property (weak, nonatomic) IBOutlet UIButton *partReligionBtn;
@property (weak, nonatomic) IBOutlet UIButton *partCasteBtn;
@property (weak, nonatomic) IBOutlet UIButton *partStarBtn;
//@property (weak, nonatomic) IBOutlet UIButton *partManglikBtn;
@property (weak, nonatomic) IBOutlet UIButton *partnerMTongue;
@property (strong, nonatomic) IBOutlet UIButton *partManglikBtn;

@end
