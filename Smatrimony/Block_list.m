//
//  Block_list.m
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Block_list.h"

@interface Block_list ()

@end

@implementation Block_list

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Blocked_Dict=[[NSMutableDictionary alloc]init];
    [self Block_list];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  Blocked_Dict.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Block_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Block_cell"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"Block_cell" bundle:nil] forCellReuseIdentifier:@"Block_cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Block_cell"];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    NSString *dob=[NSString stringWithFormat:@"%@",[[Blocked_Dict valueForKey:@"birthdate"]objectAtIndex:indexPath.row]];
    
    //year
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *date1 = [dateFormatter dateFromString:today];

    NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init];
    [dateFormatte setDateFormat:@"yyyy-MM-dd"];
    NSDate *date2 = [dateFormatte dateFromString:dob];
    
    unsigned int unitFlags = NSDayCalendarUnit;
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date2  toDate:date1  options:0];
    
    int years = [comps day]/365;
    NSLog(@"%d",years);
    
    //height
    int inches= [[[Blocked_Dict valueForKey:@"height"]objectAtIndex:indexPath.row] intValue];
    float feet=inches*0.0833;
    NSString *feet_str=[NSString stringWithFormat:@"%.1f",feet];
    NSArray* theConvertion = [feet_str componentsSeparatedByCharactersInSet:
                              [NSCharacterSet characterSetWithCharactersInString:@"."]];
    int value1 = [theConvertion[0] intValue];
    int value2 = [theConvertion[1] intValue];
    
    cell.matri_id.text=[NSString stringWithFormat:@"%@",[[Blocked_Dict valueForKey:@"matri_id"]objectAtIndex:indexPath.row]];
    cell.username.text=[NSString stringWithFormat:@"%@",[[Blocked_Dict valueForKey:@"username"]objectAtIndex:indexPath.row]];
    cell.yr_hight.text=[NSString stringWithFormat:@"%d yrs, %d Ft %d in",years,value1,value2];
    cell.location.text=[NSString stringWithFormat:@"%@, %@",[[Blocked_Dict valueForKey:@"district_name"]objectAtIndex:indexPath.row],[[Blocked_Dict valueForKey:@"country_name"]objectAtIndex:indexPath.row]];
    cell.cast.text=[NSString stringWithFormat:@"%@, %@",[[Blocked_Dict valueForKey:@"religion_name"]objectAtIndex:indexPath.row],[[Blocked_Dict valueForKey:@"caste_name"]objectAtIndex:indexPath.row]];
    cell.ocp.text=[NSString stringWithFormat:@"%@",[[Blocked_Dict valueForKey:@"ocp_name"]objectAtIndex:indexPath.row]];
    NSString *pic=[NSString stringWithFormat:@"%@",[[Blocked_Dict valueForKey:@"photo1"]objectAtIndex:indexPath.row]];
    NSString * gender =[[Blocked_Dict valueForKey:@"gender"]objectAtIndex:indexPath.row];
    if ([pic isEqual:[NSNull null]]|| [pic isEqualToString:@""])
    {
        if ([gender isEqualToString:@"Groom"])
        {
            cell.img.image=[UIImage imageNamed:@"male"];
        }
        else
            cell.img.image=[UIImage imageNamed:@"female"];
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
    cell.unblock.tag=indexPath.row;
    [cell.unblock addTarget:self action:@selector(unblock_click:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)unblock_click :(id)sender
{
    int s_tag=[sender tag];
    
    NSString *M_ID=[NSString stringWithFormat:@"%@",[[Blocked_Dict valueForKey:@"matri_id"]objectAtIndex:s_tag]];

    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"loginmatri_id"];
    [dict setObject:M_ID forKey:@"matri_id"];
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/removeFromBlocklist" parameters:dict requestNumber:WUS_unblock showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             if ([status isEqualToString:@"1"])
             {
                 [self Block_list];
                 //[Blocked_Dict removeObjectForKey:[NSNumber numberWithInt:s_tag]];
//                 [Blocked_Dict removeObjectsForKeys:s_tag];
                // [_table reloadData];
                // [self Alert:result];
             }
             else
                  [self Alert:result];
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)Block_list
{
    user_inf=[NSUserDefaults standardUserDefaults];
    matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    
     [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/blocklistedProfiles" parameters:dict requestNumber:WUS_Block_list showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             
             if ([status isEqualToString:@"1"])
             {
                 Blocked_Dict=[res_dict valueForKey:@"blocklisted"];
                 _table.hidden=NO;
             }
             else
             {
                 _table.hidden=YES;
                 [self Alert:result];
             }
             [_table reloadData];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
