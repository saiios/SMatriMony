//
//  msg_vc.h
//  Smatrimony
//
//  Created by INDOBYTES on 24/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Messages_cell.h"
#import "msg_send.h"
#import "Notifications.h"
#import "Messages.h"

@protocol msg_table <NSObject>
@optional
-(void)M_reply_click:(NSIndexPath *)index;
@end

@interface msg_vc : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSUserDefaults *user_inf;
    NSString *api_str;
    NSMutableArray *List_dict;
}
@property (strong, nonatomic) IBOutlet UITableView *newsTableView;
@property (assign, nonatomic) NSInteger index;
@property(strong,nonatomic) NSMutableArray *contentArray;
@property (nonatomic, weak) id <msg_table> msg_delegate;


@end
