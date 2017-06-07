//
//  Assisted_Services_ViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 22/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"
#import "Branch_cell.h"

@interface Assisted_Services_ViewController : UIViewController<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *branches_list;
}

- (IBAction)backAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)services_click:(id)sender;
- (IBAction)branch_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *view_1;
@property (strong, nonatomic) IBOutlet UIView *view_2;

@end
