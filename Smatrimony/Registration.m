//
//  Registration.m
//  Smatrimony
//
//  Created by INDOBYTES on 23/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Registration.h"

@interface Registration ()
{
    NSArray *country_list;
    UITapGestureRecognizer *tapGestureRecognizer;
    NSString *country_id,*state_id,*district_id,*city_id;
}

@end

@implementation Registration
- (void)viewDidLoad
{
    [super viewDidLoad];
    country_id=@"0";
    state_id=@"0";
    city_id=@"0";
    district_id=@"0";
    
    agent_inf=[NSUserDefaults standardUserDefaults];
    F_id=[NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_id"]];
    F_Matri_id=[NSString stringWithFormat:@"%@",[agent_inf valueForKey:@"F_matri_id"]];
    
    if ([_From isEqualToString:@"Profile"])
    {
        _mobile_top_constraint.constant=8;
        _pwd_view.hidden=YES;
        _reg_title.text=@"Edit Profile";
        [self agent_profile];
    }
    else if ([_From isEqualToString:@"Sub"])
    {
        _mobile_top_constraint.constant=58;
        _pwd_view.hidden=NO;
        _reg_title.text=@"Add Sub Agent";
    }
    else
    {
        _mobile_top_constraint.constant=58;
        _pwd_view.hidden=NO;
        _reg_title.text=@"Agent Registration";
    }
    // Do any additional setup after loading the view from its nib.
    self.name_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.name_view.layer.borderWidth = 1;
    self.name_view.layer.cornerRadius=5;
    
    self.email_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.email_view.layer.borderWidth = 1;
    self.email_view.layer.cornerRadius=5;
    
    self.mobile_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.mobile_view.layer.borderWidth = 1;
    self.mobile_view.layer.cornerRadius=5;
    
    self.pwd_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.pwd_view.layer.borderWidth = 1;
    self.pwd_view.layer.cornerRadius=5;
    
    self.country_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.country_view.layer.borderWidth = 1;
    self.country_view.layer.cornerRadius=5;
    
    self.state_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.state_view.layer.borderWidth = 1;
    self.state_view.layer.cornerRadius=5;
    
    self.district_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.district_view.layer.borderWidth = 1;
    self.district_view.layer.cornerRadius=5;
    
    self.city_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.city_view.layer.borderWidth = 1;
    self.city_view.layer.cornerRadius=5;
    
    self.comment_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.comment_view.layer.borderWidth = 1;
    self.comment_view.layer.cornerRadius=5;
    
    self.photo_view.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:214.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.photo_view.layer.borderWidth = 1;
    self.photo_view.layer.cornerRadius=5;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _table.delegate=self;
    _table.dataSource=self;
    
}

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    //Code to handle the gesture
    [self.table_view setHidden:YES];
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

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark recent table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return country_list.count;
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
        cell.lbl.text=[NSString stringWithFormat:@"%@",[[country_list  valueForKey:@"country_name"] objectAtIndex:indexPath.row]];
    }
    else if (_table.tag==1)
    {
        cell.lbl.text=[NSString stringWithFormat:@"%@",[[country_list  valueForKey:@"state_name"] objectAtIndex:indexPath.row]];
    }
    else if (_table.tag==2)
    {
        cell.lbl.text=[NSString stringWithFormat:@"%@",[[country_list  valueForKey:@"district_name"] objectAtIndex:indexPath.row]];
    }
    else if (_table.tag==3)
    {
        cell.lbl.text=[NSString stringWithFormat:@"%@",[[country_list  valueForKey:@"city_name"] objectAtIndex:indexPath.row]];
    }
    else if (_table.tag==4)
    {
         cell.lbl.text=[NSString stringWithFormat:@"%@",[country_list   objectAtIndex:indexPath.row]];
        if (indexPath.row==2)
        {
            cell.contentView.backgroundColor=[UIColor redColor];
            cell.lbl.textColor=[UIColor whiteColor];
        }
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
        [_country setTitle:[[country_list valueForKey:@"country_name"]objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        country_id=[[country_list valueForKey:@"country_id"]objectAtIndex:indexPath.row];
    }
    else if (_table.tag==1)
    {
        [_state setTitle:[[country_list valueForKey:@"state_name"]objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        state_id=[[country_list valueForKey:@"state_id"]objectAtIndex:indexPath.row];
    }
    else if (_table.tag==2)
    {
        [_disctrict setTitle:[[country_list valueForKey:@"district_name"]objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        district_id=[[country_list valueForKey:@"district_id"]objectAtIndex:indexPath.row];
    }
    else if (_table.tag==3)
    {
        [_city setTitle:[[country_list valueForKey:@"city_name"]objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        city_id=[[country_list valueForKey:@"city_id"]objectAtIndex:indexPath.row];
    }
    else if (_table.tag==4)
    {
        _table_height.constant=400;

        if (indexPath.row==0)//cam
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:@"Device has no camera"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles: nil];
                
                [myAlertView show];
                
            } else {
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:NULL];
            }
        }
        else if (indexPath.row==1)//gallery
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];        }
    }
    tapGestureRecognizer.enabled=YES;
    [_table_view setHidden:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  //  NSIndexPath *indexpath = [NSIndexPath indexPathForRow:selected_pic_ind inSection:0];
    _img.image = info[UIImagePickerControllerEditedImage];
    NSString *img_url=info [UIImagePickerControllerReferenceURL];
    NSString *img_str=[NSString stringWithFormat:@"%@",img_url];
    if ([img_str containsString:@"JPG"])
    {
        change_img_name=[NSString stringWithFormat:@"image.jpg"];
    }
    else if ([img_str containsString:@" PNG"])
    {
        change_img_name=[NSString stringWithFormat:@"image.png"];
    }
    else
        change_img_name=[NSString stringWithFormat:@"image.jpg"];
    
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(_img.image)];
    
    NSString *base64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:F_id forKey:@"franchise_id"];
    [dict setObject:change_img_name forKey:@"photo_name"];
    [dict setObject:base64 forKey:@"photo"];//base64
    
    [self change_pic:dict];
    
         [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)change_pic:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"agent/updateProfilePic" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             [self Alert:result];
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}


- (IBAction)country_click:(id)sender
{
    tapGestureRecognizer.enabled=NO;
    [self country_api];
    _table.tag=0;
    [self.table_view setHidden:NO];
}

- (IBAction)state_click:(id)sender
{
    [_table setContentOffset:CGPointZero animated:YES];
    tapGestureRecognizer.enabled=NO;
    _table.tag=1;
    NSDictionary *params = @{@"country_id":country_id};

    [self state_api:@"services/agent/statesList" :params];
    [self.table_view setHidden:NO];
}

- (IBAction)submit_click:(id)sender
{
    [self.view endEditing:YES];
    
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
        [self Registration_Dict];
    }
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
    pwd_str = [_pwd_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   mobile_str = [_mobile_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    address_str = [_comment_tv.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if  ( [name_str length]==0)
    {
        [self Alert :@"Name should not be empty."];
        return NO;
    }
    else if ([self NSStringIsValidEmail:email_str]== NO)
    {
        [self Alert :@"Email should be valid."];
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
    else if ([country_id isEqualToString:@"0"])
    {
        [self Alert :@"Country should not be empty."];
        return NO;
    }
    else if ([state_id  isEqualToString:@"0"])
    {
        [self Alert :@"State should not be empty."];
        return NO;
    }
    else if ([city_id isEqualToString:@"0"])
    {
        [self Alert :@"City should not be empty."];
        return NO;
    }
    else if ([address_str length] == 0)
    {
        [self Alert :@"Address should not be empty."];
        return NO;
    }
    else if (![_From isEqualToString:@"Profile"])
    {
    if ([pwd_str length] == 0)
    {
        [self Alert :@"Password should not be empty."];
        return NO;
    }
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
/*
franchise_email
franchise_mobile
franchise_password
franchise_name
franchise_country [id]
franchise_state [id]
franchise_city   [id]
franchise_address
photo
*/

-(void)Registration_Dict
{
    if ([_From isEqualToString:@"Profile"])
    {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:name_str forKey:@"franchise_name"];
        [dict setObject:email_str forKey:@"franchise_email"];
        [dict setObject:mobile_str forKey:@"franchise_mobile"];
        [dict setObject:fran_id forKey:@"franchise_id"];
        
        [dict setObject:country_id forKey:@"franchise_country"];
        [dict setObject:state_id forKey:@"franchise_state"];
        [dict setObject:city_id forKey:@"franchise_city"];
        [dict setObject:address_str forKey:@"franchise_address"];
        
        [self edit_profile:dict];
    }
    else
    {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:name_str forKey:@"franchise_name"];
    [dict setObject:email_str forKey:@"franchise_email"];
    [dict setObject:mobile_str forKey:@"franchise_mobile"];
    [dict setObject:pwd_str forKey:@"franchise_password"];
    
    [dict setObject:country_id forKey:@"franchise_country"];
    [dict setObject:state_id forKey:@"franchise_state"];
    [dict setObject:city_id forKey:@"franchise_city"];
    [dict setObject:address_str forKey:@"franchise_address"];
        
    if ([_From isEqualToString:@"Sub"])
    {
        [dict setObject:fran_id forKey:@"super_agent"];
    }
    else
        [dict setObject:@"0" forKey:@"super_agent"];

    [dict setObject:@"" forKey:@"photo"];
    [self registration:dict];
    }
}

- (IBAction)district_click:(id)sender
{
    [_table setContentOffset:CGPointZero animated:YES];

    tapGestureRecognizer.enabled=NO;
    _table.tag=2;
    NSDictionary *params = @{@"state_id":state_id,@"country_id":country_id};
    
    [self state_api:@"services/agent/districtList" :params];
    [self.table_view setHidden:NO];
}

- (IBAction)city_click:(id)sender
{
    [_table setContentOffset:CGPointZero animated:YES];

    tapGestureRecognizer.enabled=NO;
    _table.tag=3;
    NSDictionary *params = @{@"state_id":state_id,@"country_id":country_id,@"district_id":district_id};
    
    [self state_api:@"services/agent/citiesList" :params];
    [self.table_view setHidden:NO];
}

- (IBAction)photo_click:(id)sender
{
    tapGestureRecognizer.enabled=NO;
    [self.table_view setHidden:NO];
    _table_height.constant=150;
    _table.tag=4;
    country_list=[[NSArray alloc]initWithObjects:@"Camera",@"Gallery",@"Cancel", nil];
    [_table reloadData];
}

-(void)country_api
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"agent/countriesList" requestNumber:WUS_S_story showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             country_list=[res_dict valueForKey:@"countrieslist"];
             if ([status isEqualToString:@"1"])
             {
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

-(void)state_api:(NSString *)url :(NSDictionary *)params
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             if (_table.tag==1)
             {
                 country_list=[res_dict valueForKey:@"statelist"];
             }
             else if (_table.tag==2)
             {
                 country_list=[res_dict valueForKey:@"districtlist"];
             }
             else if (_table.tag==3)
             {
                 country_list=[res_dict valueForKey:@"citylist"];
             }
             if ([status isEqualToString:@"1"])
             {
                 [_table reloadData];
             }
             else
             {
                 [self Alert:result];
             }
         }
         else
         {
             [_table_view setHidden:YES];
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)registration:(NSDictionary *)params
{
        [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"services/agent/registration" parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
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

-(void)edit_profile:(NSDictionary *)params
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"services/agent/editAgentProfile" parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
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

-(void)agent_profile
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if ([_Franc_id isEqual:[NSNull null]]||[_Franc_id isEqualToString:@""]||[_Franc_id isEqualToString:@"<nill>"]||_Franc_id==nil)
    {
        [dict setObject:F_id forKey:@"franchise_id"];
    }
    else
        [dict setObject:_Franc_id forKey:@"franchise_id"];

    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"services/agent/agentProfileList" parameters:dict requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             NSDictionary *agent_info=[res_dict valueForKey:@"agentinfo"];
             name_str=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"franchise_name"]];
             email_str=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"franchise_email"]];
             mobile_str=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"franchise_mobile"]];
             address_str=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"franchise_address"]];
             country_str=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"country_name"]];
             state_str=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"state_name"]];
             city_str=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"city_name"]];
             dis_str=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"district_name"]];
             fran_id=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"franchise_id"]];
             country_id=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"franchise_country"]];
             state_id=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"franchise_state"]];
             district_id=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"franchise_district"]];
             city_id=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"franchise_city"]];
             NSString *img_str=[NSString stringWithFormat:@"%@",[agent_info valueForKey:@"upload_photo"]];
             if (img_str.length!=0)
             {
                 NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/agent/img/uploaded/%@",img_str]];
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                     NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                     dispatch_async(dispatch_get_main_queue(),
                                    ^{
                                        _img.image = [UIImage imageWithData:imageData];
                                        _img.contentMode = UIViewContentModeScaleToFill;
                                    });
                 });
             }
             _name_tf.text=name_str;
             _email_tf.text=email_str;
             _mobile_tf.text=mobile_str;
             _country.titleLabel.text=country_str;
             _state.titleLabel.text=state_str;
             _disctrict.titleLabel.text=dis_str;
             _city.titleLabel.text=city_str;
             _comment_tv.text=address_str;
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

@end
