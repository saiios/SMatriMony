//
//  invoice_view.m
//  Smatrimony
//
//  Created by INDOBYTES on 29/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "invoice_view.h"

@interface invoice_view ()

@end

@implementation invoice_view

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _table.delegate=self;
    _table.dataSource=self;
    _table.estimatedRowHeight = 500.0; //

    [self invoice_view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)invoice_view
{
    NSDictionary *params = @{@"index_id": @"7940"};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"agent/salesReportInvoice" parameters:params requestNumber:WUS_FPwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         NSDictionary *res_dict=data;
         
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             //salesReport=[res_dict valueForKey:@"salesReport"];
             
             if ([status isEqualToString:@"1"])
             {
                 invoice =[[res_dict valueForKey:@"invoice"]objectAtIndex:0];
                 [_table reloadData];
                 
             }
             else
             {
                 [self Alert:result];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (invoice.count>0)
    {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Invoice_view_Cell";
    Invoice_view_Cell  *cell = (Invoice_view_Cell *)[_table dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Invoice_view_Cell" owner:self options:nil];
        cell = (Invoice_view_Cell *)[nib objectAtIndex:0];
    }
    
    cell.invoice_id.text=[NSString stringWithFormat:@"Invoice: INVOO1%@",[invoice valueForKey:@"matri_id"]];
    cell.customer_id.text=[NSString stringWithFormat:@"Customer Id: %@",[invoice valueForKey:@"matri_id"]];
    cell.pay_mode.text=[NSString stringWithFormat:@"Payment Mode: %@",[invoice valueForKey:@"paymode"]];
    
     cell.company_name.text=[NSString stringWithFormat:@"%@",[invoice valueForKey:@"web_frienly_name"]];
     cell.com_email.text=[NSString stringWithFormat:@"Email:%@",[invoice valueForKey:@"from_email"]];
     cell.p_mobile.text=[NSString stringWithFormat:@"%@",[invoice valueForKey:@"mobile"]];
     cell.plan_type.text=[NSString stringWithFormat:@"%@",[invoice valueForKey:@"p_plan"]];
     cell.p_email.text=[NSString stringWithFormat:@"%@",[invoice valueForKey:@"pemail"]];
    
    cell.plan_name.text=[NSString stringWithFormat:@"%@",[invoice valueForKey:@"pname"]];
    cell.activated_on.text=[NSString stringWithFormat:@"%@",[invoice valueForKey:@"pactive_dt"]];
    NSString * amount=[NSString stringWithFormat:@"%@",[invoice valueForKey:@"p_amount"]];

    NSString * plan_duration=[NSString stringWithFormat:@"%@",[invoice valueForKey:@"plan_duration"]];
    if ([plan_duration isEqualToString:@"Unlimited"]||[plan_duration isEqualToString:@"0 months"])
    {
        cell.exp_on.text=@"---";
    }
    else
        cell.exp_on.text=[NSString stringWithFormat:@"%@",[invoice valueForKey:@"exp_date"]];

    cell.product_amount.text=[NSString stringWithFormat:@"Product Amount:%@",amount];
    float amount_int=[amount floatValue];
    float service_tax_int=(amount_int/100)*14;
    float swatch_barath_int=(amount_int/100)*0.5;
    float grand_int=amount_int+service_tax_int+swatch_barath_int;
    
    cell.service_tax.text=[NSString stringWithFormat:@"Service Tax (14%%):%.2f",service_tax_int];
    cell.swatch_bharath.text=[NSString stringWithFormat:@"Swachh Bharat Cess (0.5%%):%.2f",swatch_barath_int];
    cell.grand_total.text=[NSString stringWithFormat:@"%.2f",grand_int];

    return cell;
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
