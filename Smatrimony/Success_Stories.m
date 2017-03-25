//
//  Success_Stories.m
//  Smatrimony
//
//  Created by INDOBYTES on 16/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Success_Stories.h"

@interface Success_Stories ()
@end

@implementation Success_Stories
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    s_tag=-1;
    [self success_service];
}

-(void)success_service
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"api/successStories" requestNumber:WUS_S_story showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             
             if ([status isEqualToString:@"1"])
             {
                 NSDictionary *stories_dict=[res_dict valueForKey:@"stories"];
                 photostories_dict=[stories_dict valueForKey:@"photostories"];
                 [_success_table reloadData];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return photostories_dict.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (s_tag == indexPath.row)
    {
        return 500;
    }
    else
        return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    success_cell *cell = [ tableView dequeueReusableCellWithIdentifier:@"success_cell"];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"success_cell" bundle:nil] forCellReuseIdentifier:@"success_cell_1"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"success_cell_1"];
    }
    cell.btn.tag=indexPath.row;
    [cell.btn addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];

    if (s_tag == indexPath.row)
    {
        cell.des.numberOfLines=20;
        UIImage *buttonImage = [UIImage imageNamed:@"top"];
        [cell.btn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    else
    {
        cell.des.numberOfLines=2;
        UIImage *buttonImage = [UIImage imageNamed:@"down"];
        [cell.btn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    NSString *pic=[[photostories_dict valueForKey:@"weddingphoto"]objectAtIndex:indexPath.row];
    NSString *bride_id=[[photostories_dict valueForKey:@"brideid"]objectAtIndex:indexPath.row];
    NSString *marriage_date=[[photostories_dict valueForKey:@"marriagedate"]objectAtIndex:indexPath.row];
    NSString *successmessage=[[photostories_dict valueForKey:@"successmessage"]objectAtIndex:indexPath.row];
    NSString *head_names=[NSString stringWithFormat:@"%@ & %@",[[photostories_dict valueForKey:@"groomname"]objectAtIndex:indexPath.row],[[photostories_dict valueForKey:@"bridename"]objectAtIndex:indexPath.row]];
    cell.head_lbl.text=head_names;
    
    //image with cache
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/SuccessStory/%@",pic]];
    
    [manager downloadImageWithURL: imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         
         if(image)
         {
             cell.img.image = image;
         }
     }];
    //
    /*
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/SuccessStory/%@",pic]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
            cell.img.image = [UIImage imageWithData:imageData];
        });
    });
    */
    if (marriage_date.length !=0)
    {
        cell.mrg_date.text=[NSString stringWithFormat:@"Marriage Date: %@",marriage_date];
    }
    else
        cell.mrg_date.text=[NSString stringWithFormat:@"Marriage Date: N/A"];
    
    if (successmessage.length !=0)
    {
        cell.des.text=[NSString stringWithFormat:@"%@",successmessage];
    }
    else
        cell.des.text=[NSString stringWithFormat:@"N/A"];
    
    if (bride_id.length !=0)
    {
        cell.title.text=[NSString stringWithFormat:@"%@",bride_id];
    }
    else
        cell.title.text=[NSString stringWithFormat:@"N/A"];
    
    return cell;
}

-(void)btn_click :(id)sender
{
    if (s_tag ==[sender tag])
    {
        s_tag=-1;
    }
    else
        s_tag=[sender tag];
    
    [_success_table reloadData];
    /*
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:s_tag inSection:0];
    success_cell *tappedCell = (success_cell *)[_success_table cellForRowAtIndexPath:indexpath];
    
    if ([tappedCell.btn.currentBackgroundImage  isEqual:[UIImage imageNamed:@"1.jpg"]])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"t.png"];
        [tappedCell.btn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    else
    {
        UIImage *buttonImage = [UIImage imageNamed:@"1.jpg"];
        [tappedCell.btn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    */
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
@end
