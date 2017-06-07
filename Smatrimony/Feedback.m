//
//  Feedback.m
//  Smatrimony
//
//  Created by INDOBYTES on 14/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Feedback.h"
#define kOFFSET_FOR_KEYBOARD 180.0

@interface Feedback ()
{
    NSString *matri_id;
}
@end

@implementation Feedback

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    singleFingerTap =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(hideKeyboard)];
//   [self.view addGestureRecognizer:singleFingerTap];
    user_inf=[NSUserDefaults standardUserDefaults];
   matri_id=[user_inf valueForKey:@"matri_id"];
    _username=[user_inf valueForKey:@"userName"];
    //   [user_inf setValue:name forKey:@"userName"];
    Cat_ary=[[NSArray alloc]initWithObjects:@"--Select--",@"Problems related to website",@"Problems related to Profiles",@"Compliments and Suggestions",@"Others", nil];
    priority_ary=[[NSArray alloc]initWithObjects:@"--Select--",@"Low",@"Medium",@"High", nil];
    _table.delegate=self;
    _table.dataSource=self;
    _table.layer.borderWidth = 2.0;
    _table.layer.borderColor = [UIColor blackColor].CGColor;
    self.name.delegate = self;
    _name_view.layer.borderColor = [UIColor brownColor].CGColor;
    _name_view.layer.borderWidth = 1.0;
    _cat_view.layer.borderColor = [UIColor brownColor].CGColor;
    _cat_view.layer.borderWidth = 1.0;
    _priority_view.layer.borderColor = [UIColor brownColor].CGColor;
    _priority_view.layer.borderWidth = 1.0;
    _feedback_textview.layer.borderColor = [UIColor brownColor].CGColor;
    _feedback_textview.layer.borderWidth = 1.0;
    _name.text=_username;
    _table.hidden=YES;
    self.matriIDLabel.text = matri_id;
    self.submitBtnLabel.layer.cornerRadius = 10;
    self.submitBtnLabel.clipsToBounds = YES;
    _feedback_textview.delegate = self;
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
   // singleFingerTap.enabled=YES;
    _table.hidden = YES;
  //  [self hideKeyboard];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView
{
    //Has Focus
    if ([aTextView.text isEqualToString:@"Enter Your Feedback"])
    {
        aTextView.text=@"";
    }
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.name isFirstResponder])
    {
        [self.name resignFirstResponder];
    }
   // [self.name endEditing:YES];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
        return NO;
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
   // _table.hidden=YES;
    [self.view endEditing:YES];
}

- (IBAction)category_click:(id)sender
{
   self.tableTopConstraintOutlet.constant = 9;
   // self.categoryPriorityoutlet.priority = 250;
    table_tag=@"C";
    //singleFingerTap.enabled=NO;
    _table.hidden = NO;
    [_table reloadData];
   }

- (IBAction)priority_click:(id)sender
{
    self.tableTopConstraintOutlet.constant = 60;
  //  self.categoryPriorityoutlet.priority = 750;
   table_tag=@"P";
    _table.hidden = NO;
    [_table reloadData];
   // singleFingerTap.enabled=NO;
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



//-(void)keyboardWillShow {
//    // Animate the current view out of the way
//    if (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}
//
//-(void)keyboardWillHide {
//    if (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}
//
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:_feedback_textview])
    {
        //move the main view, so that the keyboard does not hide it.
       
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
    
    else{
        if(sender.tag>=6)
        {
            
            if(self.view.frame.origin.y >= 0)
            {
                [self setViewMovedUp:YES];
            }
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (IBAction)call_click:(id)sender
{
    NSString *phNo = @"1800002100";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
      UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}
@end
