//
//  Block_list.h
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Block_cell.h"
#import "STParsing.h"
#import "CRToastView.h"

@interface Block_list : UIViewController<UITabBarDelegate,UITableViewDataSource>
{
    NSMutableDictionary *Blocked_Dict;
    NSUserDefaults *user_inf;
    NSString *matri_id;
}

- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;
@end
