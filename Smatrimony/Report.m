//
//  Report.m
//  Smatrimony
//
//  Created by INDOBYTES on 22/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Report.h"

@interface Report ()
{
    NSDictionary *salesReport;
}
@end

@implementation Report

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    agent_inf=[NSUserDefaults standardUserDefaults];
    F_id=[NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_id"]];
    F_Matri_id=[NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_matri_id"]];
    [self report_service];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)report_service
{
    NSDictionary *params = @{@"franchise_id":F_id};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"agent/salesReport" parameters:params requestNumber:WUS_FPwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         NSDictionary *res_dict=data;
         
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             salesReport=[res_dict valueForKey:@"salesReport"];
             
             if ([status isEqualToString:@"1"])
             {
                 
                 [_report_table reloadData];
                 
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
    return salesReport.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Invoice_Cell";
    Invoice_Cell  *cell = (Invoice_Cell *)[_report_table dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Invoice_Cell" owner:self options:nil];
        cell = (Invoice_Cell *)[nib objectAtIndex:0];
    }
    
    cell.matri_id.text=[NSString stringWithFormat:@"%@",[[salesReport valueForKey:@"pmatri_id"]objectAtIndex:indexPath.row]];
    cell.email.text=[NSString stringWithFormat:@"%@",[[salesReport valueForKey:@"pemail"]objectAtIndex:indexPath.row]];
    cell.mode.text=[NSString stringWithFormat:@"%@",[[salesReport valueForKey:@"paymode"]objectAtIndex:indexPath.row]];
    cell.activated_on.text=[NSString stringWithFormat:@"%@",[[salesReport valueForKey:@"pactive_dt"]objectAtIndex:indexPath.row]];
    cell.plan_name.text=[NSString stringWithFormat:@"%@",[[salesReport valueForKey:@"p_plan"]objectAtIndex:indexPath.row]];
    cell.expired_on.text=[NSString stringWithFormat:@"%@",[[salesReport       valueForKey:@"exp_date"]objectAtIndex:indexPath.row]];
    
    cell.s_no.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    [cell.download addTarget:self action:@selector(invoice_pdf:) forControlEvents:UIControlEventTouchUpInside];
    cell.download.tag=indexPath.row;
    
    cell.invoice_view.tag=indexPath.row;
    [cell.invoice_view addTarget:self action:@selector(invoice_view:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.border_view.layer.borderColor=[UIColor colorWithRed:44/225 green:52/225 blue:75/225 alpha:1].CGColor;
    cell.border_view.layer.borderWidth = 1.0f;
    
    return cell;
}

-(void)invoice_pdf:(UIButton *)sender
{
    [self invoice_doc];
    
       /*
    //services/agent/downloadInvoice
    NSString *s_id=[[salesReport valueForKey:@"invoice_id"]objectAtIndex:sender.tag];
    pdfViewViewController *con  = [[pdfViewViewController alloc]initWithNibName:@"pdfViewViewController" bundle:nil];
    con.orderUrl =[NSString stringWithFormat:@"%@/marketplace/sellerservice/invoiceprint/?id=%@",MAIN_Url,s_id];
    [self.navigationController pushViewController:con animated:YES ];
     */
}

-(void)invoice_doc
{
}

-(void)invoice_view:(UIButton *)sender
{
    invoice_view *con  = [[invoice_view alloc]initWithNibName:@"invoice_view" bundle:nil];
    [self.navigationController pushViewController:con animated:YES ];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 380;
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
