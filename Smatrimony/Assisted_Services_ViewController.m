//
//  Assisted_Services_ViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 22/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Assisted_Services_ViewController.h"

@interface Assisted_Services_ViewController ()

@end

@implementation Assisted_Services_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"32" forKey:@"cms_id"];
    _table.hidden=YES;

    [self Assisted:dict];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Assisted:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/cmsPages" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSDictionary *cmsPages_dict=[res_dict valueForKey:@"cmsPages"];
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                NSString *add_str=[NSString stringWithFormat:@"%@",[cmsPages_dict valueForKey:@"cms_content"]];
                
                 [_webview loadHTMLString:add_str baseURL:nil];
                 
             }
             else
             {
                 [self Alert:result];
             }
         }
     }];
}

- (NSString *)stringByStrippingHTMLFromString:(NSString *)str
{
    NSMutableString *html = [NSMutableString stringWithCapacity:[str length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    scanner.charactersToBeSkipped = NULL;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:tempText];
        
        [scanner scanUpToString:@">" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
    }
    
    return html;
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

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)services_click:(id)sender
{
    _table.hidden=YES;
    _webview.hidden=NO;
    _view_1.backgroundColor=[UIColor greenColor];
    _view_2.backgroundColor=[UIColor clearColor];
}

- (IBAction)branch_click:(id)sender
{
    _webview.hidden=YES;
    _table.hidden=NO;
    _view_1.backgroundColor=[UIColor clearColor];
    _view_2.backgroundColor=[UIColor greenColor];
    [self branch_list];
}

-(void)branch_list
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"api/brancheslist" requestNumber:WS_MAIN showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             
             if ([status isEqualToString:@"1"])
             {
                 branches_list=[res_dict valueForKey:@"brancheslist"];
                 _table.delegate=self;
                 _table.dataSource=self;
                 [_table reloadData];
             }
             else
             {
                 [self Alert:result];
             }
         }
     }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return branches_list.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return  1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 250;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        Branch_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Branch_cell"];
        if (cell==nil)
        {
            [tableView registerNib:[UINib nibWithNibName:@"Branch_cell" bundle:nil] forCellReuseIdentifier:@"Branch_cell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"Branch_cell"];
        }
    
    
    NSString *addr=[NSString stringWithFormat:@"%@",[[branches_list valueForKey:@"branch_address"]objectAtIndex:indexPath.section]];
    NSString *city=[NSString stringWithFormat:@"%@",[[branches_list valueForKey:@"city"]objectAtIndex:indexPath.section]];
    NSString *country=[NSString stringWithFormat:@"%@",[[branches_list valueForKey:@"country"]objectAtIndex:indexPath.section]];
    NSString *address=[NSString stringWithFormat:@"%@, %@, %@",addr,city,country];
    
    cell.branch_name.text=[NSString stringWithFormat:@"%@",[[branches_list valueForKey:@"branch_name"]objectAtIndex:indexPath.section]];
    cell.address.text=address;
    cell.phone.text=[NSString stringWithFormat:@"%@",[[branches_list valueForKey:@"phone_num"]objectAtIndex:indexPath.section]];
    cell.email.text=[NSString stringWithFormat:@"%@",[[branches_list valueForKey:@"email_address"]objectAtIndex:indexPath.section]];
    
    cell.directions.tag=indexPath.section;
    [cell.directions addTarget:self action:@selector(direction_click:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)direction_click:(id)sender
{
    int tag_sender=[sender tag];
    NSString *addr=[NSString stringWithFormat:@"%@",[[branches_list valueForKey:@"branch_address"]objectAtIndex:tag_sender]];
    NSString *city=[NSString stringWithFormat:@"%@",[[branches_list valueForKey:@"city_name"]objectAtIndex:tag_sender]];
    NSString *country=[NSString stringWithFormat:@"%@",[[branches_list valueForKey:@"country_name"]objectAtIndex:tag_sender]];

    NSString *address=[NSString stringWithFormat:@"%@, %@, %@",addr,city,country];
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result)
    {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil])
        {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil])
            {
                [scanner scanDouble:&longitude];
            }
        }
    }
    
//    CLLocationCoordinate2D center;
//    center.latitude = latitude;
//    center.longitude = longitude;
    
    NSURL *testURL = [NSURL URLWithString:@"comgooglemaps-x-callback://"];
        if ([[UIApplication sharedApplication] canOpenURL:testURL])
        {
            NSString *directionsRequest = [NSString stringWithFormat:@"comgooglemaps-x-callback://?daddr=%f,%f&x-success=sourceapp://?resume=true&x-source=Frejun",latitude,longitude];
            NSURL *directionsURL = [NSURL URLWithString:directionsRequest];
            [[UIApplication sharedApplication] openURL:directionsURL];
        }
        else {
            NSLog(@"Can't use comgooglemaps-x-callback:// on this device.");
        }
}

//-(void)openGoogleMaps
//{
//    NSURL *testURL = [NSURL URLWithString:@"comgooglemaps-x-callback://"];
//    if ([[UIApplication sharedApplication] canOpenURL:testURL]) {
//        NSString *directionsRequest = [NSString stringWithFormat:@"comgooglemaps-x-callback://?daddr=%@,%@&x-success=sourceapp://?resume=true&x-source=Frejun",[selectedEvent objectForKey:@"latitude"],[selectedEvent objectForKey:@"longitude"]];
//        NSURL *directionsURL = [NSURL URLWithString:directionsRequest];
//        [[UIApplication sharedApplication] openURL:directionsURL];
//    } else {
//        NSLog(@"Can't use comgooglemaps-x-callback:// on this device.");
//    }
//}
@end
