//
//  msg_send.m
//  Smatrimony
//
//  Created by INDOBYTES on 10/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "msg_send.h"

@interface msg_send ()

@end

@implementation msg_send

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *user_inf=[NSUserDefaults standardUserDefaults];
    matri_id=[user_inf valueForKey:@"matri_id"];
    From_email=[user_inf valueForKey:@"email_id"];
    gender=[user_inf valueForKey:@"gender"];

    _txt_view.text = @"Enter Your Message";
//    _txt_view.textColor = [UIColor lightGrayColor];
    _txt_view.delegate = self;
    [_to addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self service_ids];
}

-(void)service_ids
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:gender forKey:@"gender"];

    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/composeProfiles" parameters:dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             composeProfiles=[res_dict valueForKey:@"composeProfiles"];
             id_ary=[[NSMutableArray alloc]initWithArray:[composeProfiles valueForKey:@"matri_id"]];
             [self Alert:result];
             
             if ([status isEqualToString:@"1"])
             {
                 _id_table.delegate=self;
                 _id_table.dataSource=self;
                 [_id_table sendSubviewToBack:_txt_view];
                 _id_table.hidden=NO;

                 [_id_table reloadData];
             }
             else
             {
                 
             }
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
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
    // Get the new view controller using [seguefdhdfnh destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)textFieldDidChange :(UITextField *)theTextField
{
    NSArray *ddf=[[NSArray alloc]initWithObjects:@"aaa",@"dfd", nil];
    NSArray *pre_ary=[NSArray arrayWithArray:ddf];
    NSPredicate* p = [NSPredicate predicateWithFormat:@"ProductName BEGINSWITH[cd] %@", theTextField.text];
    NSArray *results = [ddf filteredArrayUsingPredicate:p];
    
   NSArray *clothsArr = [results mutableCopy]; //locationArr
//    [_clothsListTableView reloadData];
    /*
    NSPredicate * predicate =
    [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@ OR name LIKE[cd] %@", theTextField.text, theTextField.text];
    NSArray *searchResults = [NSArray arrayWithArray:[id_ary filteredArrayUsingPredicate:predicate]];
    NSLog(@"filtered array %@",searchResults);
    
       NSString *expression=[NSString stringWithFormat:@"(content BEGINSWITH[c] %@)",theTextField.text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:expression];
    NSMutableArray *mArrayFiltered = [[id_ary filteredArrayUsingPredicate:predicate] mutableCopy];
     */
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Enter Your Message"])
    {
        _txt_view.text = @"";
    }
    
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(_txt_view.text.length == 0)
    {
//        _txt_view.textColor = [UIColor redColor];
        _txt_view.text = @"Enter Your Message";
        [_txt_view resignFirstResponder];
    }
}

-(void)service
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"loginmatri_id"];
    [dict setObject:_to.text forKey:@"to_email"];
    [dict setObject:From_email forKey:@"from_email"];
    [dict setObject:_subject.text forKey:@"msg_subject"];
    [dict setObject:_txt_view.text forKey:@"msg_content"];

    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/sentaMail" parameters:dict requestNumber:WUS_Change_pwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             [self Alert:result];
             
             if ([status isEqualToString:@"1"])
             {
             }
             else
             {
                
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

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)send_click:(id)sender
{
    [self.view endEditing:YES];
    
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
       
        [self service];
    }
}

-(BOOL)valide_Data
{
    NSString *to_str = [_to.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *sub_str = [_subject.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *des_str = [_txt_view.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if  ( [to_str length]==0)
    {
        [self Alert :@"Id should not be empty."];
        return NO;
    }
    if  ( [sub_str length]==0)
    {
        [self Alert :@"Subject should not be empty."];
        return NO;
    }
    if  ( [des_str length]==0)
    {
        [self Alert :@"Message should not be empty."];
        return NO;
    }
    return YES;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSString *selected_id=[id_ary objectAtIndex:row];
    _to.text=selected_id;
    _id_table.hidden=YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Feedback_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Feedback_cell"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"Feedback_cell" bundle:nil] forCellReuseIdentifier:@"Feedback_cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Feedback_cell"];
    }
//    Feedback_cell *cell = [ tableView dequeueReusableCellWithIdentifier:@"Feedback_cell"];
//   
    NSString *id_str=[NSString stringWithFormat:@"%@",[id_ary objectAtIndex:indexPath.row]];
        cell.lbl.text = id_str;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return id_ary.count;
}
@end
