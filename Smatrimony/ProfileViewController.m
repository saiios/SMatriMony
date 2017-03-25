//
//  ProfileViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 04/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIScrollView+APParallaxHeader.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Profile_header.h"
#import "AboutProfileCell.h"
#import "BasicDetailCell.h"
#import "ReligionInfoCell.h"
#import "PartnerPreferenceTableViewCell.h"
#import "HoroScopeViewController.h"
#import "photoDetailViewController.h"

#import "STParsing.h"

@interface ProfileViewController ()<APParallaxViewDelegate,UIGestureRecognizerDelegate>
{
      BOOL parallaxWithView,menuClick;
    NSMutableArray *ProfileArr,*ImageArray,*imagesTOView;
    NSString *loggedIn_matri_id;
    NSUserDefaults *user_inf;
    NSString *clicked;
   

}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    user_inf=[NSUserDefaults standardUserDefaults];
    loggedIn_matri_id=[user_inf valueForKey:@"matri_id"];
    menuClick = true;
 _menuView.hidden = YES;
    
    profileInfoAarray = [[NSMutableArray alloc]init];

    
    // Do any additional setup after loading the view from its nib.
   //   [self.profileTableVIew addParallaxWithImage:[UIImage imageNamed:@"t.png"] andHeight:160 andShadow:YES];
  // parallaxWithView = NO;
 //
//    UIPanGestureRecognizer *rec  = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
  //    rec.delegate =self;
 //      imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t.png"]];
//    [imageView setFrame:CGRectMake(0, 0, 320, 160)];
//    [imageView setContentMode:UIViewContentModeScaleAspectFill];
//    imageView.userInteractionEnabled =YES;
//    
//    [imageView addGestureRecognizer:rec];
    _profileTableVIew.estimatedRowHeight = 44.0;
    _profileTableVIew.rowHeight = UITableViewAutomaticDimension;

  
    
    NSDictionary *params = @{@"matri_id":@"s3122",@"loginmatri_id":loggedIn_matri_id};
    
    [self profileServiceCall:@"services/api/viewFullProfile" Params:params];
   
    // set the content size to 10 image width
    
   // [self imagescroll];
    
}

-(void)sendDataToA:(NSMutableArray *)array
{
    ProfileArr = array;
    [_profileTableVIew reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
     menuClick = true;
    NSDictionary *params = @{@"matri_id":@"s3122",@"loginmatri_id":loggedIn_matri_id};
    
    [self profileServiceCall:@"services/api/viewFullProfile" Params:params];
}

-(void)imagescroll
{
    if (ProfileArr.count>0) {
        ImageArray = [[NSMutableArray alloc]init];
    
        
        
        for (int i =1; i<10; i++) {
            
            NSString *pic = [NSString stringWithFormat:@"photo%d",i];
        NSString *checkit = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:pic]];
            
            if ([checkit isEqual:[NSNull null]]||[checkit isEqualToString:@"<nil>"]||checkit == nil||checkit == NULL||[checkit isEqualToString:@""]) {
                
               
            }
            else
            {
                
               NSString *image =  [NSString stringWithFormat:@"http://www.smatrimony.com/photos/%@",checkit];
                [ImageArray addObject:image];
                
            }
            
        }
        imagesTOView = [[NSMutableArray alloc]initWithArray:ImageArray];
    
            //        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.smatrimony.com/photos/%@",image]];
 
       
    
    
    UIView  *vv = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 200)];
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 250)];
    scroll.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *myLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myLabelTapHandler:)];
        [vv addGestureRecognizer:myLabelTap];
        
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
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(jj,0, [UIScreen mainScreen].bounds.size.width,250)];
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
    //[self.view addSubview:scroll];
    [self.profileTableVIew addParallaxWithView:vv andHeight:200];
    parallaxWithView = YES;
    self.profileTableVIew.parallaxView.delegate = self;
    }
}

-(void)myLabelTapHandler:(UIGestureRecognizer *)gestureRecognizer {
   // UIView *tappedView = [gestureRecognizer.view hitTest:[gestureRecognizer locationInView:gestureRecognizer.view] withEvent:nil];
    
    // do something with it
    
    
    photoDetailViewController *hotoDetailViewController  =[[photoDetailViewController alloc]initWithNibName:@"photoDetailViewController" bundle:nil];
    
   hotoDetailViewController.images = ProfileArr;
    hotoDetailViewController.delegate=self; // protocol listener
    
    [self.navigationController pushViewController:hotoDetailViewController animated:YES];
    
}

-(void)pan:(UIPanGestureRecognizer *)rec{
    
    CGPoint vel = [rec velocityInView:self.view];
    if (fabs(vel.y) < fabs(vel.x)) {
        
    
    if (vel.x > 0)
    {
        // user dragged towards the right
        imageView.image = [UIImage imageNamed:@"bg"];
    }
    else
    {
        // user dragged towards the left
        imageView.image = [UIImage imageNamed:@"t"];
    }
    }else{
        
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint velocity = [panGestureRecognizer velocityInView:imageView];
    return fabs(velocity.y) < fabs(velocity.x);
}


- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else{
        switch (indexPath.row) {
            case 0:
                return 134;
                break;
            case 1:
                return 580;
                break;
                
            case 2:
                return 1100;
                break;
                
            default:
                return 954;
                break;
        }
            }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _profileTableVIew.allowsSelection = NO;
    
    if (indexPath.section == 0) {
        
        Profile_header *cell = [ tableView dequeueReusableCellWithIdentifier:@"Profile_header"];
        if (cell==nil)
        {
            [tableView registerNib:[UINib nibWithNibName:@"Profile_header" bundle:nil] forCellReuseIdentifier:@"Profile_header"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"Profile_header"];
        }
        
         [cell.chatBtn addTarget:self action:@selector(chatBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
         [cell.callBtn addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        cell.SortListBTn.tag=indexPath.row;
        
        [cell.SortListBTn addTarget:self action:@selector(SortListBTnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString *sortList = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"shortlist_status"]];
        if ([sortList isEqualToString:@"1"]) {
            
             [cell.SortListBTn setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            [cell.SortListBTn setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
            
        }
        
       
        return cell;

    }else{
        if (indexPath.row == 0) {
            AboutProfileCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"AboutProfileCell"];
            if (cell==nil)
            {
                [tableView registerNib:[UINib nibWithNibName:@"AboutProfileCell" bundle:nil] forCellReuseIdentifier:@"AboutProfileCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"AboutProfileCell"];
            }
            
            if (ProfileArr.count > 0) {
                
            
            cell.aboutLbl.text = [ProfileArr valueForKey:@"profile_text"];
            }
            return cell;
        }else if (indexPath.row ==1){
         
                BasicDetailCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"BasicDetailCell"];
                if (cell==nil)
                {
                    [tableView registerNib:[UINib nibWithNibName:@"BasicDetailCell" bundle:nil] forCellReuseIdentifier:@"BasicDetailCell"];
                    cell = [tableView dequeueReusableCellWithIdentifier:@"BasicDetailCell"];
                }
            if (ProfileArr.count > 0) {
                
                
        cell.nameLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"firstname"]];
    cell.ageLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"birthdate"]];
             cell.heightLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"weight"]];
             cell.weightLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"height"]];
            cell.motherToungLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"mtongue_name"]];
            cell.physicalStatusLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"physical_status"]];
             cell.maritualStatusLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"m_status"]];
             cell.skinToneLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"complexion"]];
             cell.bodyTypeLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"bodytype"]];
             cell.eatingHabitsLbl.text =[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"diet"]];
             cell.drinkingLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"drink"]];
            cell.bloodGroupLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"b_group"]];
             cell.hobbiesLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"hobby"]];
             cell.profileCreatedByLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"profileby"]];
            cell.referencedByLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"reference"]];
            cell.birthTimeLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"birthtime"]];
            cell.languagesKnownLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"otherlanguages"]];
            }
            
            return cell;
            //9618387977

        }else if (indexPath.row ==2) {
            ReligionInfoCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"ReligionInfoCell"];
            if (cell==nil)
            {
                [tableView registerNib:[UINib nibWithNibName:@"ReligionInfoCell" bundle:nil] forCellReuseIdentifier:@"ReligionInfoCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"ReligionInfoCell"];
            }
            
            if (ProfileArr.count > 0) {
                
            
             cell.religionLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"religion_name"]];
             cell.casteLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"caste_name"]];
            
            NSString *gotra = [NSString stringWithFormat:@"%@, %@,%@",[ProfileArr valueForKey:@"gothra"],[ProfileArr  valueForKey:@"gothra1"],[ProfileArr  valueForKey:@"gothra2"]];
            cell.gotramLbl.text = gotra;
            
             cell.starLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"star"]];
             cell.manglikLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"manglik"]];
             cell.horoscope.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"horoscope"]];
             cell.MoonsingLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"moonsign"]];
             
                       //professional
             
             cell.educationLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"edu_name"]];
             cell.designationLbl.text =[NSString stringWithFormat:@"%@", [ProfileArr  valueForKey:@"desg_name"]];
             cell.occupationLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"ocp_name"]];
             cell.employedInLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"emp_in"]];
             cell.annualIncomeLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"income"]];
            
                          //locaton
             
             cell.stateLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"state_name"]];
             cell.districtLbl.text =[NSString stringWithFormat:@"%@", [ProfileArr  valueForKey:@"district_name"]];
             cell.citizenShip.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_resi_status"]];
             cell.country.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"country_name"]];
             
             
             // family
             
             cell.familyTypeLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"family_type"]];
             cell.familyStatusLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"family_status"]];
             cell.fatherNameLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"father_name"]];
             cell.motherNameLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"mother_name"]];
             cell.FatherOccupationLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"father_occupation"]];
             cell.MotherOccupationLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"mother_occupation"]];
             cell.noOfBrothersLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_of_brothers"]];
             cell.noOfSistersLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_of_sisters"]];
             cell.marriedBrothersLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"no_marri_brother"]];
             cell.marriedsistersLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_marri_sister"]];
             cell.AboutMyFamLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"family_details"]];
          
            }
            return cell;
        }
        
        else
        {

            static NSString *simpleTableIdentifier = @"PartnerPreferenceTableViewCell";
            PartnerPreferenceTableViewCell  *cell = (PartnerPreferenceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PartnerPreferenceTableViewCell" owner:self options:nil];
                cell = (PartnerPreferenceTableViewCell *)[nib objectAtIndex:0];
            }
            if (ProfileArr.count > 0) {
                
                NSString * image = [ProfileArr valueForKey:@"photo1"];
                
                NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.smatrimony.com/photos/%@",image]];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                    dispatch_async(dispatch_get_main_queue(),
                                   ^{
                                       cell.profilePreferenceImage.image = [UIImage imageWithData:imageData];
                                   });
                });

                
                cell.matchCount.text = [NSString stringWithFormat:@"MATCHES %@/22",[ProfileArr  valueForKey:@"matching_count"]];
                
                 cell.lookingForLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"looking_for"]];
                 cell.agePreferenceLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_frm_age"]];
                 cell.heightPreferenceLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_height"]];
                 cell.MotherToungeLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_mtongue_names"]];
                 cell.bodyTypeLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_bodytype"]];
                 cell.eatingHabitsLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_diet"]];
                 cell.smokingLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_smoke"]];
                 cell.drinkingLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_drink"]];
                cell.skinToneLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_complexion"]];
                
                 //religion
                 cell.ReligionLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_religion_names"]];
                 cell.casteLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_caste_names"]];
                 cell.starLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_star"]];
                 cell.manglik.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_manglik"]];
                
                 // profrssional
                  cell.educationLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_education"]];
                  cell.DesignationLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_designation_names"]];
                  cell.occupationLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_occupation_names"]];
                  cell.EmployedInLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_emp_in"]];
                  cell.AnnualIncomeLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_income"]];
                
                cell.counrtyLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_country"]];
                cell.stateLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_state_names"]];
                cell.cityLbl.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_city_names"]];
                cell.citizenShip.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_resi_status"]];
                
                
                           }
            //imagecheck
            NSString *check_mtounge = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"mtounge_status"]];
            
            if ([ check_mtounge isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.imgM_Tounge setImage:image];
                
            }
    else
        {
            UIImage *image = [UIImage imageNamed:@"checked1.png"];
            [cell.imgM_Tounge setImage:image];
               
        }
            
            //LookFor
            NSString *LookFor = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"looking_status"]];
            
            if ([ LookFor isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.imgLookFor setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.imgLookFor setImage:image];
                
            }
            
            //imgAgePreference
            NSString *AgePreference = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"birthdate_status"]];
            
            if ([ AgePreference isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.imgAgePreference setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.imgAgePreference setImage:image];
                
            }
            
            //imgBobyType
            NSString *imgBobyType = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"bodytype_status"]];
            
            if ([ imgBobyType isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.imgBobyType setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.imgBobyType setImage:image];
                
            }
            
            //imgHeight
            NSString *imgHeight = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"height_status"]];
            
            if ([ imgHeight isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.imgHeight setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.imgHeight setImage:image];
                
            }
            
            //imgEatingHabbits
            NSString *imgEatingHabbits = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"diet_status"]];
            
            if ([ imgEatingHabbits isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.imgEatingHabbits setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.imgEatingHabbits setImage:image];
                
            }
            
            //imgSmoking
            NSString *imgSmoking = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"smoke_status"]];
            
            if ([imgSmoking isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.imgSmoking setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.imgSmoking setImage:image];
                
            }
            
            //imgEatingHabbits
            NSString *imgDrink = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"drink_status"]];
            
            if ([ imgDrink isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.imgDrink setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.imgDrink setImage:image];
                
            }
            
            //imgSkinTone
            NSString *imgSkinTone = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"complexion_status"]];
            
            if ([ imgSkinTone isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.imgSkinTone setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.imgSkinTone setImage:image];
                
            }
            
            //Imgreligion
            NSString *Imgreligion = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"religion_status"]];
            
            if ([ Imgreligion isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.Imgreligion setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.Imgreligion setImage:image];
                
            }
            
            //ImgCaste
            NSString *ImgCaste = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"caste_status"]];
            
            if ([ ImgCaste isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgCaste setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgCaste setImage:image];
                
            }
            
            //ImgStar
            NSString *ImgStar = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"star_status"]];
            
            if ([ ImgStar isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgStar setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgStar setImage:image];
                
            }
            
            
            //ImgManglik
            NSString *ImgManglik = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"manglik_status"]];
            
            if ([ ImgManglik isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgManglik setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgManglik setImage:image];
                
            }
            
            //ImgEducation
            NSString *ImgEducation = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"edu_detail_status"]];
            
            if ([ ImgEducation isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgEducation setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgEducation setImage:image];
                
            }
            
            //ImgDesignation
            NSString *ImgDesignation = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"designation_status"]];
            
            if ([ ImgDesignation isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgDesignation setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgDesignation setImage:image];
                
            }
            //ImgOccupation
            NSString *ImgOccupation = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"occupation_status"]];
            
            if ([ ImgOccupation isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgOccupation setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgOccupation setImage:image];
                
            } //ImgEmployedIn
            NSString *ImgEmployedIn = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"emp_in_status"]];
            
            if ([ ImgEmployedIn isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgEmployedIn setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgEmployedIn setImage:image];
                
            }
            //ImgAnnualIncome
            NSString *ImgAnnualIncome = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"income_status"]];
            
            if ([ ImgAnnualIncome isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgAnnualIncome setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgAnnualIncome setImage:image];
                
            }
            
            //ImgAnnualIncome
            NSString *Imgcountry = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"country_status"]];
            
            if ([ Imgcountry isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.Imgcountry setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.Imgcountry setImage:image];
                
            }
            //ImgState
            NSString *ImgState = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"state_status"]];
            
            if ([ ImgState isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgState setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgState setImage:image];
                
            }
            //ImgCity
            NSString *ImgCity = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"city_status"]];
            
            if ([ ImgCity isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgCity setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgCity setImage:image];
                
            }
            //ImgCitizenShip
            NSString *ImgCitizenShip = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"residence_status"]];
            
            if ([ ImgCitizenShip isEqualToString:@"0"]) {
                
                UIImage *image = [UIImage imageNamed:@"multiply1.png"];
                [cell.ImgCitizenShip setImage:image];
                
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"checked1.png"];
                [cell.ImgCitizenShip setImage:image];
                
            }
            
            return cell;
        }
    }
}


-(void)chatBtnClick
{
    
}
-(void)callBtnClick
{
    
    NSString *numb = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"mobile"]];
    
    NSString *phoneNumber = [@"tel://" stringByAppendingString:numb];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
}
-(void)SortListBTnClick:(id)sender
{
    
    
    
    UIButton *button=(UIButton *) sender;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    // NSInteger row = indexpath.row;
    
    Profile_header *tappedCell = (Profile_header *)[_profileTableVIew cellForRowAtIndexPath:indexpath];
    
    
    
    if ([tappedCell.SortListBTn.imageView.image isEqual:[UIImage imageNamed:@"unshortlist_icon.png"]])
    {
        
        //    [tappedCell.SortListBtn setImage:[UIImage imageNamed:@"short_list.png"] forState:UIControlStateNormal];
        
        NSString *index = [NSString stringWithFormat:@"%ld",(long)[sender tag]];
       
        NSString *listId = [ProfileArr valueForKey:@"matri_id"];
        
        NSDictionary *params = @{@"matri_id":listId,@"loginmatri_id":loggedIn_matri_id};
        [self profileServiceCallForSort:@"services/api/addToShortlist" Params:params];
        
        
    }
    else
    {
        
      
        //  [tappedCell.SortListBtn setImage:[UIImage imageNamed:@"unshortlist_icon.png"] forState:UIControlStateNormal];
        
        NSString *index = [NSString stringWithFormat:@"%ld",(long)[sender tag]];
        
        
        NSString *listId = [ProfileArr valueForKey:@"matri_id"];
        
        NSDictionary *params = @{@"matri_id":listId,@"loginmatri_id":loggedIn_matri_id};
        [self profileServiceCallForSort:@"services/api/removeFromShortlist" Params:params];
       
        
    }
    
    
}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
    
    
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));

    
}

#pragma mark - ProfileService Call

-(void)profileServiceCall:(NSString *)url Params:(NSDictionary *)param {
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:param requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         
         
         if (success)
         {
             
             if ([clicked isEqualToString:@"horo"]) {
                 
             
             NSDictionary *res_dict = data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             
             if ([status isEqualToString:@"1"])
             {
                 
                 NSString *htmltoWeb = [NSString stringWithFormat:@"http://www.smatrimony.com/Reports/%@",[[res_dict valueForKey:@"horoscope"]valueForKey:@"horofname"]];
                
                 HoroScopeViewController *horoScopeViewController  =[[HoroScopeViewController alloc]initWithNibName:@"HoroScopeViewController" bundle:nil];
                
                 horoScopeViewController.html = htmltoWeb;
                 [self.navigationController pushViewController:horoScopeViewController animated:YES];
                 
                 
            }
             
             
             
             else if ([status isEqualToString:@"2"])
             {
                 
                ALERT_DIALOG(@"Alert", result);
                 
                 
                 
             }
             
             else
             {
                 ALERT_DIALOG(@"Alert", @"Try again");
                
             }
             }
             
             else if ([clicked isEqualToString:@"block"])
             {
                 
                 
                 NSDictionary *res_dict = data;
                 
                 NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
                 
                 NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
                 
                 
                 if ([status isEqualToString:@"1"])
                 {
                     
                     
                         ALERT_DIALOG(@"Success", result);
                     
                 }
                 
                 else if ([status isEqualToString:@"2"])
                 {
                    ALERT_DIALOG(@"Alert", result);
                 
                 }
                 
                 else
                 {
                     ALERT_DIALOG(@"Alert", @"Try again");
                    
                 }
             }
             
             else
             {
                 
                 NSDictionary *res_dict = data;
                 
                 NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
                 
                 NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
                 
                 
                 if ([status isEqualToString:@"1"])
                 {
                   
                    
                         ProfileArr = [[NSMutableArray alloc] init];
                         ProfileArr = [res_dict valueForKey:@"profilelist"];
                         
                         [_profileTableVIew reloadData];
                         
                         [self imagescroll];
                    
                     
                 }
                 
                 
                 else if ([status isEqualToString:@"2"])
                 {
                  
                     ALERT_DIALOG(@"Alert", result);
                     
                   
                 }
                 
                 else
                 {
                     ALERT_DIALOG(@"Alert", @"Try again");
                }
             }
         }
         
         else
         {
             ALERT_DIALOG(@"Alert", @"Something went wrong");
             
         }
         
          clicked = @"";
     }];
    
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
                 
                 NSDictionary *params = @{@"matri_id":@"s3122",@"loginmatri_id":loggedIn_matri_id};
                 
                 [self profileServiceCall:@"services/api/viewFullProfile" Params:params];
                 
                 
                 
             }
             
             
             
             else if ([status isEqualToString:@"2"])
             {
                 ALERT_DIALOG(@"Alert", result);
                 
                 
                 
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

#pragma mark Right menu

- (IBAction)optionsMenuClicked:(id)sender
{
    
    if (menuClick) {
        
        _menuView.hidden = NO;
        menuClick = false;
        
    }
    else
    {
    _menuView.hidden = YES;
    menuClick = true;
    }
}

- (IBAction)viewHoroscope:(id)sender {
    
    
    clicked = @"horo";
    [self serviceHandler];
  
}



- (IBAction)BlockBtn:(id)sender {
    
    clicked = @"block";
    [self serviceHandler];
    
//    Url : http://www.devtesthub.com/services/api/addToBlocklist
//    method : POST
//    
//    Inputs
//    matri_id
//    loginmatri_id

}

-(void)serviceHandler
{
     _menuView.hidden = YES;
    
    if ([clicked isEqualToString:@"block"]) {
        
    
    
    NSString *listId = [ProfileArr valueForKey:@"matri_id"];
    
    NSDictionary *params = @{@"matri_id":listId,@"loginmatri_id":loggedIn_matri_id};
    
    [self profileServiceCall:@"services/api/addToBlocklist" Params:params];
    }
    else if ([clicked isEqualToString:@"horo"])
    {
        
        NSString *listId = [ProfileArr valueForKey:@"matri_id"];
        
        NSDictionary *params = @{@"matri_id":@"s2550",@"loginmatri_id":loggedIn_matri_id};
        
        [self profileServiceCall:@"services/api/view_horoscope" Params:params];
    }

        
    }

@end
