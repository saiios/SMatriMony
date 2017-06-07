//
//  view_controller.h
//  Smatrimony
//
//  Created by INDOBYTES on 15/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Mail_cell.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h> //@protocol profileTable_1 <NSObject>
#import "STParsing.h"
#import "msg_send.h"
#import "msg_vc.h"
//@optional
//-(void)clickedProfileTable_1:(NSIndexPath *)index;
//@end

@protocol msg_send <NSObject>
@optional
-(void)sendmail_click:(NSIndexPath *)index;

@end

@interface view_controller : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    UIImageView *checkimg;
    BOOL isCheck;
    NSUserDefaults *user_inf;
    NSMutableDictionary *mail_dict,*sent_dict;
    NSString *ph_no;
}
@property (strong, nonatomic) IBOutlet UITableView *newsTableView;
//@property (nonatomic, weak) id <profileTable_1> delegate;

-(void)reloadController:(NSArray *)news;

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) IBOutlet UILabel *index_lbl;
@property (assign, nonatomic) NSDictionary *mail_dict;
@property (assign, nonatomic) NSString *mail_tag;


// POP VIEW OUTLES

@property (strong, nonatomic) IBOutlet UIView *popUpViewOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *imageOutlet;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageOutlet;

- (IBAction)cancelAction:(id)sender;
- (IBAction)notInterested_Yes_Action:(id)sender;
 // PROTOCOL OBJ

@property (nonatomic, weak) id<msg_send> msgSendObj_delegate;



@end
