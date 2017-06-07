//
//  HoroscopeController.m
//  Smatrimony
//
//  Created by INDOBYTES on 24/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "HoroscopeController.h"

@interface HoroscopeController ()
{
    NSMutableArray *countryArr,*stateArr,*districtArr,*cityArr,*languageArr;
    NSString * button;
    horoscope_TableViewCell * cell;
    NSString *countryId,*stateId,*districtId,*cityId,*languageId,*charStyleId,*timeOfCorId;
    NSArray * chartArr,*timeOfCorArr;
    NSDateFormatter *dateFormat;
    NSUserDefaults * defaults;
}
@end

@implementation HoroscopeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.popUpTable.hidden = YES;
    button = @"";
    countryId = @"";
    stateId = @"";
    districtId = @"";
    cityId = @"";
    languageId = @"";
    charStyleId = @"";
    timeOfCorId =@"";
    self.dateView.hidden = true;
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    defaults = [NSUserDefaults standardUserDefaults];
   
    chartArr = [[NSArray alloc]initWithObjects:@"South Indian",@"North Indian",@"East Indian",@"Kerala", nil];
    timeOfCorArr= [[NSArray alloc]initWithObjects:@"Standard Time",@"Daylight Saving", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([button isEqualToString:@"country"]) {
        return [countryArr count];
    }
    else if ([button isEqualToString:@"state"])
    {
        return [stateArr count];
    }
    else if ([button isEqualToString:@"district"])
    {
        return [districtArr count];
    }
    else if ([button isEqualToString:@"city"])
    {
        return [cityArr count];
    }
    else if ([button isEqualToString:@"language"])
    {
        return [languageArr count];
    }
    
    else if ([button isEqualToString:@"chartStyle"])
    {
        return [chartArr count];
    }
    else if ([button isEqualToString:@"timeOfCor"])
    {
        return [timeOfCorArr count];
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_miniTable) {
        return 44;
    }
    return 495;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  horoscope_TableViewCell * cell =
    if (tableView == _mainTableView) {
        
     static NSString *simpleTableIdentifier = @"horoscope_TableViewCell";
            
            cell = (horoscope_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"horoscope_TableViewCell" owner:self options:nil];
                cell = (horoscope_TableViewCell *)[nib objectAtIndex:0];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.backLabel addTarget:self action:@selector(backLabelAction) forControlEvents:UIControlEventTouchUpInside];
             cell.dobLabel.text = _Dob;
            [cell.timeOfBirthOutlet addTarget:self action:@selector(timeOfBirthAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.countryOutlet addTarget:self action:@selector(countryAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.stateOutlet addTarget:self action:@selector(stateAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.districtOutlet addTarget:self action:@selector(districtAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.cityOutlet addTarget:self action:@selector(cityAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.languageOutlet addTarget:self action:@selector(languageAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.chartStyleOutlet addTarget:self action:@selector(chartStyleAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.timeOfCorrectionOutlet addTarget:self action:@selector(timeOfCorrection) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
    
}
  
    else {
        
        UITableViewCell * minicell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"minicell"];
        if (minicell == nil) {
            minicell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"minicell"];
        }
        if ([button isEqualToString:@"country"]) {
            minicell.textLabel.text = [[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
            
        }
        else if ([button isEqualToString:@"state"])
        {
            minicell.textLabel.text = [[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"];
        }
        else if ([button isEqualToString:@"district"])
        {
            minicell.textLabel.text = [[districtArr objectAtIndex:indexPath.row]valueForKey:@"district_name"];
        }
        else if ([button isEqualToString:@"city"])
        {
            minicell.textLabel.text = [[cityArr objectAtIndex:indexPath.row]valueForKey:@"city_name"];
        }
        else if ([button isEqualToString:@"language"])
        {
            minicell.textLabel.text = [[languageArr objectAtIndex:indexPath.row]valueForKey:@"mtongue_name"];
        }
        else if ([button isEqualToString:@"chartStyle"])
        {
            minicell.textLabel.text = [chartArr objectAtIndex:indexPath.row];
        }
        else if ([button isEqualToString:@"timeOfCor"])
        {
            minicell.textLabel.text = [timeOfCorArr objectAtIndex:indexPath.row];
        }

        return minicell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([button isEqualToString:@"country"]) {
        cell.countryBirthLabel.text = [[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
        countryId=[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_id"];
        cell.stateBirthLabel.text = @"";
        cell.districtBirthLabel.text = @"";
        cell.citryBirthLabel.text = @"";
        self.popUpTable.hidden = YES;
    }
    else if ([button isEqualToString:@"state"])
    {
        cell.stateBirthLabel.text = [[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"];
        stateId=[[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_id"];
        cell.districtBirthLabel.text = @"";
        cell.citryBirthLabel.text = @"";
        self.popUpTable.hidden = YES;
    }
    else if ([button isEqualToString:@"district"])
    {
        cell.districtBirthLabel.text = [[districtArr objectAtIndex:indexPath.row]valueForKey:@"district_name"];
        districtId=[[districtArr objectAtIndex:indexPath.row]valueForKey:@"district_id"];
         cell.citryBirthLabel.text = @"";
        self.popUpTable.hidden = YES;
    }
    else if ([button isEqualToString:@"city"])
    {
        cell.citryBirthLabel.text = [[cityArr objectAtIndex:indexPath.row]valueForKey:@"city_name"];
        cityId=[[cityArr objectAtIndex:indexPath.row]valueForKey:@"city"];
        self.popUpTable.hidden = YES;
    }
    else if ([button isEqualToString:@"language"])
    {
        cell.languageLabel.text = [[languageArr objectAtIndex:indexPath.row]valueForKey:@"mtongue_name"];
        languageId=[[languageArr objectAtIndex:indexPath.row]valueForKey:@"mtongue_id"];
        self.popUpTable.hidden = YES;
    }
    else if ([button isEqualToString:@"chartStyle"])
    {
        cell.chartStyleLabel.text = [chartArr objectAtIndex:indexPath.row];
        charStyleId=[chartArr objectAtIndex:indexPath.row];
        self.popUpTable.hidden = YES;
    }
    else if ([button isEqualToString:@"timeOfCor"])
    {
        cell.timeOfCorrectionLabel.text = [timeOfCorArr objectAtIndex:indexPath.row];
        timeOfCorId=[timeOfCorArr objectAtIndex:indexPath.row];
        self.popUpTable.hidden = YES;
    }
}
-(void)backLabelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)timeOfBirthAction
{
    self.dateView.hidden = NO;
  //  cell.timeOfBirthLabel.text = self.datePickerOutlet;
    NSString *dateString =  [dateFormat stringFromDate:self.datePickerOutlet.date];
    cell.timeOfBirthLabel.text = dateString;
    
     [self.datePickerOutlet addTarget:self action:@selector(onDatePickerValueChanged) forControlEvents:UIControlEventValueChanged];
//    _ViewDatePicker.hidden = false;
//    self.ViewPopUp.hidden = YES;
//    
//    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
//    NSString *dateString =  [dateFormat stringFromDate:_datePicker.date];
//    cell1.DOBtF.text  = dateString;
}
-(void)onDatePickerValueChanged
{
    NSString *dateString =  [dateFormat stringFromDate:self.datePickerOutlet.date];
    cell.timeOfBirthLabel.text = dateString;
}
-(void)countryAction
{
    self.popUpTable.hidden = NO;
    button = @"country";
    [self popupServiceCall:@"services/api/dropdownlist"];
}
-(void)stateAction
{
    if ([countryId isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"please enter Country");
    }
    else
    {
    self.popUpTable.hidden = NO;
    button = @"state";
    NSDictionary *params = @{@"country_id": countryId};
    [self popupServiceCall:@"services/api/statesList" params:params];
    }
}
-(void)districtAction
{
    if ([stateId isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"please enter State");
    }
    else
    {
    self.popUpTable.hidden = NO;
    button = @"district";
    NSDictionary *params = @{@"state_id": stateId,@"country_id":countryId};
    [self popupServiceCall:@"services/api/districtList" params:params];
    }
}
-(void)cityAction
{
    if ([districtId isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"please enter District");
    }
    else
    {
        self.popUpTable.hidden = NO;
        button = @"city";
    NSDictionary *params = @{@"state_id": stateId,@"country_id":countryId,@"district_id":districtId};
    [self popupServiceCall:@"services/api/citiesList" params:params];
    }
}
-(void)languageAction
{
    self.popUpTable.hidden = NO;
    button = @"language";
    [self popupServiceCall:@"services/api/dropdownlist"];
}
-(void)chartStyleAction
{
    self.popUpTable.hidden = NO;
    button = @"chartStyle";
    [_miniTable reloadData];
}
-(void)timeOfCorrection
{
    self.popUpTable.hidden = NO;
    button = @"timeOfCor";
    [_miniTable reloadData];
}

-(void)popupServiceCall:(NSString *)url
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:url requestNumber:WUS_getPopUPData showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             
             
             if ([status isEqualToString:@"1"])
             {
                 NSDictionary *popUPList=[res_dict valueForKey:@"dropdownlist"];
                 if ([button isEqualToString:@"country"]) {
                 countryArr=[popUPList valueForKey:@"countrieslist"];
                 [_miniTable reloadData];
                 }
                 else if ([button isEqualToString:@"language"])
                 {
                     languageArr=[popUPList valueForKey:@"languageslist"];
                     [_miniTable reloadData];
                 }
                 
             }
         }
     }];
}
-(void)popupServiceCall:(NSString *)url params:(NSDictionary *)params
{
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict = data;
             
             NSString *status = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 if ([button isEqualToString:@"state"]) {
                     stateArr = [[NSMutableArray alloc] init];
                     stateArr=[res_dict valueForKey:@"statelist"];
                     [_miniTable reloadData];
                 }
                 else if ([button isEqualToString:@"district"]) {
                     districtArr = [[NSMutableArray alloc] init];
                     districtArr=[res_dict valueForKey:@"districtlist"];
                     [_miniTable reloadData];
                 }
                 else if ([button isEqualToString:@"city"]) {
                     cityArr = [[NSMutableArray alloc] init];
                     cityArr = [res_dict valueForKey:@"citylist"];
                     [_miniTable reloadData];
                 }
             }
         }
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

- (IBAction)datePickerDOneAction:(id)sender {
    self.dateView.hidden = true;
    
    NSString *dateString =  [dateFormat stringFromDate:self.datePickerOutlet.date];
    cell.timeOfBirthLabel.text = dateString;
}
@end
