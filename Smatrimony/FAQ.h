//
//  FAQ.h
//  Smatrimony
//
//  Created by INDOBYTES on 11/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"
#import "faq_cell.h"

@interface FAQ : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    int s_tag;
    NSDictionary *faq_dict;
    faq_cell *cell;
}
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *faq_table;

@end
