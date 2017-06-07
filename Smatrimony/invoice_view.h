//
//  invoice_view.h
//  Smatrimony
//
//  Created by INDOBYTES on 29/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"
#import "Invoice_view_Cell.h"
@interface invoice_view : UIViewController
{
    NSDictionary *invoice;
}
@property (strong, nonatomic) IBOutlet UITableView *table;
- (IBAction)back_click:(id)sender;

@end
