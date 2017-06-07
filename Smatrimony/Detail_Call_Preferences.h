//
//  Detail_Call_Preferences.h
//  Smatrimony
//
//  Created by INDOBYTES on 25/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
@interface Detail_Call_Preferences : UIViewController
{
    NSUserDefaults *user_inf;
    NSString *matri_id;
}

//Button Actions

- (IBAction)anytimeAction:(id)sender;
- (IBAction)fifteendaysAction:(id)sender;
- (IBAction)thirtydaysAction:(id)sender;
- (IBAction)sixtydaysAtion:(id)sender;
- (IBAction)neverAction:(id)sender;

//Buttons Outlets
@property (strong, nonatomic) IBOutlet UIButton *anytimeBtn;
@property (strong, nonatomic) IBOutlet UIButton *fifteendaysBtn;
@property (strong, nonatomic) IBOutlet UIButton *thirtydaysBtn;
@property (strong, nonatomic) IBOutlet UIButton *sixtydaysBtn;
@property (strong, nonatomic) IBOutlet UIButton *neverBtn;

@property (strong , nonatomic) NSString * resultAction;

- (IBAction)backAction:(id)sender;

@end
