//
//  EditProfileViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 27/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "EditProfileViewController.h"
#import "STParsing.h"
#import "AboutProfileTableViewCell.h"
#import "Partner_Preference_TableViewCell.h"
#import "HeaderTitleTableViewCell.h"
#import "Detail_Edit_Profile_ViewController.h"
#import "MenuViewController.h"
#import "HoroscopeController.h"
@interface EditProfileViewController ()
{
    NSUserDefaults * user_inf;
   NSString *loggedIn_matri_id,*clickedIs;
    NSMutableArray *ProfileArr;
    NSArray* heightArr,*heightServiceArr;
    NSString *heightStrng,*heightToStrng,*temp;
    NSDateFormatter *dateFormat;
}

@end

@implementation EditProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    user_inf = [NSUserDefaults standardUserDefaults];
    
    loggedIn_matri_id = [user_inf valueForKey:@"matri_id"];
    NSDictionary *params = @{@"matri_id":loggedIn_matri_id};
   heightArr = [[NSMutableArray alloc]initWithObjects:@"Below 4 ft",@"4 ft 06 in",@"4 ft 07 in",@"4 ft 08 in",@"4 ft 09 in",@"4 ft 10 in",@"4 ft 11 in",@"5 ft 0 in",@"5 ft 01 in",@"5 ft 02 in",@"5 ft 03 in",@"5 ft 04 in",@"5 ft 05 in",@"5 ft 06 in",@"5 ft 07 in",@"5 ft 08 in",@"5 ft 09 in",@"5 ft 10 in",@"5 ft 11 in",@"6 ft 0 in",@"6 ft 01 in",@"6 ft 02 in",@"6 ft 03 in",@"6 ft 04 in",@"6 ft 05 in",@"6 ft 06 in",@"6 ft 07 in",@"6 ft 08 in",@"6 ft 09 in",@"6 ft 10 in",@"6 ft 11 in",@"7 ft 00 in",@"Above 7 ft", nil];
    
       heightServiceArr = [[NSMutableArray alloc]initWithObjects:@"48",@"54",@"55",@"56",@"57",@"58",@"59",@"60",@"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"80",@"81",@"82",@"83",@"84",nil];
    [self process_bar];
    heightStrng=@"";
    heightToStrng=@"";
    
    dateFormat = [[NSDateFormatter alloc] init];
    //  [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    user_inf = [NSUserDefaults standardUserDefaults];
    
    loggedIn_matri_id = [user_inf valueForKey:@"matri_id"];
    NSDictionary *params = @{@"matri_id":loggedIn_matri_id};
    
    [self profileServiceCall:@"services/api/memberProfile" Params:params];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch (indexPath.row)
    {
            case 0:
                return 350;
                break;
            case 1:
                return 2015;
                break;
                
            case 2:
                return 1400;
                break;
          
            default:
                return 0;
                break;
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    _editaprofileTableView.allowsSelection = NO;
    
    if (indexPath.row ==1) {
        
    
  //  HeaderTitleTableViewCell
            AboutProfileTableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"AboutProfileTableViewCell"];
            if (cell==nil)
            {
                [tableView registerNib:[UINib nibWithNibName:@"AboutProfileTableViewCell" bundle:nil] forCellReuseIdentifier:@"AboutProfileTableViewCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"AboutProfileTableViewCell"];
            
            
        }
        
       [cell.ownWordsBtn addTarget:self action:@selector(ownWordsBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cell.basicDetailBtn addTarget:self action:@selector(basicDetailBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        
          [cell.educationInfoBtn addTarget:self action:@selector(educationInfoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
          [cell.locationInfoBtn addTarget:self action:@selector(locationInfoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
          [cell.religiousInfoBtn addTarget:self action:@selector(religiousInfoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
          [cell.familyDetailsInfoBtn addTarget:self action:@selector(familyDetailsInfoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        
          [cell.AboutFamilyInfoBtn addTarget:self action:@selector(AboutFamilyInfoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    /*
   
    
   
     
     
     */
       

        
         if (ProfileArr.count > 0) {
             
              temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"profile_text"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.aboutTextviewOutlet.text = temp;
             }
             else
                 cell.aboutTextviewOutlet.text=@"Not Specified";
             
            cell.nameLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"username"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"username"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.nameLabel.text = temp;
             }
             else
                 cell.nameLabel.text=@"Not Specified";
             
         //   cell.genderLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"gender"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"gender"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.genderLabel.text = temp;
             }
             else
                 cell.genderLabel.text=@"Not Specified";
             
            // cell.ageLabel.text
             NSString * dob  = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"birthdate"]];
             //dob = [dob substringToIndex:4];
             //year current date
                           NSString *today = [dateFormat stringFromDate:[NSDate date]];
             NSDate *date1 = [dateFormat dateFromString:today];
             
             
             //year to calculate
             NSDate *date2 = [dateFormat dateFromString:dob];
             
             NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                                components:NSCalendarUnitYear
                                                fromDate:date2
                                                toDate:date1
                                                options:0];
             NSInteger age = [ageComponents year];
             
            // NSLog(@"%@ ,%ld%@ years",dob,(long)age);
             cell.ageLabel.text = [NSString stringWithFormat:@"%ld Yrs",(long)age];
                             cell.physicalStatusLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"physical_status"]];
                           //  cell.heightLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"height"]];
             NSString * heightStrngId = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"height"]];
             for (int j=0;j<heightServiceArr.count; j++) {
                 if ([heightStrngId isEqualToString:[heightServiceArr objectAtIndex:j]]) {
                     heightStrng=[heightArr objectAtIndex:j];
                 }
                 
             }
           cell.heightLabel.text = [ NSString stringWithFormat:@"%@",heightStrng];
             
                           //  cell.weightLabel.text = [NSString stringWithFormat:@"%@ Kgs",[ProfileArr  valueForKey:@"weight"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"weight"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.weightLabel.text = temp;
             }
             else
                 cell.weightLabel.text=@"Not Specified";
             
          // cell.maritalStatusLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"m_status"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"m_status"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.maritalStatusLabel.text = temp;
             }
             else
                 cell.maritalStatusLabel.text=@"Not Specified";
             
        // cell.skinToneLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"complexion"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"complexion"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.skinToneLabel.text = temp;
             }
             else
                 cell.skinToneLabel.text=@"Not Specified";
             
        //  cell.bodyTypeLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"bodytype"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"bodytype"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.bodyTypeLabel.text = temp;
             }
             else
                 cell.bodyTypeLabel.text=@"Not Specified";
             
        // cell.profileForLabel.text =[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"profileby"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"profileby"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.profileForLabel.text = temp;
             }
             else
                 cell.profileForLabel.text=@"Not Specified";
             
      //     cell.eatingHabitsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"diet"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"diet"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.eatingHabitsLabel.text = temp;
             }
             else
                 cell.eatingHabitsLabel.text=@"Not Specified";
             
         //cell.drinkingHabitsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"drink"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"drink"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.drinkingHabitsLabel.text = temp;
             }
             else
                 cell.drinkingHabitsLabel.text=@"Not Specified";
             
       //  cell.smokingHabitsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"smoke"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"smoke"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.smokingHabitsLabel.text = temp;
             }
             else
                 cell.smokingHabitsLabel.text=@"Not Specified";
             
       // cell.otherLanguagesLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"otherlanguages"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"otherlanguages"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.otherLanguagesLabel.text = temp;
             }
             else
                 cell.otherLanguagesLabel.text=@"Not Specified";
             
      // cell.hobbiesLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"hobby"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"hobby"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.hobbiesLabel.text = temp;
             }
             else
                 cell.hobbiesLabel.text=@"Not Specified";
             
          // cell.birthPlaceLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"birthplace"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"birthplace"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"]||[temp isEqualToString:@":"])) {
                 
                 cell.birthPlaceLabel.text = temp;
             }
             else
                 cell.birthPlaceLabel.text=@"Not Specified";
             
            //cell.birthTimeLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"birthtime"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"birthtime"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.birthTimeLabel.text = temp;
             }
             else
                 cell.birthTimeLabel.text=@"Not Specified";
             /////////
             
            // cell.referenceByLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"reference"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"reference"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.referenceByLabel.text = temp;
             }
             else
                 cell.referenceByLabel.text=@"Not Specified";
             
            // cell.bloodGroupLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"b_group"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"b_group"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.bloodGroupLabel.text = temp;
             }
             else
                 cell.bloodGroupLabel.text=@"Not Specified";
             
             //cell.motherTongueLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"mtongue_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"mtongue_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.motherTongueLabel.text = temp;
             }
             else
                 cell.motherTongueLabel.text=@"Not Specified";
             
            //cell.religionLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"religion_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"religion_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.religionLabel.text = temp;
             }
             else
                 cell.religionLabel.text=@"Not Specified";
             
             //cell.casteLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"caste_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"caste_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.casteLabel.text = temp;
             }
             else
                 cell.casteLabel.text=@"Not Specified";
             
             NSString * profilrFor=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"subcaste_name"]];
             if (!([profilrFor isEqual:[NSNull null]]||[profilrFor isEqualToString:@"<nil>"]||profilrFor == nil||profilrFor == NULL||[profilrFor isEqualToString:@""]||[profilrFor isEqualToString:@"<null>"])) {
                 
                 cell.subCasteLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"subcaste_name"]];
             }
             else
                 cell.subCasteLabel.text=@"Not Specified";
           //  cell.subCasteLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"subcaste_name"]];
         //    cell.gothramLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"gothra"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"gothra"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.gothramLabel.text = temp;
             }
             else
                 cell.gothramLabel.text=@"Not Specified";
             
         //    cell.manglikLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"manglik"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"manglik"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.manglikLabel.text =[NSString stringWithFormat:@" %@", temp];
             }
             else
                 cell.manglikLabel.text=@"Not Specified";
             
            // cell.starLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"star"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"star"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.starLabel.text = temp;
             }
             else
                 cell.starLabel.text=@"Not Specified";
             
            // cell.padamLabel.text =[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"padam"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"padam"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.padamLabel.text = temp;
             }
             else
                 cell.padamLabel.text=@"Not Specified";
             
           //  cell.horoscopeLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"horoscope"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"horoscope"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.horoscopeLabel.text = temp;
             }
             else
                 cell.horoscopeLabel.text=@"Not Specified";
             
           //  cell.moonSignLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"moonsign"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"moonsign"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.moonSignLabel.text = temp;
             }
             else
                 cell.moonSignLabel.text=@"Not Specified";
             
             //cell.educationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"edu_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"edu_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.educationLabel.text = temp;
             }
             else
                 cell.educationLabel.text=@"Not Specified";
             
             NSString *edDetail = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"edu_indetail"]];
             NSString *edDetl;
             if ([edDetail isEqual:[NSNull null]]||[edDetail isEqualToString:@"<nil>"]||edDetail == nil||edDetail == NULL||[edDetail isEqualToString:@""]) {
                 
                 edDetl = @"Not Specified";
             }
             else{
                 edDetl =edDetail;

             }
             cell.educationInDetailLabel.text = edDetl;
             
        //     cell.occupationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"ocp_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"ocp_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.occupationLabel.text = temp;
             }
             else
                 cell.occupationLabel.text=@"Not Specified";
             
            // cell.designationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"desg_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"desg_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.designationLabel.text = temp;
             }
             else
                 cell.designationLabel.text=@"Not Specified";
             
            // cell.employedInLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"emp_in"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"emp_in"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.employedInLabel.text = temp;
             }
             else
                 cell.employedInLabel.text=@"Not Specified";
             
             ///
             
            // cell.annualIncomeLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"income"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"income"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.annualIncomeLabel.text = temp;
             }
             else
                 cell.annualIncomeLabel.text=@"Not Specified";
             
          //   cell.addressLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"address"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"address"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.addressLabel.text = temp;
             }
             else
                 cell.addressLabel.text=@"Not Specified";
             
          //   cell.countryLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"country_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"country_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.countryLabel.text = temp;
             }
             else
                 cell.countryLabel.text=@"Not Specified";
             
            // cell.stateLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"state_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"state_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.stateLabel.text = temp;
             }
             else
                 cell.stateLabel.text=@"Not Specified";
             
            // cell.districtLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"district_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"district_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.districtLabel.text = temp;
             }
             else
                 cell.districtLabel.text=@"Not Specified";
             
           //  cell.cityLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"city_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"city_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.cityLabel.text = temp;
             }
             else
                 cell.cityLabel.text=@"Not Specified";
             
           //  cell.residenceStatusLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"residence"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"residence"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.residenceStatusLabel.text = temp;
             }
             else
                 cell.residenceStatusLabel.text=@"Not Specified";
             
            // cell.familyTypeLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"family_type"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"family_type"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.familyTypeLabel.text = temp;
             }
             else
                 cell.familyTypeLabel.text=@"Not Specified";
             
          //   cell.familyStatusLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"family_status"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"family_status"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.familyStatusLabel.text = temp;
             }
             else
                 cell.familyStatusLabel.text=@"Not Specified";

           //  cell.fathersNameLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"father_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"father_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.fathersNameLabel.text = temp;
             }
             else
                 cell.fathersNameLabel.text=@"Not Specified";
             
          //   cell.fathersOccupationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"father_occupation"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"father_occupation"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.fathersOccupationLabel.text = temp;
             }
             else
                 cell.fathersOccupationLabel.text=@"Not Specified";
             
           //  cell.mothersNameLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"mother_name"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"mother_name"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.mothersNameLabel.text = temp;
             }
             else
                 cell.mothersNameLabel.text=@"Not Specified";
             
          //   cell.mothersOccupationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"mother_occupation"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"mother_occupation"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.mothersOccupationLabel.text = temp;
             }
             else
                 cell.mothersOccupationLabel.text=@"Not Specified";
             
          //   cell.sisterLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_of_sisters"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_of_sisters"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.sisterLabel.text = temp;
             }
             else
                 cell.sisterLabel.text=@"Not Specified";
             
        //     cell.sisterMarriedLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_marri_sister"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_marri_sister"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.sisterMarriedLabel.text = temp;
             }
             else
                 cell.sisterMarriedLabel.text=@"Not Specified";
             
        //     cell.brotherLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"no_of_brothers"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_of_brothers"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.brotherLabel.text = temp;
             }
             else
                 cell.brotherLabel.text=@"Not Specified";
             
             //cell.brotherMarriedLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_marri_brother"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"no_marri_brother"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.brotherMarriedLabel.text = temp;
             }
             else
                 cell.brotherMarriedLabel.text=@"Not Specified";
             
          //   cell.aboutMyFamilytextView.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"family_details"]];
             temp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"family_details"]];
             if (!([temp isEqual:[NSNull null]]||[temp isEqualToString:@"<nil>"]||temp == nil||temp == NULL||[temp isEqualToString:@""]||[temp isEqualToString:@"<null>"])) {
                 
                 cell.aboutMyFamilytextView.text = temp;
             }
             else
                 cell.aboutMyFamilytextView.text=@"Not Specified";
  
             
             
             //////////////
        /*
             -(BOOL)valueCheckingMethod : (NSString *)value
             {
                 if(value isEqual:[NSNull null]]||[edDetail isEqualToString:@"<nil>"]||edDetail == nil||edDetail == NULL||[edDetail isEqualToString:@""])
                        return true;
             }
             
             fail = [self valueCheckingMethod:cell.sisterLabel.text ] ;
         if(fail)
           {
           cell.sisterLabel.text =@" Not Specified ";
         }
         
         if ([edDetail isEqual:[NSNull null]]||[edDetail isEqualToString:@"<nil>"]||edDetail == nil||edDetail == NULL||[edDetail isEqualToString:@""]) {
         
         edDetl = @"Not Specified";
         }

          */

         }
        
      
        
        
        
    return cell;
    }
    else if(indexPath.row == 2)
    {
        
      
        
        Partner_Preference_TableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"Partner_Preference_TableViewCell"];
        if (cell==nil)
        {
            
            [tableView registerNib:[UINib nibWithNibName:@"Partner_Preference_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Partner_Preference_TableViewCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"Partner_Preference_TableViewCell"];
            
            
        }
        [cell.partnerBasicBtn addTarget:self action:@selector(partnerBasicBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        [cell.partnerProfessionalBtn addTarget:self action:@selector(partnerProfessionalBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        [cell.partnerReligiousBtn addTarget:self action:@selector(partnerReligiousBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.partnerLocationBtn addTarget:self action:@selector(partnerLocationBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        
         if (ProfileArr.count > 0) {
             
             NSString * heightStrngId = [ProfileArr  valueForKey:@"part_height"];
             NSString * heightTostrngId = [ProfileArr  valueForKey:@"part_height_to"];
             
             for (int i=0;i<heightServiceArr.count; i++) {
                 if ([heightStrngId isEqualToString:[heightServiceArr objectAtIndex:i]]) {
                     heightStrng=[heightArr objectAtIndex:i];
                 }
                 if ([heightTostrngId isEqualToString:[heightServiceArr objectAtIndex:i]]) {
                     heightToStrng=[heightArr objectAtIndex:i];
                 }
             }
             
             NSString * profilrFor=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"looking_for"]];
             if (!([profilrFor isEqual:[NSNull null]]||[profilrFor isEqualToString:@"<nil>"]||profilrFor == nil||profilrFor == NULL||[profilrFor isEqualToString:@""]||[profilrFor isEqualToString:@"<null>"])) {
                 
                 cell.lookigForLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"looking_for"]];
             }
             else
                 cell.lookigForLabel.text=@"Not Specified";
  
        //   cell.lookigForLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"looking_for"]];
             NSString * agePreference = [NSString stringWithFormat:@" %@ - %@ Yrs",[ProfileArr  valueForKey:@"part_frm_age"], [ProfileArr  valueForKey:@"part_to_age"]];
             
             
             cell.agePreferencesLabel.text = agePreference ;
             NSString * phy=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"physical_status"]];
             if (!([phy isEqual:[NSNull null]]||[phy isEqualToString:@"<nil>"]||phy == nil||profilrFor == NULL||[phy isEqualToString:@""]||[phy isEqualToString:@"<null>"])) {
                 
                 cell.physicalStatusLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"physical_status"]];
             }
             else
                 cell.physicalStatusLabel.text=@"Not Specified";
            // cell.physicalStatusLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"physical_status"]];
             
             //cell.expecationsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_expect"]];
             NSString * excpt=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"physical_status"]];
             if (!([excpt isEqual:[NSNull null]]||[excpt isEqualToString:@"<nil>"]||excpt == nil||excpt == NULL||[phy isEqualToString:@""]||[excpt isEqualToString:@"<null>"])) {
                 
                 cell.expecationsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"physical_status"]];
             }
             else
                 cell.expecationsLabel.text=@"Not Specified";
             
            // cell.heightLabel.text = [NSString stringWithFormat:@"%@-%@",heightStrng,heightToStrng];
             NSString * heightStr=[NSString stringWithFormat:@"%@-%@",heightStrng,heightToStrng];
             if (!([heightStr isEqual:[NSNull null]]||[heightStr isEqualToString:@"<nil>"]||heightStr == nil||heightStr == NULL||[heightStr isEqualToString:@""]||[heightStr isEqualToString:@"<null>"])) {
                 
                 cell.heightLabel.text =[NSString stringWithFormat:@" %@",heightStr];
             }
             else
                 cell.expecationsLabel.text=@"Not Specified";

            //cell.bodyTypesLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_bodytype"]];
             NSString * partbodyType=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_bodytype"]];
             if (!([partbodyType isEqual:[NSNull null]]||[partbodyType isEqualToString:@"<nil>"]||partbodyType == nil||partbodyType == NULL||[partbodyType isEqualToString:@""]||[partbodyType isEqualToString:@"<null>"])) {
                 
                 cell.bodyTypesLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_bodytype"]];
             }
             else
                 cell.bodyTypesLabel.text=@"Not Specified";
             
             
          //   cell.eatingHabitsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_diet"]];
             NSString * parteat=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_diet"]];
             if (!([parteat isEqual:[NSNull null]]||[parteat isEqualToString:@"<nil>"]||parteat == nil||parteat == NULL||[parteat isEqualToString:@""]||[parteat isEqualToString:@"<null>"])) {
                 
                 cell.eatingHabitsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_diet"]];
             }
             else
                 cell.eatingHabitsLabel.text=@"Not Specified";

            // cell.smokingHabitsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_smoke"]];
             NSString * partsmoke=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_smoke"]];
             if (!([partsmoke isEqual:[NSNull null]]||[partsmoke isEqualToString:@"<nil>"]||partsmoke == nil||partsmoke == NULL||[partsmoke isEqualToString:@""]||[partsmoke isEqualToString:@"<null>"])) {
                 
                 cell.smokingHabitsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_smoke"]];
             }
             else
                 cell.smokingHabitsLabel.text=@"Not Specified";
             
             //cell.drinkingHabitsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_drink"]];
             NSString * partdrink=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_drink"]];
             if (!([partdrink isEqual:[NSNull null]]||[partdrink isEqualToString:@"<nil>"]||partdrink == nil||partdrink == NULL||[partdrink isEqualToString:@""]||[partdrink isEqualToString:@"<null>"])) {
                 
                 cell.drinkingHabitsLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_drink"]];
             }
             else
                 cell.drinkingHabitsLabel.text=@"Not Specified";
             
           //  cell.skinToneLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_complexion"]];
             NSString * partskin=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_complexion"]];
             if (!([partskin isEqual:[NSNull null]]||[partskin isEqualToString:@"<nil>"]||partskin == nil||partskin == NULL||[partskin isEqualToString:@""]||[partskin isEqualToString:@"<null>"])) {
                 
                 cell.skinToneLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_complexion"]];
             }
             else
                 cell.skinToneLabel.text=@"Not Specified";
             
             //cell.educationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_education"]];
             NSString * partedu=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_education"]];
             if (!([partedu isEqual:[NSNull null]]||[partedu isEqualToString:@"<nil>"]||partedu == nil||partedu == NULL||[partedu isEqualToString:@""]||[partedu isEqualToString:@"<null>"])) {
                 
                 cell.educationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_education"]];
             }
             else
                 cell.educationLabel.text=@"Not Specified";
             
           //  cell.designationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_designation_names"]];
             NSString * partdesig=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_designation_names"]];
             if (!([partdesig isEqual:[NSNull null]]||[partdesig isEqualToString:@"<nil>"]||partdesig == nil||partdesig == NULL||[partdesig isEqualToString:@""]||[partdesig isEqualToString:@"<null>"])) {
                 
                 cell.designationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_designation_names"]];
             }
             else
                 cell.designationLabel.text=@"Not Specified";
             
             // cell.occupationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_occupation_names"]];
             NSString * partocp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_occupation_names"]];
             if (!([partocp isEqual:[NSNull null]]||[partocp isEqualToString:@"<nil>"]||partocp == nil||partocp == NULL||[partocp isEqualToString:@""]||[partocp isEqualToString:@"<null>"])) {
                 
                 cell.occupationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_occupation_names"]];
             }
             else
                 cell.occupationLabel.text=@"Not Specified";
             
             //cell.employedInLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_emp_in"]];
             NSString * partemp=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_emp_in"]];
             if (!([partemp isEqual:[NSNull null]]||[partemp isEqualToString:@"<nil>"]||partemp == nil||partemp == NULL||[partemp isEqualToString:@""]||[partemp isEqualToString:@"<null>"])) {
                 
                 cell.employedInLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_emp_in"]];
             }
             else
                 cell.employedInLabel.text=@"Not Specified";
             
          //   cell.annualIncomeLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_income"]];
             NSString * partIncm=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_income"]];
             if (!([partIncm isEqual:[NSNull null]]||[partIncm isEqualToString:@"<nil>"]||partIncm == nil||partIncm == NULL||[partIncm isEqualToString:@""]||[partIncm isEqualToString:@"<null>"])) {
                 
                 cell.annualIncomeLabel.text = [NSString stringWithFormat:@" %@",[ProfileArr  valueForKey:@"part_income"]];
             }
             else
                 cell.annualIncomeLabel.text=@"Not Specified";
             
             cell.religionLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_religion_names"]];
             NSString * partreligion=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_religion_names"]];
             if (!([partreligion isEqual:[NSNull null]]||[partreligion isEqualToString:@"<nil>"]||partreligion == nil||partreligion == NULL||[partreligion isEqualToString:@""]||[partreligion isEqualToString:@"<null>"])) {
                 
                 cell.religionLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_religion_names"]];
             }
             else
                 cell.religionLabel.text=@"Not Specified";
             
            // cell.partMtongueLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_mtongue_names"]];
             NSString * partM=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_mtongue_names"]];
             if (!([partM isEqual:[NSNull null]]||[partM isEqualToString:@"<nil>"]||partM == nil||partM == NULL||[partM isEqualToString:@""]||[partM isEqualToString:@"<null>"])) {
                 
                 cell.partMtongueLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_mtongue_names"]];
             }
             else
                 cell.partMtongueLabel.text=@"Not Specified";
             
            // cell.casteLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_caste_names"]];
             NSString * partC=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_caste_names"]];
             if (!([partC isEqual:[NSNull null]]||[partC isEqualToString:@"<nil>"]||partC == nil||partC == NULL||[partC isEqualToString:@""]||[partC isEqualToString:@"<null>"])) {
                 
                 cell.casteLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_caste_names"]];
             }
             else
                 cell.casteLabel.text=@"Not Specified";
             
             //cell.starLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_star_names"]];
             NSString * partS=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_star_names"]];
             if (!([partS isEqual:[NSNull null]]||[partS isEqualToString:@"<nil>"]||partS == nil||partS == NULL||[partS isEqualToString:@""]||[partS isEqualToString:@"<null>"])) {
                 
                 cell.starLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_star_names"]];
             }
             else
                 cell.starLabel.text=@"Not Specified";
             
            // cell.manglikLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_manglik"]];
             NSString * partMan=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_manglik"]];
             if (!([partMan isEqual:[NSNull null]]||[partMan isEqualToString:@"<nil>"]||partMan == nil||partMan == NULL||[partMan isEqualToString:@""]||[partMan isEqualToString:@"<null>"])) {
                 
                 cell.manglikLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_manglik"]];
             }
             else
                 cell.manglikLabel.text=@"Not Specified";
         //    cell.partMtongueLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_mtongue_names"]];
            // cell.countryLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_country"]];
             NSString * partCountry=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_country"]];
             if (!([partCountry isEqual:[NSNull null]]||[partCountry isEqualToString:@"<nil>"]||partCountry == nil||partCountry == NULL||[partCountry isEqualToString:@""]||[partCountry isEqualToString:@"<null>"])) {
                 
                 cell.countryLabel.text = [NSString stringWithFormat:@" %@",[ProfileArr  valueForKey:@"part_country"]];
             }
             else
                 cell.countryLabel.text=@"Not Specified";
             
            // cell.residingStateLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_state_names"]];
             NSString * partSt=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_state_names"]];
             if (!([partSt isEqual:[NSNull null]]||[partSt isEqualToString:@"<nil>"]||partSt == nil||partSt == NULL||[partSt isEqualToString:@""]||[partSt isEqualToString:@"<null>"])) {
                 
                 cell.residingStateLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_state_names"]];
             }
             else
                 cell.residingStateLabel.text=@"Not Specified";
             
             NSString * partdist=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_district_names"]];
             if (!([partdist isEqual:[NSNull null]]||[partdist isEqualToString:@"<nil>"]||partdist == nil||partdist == NULL||[partdist isEqualToString:@""]||[partdist isEqualToString:@"<null>"])) {
                 
                 cell.partDistrictLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_district_names"]];
             }
             else
                 cell.partDistrictLabel.text=@"Not Specified";
            // cell.residingCityLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_city_names"]];
             NSString * partcit=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_city_names"]];
             if (!([partcit isEqual:[NSNull null]]||[partcit isEqualToString:@"<nil>"]||partcit == nil||partcit == NULL||[partcit isEqualToString:@""]||[partcit isEqualToString:@"<null>"])) {
                 
                 cell.residingCityLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_city_names"]];
             }
             else
                 cell.residingCityLabel.text=@"Not Specified";
             
          //   cell.citizenShipLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_resi_status"]];
             NSString * partresid=[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"part_resi_status"]];
             if (!([partresid isEqual:[NSNull null]]||[partresid isEqualToString:@"<nil>"]||partresid == nil||partresid == NULL||[partresid isEqualToString:@""]||[partresid isEqualToString:@"<null>"])) {
                 
                 cell.citizenShipLabel.text = [NSString stringWithFormat:@" %@",[ProfileArr  valueForKey:@"part_resi_status"]];
             }
             else
                 cell.citizenShipLabel.text=@"Not Specified";
             
         }
        
        return cell;
    }
    else {
        
        //
        HeaderTitleTableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"HeaderTitleTableViewCell"];
        if (cell==nil)
        {
            [tableView registerNib:[UINib nibWithNibName:@"HeaderTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"HeaderTitleTableViewCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderTitleTableViewCell"];
        }
        float p=processbar/100;
        [cell.progress setProgress:p animated:YES];
        cell.progress_lbl.text=[NSString stringWithFormat:@"Your Profile is %.1f %% Completed",processbar];
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(horo_click:)];
        [cell.horo_view addGestureRecognizer:singleFingerTap];
        
        UITapGestureRecognizer *singleFingerTap1 =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(info_click:)];
        [cell.info_view addGestureRecognizer:singleFingerTap1];
        
        UITapGestureRecognizer *singleFingerTap2 =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(pic_click:)];
        [cell.pic_view addGestureRecognizer:singleFingerTap2];
        
        NSUserDefaults *user_inf=[NSUserDefaults standardUserDefaults];
        NSString *profile_pic=[user_inf valueForKey:@"profile_pic"];
        NSString *genderStatus=[user_inf valueForKey:@"gender"];
        
        if ([profile_pic isEqual:[NSNull null]]|| [profile_pic isEqualToString:@""])
        {
            if ([genderStatus isEqualToString:@"Groom"]) {
               cell.profile_pic.image = [UIImage imageNamed:@"male"];
            }
            else
            {
                cell.profile_pic.image = [UIImage imageNamed:@"female"];
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
                                   cell.profile_pic.image = [UIImage imageWithData:imageData];
                                   cell.profile_pic.contentMode = UIViewContentModeScaleToFill;
                                   cell.profile_pic.layer.backgroundColor=[[UIColor clearColor] CGColor];
                                   cell.profile_pic.layer.cornerRadius=45;
                                   cell.profile_pic.layer.borderWidth=2.0;
                                   cell.profile_pic.layer.masksToBounds = YES;
                                   cell.profile_pic.layer.borderColor=[[UIColor grayColor] CGColor];
                               });
            });
        }
        cell.horoscope.contentMode = UIViewContentModeScaleToFill;
        cell.horoscope.layer.backgroundColor=[[UIColor clearColor] CGColor];
        cell.horoscope.layer.cornerRadius=45;
        cell.horoscope.layer.borderWidth=2.0;
        cell.horoscope.layer.masksToBounds = YES;
        cell.horoscope.layer.borderColor=[[UIColor grayColor] CGColor];
        
        cell.contact_info.contentMode = UIViewContentModeScaleToFill;
        cell.contact_info.layer.backgroundColor=[[UIColor clearColor] CGColor];
        cell.contact_info.layer.cornerRadius=45;
        cell.contact_info.layer.borderWidth=2.0;
        cell.contact_info.layer.masksToBounds = YES;
        cell.contact_info.layer.borderColor=[[UIColor grayColor] CGColor];
         return cell;
    }
   /* else
    {
        
        horoscope_TableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"horoscope_TableViewCell"];
        if (cell==nil)
        {
            
            [tableView registerNib:[UINib nibWithNibName:@"horoscope_TableViewCell" bundle:nil] forCellReuseIdentifier:@"horoscope_TableViewCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"horoscope_TableViewCell"];
        }
        return cell;
    }*/
}

- (void)horo_click:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];

//Do stuff here...
 HoroscopeController *horoscopeCell = [[HoroscopeController alloc]initWithNibName:@"HoroscopeController" bundle:nil];
       NSString * dob  = [NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"birthdate"]];
    horoscopeCell.Dob = dob;
 [self.navigationController pushViewController:horoscopeCell animated:YES];
}

- (void)pic_click:(UITapGestureRecognizer *)recognizer
{
    All_photos *profile = [[All_photos alloc]initWithNibName:@"All_photos" bundle:nil];
    [self.navigationController pushViewController:profile animated:YES];
    //Do stuff here...
}

- (void)info_click:(UITapGestureRecognizer *)recognizer
{
    Contact_info *profile = [[Contact_info alloc]initWithNibName:@"Contact_info" bundle:nil];
    profile.emailId =[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"email"]];
    profile.phn =[NSString stringWithFormat:@"%@",[ProfileArr  valueForKey:@"mobile"]];
    [self.navigationController pushViewController:profile animated:YES];
    //Do stuff here...
}

/*
 ownWords
 basicDetail
 education
 location
 familyDetails
 AboutFamily
 partnerBasic
 partnerProfessional
 partnerReligious
 partnerLocation
 */







-(void)ownWordsBtnTapped
{
        clickedIs = @"ownWords";
    [self moveToDetailEditController:clickedIs];
    
    }

-(void)basicDetailBtnTapped
{
     clickedIs = @"basicDetail";
     [self moveToDetailEditController:clickedIs];
}

-(void)educationInfoBtnTapped
{
    clickedIs = @"education";
     [self moveToDetailEditController:clickedIs];
}
-(void)locationInfoBtnTapped
{
    clickedIs = @"location";
     [self moveToDetailEditController:clickedIs];
}
-(void)religiousInfoBtnTapped
{
    clickedIs = @"religious";
     [self moveToDetailEditController:clickedIs];
}
-(void)familyDetailsInfoBtnTapped
{
    clickedIs = @"familyDetails";
     [self moveToDetailEditController:clickedIs];
}
-(void)AboutFamilyInfoBtnTapped
{
    clickedIs = @"AboutFamily";
     [self moveToDetailEditController:clickedIs];
}

-(void)partnerBasicBtnTapped
{
    clickedIs = @"partnerBasic";
     [self moveToDetailEditController:clickedIs];
}
-(void)partnerProfessionalBtnTapped
{
    clickedIs = @"partnerProfessional";
     [self moveToDetailEditController:clickedIs];
}
-(void)partnerReligiousBtnTapped
{
    clickedIs = @"partnerReligious";
     [self moveToDetailEditController:clickedIs];
}
-(void)partnerLocationBtnTapped
{
    clickedIs = @"partnerLocation";
    [self moveToDetailEditController:clickedIs];
}



-(void)moveToDetailEditController:(NSString *)clicked
{
    Detail_Edit_Profile_ViewController *menuController  =[[Detail_Edit_Profile_ViewController alloc]initWithNibName:@"Detail_Edit_Profile_ViewController" bundle:nil];
    menuController.Clicked = clicked;
    [self.navigationController pushViewController:menuController animated:YES];
    
}



- (IBAction)backClickedBtn:(id)sender {
    
    NSArray *currentControllers = self.navigationController.viewControllers;
   
    BOOL ischeck = false;
    
    for (UIViewController *vc in currentControllers) {
        if ([vc isKindOfClass:[MenuViewController class]]) {
            //It exists
            ischeck =YES;
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
        if (!ischeck) {
    
    MenuViewController *menuController  =[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
   // menuController.user_name_str=[user_info valueForKey:@"username"];
    [self.navigationController pushViewController:menuController animated:YES];
        }
}





-(void)profileServiceCall:(NSString *)url Params:(NSDictionary *)param{
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
                     
                     
                     ProfileArr = [[NSMutableArray alloc] init];
                     ProfileArr = [res_dict valueForKey:@"profilelist"];
                    // [self process_bar];
                                       [_editaprofileTableView reloadData];
                     NSLog(@" %@ ",ProfileArr);
                    
                     
                     
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

-(void)process_bar
{
    NSDictionary *params = @{@"matri_id":loggedIn_matri_id};
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"api/Processbar" parameters:params requestNumber:WUS_Login showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict = data;
             NSString *status=[NSString stringWithFormat:@"%@",[data valueForKey:@"status"]];
            NSString *proce=[NSString stringWithFormat:@"%@",[data valueForKey:@"processbar"]];
             processbar=[proce floatValue];
             
             NSArray *indexPathArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
             //You can add one or more indexPath in this array...
             
             [_editaprofileTableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
         }
         [self profileServiceCall:@"services/api/memberProfile" Params:params];
      }];
}

@end
