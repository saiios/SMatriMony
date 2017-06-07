//
//  DR_vc.m
//  Smatrimony
//
//  Created by INDOBYTES on 24/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "DR_vc.h"
#import "DDHTimerControl.h"


@interface DR_vc ()
{
    NSString *orginalTime;
    DR_cell *cell;
}



@end

@implementation DR_vc
@synthesize Daily_delegate;
//@synthesize myCounterLabel;
int hours, minutes, seconds;
int secondsLeft;

NSInteger totalSeconds;

-(AppDelegate *)appdelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}




-(void)viewWillAppear:(BOOL)animated
{
  //  [self timmer];
    

    [_newsTableView reloadData];
}

-(void)timmer
{
    NSDate* now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitHour  | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    NSInteger second = [dateComponents second];
    
    NSInteger standardHour = 23;
    NSInteger standardMinute = 59;
    NSInteger standardSecond =59;
    
    NSInteger remainingHours = (standardHour- hour);
    NSInteger remainingMinute = (standardMinute- minute);
    NSInteger remainingSecond = (standardSecond- second);
    
    totalSeconds = remainingSecond+(remainingMinute*60)+(remainingHours*60*60);
    BOOL isFirstTime;
   // totalSeconds = 30;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
       
    _newsTableView.delegate =self;
    _newsTableView.dataSource =self;
    
    _newsTableView.rowHeight = UITableViewAutomaticDimension;
    _newsTableView.estimatedRowHeight = 160.0; //
    
    
    user_inf=[NSUserDefaults standardUserDefaults];
    gender=[user_inf valueForKey:@"gender"];
                  [self countdownTimer];
              
  }




- (void)updateCounter:(NSTimer *)theTimer {
    [self timmer];
    secondsLeft = (int)totalSeconds;
    if(secondsLeft > 0 ){
        
                       secondsLeft -- ;
                   hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
       orginalTime = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
        cell.timerLabel.text = orginalTime;
    }
    else{
        secondsLeft = (int)totalSeconds;
    }
}

-(void)countdownTimer{
    
    secondsLeft = hours = minutes = seconds = 0;
   
    timerd = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height;
    //return 160;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return 1;
    return  _contentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"DR_cell"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"DR_cell" bundle:nil] forCellReuseIdentifier:@"DR_cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"DR_cell"];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.name.text=[NSString stringWithFormat:@"%@ (%@)",_name,_m_id];
    //    NSString *y_a=[NSString stringWithFormat:@"%@",_yr_age];
    //height
    cell.timerLabel.text = orginalTime;
    int inches= [_height intValue];
    float feet=inches*0.0833;
    NSString *feet_str=[NSString stringWithFormat:@"%.1f",feet];
    NSArray* theConvertion = [feet_str componentsSeparatedByCharactersInSet:
                              [NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSString *value1 = theConvertion[0];
    NSString *value2 = theConvertion[1];
    
    //year
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *date1 = [dateFormatter dateFromString:today];
    
    NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init];
    [dateFormatte setDateFormat:@"yyyy-MM-dd"];
    NSString *str_dob=_str;
    NSDate *date2 = [dateFormatte dateFromString:[NSString stringWithFormat:@"%@",str_dob]];
    
    unsigned int unitFlags = NSDayCalendarUnit;
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date2  toDate:date1  options:0];
    
    NSString *years = [NSString stringWithFormat:@"%d",([comps day]/365)];
    
    NSString *age_str=[NSString stringWithFormat:@"%@ Yrs %@ Ft %@ in",years,value1,value2];
    
    cell.age.text=age_str;
    cell.address.text=[NSString stringWithFormat:@"%@",_address];
    
    if ([_img isEqual:[NSNull null]]|| [_img isEqualToString:@""])
    {
        if ([gender isEqualToString:@"Groom"])
        {
            cell.img.image=[UIImage imageNamed:@"female"];
        }
        else
            cell.img.image=[UIImage imageNamed:@"male"];
    }
    else
    {
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",_img]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               cell.img.image = [UIImage imageWithData:imageData];
                               cell.img.contentMode = UIViewContentModeScaleToFill;
                           });
        });
    }
    [cell.skip addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    [cell.yes addTarget:self action:@selector(yes:) forControlEvents:UIControlEventTouchUpInside];
    cell.skip.tag=indexPath.row;
    cell.yes.tag=indexPath.row;
    [cell.full_profile addTarget:self action:@selector(full_profile:) forControlEvents:UIControlEventTouchUpInside];
    cell.full_profile.tag=indexPath.row;
    return cell;
}
-(void)full_profile:(id)sender
{
    int tag=[sender tag];
    
    
    [Daily_delegate Daily_Detail:tag];
}

-(void)skip:(id)sender
{
    int tag_int=[sender tag];
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:_m_id forKey:@"matri_id"];
    [dict setObject:matri_id forKey:@"loginmatri_id"];
    [self ADD_TO_block_service:dict];
}

-(void)yes:(id)sender
{
    int tag_int=[sender tag];
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:_m_id forKey:@"matri_id"];
    [dict setObject:matri_id forKey:@"loginmatri_id"];
    [self intrest_service:dict];
}

-(void)intrest_service:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/sendInterest" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             if ([status isEqualToString:@"1"])
             {
                 
             }
             else
                 [self Alert:result];
             /*
              {
              result = "You are not a paid member, Please upgrade your membership to express the interest.";
              status = 2;
              }
              */
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)ADD_TO_block_service:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/ignoreProfile" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             if ([status isEqualToString:@"1"])
             {
//                 DailyRecommendations *menuController  =[[DailyRecommendations alloc]initWithNibName:@"DailyRecommendations" bundle:nil];
//                 [self.navigationController pushViewController:menuController animated:YES];
                 DailyRecommendations *dr=[[DailyRecommendations alloc]init];
                 [dr viewControllerAtIndex:_index+1];
             }
             
             [self Alert:result];
             /*
              {
              result = "You are not a paid member, Please upgrade your membership to express the interest.";
              status = 2;
              }
              */
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


-(void)reloadController:(NSArray *)news
{
    //    [contentArray removeAllObjects];
    //    [contentArray addObjectsFromArray:news];
    //  [_newsTableView reloadData];
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
