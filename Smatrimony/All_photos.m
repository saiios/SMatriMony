//
//  All_photos.m
//  Smatrimony
//
//  Created by INDOBYTES on 28/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "All_photos.h"

@interface All_photos ()

@end

@implementation All_photos

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
user_inf=[NSUserDefaults standardUserDefaults];
    matri_id=[user_inf valueForKey:@"matri_id"];
    gender=[user_inf valueForKey:@"gender"];

    
    selected_pic_ind=-1;
    _collection_view.delegate=self;
    _collection_view.dataSource=self;

     NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    
    [_collection_view registerNib:[UINib nibWithNibName:@"Pic_Cell" bundle:nil] forCellWithReuseIdentifier:@"Pic_Cell_id"];

    _table.delegate=self;
    _table.dataSource=self;
    _table.layer.borderWidth = 2.0;
    _table.layer.borderColor = [UIColor blackColor].CGColor;
    _table.hidden=YES;

    table_ary=[[NSMutableArray alloc]initWithObjects:@"Camera",@"Gallary",@"Set as Profile Pic",@"Delete",@"Cancel", nil];
    singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(hideKeyboard)];
  //  [self.view addGestureRecognizer:singleFingerTap];
    singleFingerTap.enabled=NO;
    
    [self all_pics:dict];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}
-(void)all_pics:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/getPhotos" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
//             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
//             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
            All_pics_dict=[res_dict valueForKey:@"photos"];
             all_keys=[All_pics_dict allKeys];
             
             [_collection_view reloadData];
            // [self Alert:result];
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return table_ary.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
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
        cell.lbl.text = [NSString stringWithFormat:@"%@",[table_ary objectAtIndex:indexPath.row]];
    if ([selected_pic isEqual:[NSNull null]]||[selected_pic isEqualToString:@""])
    {
        if (indexPath.row==2)
        {
            cell.backgroundColor=[UIColor redColor];
            cell.lbl.textColor=[UIColor whiteColor];
        }
        else
        {
            cell.backgroundColor=[UIColor whiteColor];
            cell.lbl.textColor=[UIColor blackColor];
        }
    }
    else
    {
    if (indexPath.row==4)
    {
        cell.backgroundColor=[UIColor redColor];
        cell.lbl.textColor=[UIColor whiteColor];
    }
    else
    {
        cell.backgroundColor=[UIColor whiteColor];
        cell.lbl.textColor=[UIColor blackColor];
    }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    singleFingerTap.enabled=NO;
    _table.hidden=YES;
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
    else if (indexPath.row==1)//galary
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];

    }
    else if (indexPath.row==2)//set profile pic
    {
        if ([selected_pic isEqual:[NSNull null]]||[selected_pic isEqualToString:@""])
        {
        }
        else
        {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:matri_id forKey:@"matri_id"];
        [dict setObject:[NSString stringWithFormat:@"%d",selected_id] forKey:@"photo_id"];
        
        [self set_profile_pic:dict];
        }
    }
    else if (indexPath.row==3)//delete
    {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:matri_id forKey:@"matri_id"];
        [dict setObject:[NSString stringWithFormat:@"%d",selected_id] forKey:@"photo_id"];
        [dict setObject:[All_pics_dict valueForKey:[NSString stringWithFormat:@"photo%d",selected_id]] forKey:@"photo_name"];
        
        selected_pic=[All_pics_dict valueForKey:[all_keys objectAtIndex:indexPath.row]];
        [self del_profile_pic:dict];
    }
    else if (indexPath.row==4)//cancle
    {
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:selected_pic_ind inSection:0];
    chosenImage = info[UIImagePickerControllerEditedImage];
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

    
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(chosenImage)];

    NSString *base64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    [_collection_view reloadItemsAtIndexPaths:@[indexpath]];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:matri_id forKey:@"matri_id"];
    [dict setObject:[NSString stringWithFormat:@"%d",selected_id] forKey:@"photo_id"];
    [dict setObject:change_img_name forKey:@"photo_name"];
    [dict setObject:base64 forKey:@"photo"];//base64

    [self change_pic:dict];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return All_pics_dict.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
        return CGSizeMake(_collection_view.frame.size.width/3-20, _collection_view.frame.size.width/3-20);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier = @"Pic_Cell_id";
    
    Pic_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    NSString *img_str=[All_pics_dict valueForKey:[NSString stringWithFormat:@"photo%d",indexPath.row+1]];
    if (indexPath.row == selected_pic_ind)
    {
        cell.img.image=chosenImage;
    }
    else
    {
        if ([img_str isEqual:[NSNull null]]|| [img_str isEqualToString:@""])
        {
            if ([gender isEqualToString:@"Groom"])
            {
                cell.img.image=[UIImage imageNamed:@"male"];
            }
            else
                cell.img.image=[UIImage imageNamed:@"female"];
        }
        else
        {
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",img_str]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               cell.img.image = [UIImage imageWithData:imageData];
                               cell.img.contentMode = UIViewContentModeScaleToFill;
                           });
            });
        }
    }
        return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selected_id=indexPath.row+1;
    selected_pic_ind=indexPath.row;
    singleFingerTap.enabled=YES;
    _table.hidden=NO;
    
    selected_pic= [All_pics_dict valueForKey:[NSString stringWithFormat:@"photo%d",selected_id]];
    
    if ([selected_pic isEqual:[NSNull null]]||[selected_pic isEqualToString:@""])
    {
        table_ary=[[NSMutableArray alloc]initWithObjects:@"Camera",@"Gallary",@"Cancel", nil];
        _table_height.constant=120;
    }
    else
    {
        _table_height.constant=200;
        table_ary=[[NSMutableArray alloc]initWithObjects:@"Camera",@"Gallary",@"Set as Profile Pic",@"Delete",@"Cancel", nil];
    }

    [_table reloadData];
}

-(void)set_profile_pic:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/setProfilePicture" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             user_inf=[NSUserDefaults standardUserDefaults];
             [user_inf setValue:selected_pic forKey:@"profile_pic"];
             
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

-(void)change_pic:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/changePhoto" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
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

-(void)del_profile_pic:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/deletePhoto" parameters:Dict requestNumber:WUS_Feedback showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             
             user_inf=[NSUserDefaults standardUserDefaults];
             [user_inf setValue:selected_pic forKey:@"profile_pic"];
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([result isEqualToString:@"success"])
             {
                 NSMutableDictionary *dict = [NSMutableDictionary new];
                 [dict setObject:matri_id forKey:@"matri_id"];
                 [self all_pics:dict];
             }
             [self Alert:result];
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
