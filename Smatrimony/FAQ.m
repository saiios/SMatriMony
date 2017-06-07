//
//  FAQ.m
//  Smatrimony
//
//  Created by INDOBYTES on 11/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "FAQ.h"

@interface FAQ ()

@end

@implementation FAQ

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    s_tag=-1;
    [self faq_service];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)faq_service
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"api/faqsList" requestNumber:WUS_S_story showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             
             if ([status isEqualToString:@"1"])
             {
                 faq_dict=[res_dict valueForKey:@"faqsList"];
                 [_faq_table reloadData];
             }
             else if ([status isEqualToString:@"0"]||[status isEqualToString:@"3"])
             {
                 [self Alert:result];
             }
             else if ([status isEqualToString:@"2"])
             {
                 [self Alert:@"Under Review!"];
             }
             else
             {
                 [self Alert:@"Login failed!"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return faq_dict.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (s_tag == indexPath.row)
    {
//        CGFloat height_row=cell.des.frame.size.height;
//        return height_row+50;
        
        CGSize constraintSize = {self.view.frame.size.width-20, 20000}; //230 is cell width & 20000 is max height for cell
        CGSize neededSize = [ [NSString stringWithFormat:@"%@",[[faq_dict valueForKey:@"faq_content"]objectAtIndex:indexPath.row]] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f] constrainedToSize:constraintSize  lineBreakMode:UILineBreakModeCharacterWrap];
        
        
        return MAX(90, neededSize.height +60);
    }
    else
        return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [ tableView dequeueReusableCellWithIdentifier:@"faq_cell_1"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"faq_cell" bundle:nil] forCellReuseIdentifier:@"faq_cell_1"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"faq_cell_1"];
    }
    cell.btn.tag=indexPath.row;
    [cell.btn addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
    
    if (s_tag == indexPath.row)
    {
        cell.des.numberOfLines=0;
        UIImage *buttonImage = [UIImage imageNamed:@"top"];
        [cell.btn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    else
    {
        cell.des.numberOfLines=2;
        UIImage *buttonImage = [UIImage imageNamed:@"down"];
        [cell.btn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    NSString *des_str=[[faq_dict valueForKey:@"faq_content"]objectAtIndex:indexPath.row];
   NSAttributedString *resultstring = [[NSAttributedString alloc] initWithData:[des_str dataUsingEncoding:NSUTF8StringEncoding] options:@{
                                                                                                                                          NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]
                                                                                                                                          }
                                                            documentAttributes:nil error:nil];
     // NSString* htmlStr = @"<some>html</string>";
    des_str = [resultstring string];
 if (des_str.length !=0)
    {
        if ([des_str containsString:@"<p>"]||[des_str containsString:@"</p>"]||[des_str containsString:@"<em>"]||[des_str containsString:@"</em>"]||[des_str containsString:@"&nbsp;"]) {
            des_str = [des_str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
            des_str = [des_str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            des_str = [des_str stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
            des_str = [des_str stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
            des_str = [des_str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
            

        }
        cell.des.text=[NSString stringWithFormat:@"%@",des_str];
    }
    else
        cell.des.text=[NSString stringWithFormat:@"N/A"];
    NSString *faq_title=[[faq_dict valueForKey:@"faq_title"]objectAtIndex:indexPath.row];
    if (faq_title.length !=0)
    {
        cell.title.text=[NSString stringWithFormat:@"%@",faq_title];
    }
    else
        cell.title.text=[NSString stringWithFormat:@"N/A"];
    
    return cell;
}
-(NSString *)stringByStrippingHTML:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}
-(void)btn_click :(id)sender
{
    if (s_tag ==[sender tag])
    {
        s_tag=-1;
    }
    else
        s_tag=[sender tag];
    
    [_faq_table reloadData];
    }

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
