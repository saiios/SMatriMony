//
//  view_controller.m
//  Smatrimony
//
//  Created by INDOBYTES on 15/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "view_controller.h"

@interface view_controller ()<profileTable>
{

        NSString *genderStatus,*indexID,*matri_id;
    Mail_cell *cell_mail;
    NSIndexPath *indexpathvalue;
}
@end



@implementation view_controller
@synthesize msgSendObj_delegate;

-(AppDelegate *)appdelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)viewWillAppear:(BOOL)animated
{
  // self.popUpViewOutlet.hidden = true;
    _newsTableView.delegate =self;
    _newsTableView.dataSource =self;
    [_newsTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.popUpViewOutlet.hidden = true;
    _index_lbl.text=[NSString stringWithFormat:@"%d",_index];
    
    _newsTableView.rowHeight = UITableViewAutomaticDimension;
    _newsTableView.estimatedRowHeight = 160.0; //
    // Do any additional setup after loading the view from its nib.
    
    [mail_dict removeAllObjects];
    [sent_dict removeAllObjects];
    mail_dict=[[NSMutableDictionary alloc]init];
    sent_dict=[[NSMutableDictionary alloc]init];
    user_inf=[NSUserDefaults standardUserDefaults];
   // NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    if ([_mail_tag isEqualToString:@"INBOX"])
    {
        if (_index ==0)//Pending
        {
            [dict setObject:@"Pending" forKey:@"status"];
           
        }
        else if (_index ==1)//Accept
        {
            [dict setObject:@"Accept" forKey:@"status"];
        }
        else if (_index ==2)//Reject
        {
            [dict setObject:@"Reject" forKey:@"status"];
        }
        
        [self inbox_msg:dict];
    }
    else if ([_mail_tag isEqualToString:@"SENT"])
    {
        if (_index ==1)//accept
        {
            [dict setObject:@"Accept" forKey:@"status"];
        }
        else if (_index ==0)//Pending //changed index
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
//    if (_index ==2) {
//        return 110;
//    }
//    else
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
   cell_mail = [tableView dequeueReusableCellWithIdentifier:@"Mail_cell"];
    if (cell_mail==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"Mail_cell" bundle:nil] forCellReuseIdentifier:@"Mail_cell"];
        cell_mail = [tableView dequeueReusableCellWithIdentifier:@"Mail_cell"];
    }
    cell_mail.selectionStyle =UITableViewCellSelectionStyleNone;
    
    if ([_mail_tag isEqualToString:@"SENT"])
    {
        cell_mail.short_msg.text = @"Interest Sent";
        cell_mail.name.text=[NSString stringWithFormat:@"%@ ( %@ )",[[sent_dict valueForKey:@"firstname"]objectAtIndex:indexPath.row],[[sent_dict valueForKey:@"matri_id"]objectAtIndex:indexPath.row]];// changed username to first name
        NSString *hello =[NSString stringWithFormat:@"%@",[[sent_dict valueForKey:@"ei_sent_date"]objectAtIndex:indexPath.row]];
        hello=[hello substringToIndex:11];
        cell_mail.date.text=hello;
        
        [cell_mail.send_mail addTarget:self action:@selector(send_mail_click:) forControlEvents:UIControlEventTouchUpInside];
        [cell_mail.call_now addTarget:self action:@selector(call_click:) forControlEvents:UIControlEventTouchUpInside];
        cell_mail.send_mail.tag=indexPath.row;
        cell_mail.call_now.tag=indexPath.row;
        cell_mail.call_now.hidden = true;
        cell_mail.firstBtnImage.hidden = true;
        
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
                                   cell_mail.img.image = [UIImage imageWithData:imageData];
                               });
            });
        }
        
    }
    else
    {
        if(_index == 0)
        {
            int * indexValue;
            indexValue=(int)indexPath.row;
            [cell_mail.call_now setTitle:@"       NOT INTRESTED" forState:UIControlStateNormal];//dont remove space
            cell_mail.firstBtnImage.image=[UIImage imageNamed:@"cancel.png"];
            [cell_mail.send_mail setTitle:@"  YES" forState:UIControlStateNormal];
            cell_mail.secongBtnImg.image=[UIImage imageNamed:@"ic_inbox_yes.png"];
            cell_mail.short_msg.text = @"Message Received";
            cell_mail.long_msg.text= [NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"ei_message"]objectAtIndex:indexPath.row]];//
            cell_mail.call_now.tag= indexPath.row;
            [cell_mail.call_now addTarget:self action:@selector(notInterested_Click:) forControlEvents:UIControlEventTouchUpInside];
            [cell_mail.send_mail addTarget:self action:@selector(yes_Click:) forControlEvents:UIControlEventTouchUpInside];
            
            //Image
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
                                       cell_mail.img.image = [UIImage imageWithData:imageData];
                                   });
                });
            }
            
            // NAME ND DOB
            cell_mail.name.text=[NSString stringWithFormat:@"%@ ( %@ )",[[mail_dict valueForKey:@"username"]objectAtIndex:indexPath.row],[[mail_dict valueForKey:@"matri_id"]objectAtIndex:indexPath.row]];
            NSString *hello = [NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"ei_sent_date"]objectAtIndex:indexPath.row]];
            hello=[hello substringToIndex:11];
            cell_mail.date.text=hello;
        }
        else if(_index == 1)
        {
            cell_mail.name.text=[NSString stringWithFormat:@"%@ ( %@ )",[[mail_dict valueForKey:@"username"]objectAtIndex:indexPath.row],[[mail_dict valueForKey:@"matri_id"]objectAtIndex:indexPath.row]];
            NSString *hello = [NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"ei_sent_date"]objectAtIndex:indexPath.row]];
            hello=[hello substringToIndex:11];
            cell_mail.date.text=hello;
       // cell.date.text=[NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"birthdate"]objectAtIndex:indexPath.row]];
            genderStatus = [NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"gender"]objectAtIndex:indexPath.row]];
            if ([genderStatus isEqualToString:@"Groom"]) {
                cell_mail.long_msg.text = @"You have accepted his interest";
            }
            else
            {
                 cell_mail.long_msg.text = @"You have accepted her interest";
            }
        [cell_mail.send_mail addTarget:self action:@selector(send_mail_click:) forControlEvents:UIControlEventTouchUpInside];
        [cell_mail.call_now addTarget:self action:@selector(call_click:) forControlEvents:UIControlEventTouchUpInside];
        cell_mail.send_mail.tag=indexPath.row;
        cell_mail.call_now.tag=indexPath.row;
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
                                   cell_mail.img.image = [UIImage imageWithData:imageData];
                               });
            });
        }
    }
        else
        {
            cell_mail.name.text=[NSString stringWithFormat:@"%@ ( %@ )",[[mail_dict valueForKey:@"username"]objectAtIndex:indexPath.row],[[mail_dict valueForKey:@"matri_id"]objectAtIndex:indexPath.row]];
            NSString *hello = [NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"ei_sent_date"]objectAtIndex:indexPath.row]];
            hello=[hello substringToIndex:11];
            cell_mail.date.text=hello;
            cell_mail.short_msg.text = @"Interest Declined";
            
            genderStatus = [NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"gender"]objectAtIndex:indexPath.row]];
            if ([genderStatus isEqualToString:@"Groom"]) {
                cell_mail.long_msg.text = @"You have declined his Interset";
            }
            else
            {
                cell_mail.long_msg.text = @"You have declined her Interset";
            }
            NSString *pic=[[mail_dict valueForKey:@"photo1"]objectAtIndex:indexPath.row];
            if ([pic isEqual:[NSNull null]]||[pic isEqualToString:@""])
            {
                if ([genderStatus isEqualToString:@"Groom"]) {
                    cell_mail.img.image = [UIImage imageNamed:@"male"];
                }
                else
                {
                    cell_mail.img.image = [UIImage imageNamed:@"female"];
                }
                
            }
            else
            {
                NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",pic]];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                    dispatch_async(dispatch_get_main_queue(),
                                   ^{
                                       cell_mail.img.image = [UIImage imageWithData:imageData];
                                   });
                });
            }
            // DISABLE BUTTONS
              cell_mail.buttonView.hidden = true;
//            cell.call_now.hidden = true;
//            cell.send_mail.hidden = true;
//            cell.firstBtnImage.hidden = true;
//            cell.secongBtnImg.hidden = true;
        //    [cell.frame.size.height set= 127;
        }
    }
    return cell_mail;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//}
-(void)call_click:(id)sender
{
    int tag_int=[sender tag];
    if ([_mail_tag isEqualToString:@"SENT"])
    {
        ph_no=[[sent_dict valueForKey:@"mobile"]objectAtIndex:tag_int];
       // cell_mail.call_now.hidden = YES;
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
-(void)send_mail_click:(id)str
{
  

    int sender_tag=[str tag];
    indexpathvalue = [NSIndexPath indexPathForRow:sender_tag inSection:0];
      [self checkMemberShip];
    
   }
-(void)checkMemberShip
{
    //raviratna5566@gmail.com checkmembership
    
    
    NSDictionary *memberShipDIct;
    NSString *url;
    
    
    memberShipDIct = @{@"matri_id":matri_id};
    url = @"services/api/checkmembership";
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:memberShipDIct requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         
         
         if (success)
         {
             
             NSDictionary *sortDIct = data;
             
             
             
             NSString *status=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 [self.msgSendObj_delegate sendmail_click:indexpathvalue];
             }
             else
             {
                 [self Alert:result];
             }
         }
         else
         {
             ALERT_DIALOG(@"Alert", @"Something Went Wrong");
         }
     }];
}
-(void)notInterested_Click:(UIButton *)sender
{
    self.popUpViewOutlet.hidden = false;
    Mail_cell *cell = (Mail_cell *)sender.superview.superview.superview;
    NSIndexPath *indexPath = [_newsTableView indexPathForCell:cell];
   // _selectedAddress = [userPickUpAdress objectAtIndex:indexPath.row];
    genderStatus = [NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"gender"]objectAtIndex:indexPath.row]];
    NSString *pic=[[mail_dict valueForKey:@"photo1"]objectAtIndex:indexPath.row];
    if ([pic isEqual:[NSNull null]]||[pic isEqualToString:@""])
    {
        if ([genderStatus isEqualToString:@"Groom"]) {
            cell.img.image = [UIImage imageNamed:@"male"];
        }
        else
        {
            cell.img.image = [UIImage imageNamed:@"female"];
        }

    }
    else
    {
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",pic]];
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
           dispatch_async(dispatch_get_main_queue(),
                          ^{
                                self.imageOutlet.image = [UIImage imageWithData:imageData];
                        });
       });
    }
    self.nameLabel.text = [[mail_dict valueForKey:@"username"]objectAtIndex:indexPath.row];
    self.idLabel.text =[NSString stringWithFormat:@"( %@ )",[[mail_dict valueForKey:@"matri_id"]objectAtIndex:indexPath.row]];
    
    if ([genderStatus isEqualToString:@"Groom"]) {
    self.messageOutlet.text = @"Are you sure you want to decline his Interest";
    }
    else
    {
        self.messageOutlet.text = @"Are you sure you want to decline her Interest";
    }
   indexID =[NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"ei_id"]objectAtIndex:indexPath.row]];
}

-(void)yes_Click:(UIButton *)sender
{
    Mail_cell *cell = (Mail_cell *)sender.superview.superview.superview;
    NSIndexPath *indexPath = [_newsTableView indexPathForCell:cell];
    genderStatus = [NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"gender"]objectAtIndex:indexPath.row]];
    indexID =[NSString stringWithFormat:@"%@",[[mail_dict valueForKey:@"ei_id"]objectAtIndex:indexPath.row]];
    NSDictionary * params = @{@"status":@"Accept",@"exp_id":indexID,@"gender":genderStatus};
    [self popupServiceCallFor_Post:@"services/api/updateInterest" params:params];
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

- (IBAction)cancelAction:(id)sender {
    self.popUpViewOutlet.hidden = true;
}

- (IBAction)notInterested_Yes_Action:(id)sender {
  
    NSDictionary * params = @{@"status":@"Reject",@"exp_id":indexID,@"gender":genderStatus};
    [self popupServiceCallFor_Post:@"services/api/updateInterest" params:params];
    self.popUpViewOutlet.hidden = true;
    
}

#pragma mark - Service Call

-(void)popupServiceCallFor_Post:(NSString *)url params:(NSDictionary *)params//submit actions
{
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             
             NSDictionary *res_dict = data;
             
             NSString *status = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             if ([status isEqualToString:@"1"]) {
                 ALERT_DIALOG(@"Success", @"You have Successfully declined ");
             }
             if ([status isEqualToString:@"2"]) {
                 ALERT_DIALOG(@"Alert", result);
             }
             
             
             
         }
     }];
    
}



@end
