//
//  Detail_Call_Preferences.m
//  Smatrimony
//
//  Created by INDOBYTES on 25/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Detail_Call_Preferences.h"

@interface Detail_Call_Preferences ()

@end

@implementation Detail_Call_Preferences

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    user_inf=[NSUserDefaults standardUserDefaults];
    matri_id=[user_inf valueForKey:@"matri_id"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)anytimeAction:(id)sender {
    self.resultAction = @"Any time";
    [self.anytimeBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [self.fifteendaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.thirtydaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.sixtydaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.neverBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self service_call];
}
- (IBAction)fifteendaysAction:(id)sender
{
    self.resultAction = @"Once in 15 days";
    [self.anytimeBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.fifteendaysBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [self.thirtydaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.sixtydaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.neverBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self service_call];
}
- (IBAction)thirtydaysAction:(id)sender {
    self.resultAction = @"Once in 30 days";
    [self.anytimeBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.fifteendaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.thirtydaysBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [self.sixtydaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.neverBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self service_call];
}

- (IBAction)sixtydaysAtion:(id)sender {
    self.resultAction = @"Once in 60 days";
    [self.anytimeBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.fifteendaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.thirtydaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.sixtydaysBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [self.neverBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self service_call];
}

- (IBAction)neverAction:(id)sender {
    self.resultAction = @"Never";
    [self.anytimeBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.fifteendaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.thirtydaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.sixtydaysBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [self.neverBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [self service_call];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)service_call
{
    NSMutableDictionary *dict;
    dict =[[NSMutableDictionary alloc]init];
    [dict setObject:self.resultAction forKey:@"time_to_call"];
    [dict setObject:matri_id forKey:@"matri_id"];
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/editProfile" parameters:dict requestNumber:WUS_unblock showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             ALERT_DIALOG(@"Alert", @"Success");
         }
         else
         {
             ALERT_DIALOG(@"Alert", @"Something Went Wrong");
         }
     }];
    

}
@end
