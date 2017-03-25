//
//  msg_vc.m
//  Smatrimony
//
//  Created by INDOBYTES on 24/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "upgrade_vc.h"

@interface upgrade_vc ()

@end

@implementation upgrade_vc

@synthesize contentArray;

-(AppDelegate *)appdelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)viewWillAppear:(BOOL)animated{
    [_newsTableView reloadData];
}

- (void)viewDidLoad {
    
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
    [dict setObject:_duration forKey:@"plan_duration"];
    
    [self service:dict :api_str];
}
-(void)service:(NSDictionary *)Dict :(NSString *)api
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/membershipPlans" parameters:Dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
            
             List_dict=[data valueForKey:@"planslist"];
             
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
    return 455;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     //return 10;
    return  List_dict.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    upgrade_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"upgrade_cell"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"upgrade_cell" bundle:nil] forCellReuseIdentifier:@"upgrade_cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"upgrade_cell"];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    BOOL chat=[[List_dict valueForKey:@"chat"]objectAtIndex:indexPath.row];
    if (chat==YES)
    {
        cell.chat.text=@"You Can Chat with prospects Directly";
    }
    else
        cell.chat.text=@"You Can't Chat with prospects Directly";
    
    NSString *horo=[[List_dict valueForKey:@"plan_horo"]objectAtIndex:indexPath.row];
    if ([horo isEqualToString:@"0"])
    {
        cell.chat.text=@"view Unlimited Horoscopes";
    }
    else
        cell.chat.text=[NSString stringWithFormat:@"view %@ Horoscopes",horo];
    NSString *discount=[[List_dict valueForKey:@"discount_amount"]objectAtIndex:indexPath.row];
    NSString *price=[NSString stringWithFormat:@"Rs.%@",[[List_dict valueForKey:@"plan_amount"]objectAtIndex:indexPath.row]];

    if ([discount isEqualToString:@"0"])
    {
        cell.price_month.text=@"";
        cell.price.text=price;
    }
    else
    {
        cell.price_month.text=[NSString stringWithFormat:@"%@ ",[[List_dict valueForKey:@"discount_amount"]objectAtIndex:indexPath.row]];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:price];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        cell.price.attributedText=attributeString;
    }
    cell.plan_name.text=[NSString stringWithFormat:@"%@ ",[[List_dict valueForKey:@"plan_name"]objectAtIndex:indexPath.row]];
     cell.mesages.text=[NSString stringWithFormat:@"Send %@ personalized Messages.",[[List_dict valueForKey:@"plan_msg"]objectAtIndex:indexPath.row]];
    cell.mobile.text=[NSString stringWithFormat:@"view mobile numbers of %@ members to contact them directly.",[[List_dict valueForKey:@"plan_contacts"]objectAtIndex:indexPath.row]];
    
    [cell.make_payment addTarget:self action:@selector(make_payment:) forControlEvents:UIControlEventTouchUpInside];
    cell.make_payment.tag=indexPath.row;
    
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
-(void)make_payment:(id)sender
{
    int sender_tag=[sender tag];

    [_upgrade_delegate payment_click:[List_dict objectAtIndex:sender_tag]];
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

-(void)reloadController:(NSArray *)news{
    //    [contentArray removeAllObjects];
    //    [contentArray addObjectsFromArray:news];
    //  [_newsTableView reloadData];
    
    
}
@end
