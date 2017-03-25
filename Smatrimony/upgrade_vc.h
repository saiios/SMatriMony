//
//  msg_vc.h
//  Smatrimony
//
//  Created by INDOBYTES on 24/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "upgrade_cell.h"
#import "msg_send.h"
#import "Notifications.h"
#import "upgrade.h"
#import "offline_payment.h"
@protocol upgrade_protocol <NSObject>
@optional
-(void)payment_click:(NSDictionary *)payment_dict;
@end

@interface upgrade_vc : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSUserDefaults *user_inf;
    NSString *api_str;
    NSMutableArray *List_dict;
}

@property (strong, nonatomic) IBOutlet UITableView *newsTableView;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSString *duration;
@property(strong,nonatomic) NSMutableArray *contentArray;
@property (nonatomic, weak) id <upgrade_protocol> upgrade_delegate;


@end
