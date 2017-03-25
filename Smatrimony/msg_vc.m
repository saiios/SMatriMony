//
//  msg_vc.m
//  Smatrimony
//
//  Created by INDOBYTES on 24/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "msg_vc.h"

@interface msg_vc ()

@end

@implementation msg_vc

@synthesize contentArray;
@synthesize msg_delegate;

-(AppDelegate *)appdelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_newsTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _newsTableView.delegate =self;
    _newsTableView.dataSource =self;
    
    _newsTableView.rowHeight = UITableViewAutomaticDimension;
    _newsTableView.estimatedRowHeight = 160.0; //
    // Do any additional setup after loading the view from its nib.
    List_dict =[[NSMutableArray alloc]init];
    
    [self init_service];
}

-(void)init_service
{
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    
    if (_index ==0)//accept
    {
        api_str=@"api/InboxMailsList";
    }
    else if (_index ==1)//Pending
    {
        api_str=@"api/sentMailsList";
    }
    else if (_index ==2)//Reject
    {
        api_str=@"api/draftMailsList";
    }
    else if (_index ==3)//Pending
    {
        api_str=@"api/trashedMailsList";
    }
    else if (_index ==4)//Reject
    {
        api_str=@"api/importantMailsList";
    }
    
    [self service:dict :api_str];
}
-(void)service:(NSDictionary *)Dict :(NSString *)api
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:api parameters:Dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             if (_index ==0)//inbox
             {
                 List_dict=[data valueForKey:@"inboxlist"];
             }
             else if (_index ==1)//sent
             {
                 List_dict=[data valueForKey:@"sentlist"];
             }
             else if (_index ==2)//draft
             {
                 List_dict=[data valueForKey:@"draftlist"];
             }
             else if (_index ==3)//trash
             {
                 List_dict=[data valueForKey:@"trashedlist"];
             }
             else if (_index ==4)//important
             {
                 List_dict=[data valueForKey:@"importantlist"];
             }
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             // NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             [_newsTableView reloadData];
             
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
    if (_index ==3)
    {
        return 130;
    }
    return 160;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return 1;
    return  List_dict.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Messages_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Messages_cell"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"Messages_cell" bundle:nil] forCellReuseIdentifier:@"Messages_cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Messages_cell"];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    cell.name.text=[NSString stringWithFormat:@"%@ (%@)",[[List_dict valueForKey:@"username"]objectAtIndex:indexPath.row],[[List_dict valueForKey:@"msg_from"]objectAtIndex:indexPath.row]];
    cell.dob.text=[NSString stringWithFormat:@"%@",[[List_dict valueForKey:@"birthdate"]objectAtIndex:indexPath.row]];
    cell.lbl.text=[NSString stringWithFormat:@"%@",[[List_dict valueForKey:@"msg_content"]objectAtIndex:indexPath.row]];
    [cell.reply addTarget:self action:@selector(reply_click:) forControlEvents:UIControlEventTouchUpInside];
    cell.reply.tag=indexPath.row;
    
    NSString *imp_status=[NSString stringWithFormat:@"%@",[[List_dict valueForKey:@"msg_important_status"]objectAtIndex:indexPath.row]];
    if ([imp_status isEqualToString:@"No"])
    {
        [cell.btn1 setImage:[UIImage imageNamed:@"unshortlist_icon"] forState:UIControlStateNormal];
    }
    else
        [cell.btn1 setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateNormal];
    if (_index==4||[imp_status isEqualToString:@"Yes"])
    {
         [cell.btn1 addTarget:self action:@selector(back_from_imp:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    [cell.btn1 addTarget:self action:@selector(send_to_imp:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn1.tag=indexPath.row;
    
    [cell.btn2 addTarget:self action:@selector(send_to_trash:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn2.tag=indexPath.row;
    
    NSString *img_str=[[List_dict valueForKey:@"photo1"]objectAtIndex:indexPath.row];
    if ([img_str isEqual:[NSNull null]]|| [img_str isEqualToString:@""])
    {
    }
    else
    {
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",img_str]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               cell.img.image = [UIImage imageWithData:imageData];
                               cell.img.contentMode = UIViewContentModeScaleToFill;
                           });
        });
    }
if (_index ==3)
{
    cell.btn1.hidden=YES;
    cell.btn2.hidden=YES;
    cell.reply.hidden=YES;
}
    return cell;
}

-(void)send_to_imp:(id)sender
{
    int tag_int=[sender tag];
    NSString *msg_id=[[List_dict valueForKey:@"msg_id"]objectAtIndex:tag_int];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:msg_id forKey:@"msg_ids"];
    [dict setObject:@"Yes" forKey:@"status"];

    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/savetoImportant" parameters:dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             if ([status isEqualToString:@"1"])
             {
                 [self init_service];
             }
             else
             {
                 
             }
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)back_from_imp:(id)sender
{
    int tag_int=[sender tag];
    NSString *msg_id=[[List_dict valueForKey:@"msg_id"]objectAtIndex:tag_int];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:msg_id forKey:@"msg_ids"];
    [dict setObject:@"No" forKey:@"status"];
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/savetoImportant" parameters:dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             if ([status isEqualToString:@"1"])
             {
                 [self init_service];
             }
             else
             {
                 
             }
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)send_to_trash:(id)sender
{
    int tag_int=[sender tag];
    NSString *msg_id=[[List_dict valueForKey:@"msg_id"]objectAtIndex:tag_int];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:msg_id forKey:@"msg_ids"];
    if (_index==1||_index==2||_index==4)
    {
        [dict setObject:@"sender" forKey:@"trashedby"];
    }
    else
        [dict setObject:@"reciever" forKey:@"trashedby"];
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/sendtotrashMail" parameters:dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             if ([status isEqualToString:@"1"])
             {
//                 [List_dict removeObject:1];
//                 [_newsTableView reloadData];
                 [self init_service];
             }
             else
             {
             }
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)reply_click:(id)sender
{
    int sender_tag=[sender tag];
     NSIndexPath *indexpath = [NSIndexPath indexPathForRow:sender_tag inSection:0];
     [msg_delegate M_reply_click:indexpath];
}

-(void)reloadController:(NSArray *)news
{
    //    [contentArray removeAllObjects];
    //    [contentArray addObjectsFromArray:news];
    //  [_newsTableView reloadData];
    
    
}
@end
