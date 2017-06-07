//
//  AgentDetailCell.h
//  Smatrimony
//
//  Created by INDOBYTES on 06/06/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *matriIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *matchesLabel;
@property (strong, nonatomic) IBOutlet UITextView *addressTextView;
@property (strong, nonatomic) IBOutlet UIImageView *imageOutlet;

@property (strong, nonatomic) IBOutlet UIButton *selectionBtn;
@property (strong, nonatomic) IBOutlet UIButton *thumbBtn;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *noteBtn;

@end
