//
//  photoDetailViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 24/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "photoDetailViewController.h"
#import "UIScrollView+APParallaxHeader.h"
#import "STParsing.h"
#import "upgrade.h"

@interface photoDetailViewController ()
{
    NSMutableArray *ImageArray;
    NSString *loggedIn_matri_id,*clicked,*clickedGender;
    NSUserDefaults *user_inf;
}

@end

@implementation photoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    user_inf=[NSUserDefaults standardUserDefaults];
    loggedIn_matri_id=[user_inf valueForKey:@"matri_id"];
    clickedGender =   [_images valueForKey:@"gender"];
    self.upgradeViewOutlet.hidden = true;
    if ([clickedGender isEqualToString:_loginUserGender]) {
        self.hideView.hidden = true;
        self.sendInterestBtnOutlet.hidden = true;
        self.chatNowBtnOutlet.hidden = true;
        self.sortListBtnOutlet.hidden = true;
    }
    if ([[_images valueForKey:@"status"]isEqualToString:@"Active"]) {
        
        _likeHerBtnOutlet.hidden = YES;
        
    }
    else
        _likeHerBtnOutlet.hidden = NO;
    
    NSString *interest_status = [NSString stringWithFormat:@"%@",[_images  valueForKey:@"interest_status"]];
    
    if ([interest_status isEqualToString:@"1"]) {
        
          [_sendInterestBtnOutlet setImage:[UIImage imageNamed:@"love.png"] forState:UIControlStateNormal];
        self.interestOutlet.text = @"Interest Sent";
      //  _sendInterestBtnOutlet.backgroundColor = [UIColor colorWithRed:252/255.0f green:109/255.0f blue:82/255.0f alpha:1.0f];
        
    }
    
    else
    {
        
         // _sendInterestBtnOutlet.backgroundColor = [UIColor clearColor];
        [_sendInterestBtnOutlet setImage:[UIImage imageNamed:@"loveno.png"] forState:UIControlStateNormal];
        self.interestOutlet.text = @"Send Interest";
    }

    NSString *sortList = [NSString stringWithFormat:@"%@",[_images valueForKey:@"shortlist_status"]];
    if ([sortList isEqualToString:@"1"]) {
        
        [_sortListBtnOutlet setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
        
        self.shortListLabel.text = @"Shortlisted";
    }
    else
    {
        [_sortListBtnOutlet setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
        self.shortListLabel.text = @"Shortlist";
    }
    
    
    [self imagescroll];
    
    
}

@synthesize delegate;
-(void)viewWillDisappear:(BOOL)animated
{
    [delegate sendDataToA:_images];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagescroll
{
    if (_images.count>0) {
        ImageArray = [[NSMutableArray alloc]init];
        UIImageView *imgV ;
        
        
        for (int i =1; i<10; i++) {
            
            NSString *pic = [NSString stringWithFormat:@"photo%d",i];
            NSString *checkit = [NSString stringWithFormat:@"%@",[_images valueForKey:pic]];
            
            if ([checkit isEqual:[NSNull null]]||[checkit isEqualToString:@"<nil>"]||checkit == nil||checkit == NULL||[checkit isEqualToString:@""]) {
                
                
            }
            else
            {
                
                NSString *image =  [NSString stringWithFormat:@"http://www.smatrimony.com/photos/%@",checkit];
                [ImageArray addObject:image];
                
            }
            
        }
       
        
        //        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.smatrimony.com/photos/%@",image]];
        
        
        
        
        UIView  *vv = [[UIView alloc]initWithFrame:CGRectMake(0,150, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,130, [UIScreen mainScreen].bounds.size.width,self.view.frame.size.height-250)];
        scroll.backgroundColor = [UIColor whiteColor];
        
        if (!(ImageArray.count >0)) {
            
            
            imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,250)];
            imgV.backgroundColor = [UIColor whiteColor];
            imgV.userInteractionEnabled =NO;
            
            
            if ([clickedGender isEqualToString:@"Groom"]) {
                [imgV setImage: [UIImage imageNamed:@"male"]];
            }
            else
            {
                [imgV setImage: [UIImage imageNamed:@"female"]];
            }
            
            [vv addSubview:imgV];
        }
        
        
        else{

               for(int i = 0; i < [ImageArray count]; i++)
        {
            UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                      [NSURL URLWithString:[ImageArray objectAtIndex:i]]]];
            
            //After converted, replace the same array with the new UIImage Object
            [ImageArray replaceObjectAtIndex:i withObject: image];
        }
        
        
        
        for (int i=0; i<[ImageArray count]; i++) {
            NSLog(@"%f",[UIScreen mainScreen].bounds.size.width*i);
            // create imageView
            float jj =[UIScreen mainScreen].bounds.size.width*i;
            
            imgV = [[UIImageView alloc] initWithFrame:CGRectMake(jj,0, [UIScreen mainScreen].bounds.size.width,400)];
            // set scale to fill
            // imgV.contentMode=UIViewContentModeScaleAspectFill;
            imgV.backgroundColor = [UIColor greenColor];
            // imgV.image=[UIImage imageNamed:@"t.png"];
            [imgV setImage:[ImageArray objectAtIndex:i]];
            imgV.userInteractionEnabled =YES;
            // apply tag to access in future
            imgV.tag=i+1;
            
            
            [scroll addSubview:imgV];
            
            
            
            
        }
        
        scroll.backgroundColor = [UIColor grayColor];
        [scroll setContentSize:CGSizeMake( [UIScreen mainScreen].bounds.size.width*[ImageArray count], 250)];
        scroll.pagingEnabled =YES;
        [vv addSubview:scroll];
        [self.view addSubview:scroll];
        [self.view addSubview:_upgradeViewOutlet];
//        [self.profileTableVIew addParallaxWithView:vv andHeight:200];
//        parallaxWithView = YES;
//        self.profileTableVIew.parallaxView.delegate = self;
    }
    }
}

- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)likeHerBtnActn:(id)sender {
    
    upgrade *menuController  =[[upgrade alloc]initWithNibName:@"upgrade" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)sortListBtnActn:(id)sender {
    
    
    if ([_sortListBtnOutlet.imageView.image isEqual:[UIImage imageNamed:@"unshortlist_icon.png"]])
    {
        
        
        NSString *listId = [_images valueForKey:@"matri_id"];
        
        NSDictionary *params = @{@"matri_id":listId,@"loginmatri_id":loggedIn_matri_id};
        [self profileServiceCallForSort:@"services/api/addToShortlist" Params:params];
        
        
    }
    else
    {
     
        NSString *listId = [_images valueForKey:@"matri_id"];
        
        NSDictionary *params = @{@"matri_id":listId,@"loginmatri_id":loggedIn_matri_id};
        [self profileServiceCallForSort:@"services/api/removeFromShortlist" Params:params];
        
        
    }
    
    
}
- (IBAction)chatNowBtnActn:(id)sender {
}
- (IBAction)sendintrstBtnActn:(id)sender {
    
  
    
   
    clicked = @"interest";
    
    
    NSString *listId = [_images valueForKey:@"matri_id"];
    
    NSDictionary *params = @{@"matri_id":listId,@"loginmatri_id":loggedIn_matri_id};
  //  NSString *urlMethod =@"services/api/sendInterest";
    [self profileServiceCallForSort:@"services/api/sendInterest" Params:params];
    
    
    //[self checkUpgrade:params url:urlMethod];
    
    
   }

-(void)profileServiceCallForSort:(NSString *)url Params:(NSDictionary *)param {
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:param requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         
         
         if (success)
         {
             NSDictionary *res_dict = data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
           
                 
                 if ([status isEqualToString:@"1"])
                 {
                     
                     if ([clicked isEqualToString:@"interest"]) {
                         
                         if (  (_sendInterestBtnOutlet.backgroundColor = [UIColor clearColor])) {
                             _sendInterestBtnOutlet.backgroundColor =  [UIColor colorWithRed:252/255.0f green:109/255.0f blue:82/255.0f alpha:1.0f];
                            // [self.sendInterestBtnOutlet setImage: forState:UIControlState];
                             [self.sendInterestBtnOutlet setImage:[UIImage imageNamed:@"love"] forState:UIControlStateNormal];
                             self.interestOutlet.text = @"Interest Sent";
                         }
                         else
                         {
                             _sendInterestBtnOutlet.backgroundColor = [UIColor clearColor];
                              [self.sendInterestBtnOutlet setImage:[UIImage imageNamed:@"loveno"] forState:UIControlStateNormal];
                             self.interestOutlet.text = @"Send Interest";
                         }
                         ALERT_DIALOG(@"Success", result);
                     }
                     else
                     {
                     
                     if ([_sortListBtnOutlet.imageView.image isEqual:[UIImage imageNamed:@"unshortlist_icon.png"]])
                     {
                         [_sortListBtnOutlet setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
                         self.shortListLabel.text = @"Shortlisted";
                         
                     }
                     
                     else{
                         [_sortListBtnOutlet setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
                         self.shortListLabel.text = @"Shortlist";
                     }
                }//clicked
                 
             }
             
             
             
             else if ([status isEqualToString:@"2"])
             {
                 //ALERT_DIALOG(@"Alert", result);
                
                 self.upgradeNameOutlet.text = [NSString stringWithFormat:@"To Send Interest to %@ now Upgrade membership",[_images valueForKey:@"username"]];
                 NSString * genderStatus =[NSString stringWithFormat:@"%@",[_images valueForKey:@"gender"]];
                 NSString *profile_pic = [NSString stringWithFormat:@"%@",[_images valueForKey:@"photo1"]];
                 if ([profile_pic isEqual:[NSNull null]]|| [profile_pic isEqualToString:@""])
                 {
                     if ([genderStatus isEqualToString:@"Groom"]) {
                        self.upgradeImage.image = [UIImage imageNamed:@"male"];
                     }
                     else
                     {
                         self.upgradeImage.image = [UIImage imageNamed:@"female"];
                     }
                 }
                 else
                 {
                     NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",profile_pic]];
                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
                                    ^
                                    {
                                        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                                        dispatch_async(dispatch_get_main_queue(),
                                                       ^
                                                       {
                                                           self.upgradeImage.image = [UIImage imageWithData:imageData];
                                                       });
                                    });
                 }
                    self.upgradeViewOutlet.hidden = false;
             }
             
             else
             {
                 ALERT_DIALOG(@"Alert",result);
                 
             }
             clicked =@"";
         }
         
         else
         {
             ALERT_DIALOG(@"Alert", @"Something went wrong");
              clicked =@"";
         }
         
     }];
}

- (IBAction)upgradeNowAction:(id)sender {
    upgrade *menuController  =[[upgrade alloc]initWithNibName:@"upgrade" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)closeAction:(id)sender {
    self.upgradeViewOutlet.hidden = true;
}
@end
