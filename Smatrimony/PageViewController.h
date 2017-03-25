//
//  PageViewController.h
//  Mews
//
//  Created by way2online on 22/04/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol profileTable <NSObject>
@optional
-(void)clickedProfileTable:(NSIndexPath *)index;
@end
@interface PageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *checkimg;
    BOOL isCheck;
    NSUserDefaults *user_inf;
}

@property (strong, nonatomic) IBOutlet UITableView *newsTableView;
@property(strong,nonatomic)    NSMutableArray *contentArray;
@property (nonatomic, weak) id <profileTable> delegate;

-(void)reloadController:(NSArray *)news;

@property (assign, nonatomic) NSInteger index;
@end
