//
//  MembersPageView.m
//  Smatrimony
//
//  Created by INDOBYTES on 31/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "MembersPageView.h"

@interface MembersPageView ()
{
    AgentDetailCell * cell;
}
@end

@implementation MembersPageView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.textValue.text = [NSString stringWithFormat:@"this is %ld page",(long)_index];
    NSDictionary * params = @{@"matri_id":@"SAP151"};
    [self profileServiceCallFor_Post:@"memberFullProfile" params:params];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *MyIdentifier = @"agentCell";
//    cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
//    // cell.accessoryType = UITableViewCellAccessoryNone;
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
//    }
    static NSString *simpleTableIdentifier = @"agentDetailCell";
    cell = (AgentDetailCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //   ageCell.accessoryType = UITableViewCellAccessoryNone;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AgentDetailCell" owner:self options:nil];
        cell = (AgentDetailCell *)[nib objectAtIndex:0];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
#pragma mark - service calls
-(void)profileServiceCallFor_Post:(NSString *)url params:(NSDictionary *)params
{
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_PROFILE showProgress:YES withHandler:^(BOOL success, id data)
     {
         
         
         if (success)
         {
             NSDictionary *res_dict = data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             
             if ([status isEqualToString:@"1"])
             {
                 
             }
             else
             {
                 [self editDetailsClick];
             }
         }
     }];
}
-(void)editDetailsClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:self];
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
