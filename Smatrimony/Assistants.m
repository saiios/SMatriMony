//
//  Assistants.m
//  Smatrimony
//
//  Created by INDOBYTES on 10/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Assistants.h"

@interface Assistants ()

@end

@implementation Assistants

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self sub_agents_list];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sub_agents_list
{
    NSDictionary *params = @{@"franchise_id": @"150"};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"agent/subFranchiselist" parameters:params requestNumber:WUS_FPwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         NSDictionary *res_dict=data;
         
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             subfranchiselist=[res_dict valueForKey:@"subfranchiselist"];
             
             if ([status isEqualToString:@"1"])
             {
                 [_asistant_table reloadData];
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

#pragma mark Assitant table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (subfranchiselist.count>0)
    {
        return subfranchiselist.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Asistant_cell";
    Asistant_cell  *cell = (Asistant_cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Asistant_cell" owner:self options:nil];
        cell = (Asistant_cell *)[nib objectAtIndex:0];
    }
    NSString *status=[NSString stringWithFormat:@"%@",[[subfranchiselist valueForKey:@"franchise_status"]objectAtIndex:indexPath.row]];
    if ([status isEqualToString:@"UNAPPROVED"])
    {
        
    }
    cell.name.text=[NSString stringWithFormat:@"%@",[[subfranchiselist valueForKey:@"franchise_name"]objectAtIndex:indexPath.row]];
    cell.id_lbl.text=[NSString stringWithFormat:@"Email:%@",[[subfranchiselist valueForKey:@"f_matri_id"]objectAtIndex:indexPath.row] ];
    cell.mobile.text=[NSString stringWithFormat:@"%@",[[subfranchiselist valueForKey:@"franchise_mobile"]objectAtIndex:indexPath.row]];
    cell.address.text=[NSString stringWithFormat:@"%@,%@",[[subfranchiselist valueForKey:@"city_name"]objectAtIndex:indexPath.row] ,[[subfranchiselist valueForKey:@"state_name"]objectAtIndex:indexPath.row]];
    cell.email.text=[NSString stringWithFormat:@"%@",[[subfranchiselist valueForKey:@"franchise_email"]objectAtIndex:indexPath.row] ];
    NSString *pic=[NSString stringWithFormat:@"%@",[[subfranchiselist valueForKey:@"upload_photo"]objectAtIndex:indexPath.row] ];
    
    cell.edit.tag=indexPath.row;
    [cell.edit addTarget:self action:@selector(edit_click:) forControlEvents:UIControlEventTouchUpInside];
    
    //image with cache
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/agent/img/uploaded/%@",pic]];
    
    [manager downloadImageWithURL: imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         
         if(image)
         {
             cell.img.image = image;
         }
     }];

    if (indexPath.row%2==1)
    {
        cell.contentView.backgroundColor=[UIColor whiteColor];
    }
    return cell;
}

-(void)edit_click:(UIButton *)sender
{
    NSString *fran_id=[NSString stringWithFormat:@"%@",[[subfranchiselist valueForKey:@"franchise_id"]objectAtIndex:[sender tag]]];
    Registration *menuController  =[[Registration alloc]initWithNibName:@"Registration" bundle:nil];
    menuController.From=@"Profile";
    menuController.Franc_id=fran_id;
    [self.navigationController pushViewController:menuController animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)add_subAgent_click:(id)sender
{
    Registration *menuController  =[[Registration alloc]initWithNibName:@"Registration" bundle:nil];
    menuController.From=@"Sub";
    [self.navigationController pushViewController:menuController animated:YES];
}
- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
