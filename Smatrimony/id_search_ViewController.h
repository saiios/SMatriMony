//
//  id_search_ViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 13/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLS.h"
@interface id_search_ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UIImageView *imgView;
    NSMutableArray *img_select_ary;
}
//@property (strong, nonatomic) IBOutlet UITableView *idSearchTableView;
@property (strong, nonatomic) IBOutlet UITableView *searchMainTableView;

@property (strong, nonatomic) IBOutlet UIView *popView;
@property (strong, nonatomic) IBOutlet UITableView *popupTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *smallPopupTableView;



- (IBAction)backAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)okAction:(id)sender;
- (IBAction)submitAction:(id)sender;




@end
