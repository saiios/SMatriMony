//
//  EditProfileViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 27/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact_info.h"
@interface EditProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    float processbar;
}
@property (strong, nonatomic) IBOutlet UIButton *backClicked;

@property (strong, nonatomic) IBOutlet UITableView *editaprofileTableView;



- (IBAction)backClickedBtn:(id)sender;


@end
