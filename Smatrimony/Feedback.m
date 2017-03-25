//
//  Feedback.m
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Feedback.h"

@interface Feedback ()

@end

@implementation Feedback

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    Cat_ary=[[NSArray alloc]initWithObjects:@"--Select--",@"Problems related to website",@"Problems related to Profiles",@"Compliments and Suggestions",@"Others", nil];
    priority_ary=[[NSArray alloc]initWithObjects:@"--Select--",@"Low",@"Medium",@"High", nil];
    _table.delegate=self;
    _table.dataSource=self;
    _table.layer.borderWidth = 2.0;
    _table.layer.borderColor = [UIColor blackColor].CGColor;
    
    _name_view.layer.borderColor = [UIColor brownColor].CGColor;
    _name_view.layer.borderWidth = 1.0;
    _cat_view.layer.borderColor = [UIColor brownColor].CGColor;
    _cat_view.layer.borderWidth = 1.0;
    _priority_view.layer.borderColor = [UIColor brownColor].CGColor;
    _priority_view.layer.borderWidth = 1.0;
    _feedback_textview.layer.borderColor = [UIColor brownColor].CGColor;
    _feedback_textview.layer.borderWidth = 1.0;
    _name.text=_username;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([table_tag isEqualToString:@"P"])
    {
        return 1;
    }
    else if ([table_tag isEqualToString:@"C"])
    {
        return 1;
    }
    else
      return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([table_tag isEqualToString:@"P"])
    {
         return priority_ary.count;
    }
    else if ([table_tag isEqualToString:@"C"])
    {
        return Cat_ary.count;
    }
    else
        return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 40;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Feedback_cell *cell = [ tableView dequeueReusableCellWithIdentifier:@"Feedback_cell"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"Feedback_cell" bundle:nil] forCellReuseIdentifier:@"Feedback_cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Feedback_cell"];
    }
    if ([table_tag isEqualToString:@"P"])
    {
        cell.lbl.text = [NSString stringWithFormat:@"%@",[priority_ary objectAtIndex:indexPath.row]];
    }
    else if ([table_tag isEqualToString:@"C"])
    {
        cell.lbl.text = [NSString stringWithFormat:@"%@",[Cat_ary objectAtIndex:indexPath.row]];
    }
    else
    cell.lbl.text = [NSString stringWithFormat:@"-"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([table_tag isEqualToString:@"P"])
    {
        _Priority_lbl.text=[NSString stringWithFormat:@"%@",[priority_ary objectAtIndex:indexPath.row]];
    }
    else if ([table_tag isEqualToString:@"C"])
    {
        _category_lbl.text=[NSString stringWithFormat:@"%@",[Cat_ary objectAtIndex:indexPath.row]];
    }
    singleFingerTap.enabled=YES;

    [self hideKeyboard];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView
{
    //Has Focus
    if ([aTextView.text isEqualToString:@"Enter Your Feedback"])
    {
        aTextView.text=@"";
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([_feedback_textview isFirstResponder])
    {
        [_feedback_textview resignFirstResponder];
    }
    return YES;
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

- (void)hideKeyboard
{
    table_tag=@"";
    _table.hidden=YES;
    [self.view endEditing:YES];
}

- (IBAction)category_click:(id)sender
{
    table_tag=@"C";
    _table.hidden=NO;
    [_table reloadData];
    singleFingerTap.enabled=NO;
}

- (IBAction)priority_click:(id)sender
{
   table_tag=@"P";
    _table.hidden=NO;
    [_table reloadData];
    singleFingerTap.enabled=NO;
}

- (IBAction)submit_click:(id)sender
{
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
         [self Feedback_Dict];
    }
}

-(void)Feedback_Dict
{
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    NSString *email_id=[user_inf valueForKey:@"email_id"];

    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[_name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"name"];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:email_id forKey:@"email"];
    [dict setObject:[_Priority_lbl.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"priority"];
    [dict setObject:[_category_lbl.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"category"];
    [dict setObject:[_feedback_textview.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"message"];
    
    NSLog(@"%@",dict);
    [self Feedback_Service:dict];
}

-(void)Feedback_Service:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/feedback" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
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

-(BOOL)valide_Data
{
    NSString *Name_str=_name.text;
    NSString *Cat_str=_category_lbl.text;
    NSString *Pri_str=_Priority_lbl.text;
    NSString *Feedback=_feedback_textview.text;

     if ([Name_str length] == 0)
    {
        [self Alert :@"Name should not be empty."];
        return NO;
    }
     else  if ([Cat_str length] == 0||[Cat_str isEqualToString:@"--Select--"])
     {
         [self Alert :@"Select Category."];
         return NO;
     }
     else  if ([Pri_str length] == 0||[Pri_str isEqualToString:@"--Select--"])
     {
         [self Alert :@"Select Category."];
         return NO;
     }
     else  if ([Feedback length] == 0||[Feedback isEqualToString:@"Enter Your Feedback"])
     {
         [self Alert :@"Enter Feedback."];
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

@end
