//
//  Report.h
//  Smatrimony
//
//  Created by INDOBYTES on 22/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invoice_Cell.h"
#import "CRToastView.h"
#import "STParsing.h"
#import "pdfViewViewController.h"
#import "invoice_view.h"

@interface Report : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults *agent_inf;
    NSString *F_id,*F_Matri_id;
}
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *report_table;

@end
