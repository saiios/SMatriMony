//
//  DR_vc.h
//  Smatrimony
//
//  Created by INDOBYTES on 24/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DR_cell.h"
#import "DailyRecommendations.h"

@protocol daily_protocol <NSObject>
-(void)Daily_Detail:(int)row; //I am thinking my data is NSArray, you can use another object for store your information.
@end


@interface DR_vc : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSUserDefaults *user_inf;
    NSString *gender;
    NSTimer *timerd;
    //IBOutlet UILabel *myCounterLabel;

}
@property(nonatomic,assign)id Daily_delegate;

@property (nonatomic, retain) UILabel *myCounterLabel;
-(void)updateCounter:(NSTimer *)theTimer;
-(void)countdownTimer;

@property (strong, nonatomic) IBOutlet UITableView *newsTableView;
@property (assign, nonatomic) NSInteger index;
@property(strong,nonatomic) NSMutableArray *contentArray;

@property (assign, nonatomic) NSString *name;
@property (assign, nonatomic) NSString *address;
@property (assign, nonatomic) NSString *img;
@property (assign, nonatomic) NSString *m_id;


@property (assign, nonatomic) NSString *height;
@property (assign, nonatomic) NSString *str;

@end
