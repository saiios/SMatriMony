//
//  PageViewController.m
//  Mews
//
//  Created by way2online on 22/04/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "PageViewController.h"
#import "ProfileTableViewCell.h"
#import "AppDelegate.h"


@interface PageViewController ()
{
    NSString *matri_id,*gValue;
    NSMutableArray *ProfileArr;
    NSMutableArray *sortlisted;
    NSMutableArray *sendInterestArr;
    BOOL sendInterestCheck;
    NSString *clicked;
    NSString * enteredMatriId;
    BOOL isEmptyArr ;
    NSInteger sendInterestTag;
    
    
    
}
@end

@implementation PageViewController

@synthesize contentArray;


-(AppDelegate *)appdelegate{
    
      return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)viewWillAppear:(BOOL)animated{
    self.popUpView.hidden = true;
    NSString * checkValue = [user_inf valueForKey:@"resultView"];
    if ([checkValue isEqualToString:@"photoView"]) {
        isPhotoView = YES;
    }
    else
    {
        isPhotoView = NO;
    }

     //NSDictionary *params = @{@"loginmatri_id":matri_id};
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _newsTableView.delegate =self;
    _newsTableView.dataSource =self;
    
    
    _newsTableView.rowHeight = UITableViewAutomaticDimension;
    _newsTableView.estimatedRowHeight = 196.0; //
    // Do any additional setup after loading the view from its nib.
    sortlisted = [[NSMutableArray alloc]init];
    sendInterestArr = [[NSMutableArray alloc]init];
    
    user_inf=[NSUserDefaults standardUserDefaults];
    matri_id=[user_inf valueForKey:@"matri_id"];
    // [user_inf setValue:gender_str forKey:@"gender"];
    _genderStrng=[user_inf valueForKey:@"gender"];
    //isPhotoView=YES;
    [self serviceHandler];
    [self.newsTableView reloadData];
    sendInterestCheck=NO;
    enteredMatriId = @"";
    self.popUpView.hidden = true;
   // ProfileViewController * profileTableObj = [[ProfileViewController alloc]init];
    isEmptyArr = YES;
    
    self.upgradeView.hidden=YES;

}



-(void)serviceHandler
{
    if (_index ==0) {
        
        // http://www.smatrimony.com/services/api/similarProfiles
        
        NSDictionary *paramss = @{@"gender":@"",@"matri_id":matri_id,@"caste":@"",@"religion":@""};
        
        [self profileServiceCallFor_Post:@"services/api/similarProfiles" params:paramss];
        
    }
    
    else if (_index ==1) {
        
        //  http://www.devtesthub.com/services/api/recentlyjoinedProfiles
        
        NSDictionary *paramss = @{@"gender":_genderStrng,@"matri_id":matri_id};
        
        [self profileServiceCallFor_Post:@"services/api/recentlyjoinedProfiles" params:paramss];
        
    }
    
    else if (_index ==2) {
        
        // http://www.devtesthub.com/services/api/shortlistedProfiles
        
        NSDictionary *paramss = @{@"matri_id":matri_id};
        
        [self profileServiceCallFor_Post:@"services/api/shortlistedProfiles" params:paramss];
        
    }
    
    
    
    else if (_index ==3) {
        
        // http://www.devtesthub.com/services/api/whomviewedProfiles
        
        NSDictionary *paramss = @{@"gender":@"",@"matri_id":matri_id,@"caste":@"",@"religion":@""};
        
        [self profileServiceCallFor_Post:@"services/api/whomviewedProfiles" params:paramss];//who viwed my profile
        
    }
    
    else if (_index ==4) {
        
        // http://www.devtesthub.com/services/api/iviewedProfiles
        
        NSDictionary *paramss = @{@"matri_id":matri_id};
        
        [self profileServiceCallFor_Post:@"services/api/iviewedProfiles" params:paramss]; //whose profile i watched
        
    }
    
    else if (_index ==5) {
        
        // http://www.devtesthub.com/services/api/iviewedContacts
        
        NSDictionary *paramss = @{@"matri_id":matri_id};
        
        [self profileServiceCallFor_Post:@"services/api/iviewedContacts" params:paramss];// whose contacts i watched
    }
    
    else if (_index ==6) {
        
        // http://www.devtesthub.com/services/api/whoviewedContacts
        
        NSDictionary *paramss = @{@"matri_id":matri_id};
        
        [self profileServiceCallFor_Post:@"services/api/whoviewedContacts" params:paramss];// who watched my contact
    }
    
    else if (_index ==7) {
        NSDictionary *paramss;
        if (_city.length>0) {
             paramss = @{@"matri_id":matri_id,@"city":_city};
        }
        else{
        paramss = @{@"matri_id":matri_id,@"city":@""};
        }
        
        [self profileServiceCallFor_Post:@"services/api/nearByProfiles" params:paramss];
    }
    else if(_index == 8)
    {
        [_newsTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 196;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_index == 8) {
        return 1;
    }
    else
    return  ProfileArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //base View
    UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(0, 0,tableView.frame.size.width,30)];
    return vi;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPhotoView ==YES)
    {
       return 351;
    }
    else if (_index == 8)
    {
        return 150;
    }
    else
        return 260;
//    CGSize constraintSize = {230.0, 20000}; //230 is cell width & 20000 is max height for cell
//    CGSize neededSize = [ [NSString stringWithFormat:@"%@",[cellar objectAtIndex:indexPath.row]] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f] constrainedToSize:constraintSize  lineBreakMode:UILineBreakModeCharacterWrap];
//    
//    
//    return MAX(45, neededSize.height +33);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(_index == 8)) {
        gValue =[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"gender"];
        if (isPhotoView ==YES)
        {
            Photo_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo_cell"];
            if (cell==nil)
            {
                [tableView registerNib:[UINib nibWithNibName:@"Photo_cell" bundle:nil] forCellReuseIdentifier:@"Photo_cell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"Photo_cell"];
            }
            if (_index == 3) {
            
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor redColor];
            // send interest
            
           
            NSString *interest_status = [NSString stringWithFormat:@"%@",[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"interest_status"]];
            cell.sendInterestBtn.tag=indexPath.row;
            
            [cell.sendInterestBtn addTarget:self action:@selector(sendInterestclick:) forControlEvents:UIControlEventTouchUpInside];
            if ([interest_status isEqualToString:@"1"] || [sendInterestArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                
                //  [cell.sendInterestBtn setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
                
                //  cell.sendInterestBtn.backgroundColor = [UIColor colorWithRed:252/255.0f green:109/255.0f blue:82/255.0f alpha:1.0f];
                [cell.sendInterestBtn setTitle:@"    Interest Sent" forState:UIControlStateNormal];
               
                 cell.sendBtnImageOutlet.image = [UIImage imageNamed:@"heart-black-shape-for-valentines.png"];
                
            }
            
            else
            {
                // [cell.sendInterestBtn setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
                
                //  cell.sendInterestBtn.backgroundColor = [UIColor whiteColor];
                [cell.sendInterestBtn setTitle:@"    Send Interest" forState:UIControlStateNormal];
                cell.sendBtnImageOutlet.image = [UIImage imageNamed:@"heart.png"];
                
                
                
            }
            
            // image
            
            NSString * image = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"photo1"];
            if ([image isEqual:[NSNull null]]||[image isEqualToString:@""])
            {
                
                if([gValue isEqualToString:@"Groom"])
                {
                    cell.imageOutlet.image = [UIImage imageNamed:@"male"];
                }
                else
                {
                    cell.imageOutlet.image = [UIImage imageNamed:@"female"];
                }
            }
            else
            {
//                NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.smatrimony.com/photos/%@",image]];
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//                    dispatch_async(dispatch_get_main_queue(),
//                                   ^{
//                                       cell.imageOutlet.image = [UIImage imageWithData:imageData];
//                                   });
//                });
     //           ------------------------------------      or    -----------------------------------------
                
                //image with cache
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                
                NSString * image = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"photo1"];
                
                NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.smatrimony.com/photos/%@",image]];
                
                [manager downloadImageWithURL: imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
                 {
                 } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                     
                     if(image)
                     {
                         cell.imageOutlet.image = image;
                     }
                 }];
                
            }
            
            
            
            
            
            
            cell.SortListBtn.tag=indexPath.row;
            
            [cell.SortListBtn addTarget:self action:@selector(SortListclick:) forControlEvents:UIControlEventTouchUpInside];
            NSString *Sortinterest = [NSString stringWithFormat:@"%@",[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"shortlist_status"]];
            
            if ([Sortinterest isEqualToString:@"1"] || [sortlisted containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                
                [cell.SortListBtn setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
                cell.photoShortListLabel.text =@"ShortListed";
            }
            
            else
            {
                [cell.SortListBtn setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
                cell.photoShortListLabel.text = @"Shortlist";
            }
            
            
            //        if ([interest_status isEqualToString:@"1"] || [sendInterestArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
            //
            //            //  [cell.sendInterestBtn setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
            //
            //            // cell.sendInterestBtn.backgroundColor = [UIColor colorWithRed:252/255.0f green:109/255.0f blue:82/255.0f alpha:1.0f];
            //            [cell.sendInterestBtn setTitle:@"    Interest Sent" forState:UIControlStateNormal];
            //            cell.btnImageOutlet.image = [UIImage imageNamed:@"heart-black-shape-for-valentines.png"];
            //        }
            //
            //        else
            //        {
            //            // [cell.sendInterestBtn setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
            //
            //            // cell.sendInterestBtn.backgroundColor = [UIColor whiteColor];
            //
            //            [cell.sendInterestBtn setTitle:@"    Send Interest" forState:UIControlStateNormal];
            //            cell.btnImageOutlet.image = [UIImage imageNamed:@"heart.png"];
            //
            //        }
            
            
            NSString *cell_matri_id = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"matri_id"];
            
            NSString *validateName = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"username"];
            
            if ([validateName isEqual:[NSNull null]]||[validateName isEqualToString:@"<nil>"]||validateName == nil||validateName == NULL||[validateName isEqualToString:@""])
            {
                
            }
            else
            {
                cell.name.text = [NSString stringWithFormat:@"%@ %@",validateName,cell_matri_id];
            }
            
            NSString *height = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"height"];
            
            int inches= [height intValue];
            
            float feet=inches*0.0833;
            
            NSString *feet_str=[NSString stringWithFormat:@"%.1f",feet];
            NSArray* theConvertion = [feet_str componentsSeparatedByCharactersInSet:
                                      [NSCharacterSet characterSetWithCharactersInString:@"."]];
            NSString *value1 = theConvertion[0];
            NSString *value2 = theConvertion[1];
            
            
            
            // cell.heightLbl.text = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"height"];
            
            //year
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *today = [dateFormatter stringFromDate:[NSDate date]];
            NSDate *date1 = [dateFormatter dateFromString:today];
            
            NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init];
            [dateFormatte setDateFormat:@"yyyy-MM-dd"];
            NSString *str_dob=[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"birthdate"];
            NSDate *date2 = [dateFormatte dateFromString:[NSString stringWithFormat:@"%@",str_dob]];
            
            unsigned int unitFlags = NSDayCalendarUnit;
            
            NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *comps = [gregorian components:unitFlags fromDate:date2  toDate:date1  options:0];
            
            NSString *years = [NSString stringWithFormat:@"%ld",([comps day]/365)];
            
            NSString *age_str=[NSString stringWithFormat:@"%@ Yrs %@ Ft %@ in",years,value1,value2];
            
            
            cell.age.text = age_str;
            
            NSString *validaeCity = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"city_name"];
            
            NSString *Address = @"";
            
            if ([validaeCity isEqual:[NSNull null]]||[validaeCity isEqualToString:@"<nil>"]||validaeCity == nil||validaeCity == NULL||[validaeCity isEqualToString:@""]) {
                
            }
            else
            {
                Address = [NSString stringWithFormat:@"%@ ,",[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"city_name"]];
                
            }
            
            //    "district_name"
            
            NSString *validaeCountry = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"country_name"];
            
            if ([validaeCity isEqual:[NSNull null]]||[validaeCity isEqualToString:@"<nil>"]||validaeCity == nil||validaeCity == NULL||[validaeCity isEqualToString:@""]) {
                
            }
            
            else
            {
                Address = [NSString stringWithFormat:@"%@, ",[Address stringByAppendingString:validaeCountry]];
            }
            
            // "district_name"
            
            NSString *validaeDistrict = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"district_name"];
            
            if ([validaeDistrict isEqual:[NSNull null]]||[validaeDistrict isEqualToString:@"<nil>"]||validaeDistrict == nil||validaeDistrict == NULL||[validaeDistrict isEqualToString:@""])
            {
            }
            else
            {
                Address = [NSString stringWithFormat:@"%@.",[Address stringByAppendingString:validaeDistrict]];
            }
            cell.address.text = Address;
            
            cell.plan.text  = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"plan_name"];
            
            return cell;
        }
        else
        {
            ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileTableViewCell"];
            if (cell==nil)
            {
                [tableView registerNib:[UINib nibWithNibName:@"ProfileTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProfileTableViewCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileTableViewCell"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
//            if ([gValue isEqualToString:_genderStrng]) {
//                cell.SortListBtn.hidden = true;
//                cell.sendInterestBtn.hidden = true;
//                cell.shortlistLabel.hidden = true;
//                cell.chatBtn.hidden = true;
//                cell.chatLabel.hidden = true;
//                cell.btnImageOutlet.hidden = true;
//            }
//            else
//            {
//                cell.SortListBtn.hidden = false;
//                cell.sendInterestBtn.hidden = false;
//                cell.shortlistLabel.hidden = false;
//                cell.chatBtn.hidden = false;
//                cell.chatLabel.hidden = false;
//                cell.btnImageOutlet.hidden = false;
//                
//            }
            cell.SortListBtn.tag=indexPath.row;
            
            [cell.SortListBtn addTarget:self action:@selector(SortListclick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.sendInterestBtn.tag=indexPath.row;
            
            
            
            [cell.sendInterestBtn addTarget:self action:@selector(sendInterestclick:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *Sortinterest = [NSString stringWithFormat:@"%@",[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"shortlist_status"]];
            
            if ([Sortinterest isEqualToString:@"1"] ) {
                
                [cell.SortListBtn setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
                cell.shortlistLabel.text = @"Shortlisted";
            }
            
            else
            {
                [cell.SortListBtn setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
                cell.shortlistLabel.text = @"Shortlist";
            }
           
            // send interest
            
            NSString *interest_status = [NSString stringWithFormat:@"%@",[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"interest_status"]];
            
            if ([interest_status isEqualToString:@"1"] || [sendInterestArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                
                //  [cell.sendInterestBtn setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
                
                // cell.sendInterestBtn.backgroundColor = [UIColor colorWithRed:252/255.0f green:109/255.0f blue:82/255.0f alpha:1.0f];
                [cell.sendInterestBtn setTitle:@"    Interest Sent" forState:UIControlStateNormal];
                cell.btnImageOutlet.image = [UIImage imageNamed:@"heart-black-shape-for-valentines.png"];
            }
            
            else
            {
                // [cell.sendInterestBtn setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
                
                // cell.sendInterestBtn.backgroundColor = [UIColor whiteColor];
                
                [cell.sendInterestBtn setTitle:@"    Send Interest" forState:UIControlStateNormal];
                cell.btnImageOutlet.image = [UIImage imageNamed:@"heart.png"];
                
            }
            
            
            
            // image
            NSString * image = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"photo1"];
            if ([image isEqual:[NSNull null]]||[image isEqualToString:@""])
            {
               
                if([gValue isEqualToString:@"Groom"])
                {
                    cell.imageOutlet.image = [UIImage imageNamed:@"male"];
                }
                else
                {
                    cell.imageOutlet.image = [UIImage imageNamed:@"female"];
                }
            }
            else{
            
            //image with cache
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            
            NSString * image = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"photo1"];
            
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.smatrimony.com/photos/%@",image]];
            
            [manager downloadImageWithURL: imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
             {
             } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                 
                 if(image)
                 {
                     cell.imageOutlet.image = image;
                 }
             }];
            }
            
//            NSString * image = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"photo1"];
//            
//            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.smatrimony.com/photos/%@",image]];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//                dispatch_async(dispatch_get_main_queue(),
//                               ^{
//                                   cell.imageOutlet.image = [UIImage imageWithData:imageData];
//                               });
//            });
            
            cell.MatriIDLbl.text = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"matri_id"];
            
            NSString *validateName = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"username"];
            
            if ([validateName isEqual:[NSNull null]]||[validateName isEqualToString:@"<nil>"]||validateName == nil||validateName == NULL||[validateName isEqualToString:@""]) {
                
            }
            else
            {
                cell.nameLbl.text = validateName;
            }
            
            NSString *height = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"height"];
            
            int inches= [height intValue];
            
            float feet=inches*0.0833;
            
            NSString *feet_str=[NSString stringWithFormat:@"%.1f",feet];
            NSArray* theConvertion = [feet_str componentsSeparatedByCharactersInSet:
                                      [NSCharacterSet characterSetWithCharactersInString:@"."]];
            NSString *value1 = theConvertion[0];
            NSString *value2 = theConvertion[1];
            
            
            
            // cell.heightLbl.text = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"height"];
            
            //year
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *today = [dateFormatter stringFromDate:[NSDate date]];
            NSDate *date1 = [dateFormatter dateFromString:today];
            
            NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init];
            [dateFormatte setDateFormat:@"yyyy-MM-dd"];
            NSString *str_dob=[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"birthdate"];
            NSDate *date2 = [dateFormatte dateFromString:[NSString stringWithFormat:@"%@",str_dob]];
            
            unsigned int unitFlags = NSDayCalendarUnit;
            
            NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *comps = [gregorian components:unitFlags fromDate:date2  toDate:date1  options:0];
            
            NSString *years = [NSString stringWithFormat:@"%ld",([comps day]/365)];
            
            NSString *age_str=[NSString stringWithFormat:@"%@ Yrs %@ Ft %@ in",years,value1,value2];
            
            //  cell.age.text=age_str;
            
            cell.heightLbl.text = age_str;
            //    "city_name"
            //    "country_name"
            //    "district_name"
            
            NSString *validaeCity = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"city_name"];
            
            NSString *Address = @"";
            
            if ([validaeCity isEqual:[NSNull null]]||[validaeCity isEqualToString:@"<nil>"]||validaeCity == nil||validaeCity == NULL||[validaeCity isEqualToString:@""]) {
                
            }
            else
            {
                Address = [NSString stringWithFormat:@"%@ ,",[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"city_name"]];
                
            }
            
            //    "district_name"
            
            NSString *validaeCountry = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"country_name"];
            
            if ([validaeCity isEqual:[NSNull null]]||[validaeCity isEqualToString:@"<nil>"]||validaeCity == nil||validaeCity == NULL||[validaeCity isEqualToString:@""]) {
                
            }
            
            else
            {
                Address = [NSString stringWithFormat:@"%@, ",[Address stringByAppendingString:validaeCountry]];
            }
            
            // "district_name"
            
            NSString *validaeDistrict = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"district_name"];
            
            if ([validaeDistrict isEqual:[NSNull null]]||[validaeDistrict isEqualToString:@"<nil>"]||validaeDistrict == nil||validaeDistrict == NULL||[validaeDistrict isEqualToString:@""]) {
                
            }
            
            else
            {
                Address = [NSString stringWithFormat:@"%@.",[Address stringByAppendingString:validaeDistrict]];
            }
            
            cell.AddressLbl.text = Address;
            
            
            NSString *validaeCaste = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"religion_name"];
            
            NSString *caste = @"";
            
            if ([validaeCaste isEqual:[NSNull null]]||[validaeCaste isEqualToString:@"<nil>"]||validaeCaste == nil||validaeCaste == NULL||[validaeCaste isEqualToString:@""]) {
                
            }
            
            else
            {
                caste = [NSString stringWithFormat:@"%@ ",[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"religion_name"]];
                
            }
            
            NSString *validaeReligion = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"caste_name"];
            
            if ([validaeReligion isEqual:[NSNull null]]||[validaeReligion isEqualToString:@"<nil>"]||validaeReligion == nil||validaeReligion == NULL||[validaeReligion isEqualToString:@""]) {
                
            }
            else
            {
                NSString *castee = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"caste_name"];
                caste = [caste stringByAppendingString:castee];
                
            }
            
            cell.casteLbl.text = caste;
            
            NSString *occName = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"ocp_name"];
            
            if ([occName isEqual:[NSNull null]]||[occName isEqualToString:@"<nil>"]||occName == nil||validaeReligion == NULL||[occName isEqualToString:@""]) {
                
            }
            
            else
            {
                
                cell.AccountLbl.text = [[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"ocp_name"];
                
            }
            
            return cell;
        }
        
      }
    else
       {
        static NSString *simpleTableIdentifier = @"Id_SearchCell";
        Id_SearchCell *cellObj= (Id_SearchCell *)[_newsTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cellObj == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Id_SearchCell" owner:self options:nil];
            cellObj = (Id_SearchCell *)[nib objectAtIndex:0];
            
        }
           cellObj.matrid_IdValue.userInteractionEnabled = YES;
          cellObj.selectionStyle = UITableViewCellSelectionStyleNone;
           
           cellObj.submitBtn.tag = indexPath.row;
           [cellObj.submitBtn addTarget:self action:@selector(idSearchSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
           return cellObj;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_index == 8) {
        
    }
    else
    {
   NSString *matriId=[NSString stringWithFormat:@"%@",[[ProfileArr objectAtIndex:indexPath.row] valueForKey:@"matri_id"]];
    [_delegate clickedProfileTable:indexPath selectedMatriId:matriId];
    }
}
-(void)idSearchSubmitAction:(id)sender
{
//    [_delegate clickedProfileTable:indexPath selectedMatriId:enteredMatriId];
    NSInteger value = [sender tag];
    NSIndexPath *myIP = [NSIndexPath indexPathForRow:value inSection:0] ;
    Id_SearchCell *tappedCell = (Id_SearchCell *)[_newsTableView cellForRowAtIndexPath:myIP];
    enteredMatriId = tappedCell.matrid_IdValue.text;
    if ([enteredMatriId isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"Please Enter MATRI ID");
    }
    else
    {
        NSDictionary *param = @{@"matri_id":enteredMatriId};
        [self validMatriId:@"api/searchbyId" params:param enteredId:enteredMatriId indexPath:myIP];
    // [_delegate clickedProfileTable:myIP selectedMatriId:enteredMatriId]; // moved to sucessses service
    }
  }

-(void)reloadController:(NSArray *)news{
//    [contentArray removeAllObjects];
//    [contentArray addObjectsFromArray:news];
  //  [_newsTableView reloadData];
    
    
}
-(void)SortListclick:(id)sender
{
    if([gValue isEqualToString:_genderStrng])
    {
        ALERT_DIALOG(@"Alert", @"can't shortlist same gender");
    }
    else
    {
    UIButton *button=(UIButton *) sender;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    // NSInteger row = indexpath.row;
    
    ProfileTableViewCell *tappedCell = (ProfileTableViewCell *)[_newsTableView cellForRowAtIndexPath:indexpath];
    
    
    
    if ([tappedCell.SortListBtn.imageView.image isEqual:[UIImage imageNamed:@"unshortlist_icon.png"]])
    {
        clicked = @"sort";
        
        //    [tappedCell.SortListBtn setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
        
        NSString *index = [NSString stringWithFormat:@"%ld",(long)[sender tag]];
        [sortlisted addObject:index];
        NSString *listId = [[ProfileArr objectAtIndex:[sender tag]] valueForKey:@"matri_id"];
        
        NSDictionary *params = @{@"matri_id":listId,@"loginmatri_id":matri_id};
        [self sortServiceCallFor_Post:@"services/api/addToShortlist" params:params];
        
        
        
    }
    else
    {
        
        clicked = @"sort";
        //  [tappedCell.SortListBtn setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
        
        NSString *index = [NSString stringWithFormat:@"%ld",(long)[sender tag]];
        
        
        NSString *listId = [[ProfileArr objectAtIndex:[sender tag]] valueForKey:@"matri_id"];
        
        NSDictionary *params = @{@"matri_id":listId,@"loginmatri_id":matri_id};
        [self sortServiceCallFor_Post:@"services/api/removeFromShortlist" params:params];
        
        [sortlisted removeObject:index];
    }
    
    }
}

-(void)sendInterestclick:(id)sender
{
    if([gValue isEqualToString:_genderStrng])
    {
        ALERT_DIALOG(@"Alert", @"can't send Intrest to same gender");
    }
    else
    {
    UIButton *button=(UIButton *) sender;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    
  
    NSString *index = [NSString stringWithFormat:@"%ld",(long)[sender tag]];
    [sortlisted addObject:index];
    NSString *listId = [[ProfileArr objectAtIndex:[sender tag]] valueForKey:@"matri_id"];
    sendInterestTag = [sender tag];
    
    NSDictionary *params = @{@"matri_id":listId,@"loginmatri_id":matri_id};
   // NSString *urlMethod =@"services/api/sendInterest";
    clicked =@"sendInterest";
     [self sortServiceCallFor_Post:@"services/api/sendInterest" params:params];
    }
    
}

-(void)checkUpgrade:(NSDictionary *)param url:(NSString *)url{
    
    // http://www.devtesthub.com/services/api/checkmembership
    clicked = @"checkmembership";
    
    [self checkMemberShip:url params:param];
    
}
- (IBAction)upgradeCloseAction:(id)sender {
    self.upgradeView.hidden = true;
}
- (IBAction)upgradeActiveAction:(id)sender {
    int sender_tag=[sender tag];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:sender_tag inSection:0];
  NSDictionary *dic =  [ProfileArr objectAtIndex:sender_tag];
    [_delegate gotoUpgradeAcc:dic];
}




-(void)profileServiceCallFor_Post:(NSString *)url params:(NSDictionary *)params
{
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         
         
         if (success)
         {
             NSDictionary *res_dict = data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             
             if ([status isEqualToString:@"1"])
             {
                
                 if (_index ==0) {
                     
                     ProfileArr = [[NSMutableArray alloc]initWithArray:[res_dict valueForKey:@"similarlist"]];
                     if (ProfileArr.count>0) {
                         isEmptyArr = NO;
                     }
                     
                 }
                 else if (_index ==1) {
                     
                     ProfileArr = [[NSMutableArray alloc]initWithArray:[res_dict valueForKey:@"recentlyjoinedlist"]];
                     if (ProfileArr.count>0) {
                         isEmptyArr = NO;
                     }
                 }
                 else if (_index ==2) {
                     
                     ProfileArr = [[NSMutableArray alloc]initWithArray:[res_dict valueForKey:@"shortlisted"]];
                     if (ProfileArr.count>0) {
                         isEmptyArr = NO;
                     }
                 }
                 else if (_index ==3) {
                     
                     ProfileArr = [[NSMutableArray alloc]initWithArray:[res_dict valueForKey:@"whomviewedlist"]];
                     if (ProfileArr.count>0) {
                         isEmptyArr = NO;
                     }
                 }
                 else if (_index ==4) {
                     
                     ProfileArr = [[NSMutableArray alloc]initWithArray:[res_dict valueForKey:@"viewedlist"]];
                     if (ProfileArr.count>0) {
                         isEmptyArr = NO;
                     }
                 }
                 else if (_index ==5) {
                     
                     ProfileArr = [[NSMutableArray alloc]initWithArray:[res_dict valueForKey:@"viewedlist"]];
                     if (ProfileArr.count>0) {
                         isEmptyArr = NO;
                     }
                 }
                 else if (_index ==6) {
                     
                     ProfileArr = [[NSMutableArray alloc]initWithArray:[res_dict valueForKey:@"viewedlist"]];
                     if (ProfileArr.count>0) {
                         isEmptyArr = NO;
                     }
                 }
                 else if (_index ==7) {
                     ProfileArr = [[NSMutableArray alloc]initWithArray:[res_dict valueForKey:@"viewedlist"]];
                     if (ProfileArr.count>0) {
                         isEmptyArr = NO;
                     }
                 }
                 [_newsTableView reloadData];
                 
//                 else
//                 {
//                     self.popUpView.hidden = false;
//                     _newsTableView.hidden = true;
//                 }
             }
             
             
             
             else if ([status isEqualToString:@"2"])
             {
                 //ALERT_DIALOG(@"Alert", result);
                 self.popUpView.hidden = false;
                 _newsTableView.hidden = true;
                 
                 
             }
             
             else
             {
                 ALERT_DIALOG(@"Alert", @"Try again");
                 
             }
             
         }
         
         else
         {
             ALERT_DIALOG(@"Alert", @"Something went wrong");
             
         }
         
     }];
}


-(void)sortServiceCallFor_Post:(NSString *)url params:(NSDictionary *)params
{
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         
         
         if (success)
         {
             //             if ([clicked isEqualToString: @"sort"]) {
             //
             //
             //
             //             }
             //             else{
             NSDictionary *sortDIct = data;
             
            
             
             NSString *status=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 
                 
                 if ([clicked isEqualToString:@"sort"]) {
                     clicked = @"";
                     sendInterestCheck = YES;
                     // [_newsTableView reloadData];
                     [self serviceHandler];
                     
                 }
                 
                 else if ([clicked isEqualToString:@"sendInterest"])
                 {
                     clicked = @"";
                     //sendInterestCheck = YES;
                     // [_newsTableView reloadData];
                     [self serviceHandler];
                     
                 }

                 
                
                 //               else
                 //                    ALERT_DIALOG(@"Alert", result);
                 
             }
             
             
             
             else if ([status isEqualToString:@"2"])
             {
                //ALERT_DIALOG(@"Alert", result);
                self.upgradeView.hidden=NO;
                 
               NSLog(@"%lu", (unsigned long)[ProfileArr count]);
                 
                  NSDictionary *listArr = [ProfileArr objectAtIndex:sendInterestTag];
                 self.upgradeName.text = [NSString stringWithFormat:@"Send interest to %@ now Upgrade membership",[listArr valueForKey:@"username"]];
                 NSString *pic=[listArr valueForKey:@"photo1"];
                 NSString *genderStatus=[listArr valueForKey:@"gender"];
                 if ([pic isEqual:[NSNull null]]||[pic isEqualToString:@""])
                 {
                     if ([genderStatus isEqualToString:@"Groom"]) {
                         self.upgradeImage.image= [UIImage imageNamed:@"male"];
                     }
                     else
                     {
                         self.upgradeImage.image = [UIImage imageNamed:@"female"];
                     }

                 }
                 else
                 {
                     NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://smatrimony.com/photos/%@",pic]];
                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                         NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                         dispatch_async(dispatch_get_main_queue(),
                                        ^{
                                            self.upgradeImage.image = [UIImage imageWithData:imageData];
                                        });
                     });
                 }
            
             }
             
             else
             {
                 ALERT_DIALOG(@"Alert", result);
                 
             }
             
         }
         
         else
         {
             ALERT_DIALOG(@"Alert", @"Something went wrong");
             
         }
         
     }];
}


-(void)checkMemberShip:(NSString *)urlToInterest params:(NSDictionary *)params
{
    //raviratna5566@gmail.com checkmembership
    
    
    NSDictionary *memberShipDIct;
    NSString *url;
    
    if ([clicked isEqualToString:@"checkmembership"]) {
        
        memberShipDIct = @{@"matri_id":matri_id};
        url = @"services/api/checkmembership";
        
    }
    else
    {
        memberShipDIct =params ;
        url = urlToInterest;
        
    }
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:memberShipDIct requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         
         
         if (success)
         {
             
             NSDictionary *sortDIct = data;
             
             
             
             NSString *status=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 if ([clicked isEqualToString:@"checkmembership"]) {
                     clicked =@"";
                     [self checkMemberShip:urlToInterest params:params];
                 }
                 
                 else
                 {
                     [self serviceHandler];
                 }
                 
             }
             
             else if ([status isEqualToString:@"2"])
             {
                 ALERT_DIALOG(@"Alert", result);
                 
                 
             }
             
             else
             {
                 ALERT_DIALOG(@"Alert", result);
                 
             }
             
         }
         
         else
         {
             ALERT_DIALOG(@"Alert", @"Something went wrong");
             
         }
         
     }];
}

////////
-(void)validMatriId:(NSString *)url params:(NSDictionary *)params enteredId:(NSString *)Id indexPath:(NSIndexPath *)myip
{
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WS_MAIN showProgress:YES withHandler:^(BOOL success, id data)
     {
         
         
         if (success)
         {
               NSDictionary *sortDIct = data;
                      NSString *status=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[sortDIct valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 
               [_delegate clickedProfileTable:myip selectedMatriId:Id];
                
                 
             }
             
             
             
//             else if ([status isEqualToString:@"2"])
//             {
//                 ALERT_DIALOG(@"Alert", result);
//                 
//                 
//                 
//             }
             
             else
             {
                 ALERT_DIALOG(@"Alert", @"Invalid Id");
                 
             }
             
         }
         
         else
         {
             ALERT_DIALOG(@"Alert", @"Something went wrong");
             
         }
         
     }];
}




@end
