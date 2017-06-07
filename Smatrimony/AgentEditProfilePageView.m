//
//  AgentEditProfilePageView.m
//  Smatrimony
//
//  Created by INDOBYTES on 07/06/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "AgentEditProfilePageView.h"

@interface AgentEditProfilePageView ()

@end

@implementation AgentEditProfilePageView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 945;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"AgentBasicDetailCell";
   AgentBasicDetailCell * agentCellObj = (AgentBasicDetailCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //   ageCell.accessoryType = UITableViewCellAccessoryNone;
    if (agentCellObj == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AgentBasicDetailCell" owner:self options:nil];
        agentCellObj = (AgentBasicDetailCell *)[nib objectAtIndex:0];
    }
    return agentCellObj;

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
