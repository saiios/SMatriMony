//
//  Assistants.h
//  Smatrimony
//
//  Created by INDOBYTES on 10/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Asistant_cell.h"
#import "Registration.h"
#import "UIImageView+WebCache.h"

@interface Assistants : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *subfranchiselist;
}
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *asistant_table;
- (IBAction)add_subAgent_click:(id)sender;

@end
