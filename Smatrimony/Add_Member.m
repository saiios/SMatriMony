//
//  Add_Member.m
//  Smatrimony
//
//  Created by INDOBYTES on 24/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Add_Member.h"

@interface Add_Member ()
{
    NSDateFormatter *dateFormat;
    NSMutableArray *profileCreatedArr, *languagetArr,*religion_list,*country_list;
    NSString *gender_str;
}
@end

@implementation Add_Member

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _picker_view.hidden = YES;
    [_date_picker setDatePickerMode:UIDatePickerModeDate];
    gender_str=@"Male";
    relation_str=@"0";
    religion_str=@"0";
    country_str=@"0";
    language_str=@"0";
    age_tag=NO;

    _dateofbirth.titleLabel.text=@"a";
    dateFormat = [[NSDateFormatter alloc] init];
    //  [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setDateFormat:@"MMMM d, YYYY"];
    //  [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    
    [_date_picker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // self.datePicker.minimumDate = minDate;
    _date_picker.maximumDate = [NSDate date];
    
    self.name_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.name_view.layer.borderWidth = 1;
    self.name_view.layer.cornerRadius=5;
    
    self.email_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.email_view.layer.borderWidth = 1;
    self.email_view.layer.cornerRadius=5;
    
    self.mobile_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.mobile_view.layer.borderWidth = 1;
    self.mobile_view.layer.cornerRadius=5;
    
    self.relation_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.relation_view.layer.borderWidth = 1;
    self.relation_view.layer.cornerRadius=5;
    
    self.country_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.country_view.layer.borderWidth = 1;
    self.country_view.layer.cornerRadius=5;
    
    self.mother_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.mother_view.layer.borderWidth = 1;
    self.mother_view.layer.cornerRadius=5;
    
    self.religion_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.religion_view.layer.borderWidth = 1;
    self.religion_view.layer.cornerRadius=5;
    
    self.dob_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.dob_view.layer.borderWidth = 1;
    self.dob_view.layer.cornerRadius=5;
    
    self.gender_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.gender_view.layer.borderWidth = 1;
    self.gender_view.layer.cornerRadius=5;

    profileCreatedArr = [[NSMutableArray alloc]initWithObjects:@"MySelf",@"Son",@"Daughter",@"Brother",@"Sister",@"Relative",@"Friend", nil];
    [_table_view setHidden:YES];
    _table.delegate=self;
    _table.dataSource=self;
    _table.tag=0;
}

- (void)didReceiveMemoryWarning
{
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

- (IBAction)date_done_click:(id)sender
{
    _picker_view.hidden = YES;
    
    // string to age
    NSString *dob = _dateofbirth.titleLabel.text;
    
    //year current date
    NSString *today = [dateFormat stringFromDate:[NSDate date]];
    NSDate *date1 = [dateFormat dateFromString:today];
    
    //year to calculate
    NSDate *date2 = [dateFormat dateFromString:dob];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:date2
                                       toDate:date1
                                       options:0];
    NSInteger age = [ageComponents year];
    NSLog(@"%@ ,%ld%@ years",dob,(long)age);
    
    if (age<18)
    {
        age_tag=NO;
    }
    else
        age_tag=YES;
    
    NSString *d = [NSString stringWithFormat:@"%@ ,%ld%@",dob,(long)age,@" years"];
    [_dateofbirth setTitle:d forState:UIControlStateNormal]; // To set the title
}

- (IBAction)dob_click:(id)sender
{
   // _dateofbirth.inputView = _date_picker;
    [self.view endEditing:YES];
    _date_picker.hidden = false;
    _picker_view.hidden = false;

//    self.ViewPopUp.hidden = YES;
    
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *dateString =  [dateFormat stringFromDate:_date_picker.date];
    [_dateofbirth setTitle:dateString forState:UIControlStateNormal]; // To set the title
}

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    // dateFormat.dateStyle = NSDateFormatterMediumStyle;
    
    NSString *dateString =  [dateFormat stringFromDate:_date_picker.date];
    [_dateofbirth setTitle:dateString forState:UIControlStateNormal]; // To set the title
}

#pragma mark recent table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_table.tag==0)
    {
        return profileCreatedArr.count;
    }
    else if (_table.tag==1)
    {
        return  languagetArr.count;
    }
    else if (_table.tag==2)
    {
        return  religion_list.count;
    }
    else if (_table.tag==3)
    {
        return  country_list.count;
    }
    return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Feedback_cell *cell = [ tableView dequeueReusableCellWithIdentifier:@"Feedback_cell"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"Feedback_cell" bundle:nil] forCellReuseIdentifier:@"Feedback_cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Feedback_cell"];
    }
    if (_table.tag==0)
    {
        cell.lbl.text=[NSString stringWithFormat:@"%@",[profileCreatedArr   objectAtIndex:indexPath.row]];
    }
    
    else if (_table.tag==1)
    {
        cell.lbl.text=[NSString stringWithFormat:@"%@",[[languagetArr  valueForKey:@"mtongue_name"] objectAtIndex:indexPath.row]];
    }
    
    else if (_table.tag==2)
    {
        cell.lbl.text=[NSString stringWithFormat:@"%@",[[religion_list  valueForKey:@"religion_name"] objectAtIndex:indexPath.row]];
    }
    else if (_table.tag==3)
    {
        cell.lbl.text=[NSString stringWithFormat:@"%@",[[country_list  valueForKey:@"country_name"] objectAtIndex:indexPath.row]];
    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_table.tag==0)
    {
        [_relation setTitle:[profileCreatedArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        //country_id=[[country_list valueForKey:@"mtongue_id"]objectAtIndex:indexPath.row];
    }
    else if (_table.tag==1)
    {
        [_language setTitle:[[languagetArr valueForKey:@"mtongue_name"]objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    else if (_table.tag==2)
    {
        [_religion setTitle:[[religion_list valueForKey:@"religion_name"]objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    else if (_table.tag==3)
    {
        [_country setTitle:[[country_list valueForKey:@"country_name"]objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    [_table_view setHidden:YES];
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
                 if (_table.tag==1)
                 {
                     [languagetArr removeAllObjects];
                     
                     languagetArr=[[popUPList valueForKey:@"languageslist"] mutableCopy];
                 }
                 else if (_table.tag==2)
                 {
                     [religion_list removeAllObjects];
                     
                     religion_list=[[popUPList valueForKey:@"religionslist"] mutableCopy];
                 }
                 else if (_table.tag==3)
                 {
                     [country_list removeAllObjects];
                     country_list=[[popUPList valueForKey:@"countrieslist"] mutableCopy];
                 }
                 [_table_view setHidden:NO];
                 [_table reloadData];
                 
                /*
                 else if ([button isEqualToString:@"religiousMTongueBtn"]) {
                     
                     
                     religiosMtongueArr=[popUPList valueForKey:@"languageslist"];
                     
                     [_popUpTableView reloadData];
                     
                 }
                                 else if ([button isEqualToString:@"religionBtn"]) {
                     [religionArr removeAllObjects];
                     religionArr=[[popUPList valueForKey:@"religionslist"] mutableCopy];
                     [_popUpTableView reloadData];
                 }
                 */
             }
             //         else
             //         {
             //             [self Alert:@"Something went wrong"];
             //             _ViewPopUp.hidden = YES;
         }
     }];
}

- (IBAction)relation_click:(id)sender
{
    [self.view endEditing:YES];

    _table.tag=0;
    [_table_view setHidden:NO];
    [_table  reloadData];
}
- (IBAction)mother_click:(id)sender
{
    [self.view endEditing:YES];

    _table.tag=1;
    [self popupServiceCall:@"services/api/dropdownlist"];
}
- (IBAction)religion_click:(id)sender
{
    [self.view endEditing:YES];

    _table.tag=2;
    [self popupServiceCall:@"services/api/dropdownlist"];
}

- (IBAction)country_click:(id)sender
{
    [self.view endEditing:YES];

    _table.tag=3;
    [self popupServiceCall:@"services/api/dropdownlist"];
}

- (IBAction)submit_click:(id)sender
{
    [self.view endEditing:YES];

    [self.view endEditing:YES];
    
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
        [self Add_Member];
    }
}

-(void)Add_Member
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:name_str forKey:@"franchised_by"];
    [params setObject:email_str forKey:@"email"];
    [params setObject:pwd_str forKey:@"password"];
    [params setObject:dob_str forKey:@"birthdate"];
    [params setObject:name_str forKey:@"firstname"];
    [params setObject:gender_str forKey:@"gender"];
    [params setObject:mobile_str forKey:@"mobile"];
    [params setObject:religion_str forKey:@"religion"];
    //[params setObject:countr forKey:@"country_id"];
    [params setObject:language_str forKey:@"m_tongue"];
    [params setObject:relation_str forKey:@"profileby"];

    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"services/agent/addMember" parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             [self Alert:result];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             [_table_view setHidden:YES];
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL)valide_Data
{
    name_str = [_name_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    email_str = [_email_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    pwd_str = [_password_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    mobile_str = [_mobile_number.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    dob_str = [_dateofbirth.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    religion_str = [_religion.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    language_str = [_language.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    relation_str = [_relation.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    country_str = [_country.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if  ( [name_str length]==0)
    {
        [self Alert :@"Name should not be empty."];
        return NO;
    }
    else if  ( [dob_str length]==0)
    {
        [self Alert :@"Date Of Birth should not be empty."];
        return NO;
    }
    else if (age_tag ==NO)
    {
        [self Alert :@"Age should be greater than 18."];
        return NO;
    }
    else if ([relation_str isEqualToString:@"0"])
    {
        [self Alert :@"Relation should not be empty."];
        return NO;
    }
    else if ([language_str length] == 0)
    {
        [self Alert :@"Language should not be empty."];
        return NO;
    }
    else if ([religion_str  isEqualToString:@"0"])
    {
        [self Alert :@"Religion should not be empty."];
        return NO;
    }
    else if ([country_str isEqualToString:@"0"])
    {
        [self Alert :@"Country should not be empty."];
        return NO;
    }

    
    else if ([mobile_str length] == 0)
    {
        [self Alert :@"Mobile Number should not be empty."];
        return NO;
    }
    else if ([mobile_str length] < 10)
    {
        [self Alert :@"Mobile Number should not be Less Than 10 Digits."];
        return NO;
    }
    else if ([self NSStringIsValidEmail:email_str]== NO)
    {
        [self Alert :@"Email should be valid."];
        return NO;
    }
    else if  ( [pwd_str length]==0)
    {
        [self Alert :@"Password should not be empty."];
        return NO;
    }
   
    return YES;
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

- (IBAction)male_click:(id)sender
{
    [_male setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [_female setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    gender_str=@"Male";
}

- (IBAction)female_click:(id)sender
{
    [_female setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [_male setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    gender_str=@"FeMale";
}
- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
