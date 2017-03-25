//
//  view_controller.m
//  Smatrimony
//
//  Created by INDOBYTES on 15/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "view_controller.h"

@interface view_controller ()

@end

@implementation view_controller


-(AppDelegate *)appdelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)viewWillAppear:(BOOL)animated
{
    _newsTableView.delegate =self;
    _newsTableView.dataSource =self;
    [_newsTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _index_lbl.text=[NSString stringWithFormat:@"%d",_index];
    
    _newsTableView.rowHeight = UITableViewAutomaticDimension;
    _newsTableView.estimatedRowHeight = 160.0; //
    // Do any additional setup after loading the view from its nib.
    
    [mail_dict removeAllObjects];
    [sent_dict removeAllObjects];
    mail_dict=[[NSMutableDictionary alloc]init];
    sent_dict=[[NSMutableDictionary alloc]init];
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    if ([_mail_tag isEqualToString:@"INBOX"])
    {
        if (_index ==0)//accept
        {
            [dict setObject:@"Accept" forKey:@"status"];
        }
        else if (_index ==1)//Pending
        {
            [dict setObject:@"Pending" forKey:@"status"];
        }
        else if (_index ==2)//Reject
        {
            [dict setObject:@"Reject" forKey:@"status"];
        }
        
        [self inbox_msg:dict];
    }
    else if ([_mail_tag isEqualToString:@"SENT"])
    {
        if (_index ==0)//accept
        {
            [dict setObject:@"Accept" forKey:@"status"];
        }
        else if (_index ==1)//Pending
        {
            [dict setObject:@"Pending" forKey:@"status"];
        }
        else if (_index ==2)//Reject
        {
            [dict setObject:@"Reject" forKey:@"status"];
        }
        
        [self sent_msg:dict];
    }
}

-(void)inbox_msg:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/interestReceivedProfiles" parameters:Dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             mail_dict=[data valueForKey:@"interestedprofiles"];
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             // NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             [_newsTableView reloadData];
             
             if ([status isEqualToString:@"1"])
             {
                 [_newsTableView reloadData];
             }
             else
             {
                 UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _newsTableView.bounds.size.width, _newsTableView.bounds.size.height)];
                 noDataLabel.text             = @"No Data Found.";
                 noDataLabel.numberOfLines=2;
                 noDataLabel.textColor        = [UIColor blackColor];
                 noDataLabel.textAlignment    = NSTextAlignmentCenter;
                 _newsTableView.backgroundView = noDataLabel;
             }
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)sent_msg:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/interestSentProfiles" parameters:Dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             sent_dict=[data valueForKey:@"interestedprofiles"];
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             // NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
             }
             else
             {
                 UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _newsTableView.bounds.size.width, _newsTableView.bounds.size.height)];
                 noDataLabel.text             = @"No Data Found.";
                 noDataLabel.numberOfLines=2;
                 noDataLabel.textColor        = [UIColor blackColor];
                 noDataLabel.textAlignment    = NSTextAlignmentCenter;
                 _newsTableView.backgroundView = noDataLabel;
             }
             [_newsTableView reloadData];

         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)Alert:(NSString *)Msg
{
    NSDictionary *options = @{kCRToastNotificationTypeKey:@(CRToastTypeNavigationBar),
                              
                              kCRToastTextKey : Msg,
                              
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              
                              kCRToastBackgroundColorKey : [UIColor colorWithRed:13.0/255.0 green:147.0/255.0 blue:68.0/255.0 alpha:1],
                              kCRToastTimeIntervalKey: @(2),
                              //                              kCRToastFontKey:[UIFont fontWithName:@"PT Sans Narrow" size:23],
                              kCRToastInteractionRespondersKey:@[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeSwipeUp
                                                                  
                                                                                                                 automaticallyDismiss:YES
                                                                  
                                                                                                                                block:^(CRToastInteractionType interactionType){
                                                                                                                                    
                                                                                                                                    NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
                                                                                                                                }]],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              };
    
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                    NSLog(@"Completed");
                                }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return 1;
    if ([_mail_tag isEqualToString:@"SENT"])
    {
        return sent_dict.count;
    }
    else
        return  mail_dict.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Mail_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mail_cell"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"Mail_cell" bundle:nil] forCellReuseIdentifier:@"Mail_cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Mail_cell"];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    if ([_mail_tag isEqualToString:@"SENT"])
    {
        cell.name.text=[NSString stringWithFormat:@"%@ %@",[[sent_dict valueForKey:@"username"]objectAtIndex:indexPath.row],[[sent_dict valueForKey:@"matri_id"]objectAtIndex:indexPath.row]];
        cell.date.text=[NSString stringWithFormat:@"%@",[[sent_dict valueForKey:@"birthdate"]objectAtIndex:indexPath.row]];
        [cell.send_mail addTarget:self action:@selector(send_mail_click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.call_now addTarget:self action:@selector(call_click:) forControlEvents:UIControlEventTouchUpInside];
        cell.send_mail.tag=indexPath.row;
        cell.call_now.tag=indexPath.row;
        
        NSString *pic=[[sent_dict valueForKey:@"photo1"]objectAtIndex:indexPath.row];
        if ([pic isEqual:[NSNull null]]||[pic isEqualToString:@""])
        {
        }
        else
        {
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",pic]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                                   cell.img.image = [UIImage imageWithData:imageData];
                               });
            });
        }
        
    }
    else
    {
        cell.name.text=[NSString stringWithFormat:@"%@ %@",[[mail_dict valueForKey:@"username"]objectAtIndex:indexPath.row],[[mail_dict valueForKey:@"matri_id"]objectAtIndex:indexPath.row]];
        cell.date.text=[NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"birthdate"]objectAtIndex:indexPath.row]];
        [cell.send_mail addTarget:self action:@selector(send_mail_click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.call_now addTarget:self action:@selector(call_click:) forControlEvents:UIControlEventTouchUpInside];
        cell.send_mail.tag=indexPath.row;
        cell.call_now.tag=indexPath.row;
        NSString *pic=[[mail_dict valueForKey:@"photo1"]objectAtIndex:indexPath.row];
        if ([pic isEqual:[NSNull null]]||[pic isEqualToString:@""])
        {
        }
        else
        {
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",pic]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                                   cell.img.image = [UIImage imageWithData:imageData];
                               });
            });
        }
    }
    return cell;
}

-(void)call_click:(id)sender
{
    int tag_int=[sender tag];
    if ([_mail_tag isEqualToString:@"SENT"])
    {
        ph_no=[[sent_dict valueForKey:@"mobile"]objectAtIndex:tag_int];
    }
    else
        ph_no=[[mail_dict valueForKey:@"mobile"]objectAtIndex:tag_int];
    
    NSString *phoneNumber = [@"tel://" stringByAppendingString:ph_no];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    /*
     NSString *phNo = @"+919876543210";
     NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
     
     if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
     [[UIApplication sharedApplication] openURL:phoneUrl];
     } else
     {
     calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
     [calert show];
     }
     */
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//  //  [_delegate clickedProfileTable_1:indexPath];
//}


-(void)reloadController:(NSArray *)news{
    //    [contentArray removeAllObjects];
    //    [contentArray addObjectsFromArray:news];
    //  [_newsTableView reloadData];
}

//mail
// From within your active view controller
-(void)send_mail_click:(NSString *)str
{
    // From within your active view controller
    //    if([MFMailComposeViewController canSendMail]) {
    MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
    mailCont.mailComposeDelegate = self;
    // Required to invoke mailComposeController when send
    
    [mailCont setSubject:@"SMatrimony"];
    [mailCont setToRecipients:[NSArray arrayWithObject:@""]];
    [mailCont setMessageBody:@"" isHTML:NO];
    
    [self presentViewController:mailCont animated:YES completion:nil];
    //    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
