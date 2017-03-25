//
//  Success_Stories.h
//  Smatrimony
//
//  Created by INDOBYTES on 16/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "success_cell.h"
#import "Feedback_cell.h"
#import "STParsing.h"
#import "CRToastView.h"
#import "UIImageView+WebCache.h"

@interface Success_Stories : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    int s_tag;
    NSDictionary *photostories_dict;
}
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *success_table;

@end
