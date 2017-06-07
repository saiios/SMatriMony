//
//  Detail_Edit_Profile_ViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 28/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Detail_Edit_Profile_ViewController.h"
#import "Myown_Words_Cell.h"
#import "basic_Detail_TableViewCell.h"
#import "religious_Information_TableViewCell.h"
#import "educ_profsnl_Information_TableViewCell.h"
#import "Location_TableViewCell.h"
#import "family_Details_TableViewCell.h"
#import "about_family_TableViewCell.h"
#import "Part_Basic_Prefer_TableViewCell.h"
#import "Partner_Professional_Preference_TableViewCell.h"
#import "Partnr_Religious_Preferences_TableViewCell.h"
#import "Partner_Location_TableViewCell.h"
#import "EditProfileViewController.h"
#import "STParsing.h"

@interface Detail_Edit_Profile_ViewController ()
{
    Myown_Words_Cell *cell1;
    basic_Detail_TableViewCell * basicCell;
    religious_Information_TableViewCell *religiousCell;
    educ_profsnl_Information_TableViewCell * educationCell;
    Location_TableViewCell * locationCell;
    family_Details_TableViewCell * familyDetailCell;
    about_family_TableViewCell * aboutFamilyCell;
    Part_Basic_Prefer_TableViewCell * partnerBasicCell;
    Partner_Professional_Preference_TableViewCell * partnerProfessionCell;
    Partnr_Religious_Preferences_TableViewCell * partnerReligiousCell;
    Partner_Location_TableViewCell * partnerLocation;
    UITableViewCell *selectedCell,*cell;
    BOOL keyboardIsShown;
     int scrollHeight;
    
   NSUserDefaults *user_inf;
    
    NSMutableArray *EditProfileArr,*heightArr,*heightServiceArr,*weightArr,*mStatusArr,*languagetArr,*skinToneArr,*bodyTypeArr,*profileCreatedArr,*eatingArr,*drinkingArr,*smokinArr,*bloodGroupArr,*knownLangsArr,*religiosMtongueArr,*religionArr,*starArr,*eduArr,*ocupArr,*desigArr,*pOcupArr,*countryArr,*moonsignArr;
    
    NSMutableArray *physicalStatusArr,*referncedArr;
    
    NSMutableArray *manglikArr,*employedInArr ,*annualIncmArr,*residenceStatusArr,*familyTypeArr,*familyStatusArr,*sisterArr,*ageFrmArr,*castArr,*subCastArr,*partcastArr,*stateArr,*distArr,*cityArr,*partCountryArr,*partStateArr,*partDistArr,*partCityArr,*partMtongueArr;// Religious Arrays , education Arrays
   
    NSString *loggedIn_matri_id,*button,*selectType,*heightStrng,*heightToStrng;
    
    NSMutableString *otherLangStrng,*lookingForStrng,*partPhysicalStatusStrng,*partBodyTypeStrng,*partEatHabitsStrng,*partDrinkHabitsStrng,*partSmokeHabitsStrng,*partSkinToneStrng,*partEmplydInStrng,*partEducStrng,*partOcupStrng,*partDesignStrng,*partStarStrng,*partMTongueStrng,*partStateStrng,*partDistrictStrng,*partCityStrng,*partCountryStrng,*partCountryIdStrng,*partStateIdStrng,*partMTongueStrngId,*parDistrict_Id,*PartLookingForId,*partPhysicalStatusId,*partBodyTypeId,*partEatHabitsId,*partDrinkHabitsId,*partSmokeHabitsId,*partSkinToneId,*partCountryId,*partStateId,*partCityIdStrng,*partDistrictIdStrng,*partEduIdStrng,*partOcupIdStrng,*partDesignIdStrng,*partReligionStrng,*partReligionIdStrng,*partCasteStrng,*partcsteIdStrng,*partMTongueIdStrng;
    
    NSString *m_ToungId,*religionId,*caste_Id,*subCaste_Id,*rmToungId,*rstar_Id,*partm_ToungId,*pReligionId,*countryId,*stateId,*district_Id,*city_Id,*physicalStatusId,*FromHeightID,*profileTextID,*weightId,*mStatusId,*skintoneId,*bodyTypeId,*profileCreatedId,*eatingHabitsId,*drinkingHabitsId,*smokingHabitsId,*bloodGroupId,*referencedById,*firstNameId,*lastNameId,*birthplaceID,*birthTimeId,*manglikId,*horoscopeId,*moonsignId,*gothramID,*padamId,*eduId,*ocupId,*desigId,*employedInId,*annualIncomeId,*eduInDetailId,*residenceStatusId,*familyTypeId,*familyStatusId,*sistersId,*marriedSistersId,*brothersId,*marriedBrothersId,*aboutMyfamilyId,*ageFromID,*ageToId,*partHeightId,*partHeightToId,*adressId,*partMToungId,*pCaste_Id,*pStar_Id,*partResidenceStatusId,*peduId,*pOcupId,*pDesigId,*partEmplydInId,*partIncomeId,*partManglikId,*partnerEduInDetailId,*parCity_Id,*partStarIdStrng,*partnerMTongueId; // IDs
    
     NSMutableArray *indexes;
    
}

@end

@implementation Detail_Edit_Profile_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      keyboardIsShown = NO;
    _viewForTabie.hidden = true;
    ;
    indexes = [[NSMutableArray alloc]init];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM d, YYYY"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
   
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    basicCell.birthTimeOutlet.delegate = self;
    
    // self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = [NSDate date];
    
  otherLangStrng = [@"" mutableCopy];
    lookingForStrng=[@"" mutableCopy];
    partPhysicalStatusStrng=[@"" mutableCopy];
    partBodyTypeStrng=[@"" mutableCopy];
    partEatHabitsStrng=[@"" mutableCopy];
    partDrinkHabitsStrng=[@"" mutableCopy];
    partSmokeHabitsStrng=[@"" mutableCopy];
    partSkinToneStrng=[@"" mutableCopy];
    partEmplydInStrng=[@"" mutableCopy];
    partMTongueStrng=[@"" mutableCopy];
    partEducStrng=[@"" mutableCopy];
    partOcupStrng=[@"" mutableCopy];
    partDesignStrng=[@"" mutableCopy];
  //  partEmplydInStrng=[@"" mutableCopy];
    partStarStrng=[@"" mutableCopy];
    partStateStrng=[@"" mutableCopy];
    partDistrictStrng=[@"" mutableCopy];
    partCityStrng=[@"" mutableCopy];
    partCountryStrng=[@"" mutableCopy];
    partCountryIdStrng=[@"" mutableCopy];
    partStateIdStrng=[@"" mutableCopy];
    parDistrict_Id=[@"" mutableCopy];
    partDistrictIdStrng=[@"" mutableCopy];
    partMTongueStrngId=[@"" mutableCopy];
    partCityIdStrng=[@"" mutableCopy];
    partEduIdStrng=[@"" mutableCopy];
    partOcupIdStrng=[@"" mutableCopy];
    partDesignIdStrng=[@"" mutableCopy];
    partStarIdStrng=[@"" mutableCopy];
    partReligionStrng=[@"" mutableCopy];
    partCasteStrng=[@"" mutableCopy];
    partcsteIdStrng=[@"" mutableCopy];
    partMTongueIdStrng=[@"" mutableCopy];
    partReligionIdStrng=[@"" mutableCopy];
    heightStrng=@"";
    heightToStrng=@"";
    _viewForDate.hidden = true;
    
    languagetArr = [[NSMutableArray alloc]init];
    skinToneArr = [[NSMutableArray alloc]init];
    bodyTypeArr = [[NSMutableArray alloc]init];
    knownLangsArr = [[NSMutableArray alloc]init];
    religiosMtongueArr=[[NSMutableArray alloc]init];
    partMtongueArr=[[NSMutableArray alloc]init];
    religionArr=[[NSMutableArray alloc]init];
    starArr = [[NSMutableArray alloc]init];
    eduArr = [[NSMutableArray alloc]init];
    ocupArr = [[NSMutableArray alloc]init];
    desigArr = [[NSMutableArray alloc]init];
    partCountryArr=[[NSMutableArray alloc]init];
    user_inf = [NSUserDefaults standardUserDefaults];
    img_select_ary=[[NSMutableArray alloc]init];
    
    loggedIn_matri_id = [user_inf valueForKey:@"matri_id"];
    NSDictionary *params = @{@"matri_id":loggedIn_matri_id};
    
    [self profileServiceCall:@"services/api/memberProfile" Params:params];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [_editProfileTableView addGestureRecognizer:gestureRecognizer];
    // Do any additional setup after loading the view from its nib.
    heightArr = [[NSMutableArray alloc]initWithObjects:@"Below 4 ft",@"4 ft 06 in",@"4 ft 07 in",@"4 ft 08 in",@"4 ft 09 in",@"4 ft 10 in",@"4 ft 11 in",@"5 ft 0 in",@"5 ft 01 in",@"5 ft 02 in",@"5 ft 03 in",@"5 ft 04 in",@"5 ft 05 in",@"5 ft 06 in",@"5 ft 07 in",@"5 ft 08 in",@"5 ft 09 in",@"5 ft 10 in",@"5 ft 11 in",@"6 ft 0 in",@"6 ft 01 in",@"6 ft 02 in",@"6 ft 03 in",@"6 ft 04 in",@"6 ft 05 in",@"6 ft 06 in",@"6 ft 07 in",@"6 ft 08 in",@"6 ft 09 in",@"6 ft 10 in",@"6 ft 11 in",@"7 ft 00 in",@"Above 7 ft", nil];
    
    heightServiceArr = [[NSMutableArray alloc]initWithObjects:@"48",@"54",@"55",@"56",@"57",@"58",@"59",@"60",@"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"80",@"81",@"82",@"83",@"84",nil];
//    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(0,70,375,548)];
//    dot.image=[UIImage imageNamed:@"navigation_background.png"];
//    [self.viewForTabie addSubview:dot];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _popUpTableView) {
         if ([button isEqualToString:@"physicalStatusBtnClick"]||[button isEqualToString:@"partPhysicalStatusBtn"]) {
             return [physicalStatusArr count];
         }
        
         else if ([button isEqualToString:@"heightBtn"]||[button isEqualToString:@"partHeightBtn"]||[button isEqualToString:@"partHeightToBtn"]){
             return [heightArr count];
         }
         else if ([button isEqualToString:@"weightBtn"]){//mStatusArr
             return [weightArr count];
         }
        
         else if ([button isEqualToString:@"maritualStatusBtn"]||[button isEqualToString:@"lookingForBtn"]){//mStatusArr
             return [mStatusArr count];
         }
        
         else  if ([button isEqualToString:@"MToungeBtn"]) {
             
             return [languagetArr count];
         }
        
         else  if ([button isEqualToString:@"skintoneBtn"]||[button isEqualToString:@"partskinToneBtn"]) {
             
             return [skinToneArr count];
         }
        
         else if ([button isEqualToString:@"bodyTypeBtn"]||[button isEqualToString:@"partBodyTypeBtn"]) {
             return [bodyTypeArr count];
         }
         else if ([button isEqualToString:@"profileCreatedByBtn"]) {
             return [profileCreatedArr count];
         }
        
        else if ([button isEqualToString:@"eatingBtn"]||[button isEqualToString:@"partEatHabitsBtn"]) {
           
            return [eatingArr count];
                      }
        else if ([button isEqualToString:@"drinkingBtn"]||[button isEqualToString:@"partDrinkHabitsBtn"]) {
            
            return [drinkingArr count];
        }
        else if ([button isEqualToString:@"smokingBtn"]||[button isEqualToString:@"partSmokeHabitsBtn"]) {
             return [smokinArr count];
            }
        else if ([button isEqualToString:@"bloodGroupBtn"]) {
            return [bloodGroupArr count];
          }
        else if ([button isEqualToString:@"referencedByBtn"]) {
            return [referncedArr count];
        }
        
        else if ([button isEqualToString:@"otherLanguesBtn"]) {
            return [knownLangsArr count];
        }
        else if ([button isEqualToString:@"religiousMTongueBtn"]) {
            return [religiosMtongueArr count];
        }
        else if ([button isEqualToString:@"partnerMTongue"]) {
            return [partMtongueArr count];
        }
        else if ([button isEqualToString:@"religionBtn"]) {
            return [religionArr count];
        }
        
      else  if ([button isEqualToString:@"casteBtn"]) {
             return [castArr count];
                   }
       else if ([button isEqualToString:@"subCasteBtn"]) {
            return  [subCastArr count];
        }
      else if ([button isEqualToString:@"starBtn"]) {
        
           return [starArr count];
      }
        
        else if ([button isEqualToString:@"manglikBtn"]||[button isEqualToString:@"horoscopeBtn"]||[button isEqualToString:@"partManglikBtn"]) {
            return [manglikArr count];
        }
        else if ([button isEqualToString:@"moonsignBtn"]) {
            
            return [moonsignArr count];
        }
        
        
        
        //  Education Cell
        else if ([button isEqualToString:@"educationBtn"]) {
            return [eduArr count];
        }
        else if ([button isEqualToString:@"occupationBtn"]) {
            return [ocupArr count];
        }
        else if ([button isEqualToString:@"designationBtn"]) {
            return [desigArr count];
        }
         else if ([button isEqualToString:@"employedInBtn"]||[button isEqualToString:@"partEmplydInBtn"]) {
            return [employedInArr count];
           }
        else if ([button isEqualToString:@"annualIncomeBtn"]||[button isEqualToString:@"partAnnualIncmBtn"]) {
            return [annualIncmArr count];
        }
        else if ([button isEqualToString:@"countryBtn"]) {
            return [countryArr count];
      }
        else if ([button isEqualToString:@"stateBtn"]) {
            return [stateArr count];
        }
        else if ([button isEqualToString:@"districtBtn"]) {
            return [distArr count];
        }
        else if ([button isEqualToString:@"cityBtn"]) {
            return [cityArr count];
        }
         else if ([button isEqualToString:@"residenceStatusBtn"]||[button isEqualToString:@"partResidenceBtn"]) {
            return [residenceStatusArr count];
        }
        else if ([button isEqualToString:@"familyTypeBtn"]) {
             return [familyTypeArr count];
        }
        else if ([button isEqualToString:@"familyStatusBtn"]) {
            return [familyStatusArr count];
        }
        else if ([button isEqualToString:@"sisterBtn"]||[button isEqualToString:@"marriedSisBtn"]||[button isEqualToString:@"brotherBtn"]||[button isEqualToString:@"MarriedBroBtn"])
        {
            return [sisterArr count];
                    }
        
        //  Partner Details
        else if ([button isEqualToString:@"ageFromBtn"]||[button isEqualToString:@"ageToBtn"]) {
            return [ageFrmArr count];
        }
         else  if ([button isEqualToString:@"partMTongueBtn"]) {
            
            return [languagetArr count];
        }
         else if ([button isEqualToString:@"partEducationBtn"]) {
             return [eduArr count];
         }
         else if ([button isEqualToString:@"partOccupationBtn"]) {
             return [pOcupArr count];
         }
         else if ([button isEqualToString:@"partDesignationBtn"]) {
             return [desigArr count];
         }
         else if ([button isEqualToString:@"partReligionBtn"]) {
             return [religionArr count];
         }
         else  if ([button isEqualToString:@"partCasteBtn"]) {
             return [partcastArr count];
         }
         else if ([button isEqualToString:@"partStarBtn"]) {
             return [starArr count];
          }
        //
         else if ([button isEqualToString:@"partCountryBtn"]) {
             return [partCountryArr count];
         }
         else if ([button isEqualToString:@"partStateBtn"]) {
             return [partStateArr count];
         }
         else if ([button isEqualToString:@"partDistrictBtn"]) {
             return [partDistArr count];
         }
         else if ([button isEqualToString:@"partCityBtn"]) {
             return [partCityArr count];
         }
        
        else
         return 8;
        
    }
    
    else
    {
    return 1;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _editProfileTableView)
    {
 if ([_Clicked isEqualToString:@"ownWords"]) {
        
    static NSString *simpleTableIdentifier = @"Myown_Words_Cell";
    
    cell1 = (Myown_Words_Cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell1 == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Myown_Words_Cell" owner:self options:nil];
        cell1 = (Myown_Words_Cell *)[nib objectAtIndex:0];
        
    }
     selectedCell=cell1;

     if (EditProfileArr.count> 0) {
            
        
        cell1.myOwnOutlet.text = [EditProfileArr valueForKey:@"profile_text"];
         profileTextID = cell1.myOwnOutlet.text ;
            
        }
    return cell1;
    }
    
   else if ([_Clicked isEqualToString:@"basicDetail"]) {
        
        
        static NSString *simpleTableIdentifier = @"basic_Detail_TableViewCell";
        
        basicCell = (basic_Detail_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
        if (basicCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"basic_Detail_TableViewCell" owner:self options:nil];
            basicCell = (basic_Detail_TableViewCell *)[nib objectAtIndex:0];
            
        }
      selectedCell=basicCell;
       
        [basicCell.physicalStatusBtn addTarget:self action:@selector(physicalStatusBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
        [basicCell.dateOfBirthBtn addTarget:self action:@selector(dateOfBirthBtn) forControlEvents:UIControlEventTouchUpInside];
        [basicCell.heightBtn addTarget:self action:@selector(heightBtn) forControlEvents:UIControlEventTouchUpInside];
       
        [basicCell.weightBtn addTarget:self action:@selector(weightBtn) forControlEvents:UIControlEventTouchUpInside];
        [basicCell.maritualStatusBtn addTarget:self action:@selector(maritualStatusBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.MToungeBtn addTarget:self action:@selector(MToungeBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.skintoneBtn addTarget:self action:@selector(skintoneBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.bodyTypeBtn addTarget:self action:@selector(bodyTypeBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.profileCreatedByBtn addTarget:self action:@selector(profileCreatedByBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.eatingBtn addTarget:self action:@selector(eatingBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.drinkingBtn addTarget:self action:@selector(drinkingBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.smokingBtn addTarget:self action:@selector(smokingBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.otherLanguesBtn addTarget:self action:@selector(otherLanguesBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.bloodGroupBtn addTarget:self action:@selector(bloodGroupBtn) forControlEvents:UIControlEventTouchUpInside];
       
       [basicCell.referencedByBtn addTarget:self action:@selector(referencedByBtn) forControlEvents:UIControlEventTouchUpInside];
       
     
       
       
       basicCell.firstNameOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"firstname"]];
       basicCell.lastNameOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"lastname"]];
       basicCell.genderOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"gender"]];
      basicCell.dobOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"birthdate"]];
       basicCell.physicalStatusOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"physical_status"]];
       
       NSString * heightStrngId = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"height"]];
            for (int j=0;j<heightServiceArr.count; j++) {
           if ([heightStrngId isEqualToString:[heightServiceArr objectAtIndex:j]]) {
               heightStrng=[heightArr objectAtIndex:j];
           }
          
       }
       basicCell.heightOutlet.text = heightStrng;
       basicCell.motherTongueStatus.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"mtongue_name"]];
       basicCell.weightOutlet.text = [NSString stringWithFormat:@"%@ Kgs",[EditProfileArr  valueForKey:@"weight"]];
       basicCell.maritalStatusOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"m_status"]];
       basicCell.skinToneStatus.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"complexion"]];
       basicCell.bodyTypeOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"bodytype"]];
       basicCell.profileCreatedByOutlet.text =[NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"profileby"]];
       basicCell.eatingHabitsOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"diet"]];
       basicCell.drinkingHabitOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"drink"]];
       
       basicCell.smokingHabitOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"smoke"]];
       basicCell.otherKnownLangOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"otherlanguages"]];
       basicCell.hobbiesOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"hobby"]];
       basicCell.birthPlaceOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"birthplace"]];
       basicCell.birthTimeOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"birthtime"]];
       
       /////////
       
       basicCell.referencedByOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"reference"]];
       basicCell.bloodGroupOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"b_group"]];
       firstNameId = basicCell.firstNameOutlet.text;
       lastNameId = basicCell.lastNameOutlet.text;
       birthplaceID = basicCell.birthPlaceOutlet.text;
       birthTimeId = basicCell.birthTimeOutlet.text;
        return basicCell;
    }
   else if ([_Clicked isEqualToString:@"religious"]) {
       
       
       
       static NSString *simpleTableIdentifier = @"religious_Information_TableViewCell";
       
       religiousCell = (religious_Information_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
       if (religiousCell == nil)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"religious_Information_TableViewCell" owner:self options:nil];
           religiousCell = (religious_Information_TableViewCell *)[nib objectAtIndex:0];
           
       }
       selectedCell=religiousCell;
                                  [religiousCell.religiousMTongueBtn addTarget:self action:@selector(religiousMTongueBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [religiousCell.religionBtn addTarget:self action:@selector(religionBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [religiousCell.casteBtn addTarget:self action:@selector(casteBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [religiousCell.subCasteBtn addTarget:self action:@selector(subCasteBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [religiousCell.manglikBtn addTarget:self action:@selector(manglikBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [religiousCell.starBtn addTarget:self action:@selector(starBtnClick) forControlEvents:UIControlEventTouchUpInside];
      
       [religiousCell.horoscopeBtn addTarget:self action:@selector(horoscopeBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [religiousCell.moonsignBtn addTarget:self action:@selector(moonsignBtnClick) forControlEvents:UIControlEventTouchUpInside];

       religiousCell.motherTongueOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"mtongue_name"]];
       
       religiousCell.religionOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"religion_name"]];
       religiousCell.casteOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"caste_name"]];
       NSString * profilrFor=[NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"subcaste_name"]];
       if (!([profilrFor isEqual:[NSNull null]]||[profilrFor isEqualToString:@"<nil>"]||profilrFor == nil||profilrFor == NULL||[profilrFor isEqualToString:@""]||[profilrFor isEqualToString:@"<null>"])) {
           
            religiousCell.subCasteOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"subcaste_name"]];
       }
       else
            religiousCell.subCasteOutlet.text=@"Not Specified";
      
      // religiousCell.gothramOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"gothra"]];
       NSString * gothra=[NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"gothra"]];
       if (!([gothra isEqual:[NSNull null]]||[gothra isEqualToString:@"<nil>"]||gothra == nil||gothra == NULL||[gothra isEqualToString:@""]||[gothra isEqualToString:@"<null>"])) {
           
           religiousCell.gothramOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"gothra"]];
       }
       else
           religiousCell.gothramOutlet.text=@"Not Specified";
       
       religiousCell.manglikOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"manglik"]];
        religiousCell.starOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"star"]];
       religiousCell.padamOutlet.text =[NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"padam"]];
       NSString * pada=[NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"padam"]];
       if (!([pada isEqual:[NSNull null]]||[pada isEqualToString:@"<nil>"]||pada == nil||pada == NULL||[pada isEqualToString:@""]||[pada isEqualToString:@"<null>"])) {
           
           religiousCell.padamOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"padam"]];
       }
       else
           religiousCell.padamOutlet.text=@"Not Specified";
      // religiousCell.horoscopeOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"horoscope"]];
       NSString * horo=[NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"horoscope"]];
       if (!([horo isEqual:[NSNull null]]||[horo isEqualToString:@"<nil>"]||horo == nil||horo == NULL||[horo isEqualToString:@""]||[horo isEqualToString:@"<null>"])) {
           
           religiousCell.horoscopeOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"horoscope"]];
       }
       else
           religiousCell.horoscopeOutlet.text=@"Not Specified";
       
       religiousCell.moonsignOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"moonsign"]];
       gothramID = religiousCell.gothramOutlet.text;
       padamId = religiousCell.padamOutlet.text;
       return religiousCell;
   }
   else if ([_Clicked isEqualToString:@"education"]) {
       
       
       
       static NSString *simpleTableIdentifier = @"educ_profsnl_Information_TableViewCell";
       
       educationCell = (educ_profsnl_Information_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
       if (educationCell == nil)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"educ_profsnl_Information_TableViewCell" owner:self options:nil];
           educationCell = (educ_profsnl_Information_TableViewCell *)[nib objectAtIndex:0];
           
       }
       selectedCell = educationCell;
       [educationCell.educationBtn addTarget:self action:@selector(educationBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [educationCell.occupationBtn addTarget:self action:@selector(occupationBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [educationCell.designationBtn addTarget:self action:@selector(designationBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [educationCell.employedInBtn addTarget:self action:@selector(employedInBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [educationCell.annualIncomeBtn addTarget:self action:@selector(annualIncomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       
       
       
       
       educationCell.educationOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"edu_name"]];
       
       NSString *edDetail = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"edu_indetail"]];
       NSString *edDetl;
       if ([edDetail isEqual:[NSNull null]]||[edDetail isEqualToString:@"<nil>"]||edDetail == nil||edDetail == NULL||[edDetail isEqualToString:@""]) {
           
           edDetl = @"Not Specified";
       }
       else{
           edDetl =edDetail;
           
       }
       educationCell.eduInDetailOutlet.text = edDetl;
       eduInDetailId = educationCell.eduInDetailOutlet.text ;
       educationCell.occupationOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"ocp_name"]];
       educationCell.deisgnationOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"desg_name"]];
       educationCell.employedInOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"emp_in"]];
       educationCell.annualIncomeOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"income"]];
       
       return educationCell;
   }
   else if ([_Clicked isEqualToString:@"location"]) {
       
       
       
       static NSString *simpleTableIdentifier = @"Location_TableViewCell";
       
       locationCell = (Location_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
       if (locationCell == nil)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Location_TableViewCell" owner:self options:nil];
           locationCell = (Location_TableViewCell *)[nib objectAtIndex:0];
           
       }
       selectedCell=locationCell;
       [locationCell.countryBtn addTarget:self action:@selector(countryBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [locationCell.stateBtn addTarget:self action:@selector(stateBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [locationCell.districtBtn addTarget:self action:@selector(districtBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [locationCell.cityBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [locationCell.residenceStatusBtn addTarget:self action:@selector(residenceStatusBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
      
       
       
       
       locationCell.adressOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"address"]];
       
       locationCell.countryOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"country_name"]];
       locationCell.stateOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"state_name"]];
    //   locationCell.districtOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"district_name"]];
       NSString * distrcit=[NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"district_name"]];
       if (!([distrcit isEqual:[NSNull null]]||[distrcit isEqualToString:@"<nil>"]||distrcit == nil||distrcit == NULL||[distrcit isEqualToString:@""]||[distrcit isEqualToString:@"<null>"])) {
           
           locationCell.districtOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"district_name"]];
       }
       else
           locationCell.districtOutlet.text=@"Not Specified";
      // locationCell.cityOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"city_name"]];
       NSString * profilrFor=[NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"city_name"]];
       if (!([profilrFor isEqual:[NSNull null]]||[profilrFor isEqualToString:@"<nil>"]||profilrFor == nil||profilrFor == NULL||[profilrFor isEqualToString:@""]||[profilrFor isEqualToString:@"<null>"])) {
           
           locationCell.cityOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"city_name"]];
       }
       else
           locationCell.cityOutlet.text=@"Not Specified";
       locationCell.residenceStatusOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"residence"]];
       adressId=locationCell.adressOutlet.text;
       return locationCell;
   }
   else if ([_Clicked isEqualToString:@"familyDetails"]) {
       
       
       
       static NSString *simpleTableIdentifier = @"family_Details_TableViewCell";
       
       familyDetailCell = (family_Details_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
       if (familyDetailCell == nil)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"family_Details_TableViewCell" owner:self options:nil];
           familyDetailCell = (family_Details_TableViewCell *)[nib objectAtIndex:0];
           
       }
       selectedCell = familyDetailCell;
       [familyDetailCell.familyTypeBtn addTarget:self action:@selector(familyTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [familyDetailCell.familyStatusBtn addTarget:self action:@selector(familyStatusBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [familyDetailCell.sisterBtn addTarget:self action:@selector(sisterBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [familyDetailCell.marriedSisBtn addTarget:self action:@selector(marriedSisBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [familyDetailCell.brotherBtn addTarget:self action:@selector(brotherBtnClick) forControlEvents:UIControlEventTouchUpInside];
[familyDetailCell.MarriedBroBtn addTarget:self action:@selector(MarriedBroBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       
       
       familyDetailCell.familyTypeOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"family_type"]];
       familyDetailCell.familyStatusOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"family_status"]];
       familyDetailCell.fatherNameOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"father_name"]];
       familyDetailCell.fathersOccupOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"father_occupation"]];
       familyDetailCell.motherNameOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"mother_name"]];
       familyDetailCell.mothersOccupOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"mother_occupation"]];
       familyDetailCell.sistersOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"no_of_sisters"]];
       
       
       familyDetailCell.marriedSisOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"no_marri_sister"]];
       familyDetailCell.brothersOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"no_of_brothers"]];
       familyDetailCell.marriedBrotherOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"no_marri_brother"]];
       
       return familyDetailCell;
   }
   else if ([_Clicked isEqualToString:@"AboutFamily"]) {
       
       
       
       static NSString *simpleTableIdentifier = @"about_family_TableViewCell";
       
       aboutFamilyCell = (about_family_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
       if (aboutFamilyCell == nil)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"about_family_TableViewCell" owner:self options:nil];
           aboutFamilyCell = (about_family_TableViewCell *)[nib objectAtIndex:0];
           
       }
       selectedCell =aboutFamilyCell;
        aboutFamilyCell.aboutMyFamilyTextview.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"family_details"]];
       aboutMyfamilyId = aboutFamilyCell.aboutMyFamilyTextview.text ;
       return aboutFamilyCell;
   }
        
        
        
   else if ([_Clicked isEqualToString:@"partnerBasic"]) {
       
       
       
       static NSString *simpleTableIdentifier = @"Part_Basic_Prefer_TableViewCell";
       
       partnerBasicCell = (Part_Basic_Prefer_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
       if (partnerBasicCell == nil)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Part_Basic_Prefer_TableViewCell" owner:self options:nil];
           partnerBasicCell = (Part_Basic_Prefer_TableViewCell *)[nib objectAtIndex:0];
           
       }
       selectedCell = partnerBasicCell;
       
       [partnerBasicCell.lookingForBtn addTarget:self action:@selector(lookingForBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.ageFromBtn addTarget:self action:@selector(ageFromBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.ageToBtn addTarget:self action:@selector(ageToBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.partPhysicalStatusBtn addTarget:self action:@selector(partPhysicalStatusBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.partHeightBtn addTarget:self action:@selector(partHeightBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.partHeightToBtn addTarget:self action:@selector(partHeightToBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       [partnerBasicCell.partMTongueBtn addTarget:self action:@selector(partMTongueBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.partBodyTypeBtn addTarget:self action:@selector(partBodyTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.partEatHabitsBtn addTarget:self action:@selector(partEatHabitsBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.partDrinkHabitsBtn addTarget:self action:@selector(partDrinkHabitsBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.partSmokeHabitsBtn addTarget:self action:@selector(partSmokeHabitsBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerBasicCell.partskinToneBtn addTarget:self action:@selector(partskinToneBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       NSString * heightStrngId = [EditProfileArr  valueForKey:@"part_height"];
       NSString * heightTostrngId = [EditProfileArr  valueForKey:@"part_height_to"];
       
       for (int i=0;i<heightServiceArr.count; i++) {
           if ([heightStrngId isEqualToString:[heightServiceArr objectAtIndex:i]]) {
               heightStrng=[heightArr objectAtIndex:i];
           }
           if ([heightTostrngId isEqualToString:[heightServiceArr objectAtIndex:i]]) {
               heightToStrng=[heightArr objectAtIndex:i];
           }
       }
      
       
       
       partnerBasicCell.lookingForOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"looking_for"]];
           
       
       partnerBasicCell.ageFromOutlet.text =[NSString stringWithFormat:@"%@ Yrs",[EditProfileArr  valueForKey:@"part_frm_age"]];
       partnerBasicCell.ageToOutlet.text =[NSString stringWithFormat:@"%@ Yrs",[EditProfileArr  valueForKey:@"part_to_age"]];
       partnerBasicCell.partphysicalStatusOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"physical_status"]];
                                             
                                             
       partnerBasicCell.expectationsOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_expect"]];
   partnerBasicCell.partHeightOutlet.text = [NSString stringWithFormat:@"%@",heightStrng];
       partnerBasicCell.partHeightToOutlet.text = [NSString stringWithFormat:@"%@",heightToStrng];
        partnerBasicCell.partMotherTongueOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"part_mtongue_names"]];
       partnerBasicCell.partBodyTypeOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"part_bodytype"]];
       partnerBasicCell.partEatHabitsOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_diet"]];
       partnerBasicCell.partSmokeHabitsOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_smoke"]];
       
       
       partnerBasicCell.partDrinkHabitsOUtlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_drink"]];
       partnerBasicCell.partSkinToneOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_complexion"]];
       
       return partnerBasicCell;
   }
   else if ([_Clicked isEqualToString:@"partnerProfessional"]) {
       
       
       
       static NSString *simpleTableIdentifier = @"Partner_Professional_Preference_TableViewCell";
       
       partnerProfessionCell = (Partner_Professional_Preference_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
       if (partnerProfessionCell == nil)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Partner_Professional_Preference_TableViewCell" owner:self options:nil];
           partnerProfessionCell = (Partner_Professional_Preference_TableViewCell *)[nib objectAtIndex:0];
           
       }
       selectedCell = partnerProfessionCell;
      // partnerEduInDetailId=partnerProfessionCell.partEduInDetailOutlet.text;
       // button action
       [partnerProfessionCell.partEducationBtn addTarget:self action:@selector(partEducationBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerProfessionCell.partOccupationBtn addTarget:self action:@selector(partOccupationBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerProfessionCell.partDesignationBtn addTarget:self action:@selector(partDesignationBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerProfessionCell.partEmplydInBtn addTarget:self action:@selector(partEmplydInBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerProfessionCell.partAnnualIncmBtn addTarget:self action:@selector(partAnnualIncmBtnClick) forControlEvents:UIControlEventTouchUpInside];

      
       partnerProfessionCell.partEducationOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_education"]];
      // partnerProfessionCell.partEduInDetailOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_education"]];
       partnerProfessionCell.partDesignationOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_designation_names"]];
       partnerProfessionCell.partOccupationOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_occupation_names"]];
       partnerProfessionCell.PartEmployedInOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"part_emp_in"]];
       partnerProfessionCell.partIncomeOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_income"]];
      
       return partnerProfessionCell;
   }
    
   else if ([_Clicked isEqualToString:@"partnerReligious"]) {
       
       
       
       static NSString *simpleTableIdentifier = @"Partnr_Religious_Preferences_TableViewCell";
       
       partnerReligiousCell = (Partnr_Religious_Preferences_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
       if (partnerReligiousCell == nil)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Partnr_Religious_Preferences_TableViewCell" owner:self options:nil];
           partnerReligiousCell = (Partnr_Religious_Preferences_TableViewCell *)[nib objectAtIndex:0];
           
       }
       selectedCell = partnerReligiousCell;
       
       
       
       [partnerReligiousCell.partReligionBtn addTarget:self action:@selector(partReligionBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerReligiousCell.partCasteBtn addTarget:self action:@selector(partCasteBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerReligiousCell.partStarBtn addTarget:self action:@selector(partStarBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerReligiousCell.partManglikBtn addTarget:self action:@selector(partManglikBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerReligiousCell.partnerMTongue addTarget:self action:@selector(partnerMTongueClick) forControlEvents:UIControlEventTouchUpInside];
       
        partnerReligiousCell.partnerMTongueTF.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_mtongue_names"]];
       
       partnerReligiousCell.partReligionOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_religion_names"]];
       
       partnerReligiousCell.partcasteOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_caste_names"]];
       partnerReligiousCell.partStarOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_star_names"]];
       partnerReligiousCell.partManglikOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_manglik"]];
       
       return partnerReligiousCell;
       
       
   }

   else  {
       
       static NSString *simpleTableIdentifier = @"Partner_Location_TableViewCell";
       
       partnerLocation = (Partner_Location_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
       if (partnerLocation == nil)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Partner_Location_TableViewCell" owner:self options:nil];
           partnerLocation = (Partner_Location_TableViewCell *)[nib objectAtIndex:0];
           
       }
       selectedCell = partnerLocation;
       [partnerLocation.partCountryBtn addTarget:self action:@selector(partCountryBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerLocation.partStateBtn addTarget:self action:@selector(partStateBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerLocation.partDistrictBtn addTarget:self action:@selector(partDistrictBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerLocation.partCityBtn addTarget:self action:@selector(partCityBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [partnerLocation.partResidenceBtn addTarget:self action:@selector(partResidenceBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       
       partnerLocation.partCountryOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_country"]];
       partnerLocation.partStateOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"part_state_names"]];
      // partnerLocation.partStateOutlet.editable = NO;
       partnerLocation.partDistrictOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr valueForKey:@"part_district_names"]];
     //  partnerLocation.partStateOutlet.editable = NO;
       partnerLocation.partCityOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_city_names"]];
      // partnerLocation.partCityOutlet.editable = NO;
       partnerLocation.partResidenceStatusOutlet.text = [NSString stringWithFormat:@"%@",[EditProfileArr  valueForKey:@"part_resi_status"]];
       
       return partnerLocation;
   }
    
}
    else{
        
        static NSString *MyIdentifier = @"MyIdentifier";
        
       UITableViewCell *cell9 = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
         cell9.accessoryType = UITableViewCellAccessoryNone;
        
        if (cell9 == nil) {
            cell9 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
       // NSArray *arrr = [[NSArray alloc]initWithObjects:@"a",@"a",@"a",@"a",@"a",@"a",@"a",@"a",@"a", nil];
        if ([button isEqualToString:@"partMTongueBtn"]||[button isEqualToString:@"partEducationBtn"]||[button isEqualToString:@"partOccupationBtn"]||[button isEqualToString:@"partDesignationBtn"]||[button isEqualToString:@"partReligionBtn"]||[button isEqualToString:@"partCasteBtn"]||[button isEqualToString:@"partStarBtn"]||[button isEqualToString:@"partCountryBtn"]||[button isEqualToString:@"partStateBtn"]||[button isEqualToString:@"partDistrictBtn"]||[button isEqualToString:@"partCityBtn"]||[button isEqualToString:@"lookingForBtn"]||[button isEqualToString:@"partPhysicalStatusBtn"]||[button isEqualToString:@"partEatHabitsBtn"]||[button isEqualToString:@"partDrinkHabitsBtn"]||[button isEqualToString:@"partSmokeHabitsBtn"]||[button isEqualToString:@"partBodyTypeBtn"]||[button isEqualToString:@"partskinToneBtn"]||[button isEqualToString:@"partEmplydInBtn"]) {
            if ([img_select_ary containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            {
                cell9.imageView.image = [UIImage imageNamed:@"check-box-with-check-sign.png"];
            }
            else
            {
                cell9.imageView.image  = [UIImage imageNamed:@"check-box-empty.png"];
            }
        }
        else
        {
            cell9.imageView.image =[UIImage imageNamed:@""];
        }
       
        if ([button isEqualToString:@"physicalStatusBtnClick"]||[button isEqualToString:@"partPhysicalStatusBtn"]) {
            
             cell9.textLabel.text = [physicalStatusArr objectAtIndex: indexPath.row];
            
            
        }
        
        else if ([button isEqualToString:@"heightBtn"]||[button isEqualToString:@"partHeightBtn"]||[button isEqualToString:@"partHeightToBtn"]){
            cell9.textLabel.text = [heightArr objectAtIndex:indexPath.row];
        }
         else if ([button isEqualToString:@"weightBtn"]){
             cell9.textLabel.text =[NSString stringWithFormat:@"%@ Kg",[weightArr objectAtIndex:indexPath.row]];
             
         }
        
         else if ([button isEqualToString:@"maritualStatusBtn"]||[button isEqualToString:@"lookingForBtn"]) {//MaritalStatusBtnClick
             
                         cell9.textLabel.text =[mStatusArr objectAtIndex:indexPath.row];
                         
                     }
        
         else if ([button isEqualToString:@"MToungeBtn"]) {
             
             cell9.textLabel.text =[[languagetArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
            
             
             
         }
        
        
        else  if ([button isEqualToString:@"skintoneBtn"]||[button isEqualToString:@"partskinToneBtn"]) {
            
           cell9.textLabel.text =[skinToneArr objectAtIndex:indexPath.row];
          
        }
        
       else if ([button isEqualToString:@"bodyTypeBtn"]||[button isEqualToString:@"partBodyTypeBtn"]) {
           
           cell9.textLabel.text =[bodyTypeArr objectAtIndex:indexPath.row];

       }
    
       else if ([button isEqualToString:@"profileCreatedByBtn"]) {
           cell9.textLabel.text =[profileCreatedArr objectAtIndex:indexPath.row];
       }
       else if ([button isEqualToString:@"eatingBtn"]||[button isEqualToString:@"partEatHabitsBtn"]) {
           cell9.textLabel.text =[eatingArr objectAtIndex:indexPath.row];
                  }
       else if ([button isEqualToString:@"drinkingBtn"]||[button isEqualToString:@"partDrinkHabitsBtn"]) {
           
           cell9.textLabel.text =[drinkingArr objectAtIndex:indexPath.row];
       }
       else if ([button isEqualToString:@"smokingBtn"]||[button isEqualToString:@"partSmokeHabitsBtn"]) {
           cell9.textLabel.text =[smokinArr objectAtIndex:indexPath.row];
       }
       else if ([button isEqualToString:@"bloodGroupBtn"]) {
           cell9.textLabel.text =[bloodGroupArr objectAtIndex:indexPath.row];
       }
       else if ([button isEqualToString:@"referencedByBtn"]) {
           cell9.textLabel.text =[referncedArr objectAtIndex:indexPath.row];
       }
       else if ([button isEqualToString:@"otherLanguesBtn"]) {
           
            cell9.textLabel.text =[[knownLangsArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
         
       }
         // Religious Cell
        
       else if ([button isEqualToString:@"religiousMTongueBtn"]) {
           
           cell9.textLabel.text =[[religiosMtongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
           
       }
       else if ([button isEqualToString:@"partnerMTongue"]) {
           
           cell9.textLabel.text =[[partMtongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
       }
       else if ([button isEqualToString:@"religionBtn"]) {
           cell9.textLabel.text =[[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_name"];

       }
        
       else  if ([button isEqualToString:@"casteBtn"]) {
           if (castArr.count>0) {
            
           cell9.textLabel.text =[[castArr objectAtIndex:indexPath.row]valueForKey:@"caste_name"];
           }
       }
       else if ([button isEqualToString:@"subCasteBtn"]) {
      cell9.textLabel.text =[[subCastArr objectAtIndex:indexPath.row]valueForKey:@"subcaste_name"];
         //  return  [subCastArr count];
        }
       else if ([button isEqualToString:@"starBtn"]) {
            cell9.textLabel.text =[[starArr objectAtIndex:indexPath.row]valueForKey:@"stars_name"];
       
       }
   
       else if ([button isEqualToString:@"manglikBtn"]||[button isEqualToString:@"horoscopeBtn"]||[button isEqualToString:@"partManglikBtn"]) {
           cell9.textLabel.text =[manglikArr objectAtIndex:indexPath.row];
       }
        
       else if ([button isEqualToString:@"moonsignBtn"]) {
           
         cell9.textLabel.text =[moonsignArr objectAtIndex:indexPath.row];
       }
        
    // Employee Cell
       else if ([button isEqualToString:@"educationBtn"]) {
           cell9.textLabel.text =[[eduArr objectAtIndex:indexPath.row]valueForKey:@"edu_name"];
                  }
       else if ([button isEqualToString:@"occupationBtn"]) {
           cell9.textLabel.text =[[ocupArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
       }
       else if ([button isEqualToString:@"designationBtn"]) {
           cell9.textLabel.text =[[desigArr objectAtIndex:indexPath.row]valueForKey:@"desg_name"];
                }
        else if ([button isEqualToString:@"employedInBtn"]||[button isEqualToString:@"partEmplydInBtn"]) {
           cell9.textLabel.text =[employedInArr objectAtIndex:indexPath.row];
       }
       else if ([button isEqualToString:@"annualIncomeBtn"]||[button isEqualToString:@"partAnnualIncmBtn"]) {
           cell9.textLabel.text =[annualIncmArr objectAtIndex:indexPath.row];
       }
    // Locaion Cell
       else if ([button isEqualToString:@"countryBtn"]) {
           cell9.textLabel.text =[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
       }
       else if (stateArr.count>0 &&[button isEqualToString:@"stateBtn"]) {
           cell9.textLabel.text =[[stateArr objectAtIndex:indexPath.row] valueForKey:@"state_name"];
       }
       else if (distArr.count>0 &&[button isEqualToString:@"districtBtn"]) {
           cell9.textLabel.text =[[distArr objectAtIndex:indexPath.row] valueForKey:@"district_name"];
           
       }
       else if ([button isEqualToString:@"cityBtn"]) {
           if (!(cityArr.count>0)) {
               locationCell.cityOutlet.placeholder =@"No City Found";
           }
           else
               cell9.textLabel.text =[[cityArr objectAtIndex:indexPath.row] valueForKey:@"city_name"];

         //  return [cityArr count];
       }
        
        else if ([button isEqualToString:@"residenceStatusBtn"]||[button isEqualToString:@"partResidenceBtn"]) {
           cell9.textLabel.text =[residenceStatusArr objectAtIndex:indexPath.row];
       }
        
    // Family Details Cell
       else if ([button isEqualToString:@"familyTypeBtn"]) {
           cell9.textLabel.text =[familyTypeArr objectAtIndex:indexPath.row];

       }
       else if ([button isEqualToString:@"familyStatusBtn"]) {
                     cell9.textLabel.text =[familyStatusArr objectAtIndex:indexPath.row];
       }
       else if ([button isEqualToString:@"sisterBtn"]||[button isEqualToString:@"marriedSisBtn"]||[button isEqualToString:@"brotherBtn"]||[button isEqualToString:@"MarriedBroBtn"])
       {
           cell9.textLabel.text =[sisterArr objectAtIndex:indexPath.row];
       }
        
/////// Partner Details Cell Loading
               else if ([button isEqualToString:@"ageFromBtn"]||[button isEqualToString:@"ageToBtn"]) {
           
            cell9.textLabel.text =[NSString stringWithFormat:@"%@",[ageFrmArr objectAtIndex:indexPath.row]];
       }
       else if ([button isEqualToString:@"partMTongueBtn"]) {
           
           cell9.textLabel.text =[[languagetArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
       }
       else if ([button isEqualToString:@"partEducationBtn"]) {
           cell9.textLabel.text =[[eduArr objectAtIndex:indexPath.row]valueForKey:@"edu_name"];
       }
       else if ([button isEqualToString:@"partOccupationBtn"]) {
           cell9.textLabel.text =[[pOcupArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
       }
       else if ([button isEqualToString:@"partDesignationBtn"]) {
           cell9.textLabel.text =[[desigArr objectAtIndex:indexPath.row]valueForKey:@"desg_name"];
       }
       else if ([button isEqualToString:@"partReligionBtn"]) {
           cell9.textLabel.text =[[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_name"];
        }
       else  if ([button isEqualToString:@"partCasteBtn"]) {
           if (partcastArr.count>0) {
               cell9.textLabel.text =[[partcastArr objectAtIndex:indexPath.row]valueForKey:@"caste_name"];
           }
           
       }
       else if ([button isEqualToString:@"partStarBtn"]) {
           cell9.textLabel.text =[[starArr objectAtIndex:indexPath.row]valueForKey:@"stars_name"];
       }
       else if ([button isEqualToString:@"partCountryBtn"]) {
           cell9.textLabel.text =[[partCountryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
       }
       else if ([button isEqualToString:@"partStateBtn"]) {
           cell9.textLabel.text =[[partStateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"];
       }
       else if ([button isEqualToString:@"partDistrictBtn"]) {
           cell9.textLabel.text =[[partDistArr objectAtIndex:indexPath.row]valueForKey:@"district_name"];
       }
       else if ([button isEqualToString:@"partCityBtn"]) {
           cell9.textLabel.text =[[partCityArr objectAtIndex:indexPath.row]valueForKey:@"city_name"];
       }

        return cell9;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == _popUpTableView) {
      self.popUpTableView.allowsMultipleSelection = YES;
        
        if([selectType isEqualToString:@"multiple"]) {
            [img_select_ary addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            
            cell = (UITableViewCell*)[_popUpTableView cellForRowAtIndexPath:indexPath];
            cell.imageView.image = [UIImage imageNamed:@"check-box-with-check-sign.png"];
        }else
        {
            _viewForTabie.hidden = true;
        }
        
        if ([button isEqualToString:@"physicalStatusBtnClick"]) {
            basicCell.physicalStatusOutlet.text = [physicalStatusArr objectAtIndex:indexPath.row];
           physicalStatusId = basicCell.physicalStatusOutlet.text;
        }
        
        else if ([button isEqualToString:@"heightBtn"]){
            basicCell.heightOutlet.text = [heightArr objectAtIndex: indexPath.row];
            FromHeightID = [heightServiceArr objectAtIndex:indexPath.row];
        }

        
         else if ([button isEqualToString:@"weightBtn"]){
             
             
             basicCell.weightOutlet.text = [NSString stringWithFormat:@"%@ Kgs",[weightArr objectAtIndex:indexPath.row]];
             weightId = [weightArr objectAtIndex:indexPath.row];
         }
        
         else if ([button isEqualToString:@"maritualStatusBtn"]){
             
             
             basicCell.maritalStatusOutlet.text = [NSString stringWithFormat:@"%@",[mStatusArr objectAtIndex:indexPath.row]];
             mStatusId = [mStatusArr objectAtIndex:indexPath.row];
         }

         else if ([button isEqualToString:@"MToungeBtn"]) {//MaritalStatusBtnClick
             
            basicCell.motherTongueStatus.text =[[languagetArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
             m_ToungId = [NSString stringWithFormat:@"%@",[[languagetArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_id"]];
             
         }
        
         else if ([button isEqualToString:@"skintoneBtn"]) {
             
             basicCell.skinToneStatus.text =[skinToneArr objectAtIndex:indexPath.row];
             
             skintoneId = [skinToneArr objectAtIndex:indexPath.row];
         }
        
         else if ([button isEqualToString:@"bodyTypeBtn"]) {
             
             basicCell.bodyTypeOutlet.text =[bodyTypeArr objectAtIndex:indexPath.row];
             
              bodyTypeId = [bodyTypeArr objectAtIndex:indexPath.row];
             
             
         }
         else if ([button isEqualToString:@"profileCreatedByBtn"]) {
             basicCell.profileCreatedByOutlet.text =[profileCreatedArr objectAtIndex:indexPath.row];
              profileCreatedId = [profileCreatedArr objectAtIndex:indexPath.row];
         }
         else if ([button isEqualToString:@"eatingBtn"]) {
             basicCell.eatingHabitsOutlet.text =[eatingArr objectAtIndex:indexPath.row];
             eatingHabitsId = [eatingArr objectAtIndex:indexPath.row];
         }
         else if ([button isEqualToString:@"drinkingBtn"]) {
             
             basicCell.drinkingHabitOutlet.text =[drinkingArr objectAtIndex:indexPath.row];
             drinkingHabitsId = [drinkingArr objectAtIndex:indexPath.row];
         }

         else if ([button isEqualToString:@"smokingBtn"]) {
             basicCell.smokingHabitOutlet.text =[smokinArr objectAtIndex:indexPath.row];
             smokingHabitsId = [smokinArr objectAtIndex:indexPath.row];

         }
         else if ([button isEqualToString:@"bloodGroupBtn"]) {
             basicCell.bloodGroupOutlet.text =[bloodGroupArr objectAtIndex:indexPath.row];
             bloodGroupId = [bloodGroupArr objectAtIndex:indexPath.row];
         }
         else if ([button isEqualToString:@"referencedByBtn"]) {
             basicCell.referencedByOutlet.text =[referncedArr objectAtIndex:indexPath.row];
             referencedById = [referncedArr objectAtIndex:indexPath.row];
         }
        
         else if ([button isEqualToString:@"otherLanguesBtn"]) {
             
            
             NSString *str= [[knownLangsArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
             NSString *add =[NSString stringWithFormat:@"%@,",str];
            otherLangStrng = [[otherLangStrng stringByAppendingString:add] mutableCopy];
             
             basicCell.otherKnownLangOutlet.text =otherLangStrng;
             
         }
        
        // Religious Cell
        
         else if ([button isEqualToString:@"religiousMTongueBtn"]) {
             religiousCell.motherTongueOutlet.text =[[religiosMtongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
             rmToungId = [[religiosMtongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_id"];
             religiousCell.religionOutlet.text =@"";
             religiousCell.casteOutlet.text =@"";
             religiousCell.subCasteOutlet.text =@"";
             religionId = @"";
             caste_Id = @"";
             subCaste_Id = @"";
             
         }
         else if ([button isEqualToString:@"religionBtn"]) {
      religiousCell.religionOutlet.text =[[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_name"];
            religionId = [[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_id"];
             religiousCell.casteOutlet.text =@"";
             religiousCell.subCasteOutlet.text =@"";
             caste_Id = @"";
             subCaste_Id = @"";
         }
        
         else if ([button isEqualToString:@"casteBtn"]) {
             
             religiousCell.casteOutlet.text = [[castArr objectAtIndex:indexPath.row] valueForKey:@"caste_name"];
             caste_Id = [[castArr objectAtIndex:indexPath.row] valueForKey:@"caste_id"];
              religiousCell.subCasteOutlet.text =@"";
             subCaste_Id = @"";
         }
         else if ([button isEqualToString:@"subCasteBtn"]) {
             religiousCell.subCasteOutlet.text = [[subCastArr objectAtIndex:indexPath.row] valueForKey:@"subcaste_name"];
             subCaste_Id = [[subCastArr objectAtIndex:indexPath.row] valueForKey:@"subcaste_id"];
         }
         else if ([button isEqualToString:@"starBtn"]) {
             religiousCell.starOutlet.text = [[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_name"];
             rstar_Id = [[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_id"];
         }
        
         else if ([button isEqualToString:@"manglikBtn"]) {
             religiousCell.manglikOutlet.text =[manglikArr objectAtIndex:indexPath.row];
             manglikId = [manglikArr objectAtIndex:indexPath.row];

         }
         else if ([button isEqualToString:@"horoscopeBtn"]) {
             religiousCell.horoscopeOutlet.text =[manglikArr objectAtIndex:indexPath.row];
             horoscopeId = [manglikArr objectAtIndex:indexPath.row];
             
         }
        
        
         else if ([button isEqualToString:@"moonsignBtn"]) {
             
             religiousCell.moonsignOutlet.text =[moonsignArr objectAtIndex:indexPath.row];
             moonsignId = [moonsignArr objectAtIndex:indexPath.row];

            
         }
        
        // Employee Cell
         else if ([button isEqualToString:@"educationBtn"]) {
             educationCell.educationOutlet.text =[[eduArr objectAtIndex:indexPath.row]valueForKey:@"edu_name"];
             eduId = [[eduArr objectAtIndex:indexPath.row]valueForKey:@"edu_id"];
                  }
         else if ([button isEqualToString:@"occupationBtn"]) {
             educationCell.occupationOutlet.text =[[ocupArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
             ocupId = [[ocupArr objectAtIndex:indexPath.row]valueForKey:@"ocp_id"];
         }
         else if ([button isEqualToString:@"designationBtn"]) {
             educationCell.deisgnationOutlet.text =[[desigArr objectAtIndex:indexPath.row]valueForKey:@"desg_name"];
            desigId = [[desigArr objectAtIndex:indexPath.row]valueForKey:@"desg_id"];
         }
         else if ([button isEqualToString:@"employedInBtn"]) {
             educationCell.employedInOutlet.text =[employedInArr objectAtIndex:indexPath.row];
             employedInId = [employedInArr objectAtIndex:indexPath.row];
         }
         else if ([button isEqualToString:@"annualIncomeBtn"]) {
             educationCell.annualIncomeOutlet.text =[annualIncmArr objectAtIndex:indexPath.row];
             annualIncomeId = [annualIncmArr objectAtIndex:indexPath.row];
         }
        
        // Location Cell
         else if ([button isEqualToString:@"countryBtn"]) {
             locationCell.countryOutlet.text =[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
             countryId = [[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_id"];
             locationCell.stateOutlet.text = @"";
              locationCell.districtOutlet.text = @"";
              locationCell.cityOutlet.text = @"";
             stateId =@"";
             district_Id =@"";
             city_Id =@"";
         }
        //
         else if ([button isEqualToString:@"stateBtn"]) {
             locationCell.stateOutlet.text =[[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"];
             stateId = [[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_id"];
             locationCell.districtOutlet.text = @"";
             locationCell.cityOutlet.text = @"";
             district_Id =@"";
             city_Id =@"";

        }
         else if ([button isEqualToString:@"districtBtn"]) {
             
             locationCell.districtOutlet.text = [[distArr objectAtIndex:indexPath.row] valueForKey:@"district_name"];
             
             district_Id = [[distArr objectAtIndex:indexPath.row] valueForKey:@"district_id"];
             
             locationCell.cityOutlet.text = @"";
             city_Id=@"";
         }
         else if ([button isEqualToString:@"cityBtn"]) {//cityBtnClick
            locationCell.cityOutlet.text = [[cityArr objectAtIndex:indexPath.row] valueForKey:@"city_name"];
             city_Id = [[cityArr objectAtIndex:indexPath.row] valueForKey:@"city_id"];
         }
             else if ([button isEqualToString:@"residenceStatusBtn"]) {
             locationCell.residenceStatusOutlet.text =[residenceStatusArr objectAtIndex:indexPath.row];
             residenceStatusId = [residenceStatusArr objectAtIndex:indexPath.row];
         }
        
        // Family Details Cell
             else if ([button isEqualToString:@"familyTypeBtn"]) {
            familyDetailCell.familyTypeOutlet.text =[familyTypeArr objectAtIndex:indexPath.row];
            familyTypeId = [familyTypeArr objectAtIndex:indexPath.row];
             
         }
        else if ([button isEqualToString:@"familyStatusBtn"]) {
            familyDetailCell.familyStatusOutlet.text =[familyStatusArr objectAtIndex:indexPath.row];
            familyStatusId = [familyStatusArr objectAtIndex:indexPath.row];
        }
        else if ([button isEqualToString:@"sisterBtn"]) {
            familyDetailCell.sistersOutlet.text =[sisterArr objectAtIndex:indexPath.row];
            sistersId = [sisterArr objectAtIndex:indexPath.row];
        }
        else if ([button isEqualToString:@"marriedSisBtn"]) {
            familyDetailCell.marriedSisOutlet.text =[sisterArr objectAtIndex:indexPath.row];
            marriedSistersId = [sisterArr objectAtIndex:indexPath.row];
        }
        else if ([button isEqualToString:@"brotherBtn"]) {
            familyDetailCell.brothersOutlet.text =[sisterArr objectAtIndex:indexPath.row];
            brothersId = [sisterArr objectAtIndex:indexPath.row];
        }
        else if ([button isEqualToString:@"MarriedBroBtn"]) {
            familyDetailCell.marriedBrotherOutlet.text =[sisterArr objectAtIndex:indexPath.row];
            marriedBrothersId = [sisterArr objectAtIndex:indexPath.row];
        }
        
        
        //////// Partner Details selection Row
//#pragma mark - partner did select
        
        else if ([button isEqualToString:@"lookingForBtn"]) {
            
            NSString *str= [mStatusArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            
            if ([lookingForStrng containsString:add]) {
                lookingForStrng = [[lookingForStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                
                
            }
            else{
                lookingForStrng= [[lookingForStrng stringByAppendingString:add] mutableCopy];
                
            }
            
        }
        else if ([button isEqualToString:@"ageFromBtn"]) {
            partnerBasicCell.ageFromOutlet.text =[NSString stringWithFormat:@"%@ Yrs",[ageFrmArr objectAtIndex:indexPath.row]];
            ageFromID = [NSString stringWithFormat:@"%@",[ageFrmArr objectAtIndex:indexPath.row]];
        }
        else if ([button isEqualToString:@"ageToBtn"]) {
            partnerBasicCell.ageToOutlet.text =[NSString stringWithFormat:@"%@ Yrs",[ageFrmArr objectAtIndex:indexPath.row]];
            ageToId = [NSString stringWithFormat:@"%@",[ageFrmArr objectAtIndex:indexPath.row]];
        }
        else if ([button isEqualToString:@"partPhysicalStatusBtn"]) {
            
            NSString *str= [physicalStatusArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            
            if ([partPhysicalStatusStrng containsString:add]) {
                partPhysicalStatusStrng = [[partPhysicalStatusStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                
            }
            else{
                partPhysicalStatusStrng= [[partPhysicalStatusStrng stringByAppendingString:add] mutableCopy];
                
            }
            
        }
        else if ([button isEqualToString:@"partHeightBtn"]) {
            partnerBasicCell.partHeightOutlet.text =[heightArr objectAtIndex:indexPath.row];
            partHeightId = [heightServiceArr objectAtIndex:indexPath.row];
            
        }
        else if ([button isEqualToString:@"partHeightToBtn"]) {
            partnerBasicCell.partHeightToOutlet.text =[heightArr objectAtIndex:indexPath.row];
            partHeightToId = [heightServiceArr objectAtIndex:indexPath.row];
            
        }
        else if ([button isEqualToString:@"partMTongueBtn"]) {
            NSString *str= [[languagetArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            
            if ([partMTongueStrng containsString:add]) {
                partMTongueStrng = [[partMTongueStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                
            }
            else{
                partMTongueStrng= [[partMTongueStrng stringByAppendingString:add] mutableCopy];
                
            }
            
        }
        
        
        else if ([button isEqualToString:@"partBodyTypeBtn"]){
            NSString *str= [bodyTypeArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            
            if ([partBodyTypeStrng containsString:add]) {
                partBodyTypeStrng = [[partBodyTypeStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                
            }
            else{
                partBodyTypeStrng= [[partBodyTypeStrng stringByAppendingString:add] mutableCopy];
                
            }
            
        }
        
        
        
        else if ([button isEqualToString:@"partEatHabitsBtn"]){
            
            
            NSString *str= [eatingArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            
            
//            if (([add rangeOfString:@"select"].location)&& ([add rangeOfString:@"car"].location)  != NSNotFound ) {
//                NSLog(@"string contains select and car!");
//            } else {
//                NSLog(@"string does not contain select and car!");
//            }
            
            
            if ([partEatHabitsStrng containsString:add]) {
                partEatHabitsStrng = [[partEatHabitsStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                
            }
            else{
                partEatHabitsStrng= [[partEatHabitsStrng stringByAppendingString:add] mutableCopy];
                
            }
            
        }
        
        else if ([button isEqualToString:@"partDrinkHabitsBtn"]){
            NSString *str= [drinkingArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            
            if ([partDrinkHabitsStrng containsString:add]) {
                partDrinkHabitsStrng = [[partDrinkHabitsStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                
            }
            else{
                partDrinkHabitsStrng= [[partDrinkHabitsStrng stringByAppendingString:add] mutableCopy];
                
            }
            
        }
        
        else if ([button isEqualToString:@"partSmokeHabitsBtn"]){
            NSString *str= [smokinArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            
            if ([partSmokeHabitsStrng containsString:add]) {
                partSmokeHabitsStrng = [[partSmokeHabitsStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                
            }
            else{
                partSmokeHabitsStrng= [[partSmokeHabitsStrng stringByAppendingString:add] mutableCopy];
                
            }
        }
        
        else  if ([button isEqualToString:@"partskinToneBtn"])
        {
            NSString *str= [skinToneArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([partSkinToneStrng containsString:add]) {
                partSkinToneStrng = [[partSkinToneStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                
            }
            else{
                partSkinToneStrng= [[partSkinToneStrng stringByAppendingString:add] mutableCopy];
                
            }
            
        }
        
        // next page
        
         else if ([button isEqualToString:@"partEducationBtn"]) {
             NSString *str= [NSString stringWithFormat:@"%@,",[[eduArr objectAtIndex:indexPath.row] valueForKey:@"edu_name"]] ;
             
             
             if ([partEducStrng containsString:str]) {
                 partEducStrng = [[partEducStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
                 
             }
             else{
                 partEducStrng= [[partEducStrng stringByAppendingString:str] mutableCopy];
                 
             }
             
              NSString *str1= [NSString stringWithFormat:@"%@,",[[eduArr objectAtIndex:indexPath.row] valueForKey:@"edu_id"]] ;
             
             if ([partEduIdStrng containsString:str1]) {
                 partEduIdStrng = [[partEduIdStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
                 
             }
             else{
                 partEduIdStrng= [[partEduIdStrng stringByAppendingString:str1] mutableCopy];
                              }
            
         }
         else if ([button isEqualToString:@"partOccupationBtn"]) {
             
             NSString *str= [[pOcupArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
             NSString *add =[NSString stringWithFormat:@"%@,",str];
             
             if ([partOcupStrng containsString:add]) {
                 partOcupStrng = [[partOcupStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
                 
             }
             else{
                 partOcupStrng= [[partOcupStrng stringByAppendingString:add] mutableCopy];
                 
             }
             
            NSString *str1= [NSString stringWithFormat:@"%@,",[[pOcupArr objectAtIndex:indexPath.row] valueForKey:@"ocp_id"]] ;
             
             if ([partOcupIdStrng containsString:str1]) {
                 partOcupIdStrng = [[partOcupIdStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
                 
             }
             else{
                 partOcupIdStrng= [[partOcupIdStrng stringByAppendingString:str1] mutableCopy];
             }
             
            
         }
         else if ([button isEqualToString:@"partDesignationBtn"]) {
             NSString *str= [[desigArr objectAtIndex:indexPath.row]valueForKey:@"desg_name"];
             NSString *add =[NSString stringWithFormat:@"%@,",str];
             
             if ([partDesignStrng containsString:add]) {
                 partDesignStrng = [[partDesignStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
                 
             }
             else{
                 partDesignStrng= [[partDesignStrng stringByAppendingString:add] mutableCopy];
                 
             }
             
             NSString *str1= [NSString stringWithFormat:@"%@,",[[desigArr objectAtIndex:indexPath.row] valueForKey:@"desg_id"]] ;
             
             if ([partDesignIdStrng containsString:str1]) {
                 partDesignIdStrng = [[partDesignIdStrng stringByReplacingOccurrencesOfString:str1 withString:@""] mutableCopy];
                 
             }
             else{
                 partDesignIdStrng= [[partDesignIdStrng stringByAppendingString:str1] mutableCopy];
                 
             }
      
         }
        

        
         else if ([button isEqualToString:@"partEmplydInBtn"]){
             NSString *str= [employedInArr objectAtIndex:indexPath.row];
             NSString *add =[NSString stringWithFormat:@"%@,",str];
             if ([partEmplydInStrng containsString:add]) {
                 partEmplydInStrng = [[partEmplydInStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
                 
             }
             else{
                 partEmplydInStrng= [[partEmplydInStrng stringByAppendingString:add] mutableCopy];
                 
             }
             
           
         }
         else if ([button isEqualToString:@"partAnnualIncmBtn"]){
             partnerProfessionCell.partIncomeOutlet.text =[ annualIncmArr objectAtIndex:indexPath.row];
             partIncomeId = [ annualIncmArr objectAtIndex:indexPath.row];

         }
        
         else if ([button isEqualToString:@"partManglikBtn"]){
             partnerReligiousCell.partManglikOutlet.text =[ manglikArr objectAtIndex:indexPath.row];
             partManglikId = [ manglikArr objectAtIndex:indexPath.row];
             
         }
         else if ([button isEqualToString:@"partResidenceBtn"])
         {
             partnerLocation.partResidenceStatusOutlet.text =[ residenceStatusArr objectAtIndex:indexPath.row];
             partResidenceStatusId= [ residenceStatusArr objectAtIndex:indexPath.row];
         }
        
      //  #pragma mark - dododo
        
        //partnerMTongue
     
         else if ([button isEqualToString:@"partnerMTongue"]) {
             NSString *str= [[ partMtongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
             NSString *add =[NSString stringWithFormat:@"%@,",str];
             
             if ([partMTongueStrng containsString:add]) {
                 partMTongueStrng = [[partMTongueStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                 
             }
             else{
                 partMTongueStrng= [[partMTongueStrng stringByAppendingString:add] mutableCopy];
                 
             }
             NSString *str1= [[ partMtongueArr objectAtIndex:indexPath.row] valueForKey:@"m_tongue"];
             NSString *add1 =[NSString stringWithFormat:@"%@,",str1];
             if ([partMTongueIdStrng containsString:add1]) {
                 partMTongueIdStrng = [[partMTongueIdStrng stringByReplacingOccurrencesOfString:add1 withString:@""] mutableCopy];
             }
             else{ 
                 partMTongueIdStrng= [[partMTongueIdStrng stringByAppendingString:add1] mutableCopy];
             }
             
             
         }

        

        

         else if ([button isEqualToString:@"partReligionBtn"]) {
             NSString *str= [[religionArr objectAtIndex:indexPath.row]valueForKey:@"religion_name"];
             NSString *add =[NSString stringWithFormat:@"%@,",str];
             if ([partReligionStrng containsString:add]) {
                 
                 partReligionStrng = [[partReligionStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
             }
             else{
                 
                 partReligionStrng= [[partReligionStrng stringByAppendingString:add] mutableCopy];
             }
             NSString *str1= [NSString stringWithFormat:@"%@,",[[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_id"]] ;
             if ([partReligionIdStrng containsString:str1]) {
                 
                 partReligionIdStrng = [[partReligionIdStrng stringByReplacingOccurrencesOfString:str1 withString:@""] mutableCopy];
             }
             
             else{
                 
                 partReligionIdStrng = [[partReligionIdStrng stringByAppendingString:str1] mutableCopy];
             }

         }
        
        
         else if ([button isEqualToString:@"partCasteBtn"]) {
             NSString *str= [[partcastArr objectAtIndex:indexPath.row]valueForKey:@"caste_name"];
             
             NSString *add =[NSString stringWithFormat:@"%@,",str];
             if ([partCasteStrng containsString:add]) {
                 
                 partCasteStrng = [[partCasteStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
            }
             
             else{
                 
                 partCasteStrng= [[partCasteStrng stringByAppendingString:add] mutableCopy];
                }
         
             
             NSString *str1= [NSString stringWithFormat:@"%@,",[[partcastArr objectAtIndex:indexPath.row] valueForKey:@"caste_id"]] ;
             if ([partcsteIdStrng containsString:str1]) {
                 partcsteIdStrng = [[partcsteIdStrng stringByReplacingOccurrencesOfString:str1 withString:@""] mutableCopy];
                }
             else{
                 partcsteIdStrng= [[partcsteIdStrng stringByAppendingString:str1] mutableCopy];
             }

         }
         else if ([button isEqualToString:@"partStarBtn"]) {
             NSString *str= [[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_name"];
             
             NSString *add =[NSString stringWithFormat:@"%@,",str];
             if ([partStarStrng containsString:add]) {
                 
                 partStarStrng = [[partStarStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
             }
             else{
                 
                 partStarStrng= [[partStarStrng stringByAppendingString:add] mutableCopy];
             }
             
             NSString *str1= [[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_id"];
             NSString *add1 =[NSString stringWithFormat:@"%@,",str1];
             if ([partStarIdStrng containsString:add1]) {
                 
                 partStarIdStrng = [[partStarIdStrng stringByReplacingOccurrencesOfString:add1 withString:@""] mutableCopy];
             }
             
             else{
                 
                 partStarIdStrng= [[partStarIdStrng stringByAppendingString:add1] mutableCopy];
             }
  
         }
           else if ([button isEqualToString:@"partCountryBtn"]) {
               NSString *add =[NSString stringWithFormat:@"%@,",[[partCountryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"]];
               if ([partCountryStrng containsString:add]) {
                   
                   partCountryStrng = [[partCountryStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
               }
               else{
                   
                   partCountryStrng= [[partCountryStrng stringByAppendingString:add] mutableCopy];
               }
 
             
               NSString *addId =[NSString stringWithFormat:@"%@,",[[partCountryArr objectAtIndex:indexPath.row]valueForKey:@"country_id"]];
               
               if ([partCountryIdStrng containsString:addId]) {
                   
                   partCountryIdStrng = [[partCountryIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
               }
               
               else{
                   
                   partCountryIdStrng= [[partCountryIdStrng stringByAppendingString:addId] mutableCopy];
               }
        }
           else if ([button isEqualToString:@"partStateBtn"]) {
               NSString *add =[NSString stringWithFormat:@"%@,",[[partStateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"]];
               if ([partStateStrng containsString:add]) {
                   
                   partStateStrng = [[partStateStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
               }
               else{
                   
                   partStateStrng= [[partStateStrng stringByAppendingString:add] mutableCopy];
               }
               
               NSString *addId =[NSString stringWithFormat:@"%@,",[[partStateArr objectAtIndex:indexPath.row]valueForKey:@"state_id"]];
               
               if ([partStateIdStrng containsString:addId]) {
                   
                   partStateIdStrng = [[partStateIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
               }
               
               else{
                   
                   partStateIdStrng= [[partStateIdStrng stringByAppendingString:addId] mutableCopy];
               }
               
        }
           else if ([button isEqualToString:@"partDistrictBtn"]) {
               NSString *add =[NSString stringWithFormat:@"%@,",[[partDistArr objectAtIndex:indexPath.row] valueForKey:@"district_name"]];
               if ([partDistrictStrng containsString:add]) {
                   
                   partDistrictStrng = [[partDistrictStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
               }
               else{
                   
                   partDistrictStrng= [[partDistrictStrng stringByAppendingString:add] mutableCopy];
               }

               NSString *addId =[NSString stringWithFormat:@"%@,",[[partDistArr objectAtIndex:indexPath.row] valueForKey:@"district_id"]];
               
               if ([partDistrictIdStrng containsString:addId]) {
                   
                   partDistrictIdStrng = [[partDistrictIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
               }
               
               else{
                   
                   partDistrictIdStrng= [[partDistrictIdStrng stringByAppendingString:addId] mutableCopy];
               }
             
           }
           else if ([button isEqualToString:@"partCityBtn"]) {
               NSString *add =[NSString stringWithFormat:@"%@,",[[partCityArr objectAtIndex:indexPath.row] valueForKey:@"city_name"]];
               if ([partCityStrng containsString:add]) {
                   
                   partCityStrng = [[partCityStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
               }
               else{
                   
                   partCityStrng= [[partCityStrng stringByAppendingString:add] mutableCopy];
               }

               NSString *addId =[NSString stringWithFormat:@"%@,",[[partCityArr objectAtIndex:indexPath.row] valueForKey:@"city_id"]];
               if ([partCityIdStrng containsString:addId]) {
                   
                   partCityIdStrng = [[partCityIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
               }
               
               else{
                   
                   partCityIdStrng= [[partCityIdStrng stringByAppendingString:addId] mutableCopy];
               }

           }
        //else if ([button isEqualToString:@"partDistrictBtn"]) {
        //cell.textLabel.text =[[partDistArr objectAtIndex:indexPath.row]valueForKey:@"district_name"];
    }

    
    }
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (tableView == _popUpTableView) {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [img_select_ary removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    cell = (UITableViewCell*)[_popUpTableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"check-box-empty.png"];
    if ([button isEqualToString:@"lookingForBtn"]) {
        
        NSString *str= [mStatusArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([lookingForStrng containsString:add]) {
            lookingForStrng = [[lookingForStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
            
        }
        else{
            lookingForStrng= [[lookingForStrng stringByAppendingString:add] mutableCopy];
            
        }
        
    }
    
    else if ([button isEqualToString:@"partPhysicalStatusBtn"]) {
        
        NSString *str= [physicalStatusArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([partPhysicalStatusStrng containsString:add]) {
            partPhysicalStatusStrng = [[partPhysicalStatusStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
        }
        else{
            partPhysicalStatusStrng= [[partPhysicalStatusStrng stringByAppendingString:add] mutableCopy];
            
        }
        
    }
    else if ([button isEqualToString:@"partMTongueBtn"]) {
        NSString *str= [[languagetArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([partMTongueStrng containsString:add]) {
            partMTongueStrng = [[partMTongueStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
        }
        else{
            partMTongueStrng= [[partMTongueStrng stringByAppendingString:add] mutableCopy];
            
        }
        
    }
    
    
    else if ([button isEqualToString:@"partBodyTypeBtn"]){
        NSString *str= [bodyTypeArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([partBodyTypeStrng containsString:add]) {
            partBodyTypeStrng = [[partBodyTypeStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
        }
        else{
            partBodyTypeStrng= [[partBodyTypeStrng stringByAppendingString:add] mutableCopy];
            
        }
        
    }
    
    
    
    else if ([button isEqualToString:@"partEatHabitsBtn"]){
        
        
        NSString *str= [eatingArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        
        //            if (([add rangeOfString:@"select"].location)&& ([add rangeOfString:@"car"].location)  != NSNotFound ) {
        //                NSLog(@"string contains select and car!");
        //            } else {
        //                NSLog(@"string does not contain select and car!");
        //            }
        
        
        if ([partEatHabitsStrng containsString:add]) {
            partEatHabitsStrng = [[partEatHabitsStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
        }
        else{
            partEatHabitsStrng= [[partEatHabitsStrng stringByAppendingString:add] mutableCopy];
            
        }
        
    }
    
    else if ([button isEqualToString:@"partDrinkHabitsBtn"]){
        NSString *str= [drinkingArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([partDrinkHabitsStrng containsString:add]) {
            partDrinkHabitsStrng = [[partDrinkHabitsStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
        }
        else{
            partDrinkHabitsStrng= [[partDrinkHabitsStrng stringByAppendingString:add] mutableCopy];
            
        }
        
    }
    
    else if ([button isEqualToString:@"partSmokeHabitsBtn"]){
        NSString *str= [smokinArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([partSmokeHabitsStrng containsString:add]) {
            partSmokeHabitsStrng = [[partSmokeHabitsStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
        }
        else{
            partSmokeHabitsStrng= [[partSmokeHabitsStrng stringByAppendingString:add] mutableCopy];
            
        }
    }
    
    else  if ([button isEqualToString:@"partskinToneBtn"])
    {
        NSString *str= [skinToneArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        if ([partSkinToneStrng containsString:add]) {
            partSkinToneStrng = [[partSkinToneStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
        }
        else{
            partSkinToneStrng= [[partSkinToneStrng stringByAppendingString:add] mutableCopy];
            
        }
        
    }
    
    // next page
    
    else if ([button isEqualToString:@"partEducationBtn"]) {
        NSString *str= [NSString stringWithFormat:@"%@,",[[eduArr objectAtIndex:indexPath.row] valueForKey:@"edu_name"]] ;
        
        
        if ([partEducStrng containsString:str]) {
            partEducStrng = [[partEducStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
            
        }
        else{
            partEducStrng= [[partEducStrng stringByAppendingString:str] mutableCopy];
            
        }
        
        NSString *str1= [NSString stringWithFormat:@"%@,",[[eduArr objectAtIndex:indexPath.row] valueForKey:@"edu_id"]] ;
        
        if ([partEduIdStrng containsString:str1]) {
            partEduIdStrng = [[partEduIdStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
            
        }
        else{
            partEduIdStrng= [[partEduIdStrng stringByAppendingString:str1] mutableCopy];
        }
        
    }
    else if ([button isEqualToString:@"partOccupationBtn"]) {
        
        NSString *str= [[pOcupArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([partOcupStrng containsString:add]) {
            partOcupStrng = [[partOcupStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
            
        }
        else{
            partOcupStrng= [[partOcupStrng stringByAppendingString:add] mutableCopy];
            
        }
        
        NSString *str1= [NSString stringWithFormat:@"%@,",[[pOcupArr objectAtIndex:indexPath.row] valueForKey:@"ocp_id"]] ;
        
        if ([partOcupIdStrng containsString:str1]) {
            partOcupIdStrng = [[partOcupIdStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
            
        }
        else{
            partOcupIdStrng= [[partOcupIdStrng stringByAppendingString:str1] mutableCopy];
        }
        
        
    }
    else if ([button isEqualToString:@"partDesignationBtn"]) {
        NSString *str= [[desigArr objectAtIndex:indexPath.row]valueForKey:@"desg_name"];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([partDesignStrng containsString:add]) {
            partDesignStrng = [[partDesignStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
            
        }
        else{
            partDesignStrng= [[partDesignStrng stringByAppendingString:add] mutableCopy];
            
        }
        
        NSString *str1= [NSString stringWithFormat:@"%@,",[[desigArr objectAtIndex:indexPath.row] valueForKey:@"desg_id"]] ;
        
        if ([partDesignIdStrng containsString:str1]) {
            partDesignIdStrng = [[partDesignIdStrng stringByReplacingOccurrencesOfString:str1 withString:@""] mutableCopy];
            
        }
        else{
            partDesignIdStrng= [[partDesignIdStrng stringByAppendingString:str1] mutableCopy];
            
        }
        
    }
    
    
    
    else if ([button isEqualToString:@"partEmplydInBtn"]){
        NSString *str= [employedInArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        if ([partEmplydInStrng containsString:add]) {
            partEmplydInStrng = [[partEmplydInStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
            
        }
        else{
            partEmplydInStrng= [[partEmplydInStrng stringByAppendingString:add] mutableCopy];
            
        }
        
        
    }
    else if ([button isEqualToString:@"partnerMTongue"]) {
        NSString *str= [[ partMtongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([partMTongueStrng containsString:add]) {
            partMTongueStrng = [[partMTongueStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
        }
        else{
            partMTongueStrng= [[partMTongueStrng stringByAppendingString:add] mutableCopy];
            
        }
        NSString *str1= [[ partMtongueArr objectAtIndex:indexPath.row] valueForKey:@"m_tongue"];
        NSString *add1 =[NSString stringWithFormat:@"%@,",str1];
        if ([partMTongueIdStrng containsString:add1]) {
            partMTongueIdStrng = [[partMTongueIdStrng stringByReplacingOccurrencesOfString:add1 withString:@""] mutableCopy];
        }
        else{
            partMTongueIdStrng= [[partMTongueIdStrng stringByAppendingString:add1] mutableCopy];
        }
        
        
    }
    else if ([button isEqualToString:@"partReligionBtn"]) {
        NSString *str= [[religionArr objectAtIndex:indexPath.row]valueForKey:@"religion_name"];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        if ([partReligionStrng containsString:add]) {
            
            partReligionStrng = [[partReligionStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            
            partReligionStrng= [[partReligionStrng stringByAppendingString:add] mutableCopy];
        }
        NSString *str1= [NSString stringWithFormat:@"%@,",[[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_id"]] ;
        if ([partReligionIdStrng containsString:str1]) {
            
            partReligionIdStrng = [[partReligionIdStrng stringByReplacingOccurrencesOfString:str1 withString:@""] mutableCopy];
        }
        
        else{
            
            partReligionIdStrng = [[partReligionIdStrng stringByAppendingString:str1] mutableCopy];
        }
        
    }
 else if ([button isEqualToString:@"partCasteBtn"]) {
        NSString *str= [[partcastArr objectAtIndex:indexPath.row]valueForKey:@"caste_name"];
        
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        if ([partCasteStrng containsString:add]) {
            
            partCasteStrng = [[partCasteStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
        }
        
        else{
            
            partCasteStrng= [[partCasteStrng stringByAppendingString:add] mutableCopy];
        }
        
        
        NSString *str1= [NSString stringWithFormat:@"%@,",[[partcastArr objectAtIndex:indexPath.row] valueForKey:@"caste_id"]] ;
        if ([partcsteIdStrng containsString:str1]) {
            partcsteIdStrng = [[partcsteIdStrng stringByReplacingOccurrencesOfString:str1 withString:@""] mutableCopy];
        }
        else{
            partcsteIdStrng= [[partcsteIdStrng stringByAppendingString:str1] mutableCopy];
        }
        
    }
    else if ([button isEqualToString:@"partStarBtn"]) {
        NSString *str= [[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_name"];
        
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        if ([partStarStrng containsString:add]) {
            
            partStarStrng = [[partStarStrng stringByReplacingOccurrencesOfString:str withString:@""] mutableCopy];
        }
        else{
            
            partStarStrng= [[partStarStrng stringByAppendingString:add] mutableCopy];
        }
        
        NSString *str1= [[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_id"];
        NSString *add1 =[NSString stringWithFormat:@"%@,",str1];
        if ([partStarIdStrng containsString:add1]) {
            
            partStarIdStrng = [[partStarIdStrng stringByReplacingOccurrencesOfString:add1 withString:@""] mutableCopy];
        }
        
        else{
            
            partStarIdStrng= [[partStarIdStrng stringByAppendingString:add1] mutableCopy];
        }
        
    }
    else if ([button isEqualToString:@"partCountryBtn"]) {
        NSString *add =[NSString stringWithFormat:@"%@,",[[partCountryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"]];
        if ([partCountryStrng containsString:add]) {
            
            partCountryStrng = [[partCountryStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            
            partCountryStrng= [[partCountryStrng stringByAppendingString:add] mutableCopy];
        }
        
        
        NSString *addId =[NSString stringWithFormat:@"%@,",[[partCountryArr objectAtIndex:indexPath.row]valueForKey:@"country_id"]];
        
        if ([partCountryIdStrng containsString:addId]) {
            
            partCountryIdStrng = [[partCountryIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
        }
        
        else{
            
            partCountryIdStrng= [[partCountryIdStrng stringByAppendingString:addId] mutableCopy];
        }
    }
    else if ([button isEqualToString:@"partStateBtn"]) {
        NSString *add =[NSString stringWithFormat:@"%@,",[[partStateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"]];
        if ([partStateStrng containsString:add]) {
            
            partStateStrng = [[partStateStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            
            partStateStrng= [[partStateStrng stringByAppendingString:add] mutableCopy];
        }
        
        NSString *addId =[NSString stringWithFormat:@"%@,",[[partStateArr objectAtIndex:indexPath.row]valueForKey:@"state_id"]];
        
        if ([partStateIdStrng containsString:addId]) {
            
            partStateIdStrng = [[partStateIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
        }
        
        else{
            
            partStateIdStrng= [[partStateIdStrng stringByAppendingString:addId] mutableCopy];
        }
        
    }
    else if ([button isEqualToString:@"partDistrictBtn"]) {
        NSString *add =[NSString stringWithFormat:@"%@,",[[partDistArr objectAtIndex:indexPath.row] valueForKey:@"district_name"]];
        if ([partDistrictStrng containsString:add]) {
            
            partDistrictStrng = [[partDistrictStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            
            partDistrictStrng= [[partDistrictStrng stringByAppendingString:add] mutableCopy];
        }
        
        NSString *addId =[NSString stringWithFormat:@"%@,",[[partDistArr objectAtIndex:indexPath.row] valueForKey:@"district_id"]];
        
        if ([partDistrictIdStrng containsString:addId]) {
            
            partDistrictIdStrng = [[partDistrictIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
        }
        
        else{
            
            partDistrictIdStrng= [[partDistrictIdStrng stringByAppendingString:addId] mutableCopy];
        }
        
    }
    else if ([button isEqualToString:@"partCityBtn"]) {
        NSString *add =[NSString stringWithFormat:@"%@,",[[partCityArr objectAtIndex:indexPath.row] valueForKey:@"city_name"]];
        if ([partCityStrng containsString:add]) {
            
            partCityStrng = [[partCityStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            
            partCityStrng= [[partCityStrng stringByAppendingString:add] mutableCopy];
        }
        
        NSString *addId =[NSString stringWithFormat:@"%@,",[[partCityArr objectAtIndex:indexPath.row] valueForKey:@"city_id"]];
        if ([partCityIdStrng containsString:addId]) {
            
            partCityIdStrng = [[partCityIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
        }
        
        else{
            
            partCityIdStrng= [[partCityIdStrng stringByAppendingString:addId] mutableCopy];
        }
        
    }

   }
}

#pragma mark - edit didselect
/*
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _popUpTableView) {
         return 44;
    }
    
    else{
    if ([_Clicked isEqualToString:@"ownWords"])
    {
    return 178;
    }
    else if ([_Clicked isEqualToString:@"basicDetail"]) {
        return 939;
    }
    else if ([_Clicked isEqualToString:@"religious"]) {
        return 458;
    }
    else if ([_Clicked isEqualToString:@"education"]) {
        return 283;
    }
    else if ([_Clicked isEqualToString:@"location"]){
        return 280;
    }
    else if ([_Clicked isEqualToString:@"familyDetails"]){
        return 453;
    }
    else if ([_Clicked isEqualToString:@"AboutFamily"]) {
        return 263;
    }
    else if ([_Clicked isEqualToString:@"partnerBasic"]) {
        return 533;
    }
    else if ([_Clicked isEqualToString:@"partnerProfessional"]){
        return 283;
    }
    else if ([_Clicked isEqualToString:@"partnerReligious"]){
        return 269;
    }
     else  {
         return 368;
     }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Button Clicks



-(void)physicalStatusBtnClick
{
    
    button = @"physicalStatusBtnClick";
     // selectType =  @"multiple";
      selectType =  @"";

    [self popupsServiceHandiler];
  }

-(void)dateOfBirthBtn
{
    _viewForTabie.hidden = true;
    _viewForDate.hidden = false;
    button = @"dateOfBirthBtn";
    basicCell.userInteractionEnabled = false;
    basicCell.dobOutlet.inputView = _datePicker;
   
  
    
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *dateString =  [dateFormat stringFromDate:_datePicker.date];
    basicCell.dobOutlet.text  = dateString;
    
   // [self popupsServiceHandiler];
}
-(void)heightBtn
{
    
    button = @"heightBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    
    [self popupsServiceHandiler];
}
-(void)weightBtn
{
    
    button = @"weightBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    
     [self popupsServiceHandiler];
   // [self popupServiceCall:@"services/api/dropdownlist"];
}
-(void)maritualStatusBtn
{
    
    button = @"maritualStatusBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)MToungeBtn
{
    
    button = @"MToungeBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)skintoneBtn
{
    
    button = @"skintoneBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)bodyTypeBtn
{
    
    button = @"bodyTypeBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)profileCreatedByBtn
{
    
    button = @"profileCreatedByBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)eatingBtn
{
    
    button = @"eatingBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)drinkingBtn
{
    
    button = @"drinkingBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)smokingBtn
{
    
    button = @"smokingBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)otherLanguesBtn
{
    
    button = @"otherLanguesBtn";
     selectType =  @"multiple";
   // selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)bloodGroupBtn
{
    
    button = @"bloodGroupBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)referencedByBtn
{
    
    button = @"referencedByBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)religiousMTongueBtnClick
{
    button = @"religiousMTongueBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)religionBtnClick
{
    
    button = @"religionBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}



-(void)casteBtnClick
{
     button = @"casteBtn";
    selectType =  @"";
    if ([religiousCell.religionOutlet.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"please Enter Religion");
    }
    else
        [self popupsServiceHandiler];
}
-(void)subCasteBtnClick
{
    button = @"subCasteBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    if ([religiousCell.religionOutlet.text isEqualToString:@""]||[religiousCell.casteOutlet.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"please Enter Religion");
    }
    else
        [self popupsServiceHandiler];
}
//starBtnClick
-(void)starBtnClick
{
    
    button = @"starBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)manglikBtnClick
{
    
    button = @"manglikBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)horoscopeBtnClick
{
    
    button = @"horoscopeBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)moonsignBtnClick
{
   button = @"moonsignBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)educationBtnClick
{
    
    button = @"educationBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)occupationBtnClick
{
    
    button = @"occupationBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)designationBtnClick
{
    
    button = @"designationBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)employedInBtnClick
{
    
    button = @"employedInBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)annualIncomeBtnClick
{
    
    button = @"annualIncomeBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)countryBtnClick
{
    
    button = @"countryBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)stateBtnClick
{
    button = @"stateBtn";
    selectType =  @"";
    if([locationCell.countryOutlet.text isEqualToString:@""])
    {
        ALERT_DIALOG(@"Alert", @"please select Country ");

    }
    // selectType =  @"multiple";
    else
    {
        [self popupsServiceHandiler];
    }
}
-(void)districtBtnClick
{
    button = @"districtBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    if ([locationCell.countryOutlet.text isEqualToString:@""]||[locationCell.stateOutlet.text isEqualToString:@""]) {
        
        ALERT_DIALOG(@"Alert", @"Please Select Country And State");
    }
    else
        [self popupsServiceHandiler];
}
-(void)cityBtnClick
{
    
    button = @"cityBtn";
    // selectType =  @"multiple";
    selectType =  @"";
if ([locationCell.countryOutlet.text isEqualToString:@""]||[locationCell.stateOutlet.text isEqualToString:@""]||[locationCell.districtOutlet.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"Please Select District");
    }
    else
        [self popupsServiceHandiler];
}
-(void)residenceStatusBtnClick
{
    
    button = @"residenceStatusBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)familyTypeBtnClick
{
    
    button = @"familyTypeBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)familyStatusBtnClick
{
    
    button = @"familyStatusBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)sisterBtnClick
{
    
    button = @"sisterBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)marriedSisBtnClick
{
    
    button = @"marriedSisBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)brotherBtnClick
{
    
    button = @"brotherBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)MarriedBroBtnClick
{
    
    button = @"MarriedBroBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

/// Partner Details Button Actions


-(void)lookingForBtnClick
{
    
    button = @"lookingForBtn";
  selectType =  @"multiple";
  //  selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)ageFromBtnClick
{
    
    button = @"ageFromBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)ageToBtnClick
{
    
    button = @"ageToBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)partPhysicalStatusBtnClick
{
    
    button = @"partPhysicalStatusBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)partHeightBtnClick
{
    
    button = @"partHeightBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)partHeightToBtnClick
{
    
    button = @"partHeightToBtn";
    // selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)partMTongueBtnClick
{
    
    button = @"partMTongueBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)partBodyTypeBtnClick
{
    
    button = @"partBodyTypeBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)partEatHabitsBtnClick
{
    
    button = @"partEatHabitsBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)partDrinkHabitsBtnClick
{
    
    button = @"partDrinkHabitsBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)partSmokeHabitsBtnClick
{
    
    button = @"partSmokeHabitsBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)partskinToneBtnClick
{
    
    button = @"partskinToneBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)partEducationBtnClick
{
    
    button = @"partEducationBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)partOccupationBtnClick
{
    
    button = @"partOccupationBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)partDesignationBtnClick
{
    
    button = @"partDesignationBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)partEmplydInBtnClick
{
    
    button = @"partEmplydInBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)partAnnualIncmBtnClick
{
    button = @"partAnnualIncmBtn";
    //selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
}
//
-(void)partnerMTongueClick
{
    
    button = @"partnerMTongue";
    selectType =  @"multiple";
    [self popupsServiceHandiler];
}

-(void)partReligionBtnClick

{
    
    if ([partMToungId isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"Please select Mother Tongue");
    }
    else{
    button = @"partReligionBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
    }

}
-(void)partCasteBtnClick
{
    if ([partMToungId isEqualToString:@""]||[pReligionId isEqualToString:@""]||[partnerReligiousCell.partnerMTongueTF.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"Please select Mother Tongue & Religion ");
    }
    else{
    button = @"partCasteBtn";
   selectType =  @"multiple";
   // selectType =  @"";
    [self popupsServiceHandiler];
    }
    
}
-(void)partStarBtnClick
{
    button = @"partStarBtn";
    selectType =  @"multiple";
   // selectType =  @"";
    [self popupsServiceHandiler];
    
}
-(void) partManglikBtnClick
{
    
    button = @"partManglikBtn";
    //selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
    
}

-(void) partCountryBtnClick
{

    button = @"partCountryBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    [self popupsServiceHandiler];
}
-(void) partStateBtnClick
{
    button = @"partStateBtn";
    selectType =  @"multiple";
   // selectType =  @"";
    if([partnerLocation.partCountryOutlet.text isEqualToString:@""])
    {
        ALERT_DIALOG(@"Alert", @"please select Country ");
        
    }
   else
    {
        [self popupsServiceHandiler];
    }
}
-(void) partDistrictBtnClick
{
    
    button = @"partDistrictBtn";
  selectType =  @"multiple";
   // selectType =  @"";
    if ([partnerLocation.partCountryOutlet.text isEqualToString:@""]||[partnerLocation.partStateOutlet.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"Please Select Country And State");
    }
    else
        [self popupsServiceHandiler];

}
-(void) partCityBtnClick
{
    
    button = @"partCityBtn";
    selectType =  @"multiple";
    //selectType =  @"";
    if ([partnerLocation.partCountryOutlet.text isEqualToString:@""]||[partnerLocation.partStateOutlet.text isEqualToString:@""]||[partnerLocation.partDistrictOutlet.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"Please Country , State and District");
    }
    else
        [self popupsServiceHandiler];
}
-(void) partResidenceBtnClick
{
    
    button = @"partResidenceBtn";
    //selectType =  @"multiple";
    selectType =  @"";
    [self popupsServiceHandiler];
    
}






- (IBAction)backClickActn:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.view.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - 0);
    if (viewFrame.size.height <scrollHeight) {
        viewFrame.size.height = scrollHeight;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.view.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= ( keyboardSize.height - 0);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}



- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (IBAction)submmitBtnActn:(id)sender {
    
    _viewForTabie.hidden = false;
    
}

#pragma mark - service calls

-(void)popupsServiceHandiler
{
    _viewForDate.hidden = true;
 //   _viewForTabie.hidden = false;
    [self.view endEditing:YES];
    
    if ([button isEqualToString:@"physicalStatusBtnClick"]||[button isEqualToString:@"partPhysicalStatusBtn"]) {
        
      
        physicalStatusArr = [[NSMutableArray alloc]initWithObjects:@"Normal",@"Physically Challenged", nil];
        _viewForTabie.hidden = false;
        [_popUpTableView reloadData];
    }
    
    else if ([button isEqualToString:@"dateOfBirthBtn"]) {
        
       // _viewForDate.hidden = false;
        
    }
    
        else if ([button isEqualToString:@"heightBtn"]||[button isEqualToString:@"partHeightBtn"]||[button isEqualToString:@"partHeightToBtn"]) {//
    
            
    
    _viewForTabie.hidden = false;
            [_popUpTableView reloadData];
        }
        else if ([button isEqualToString:@"weightBtn"]) {//weightBtnClick
            
            weightArr = [[NSMutableArray alloc]init];
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            for (NSUInteger i = 40; i < 120; i++)
            {
                [array addObject:@(i)];
            }
            
            weightArr = array;
            _viewForTabie.hidden = false;
            [_popUpTableView reloadData];
        }
    

    
        else if ([button isEqualToString:@"maritualStatusBtn"]||[button isEqualToString:@"lookingForBtn"]) {
    
            mStatusArr = [[NSMutableArray alloc]initWithObjects:@"Unmarried",@"Widow/Widower",@"Divorcee",@"Separated", nil];
            
          //  [[NSMutableArray alloc]initWithObjects:@"Myself",@"Son",@"Daughter",@"Brother",@"Sister",@"Relative",@"Friend", nil];
    _viewForTabie.hidden = false;
            [_popUpTableView reloadData];
        }
    
        else if ([button isEqualToString:@"MToungeBtn"]) {
            
            [self popupServiceCall:@"services/api/dropdownlist"];
            
        }
    
   else if ([button isEqualToString:@"skintoneBtn"]||[button isEqualToString:@"partskinToneBtn"]) {
        
        
        skinToneArr = [[NSMutableArray alloc]initWithObjects:@"Very fair",@"Fair",@"wheatish",@"wheatish brown",@"Dark", nil];
        _viewForTabie.hidden = false;
        [_popUpTableView reloadData];
    }
    
   else if ([button isEqualToString:@"bodyTypeBtn"]||[button isEqualToString:@"partBodyTypeBtn"]) {
       
       
       bodyTypeArr = [[NSMutableArray alloc]initWithObjects:@"Slim",@"Average",@"Athletic",@"Heavy", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }

   else if ([button isEqualToString:@"profileCreatedByBtn"]) {
       
       
       profileCreatedArr = [[NSMutableArray alloc]initWithObjects:@"MySelf",@"Son",@"Daughter",@"Brother",@"Sister",@"Relative",@"Friend", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
   else if ([button isEqualToString:@"eatingBtn"]||[button isEqualToString:@"partEatHabitsBtn"]) {
       
       
       eatingArr = [[NSMutableArray alloc]initWithObjects:@"Occasionally Non-Veg",@"Veg",@"Eggetarian",@"Non-Veg", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
   else if ([button isEqualToString:@"drinkingBtn"]||[button isEqualToString:@"partDrinkHabitsBtn"]) {
       
             drinkingArr   = [[NSMutableArray alloc]initWithObjects:@"Yes",@"No",@"Occasionally", nil];
       _viewForTabie.hidden = false;
               [_popUpTableView reloadData];
           }
   else if ([button isEqualToString:@"smokingBtn"]||[button isEqualToString:@"partSmokeHabitsBtn"]) {//MaritalStatusBtnClick
       
       smokinArr   = [[NSMutableArray alloc]initWithObjects:@"Yes",@"No",@"Occasionally", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
    
   else if ([button isEqualToString:@"bloodGroupBtn"]) {
       
       bloodGroupArr   = [[NSMutableArray alloc]initWithObjects:@"A+",@"A-",@"AB+",@"AB-",@"B+",@"B-",@"O+",@"O-", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
   else if ([button isEqualToString:@"referencedByBtn"]) {
       
       referncedArr   = [[NSMutableArray alloc]initWithObjects:@"Advertisements",@"Friends",@"Search Engines",@"Others", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
    
    
   else if ([button isEqualToString:@"otherLanguesBtn"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
       
   }
   else if ([button isEqualToString:@"religiousMTongueBtn"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
       
   }
   else if ([button isEqualToString:@"partnerMTongue"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
       
   }
   else if ([button isEqualToString:@"religionBtn"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
       
   }
   else if ([button isEqualToString:@"casteBtn"]) {
       
       NSDictionary *params = @{@"religion_id": religionId,@"m_tongue":rmToungId};
       [self popupServiceCall:@"services/api/casteList" params:params];
   }

   else if ([button isEqualToString:@"subCasteBtn"]) {
       NSDictionary *params = @{@"religion_id": religionId,@"m_tongue":rmToungId,@"caste_id":caste_Id};
         [self popupServiceCall:@"services/api/subcasteList" params:params];
  }
   else if ([button isEqualToString:@"starBtn"]) {
      [self popupServiceCall:@"services/api/dropdownlist"];
   }

   else if ([button isEqualToString:@"moonsignBtn"]) {
       
        moonsignArr   = [[NSMutableArray alloc]initWithObjects:@"Does Not Matter",@"Mesh (Aries)",@"Vrishabh (Taurus) ",@"Mithun (Gemini)",@"Karka (Cancer)",@"Simha (Leo)",@"Kanya (Virgo)",@"Tula (Libra)",@"Vrischika (Scorpio)",@"Dhanu (Sagittarious)",@"Makar (Capricorn)",@"Kumbha (Aquarious)",@"Meen (Pisces)", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
        }
   else if ([button isEqualToString:@"manglikBtn"]||[button isEqualToString:@"horoscopeBtn"]||[button isEqualToString:@"partManglikBtn"]) {
       manglikArr   = [[NSMutableArray alloc]initWithObjects:@"Does Not Matter",@"Yes",@"No", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
    //Education Cell
    else if ([button isEqualToString:@"educationBtn"]) {
       
                    [self popupServiceCall:@"services/api/dropdownlist"];
   }
    else if ([button isEqualToString:@"occupationBtn"]) {
        
                    [self popupServiceCall:@"services/api/dropdownlist"];
    }
    else if ([button isEqualToString:@"designationBtn"]) {
        
                    [self popupServiceCall:@"services/api/dropdownlist"];
    }
   else if ([button isEqualToString:@"employedInBtn"]||[button isEqualToString:@"partEmplydInBtn"])
   {
       
       employedInArr   = [[NSMutableArray alloc]initWithObjects:@"Private",@"Government",@"Business",@"Defence",@"Not Employed in",@"Others", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
   else if ([button isEqualToString:@"annualIncomeBtn"]||[button isEqualToString:@"partAnnualIncmBtn"]) {
       
       annualIncmArr   = [[NSMutableArray alloc]initWithObjects:@"Rs 10,000 - 50,000",@"Rs 50,000 - 1,00,000",@"Rs 1,00,000 - 2,00,000",@"Rs 2,00,000 - 5,00,000",@"Rs 5,00,000 - 10,00,000",@"Rs 10,00,000 - 50,00,000",@"Rs 50,00,000 - 1,00,00,000",@"Above Rs 1,00,00,000",@"Does Not Matter", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
    
    //Location Cell

   else if ([button isEqualToString:@"countryBtn"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
   }
   else if ([button isEqualToString:@"stateBtn"])    {
       NSDictionary *params = @{@"country_id": countryId};
       [self popupServiceCall:@"services/api/statesList" params:params];

     //  [self popupServiceCallFor_Post:@"services/api/statesList" params:params];
       
   }
   else if ([button isEqualToString:@"districtBtn"]) {
       
       NSDictionary *params = @{@"state_id": stateId,@"country_id":countryId};
       [self popupServiceCall:@"services/api/districtList" params:params];

    //   [self popupServiceCallFor_Post:@"services/api/districtList" params:params];
       
   }

   else if ([button isEqualToString:@"cityBtn"]) {
            NSDictionary *params = @{@"state_id": stateId,@"country_id":countryId,@"district_id":district_Id};
       [self popupServiceCall:@"services/api/citiesList" params:params];

           //   [self popupServiceCallFor_Post:@"services/api/citiesList" params:params];
   }
   else if ([button isEqualToString:@"residenceStatusBtn"]||[button isEqualToString:@"partResidenceBtn"]) {
       
       residenceStatusArr   = [[NSMutableArray alloc]initWithObjects:@"Citizen",@"permanent Resident",@"Student Visa",@"Temporary Visa",@"Work Permit", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
    
   else if ([button isEqualToString:@"familyTypeBtn"]) {
       
       familyTypeArr   = [[NSMutableArray alloc]initWithObjects:@"Separate Family",@"Joint Family", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
   else if ([button isEqualToString:@"familyStatusBtn"]) {
       
       familyStatusArr   = [[NSMutableArray alloc]initWithObjects:@"Rich",@"Upper Middle Class",@"Middle Class",@"Lower Middle Class",@"Poor Family", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
   else if ([button isEqualToString:@"sisterBtn"]||[button isEqualToString:@"marriedSisBtn"]||[button isEqualToString:@"brotherBtn"]||[button isEqualToString:@"MarriedBroBtn"]) {
       
       sisterArr   = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"3+", nil];
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
    
   else if ([button isEqualToString:@"lookingForBtn"]) {
      
      _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
    
   else if ([button isEqualToString:@"ageFromBtn"]||[button isEqualToString:@"ageToBtn"]) {
       ageFrmArr = [[NSMutableArray alloc]init];
       for (int i=18; i<=60; i++) {
           [ageFrmArr addObject:@(i)];
       }
       
       _viewForTabie.hidden = false;
       [_popUpTableView reloadData];
   }
   else if ([button isEqualToString:@"partMTongueBtn"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
       
   }
   else if ([button isEqualToString:@"partEducationBtn"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
   }
    //partOccupationBtn
   else if ([button isEqualToString:@"partOccupationBtn"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
   }
   else if ([button isEqualToString:@"partDesignationBtn"]) {
       [self popupServiceCall:@"services/api/dropdownlist"];
   }
   else if ([button isEqualToString:@"partReligionBtn"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
   }
    //
   else if ([button isEqualToString:@"partCasteBtn"]) {

       NSDictionary *params = @{@"religion_id": pReligionId,@"m_tongue":partMToungId};
       [self popupServiceCall:@"services/api/casteList" params:params];
   }
   else if ([button isEqualToString:@"partStarBtn"]) {
       [self popupServiceCall:@"services/api/dropdownlist"];
   }
    
   else if ([button isEqualToString:@"partCountryBtn"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
   }
    //
   else if ([button isEqualToString:@"partStateBtn"])    {
       NSDictionary *params = @{@"country_id": partCountryId};
        [self popupServiceCall:@"services/api/statesList" params:params];
       
   }
   else if ([button isEqualToString:@"partDistrictBtn"]) {
       NSDictionary *params = @{@"state_id": partStateId,@"country_id":partCountryId};
       [self popupServiceCall:@"services/api/districtList" params:params];
   }
    
   else if ([button isEqualToString:@"partCityBtn"]) {
       NSDictionary *params = @{@"state_id": partStateId,@"country_id":partCountryId,@"district_id":parDistrict_Id};
       [self popupServiceCall:@"services/api/citiesList" params:params];
   }
   

   
    
    
    
    
    
}



-(void)popupServiceCall:(NSString *)url
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:url requestNumber:WUS_getPopUPData showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             NSString *result=[res_dict valueForKey:@"result"];
             
             
             if ([status isEqualToString:@"1"])
             {
                 NSDictionary *popUPList=[res_dict valueForKey:@"dropdownlist"];

                 if ([button isEqualToString:@"weightBtn"]) {
                     
                 //    religionsDict=[popUPList valueForKey:@"religionslist"];
                 }
//
                 else if ([button isEqualToString:@"MToungeBtn"]) {
                     [languagetArr removeAllObjects];

                     languagetArr=[[popUPList valueForKey:@"languageslist"] mutableCopy];
                     _viewForTabie.hidden = false;
                     [_popUpTableView reloadData];
                 }
                 
                  else if ([button isEqualToString:@"otherLanguesBtn"]) {
                      
                      
                      knownLangsArr=[popUPList valueForKey:@"languageslist"];
                      _viewForTabie.hidden = false;
                      [_popUpTableView reloadData];
                      
                  }
//                else if ([button isEqualToString:@"religiousMTongueBtn"]) {
//                      
//                      
//                      religiosMtongueArr=[popUPList valueForKey:@"languageslist"];
//                      _viewForTabie.hidden = false;
//                      [_popUpTableView reloadData];
//                      
//                  }
                else if ([button isEqualToString:@"partnerMTongue"]) {
                    
                    
                    partMtongueArr=[popUPList valueForKey:@"languageslist"];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                    
                }
                else if ([button isEqualToString:@"religionBtn"]) {
                    [religionArr removeAllObjects];
                      religionArr=[[popUPList valueForKey:@"religionslist"] mutableCopy];
                    _viewForTabie.hidden = false;
                      [_popUpTableView reloadData];
                  }
                else if ([button isEqualToString:@"starBtn"]) {
                    [starArr removeAllObjects];
                    starArr=[[popUPList valueForKey:@"starslist"] mutableCopy];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }

                else if ([button isEqualToString:@"educationBtn"]) {
                    [eduArr removeAllObjects];
                    eduArr=[[popUPList valueForKey:@"educationlist"] mutableCopy];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                else if ([button isEqualToString:@"occupationBtn"]) {
                    ocupArr=[popUPList valueForKey:@"occupationlist"] ;
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                else if ([button isEqualToString:@"designationBtn"]) {
                    [desigArr removeAllObjects];
                    desigArr=[[popUPList valueForKey:@"designationlist"] mutableCopy];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                else if ([button isEqualToString:@"countryBtn"]) {
 //                   [desigArr removeAllObjects];
                    countryArr=[popUPList valueForKey:@"countrieslist"];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                 //stateBtn
                 
                else if ([button isEqualToString:@"partMTongueBtn"]) {
                    [languagetArr removeAllObjects];
                    languagetArr=[[popUPList valueForKey:@"languageslist"] mutableCopy];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                else if ([button isEqualToString:@"partEducationBtn"]) {
                    [eduArr removeAllObjects];
                    eduArr=[[popUPList valueForKey:@"educationlist"] mutableCopy];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                else if ([button isEqualToString:@"partOccupationBtn"]) {
                    
                    pOcupArr=[popUPList valueForKey:@"occupationlist"];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                else if ([button isEqualToString:@"partDesignationBtn"]) {
                    [desigArr removeAllObjects];
                    desigArr=[[popUPList valueForKey:@"designationlist"] mutableCopy];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                else if ([button isEqualToString:@"partReligionBtn"]) {
                    [religionArr removeAllObjects];
                    religionArr=[[popUPList valueForKey:@"religionslist"] mutableCopy];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                 
                 //
                else if ([button isEqualToString:@"partStarBtn"]) {
                    [starArr removeAllObjects];
                    starArr=[[popUPList valueForKey:@"starslist"] mutableCopy];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                 //partCountryBtn
                else if ([button isEqualToString:@"partCountryBtn"]) {
                    //                   [desigArr removeAllObjects];
                    partCountryArr=[popUPList valueForKey:@"countrieslist"];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
             }
                 
        }
     }];
     
}

-(void)popupServiceCallFor_Post:(NSString *)url params:(NSDictionary *)params//submit actions
{
    //raviratna5566@gmail.com
    _popUpTableView.hidden = YES;
    _viewForTabie.hidden=YES;
    _ok.hidden=YES;
    _cancel.hidden=YES;
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             
             NSDictionary *res_dict = data;
             
             NSString *status = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
            // ALERT_DIALOG(@"Alert", result);
            
           //  ALERT_DIALOG(@"", @"your details have been updated successfully");
             UIAlertController * controller =[UIAlertController alertControllerWithTitle:@"Success" message:@"your details have been updated successfully." preferredStyle:UIAlertControllerStyleAlert];
             [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                 EditProfileViewController *menuController  =[[EditProfileViewController alloc]initWithNibName:@"EditProfileViewController" bundle:nil];
                 
                 [self.navigationController pushViewController:menuController animated:YES];
             }]];
            [self presentViewController:controller animated:YES completion:nil];
             
             
//             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"your details have been updated successfully" preferredStyle:UIAlertControllerStyleAlert];
//             [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
//                 EditProfileViewController *menuController  =[[EditProfileViewController alloc]initWithNibName:@"EditProfileViewController" bundle:nil];
//                 //   menuController.Clicked = clicked;
//                 
//                 
//                 [self.navigationController pushViewController:menuController animated:YES];
//             }]];
//             [self presentViewController:alertController animated:YES completion:nil];
         }
     }];
    
  // _popUpTableView.hidden = YES;
     }



-(void)popupServiceCall:(NSString *)url params:(NSDictionary *)params
{
    //raviratna5566@gmail.com
    
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict = data;
             
             NSString *status = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result = [NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                 // check valid no and mail

                 
                 
                 if ([button isEqualToString:@"casteBtn"]) {
                     castArr = [[NSMutableArray alloc] init];
                     castArr = [res_dict valueForKey:@"castelist"];
                     _viewForTabie.hidden = false;
                     [_popUpTableView reloadData];
                 }
                    //subCasteBtn
               else  if ([button isEqualToString:@"subCasteBtn"]) {
                     subCastArr = [[NSMutableArray alloc] init];
                     subCastArr = [res_dict valueForKey:@"subcastelist"];
                   _viewForTabie.hidden = false;
                     [_popUpTableView reloadData];
                 }
                else if ([button isEqualToString:@"partCasteBtn"]) {
                     partcastArr = [[NSMutableArray alloc] init];
                     partcastArr = [res_dict valueForKey:@"castelist"];
                     [_popUpTableView reloadData];
                 }
              //  else if ([button isEqualToString:@"stateBtn"]) {
                else if ([button isEqualToString:@"stateBtn"]) {
                    stateArr = [[NSMutableArray alloc] init];
                    stateArr=[res_dict valueForKey:@"statelist"];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                else if ([button isEqualToString:@"districtBtn"]) {
                    distArr = [[NSMutableArray alloc] init];
                    distArr=[res_dict valueForKey:@"districtlist"];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
           
                }
                else if ([button isEqualToString:@"cityBtn"]) {
                    cityArr = [[NSMutableArray alloc] init];
                    cityArr = [res_dict valueForKey:@"citylist"];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
              //
                else if ([button isEqualToString:@"partStateBtn"]) {
                    partStateArr = [[NSMutableArray alloc] init];
                    partStateArr=[res_dict valueForKey:@"statelist"];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                else if ([button isEqualToString:@"partDistrictBtn"]) {
                    partDistArr = [[NSMutableArray alloc] init];
                    partDistArr=[res_dict valueForKey:@"districtlist"];
                    _viewForTabie.hidden = false;
                    [_popUpTableView reloadData];
                }
                 else if ([button isEqualToString:@"partCityBtn"]) {
                     partCityArr = [[NSMutableArray alloc] init];
                     partCityArr = [res_dict valueForKey:@"citylist"];
                     _viewForTabie.hidden = false;
                     [_popUpTableView reloadData];
                 }
                 
                // _popUpTableView.hidden = YES;

             }
             
             else if ([status isEqualToString:@"2"])
             {
                 ALERT_DIALOG(@"Alert", result);
                 if ([button isEqualToString:@"subCasteBtn"]) {
                 religiousCell.subCasteOutlet.text=@"Not Specified";
               }
                else if ([button isEqualToString:@"casteBtn"]) {
                     religiousCell.casteOutlet.text=@"Not Specified";
                 }
                 
                 
                 
            else if ([button isEqualToString:@"partCasteBtn"]) {
                     partnerReligiousCell.partcasteOutlet.text=@"Not Specified";
                 }
                 //  else if ([button isEqualToString:@"stateBtn"]) {
                 else if ([button isEqualToString:@"stateBtn"]) {
                     locationCell.stateOutlet.text=@"Not Specified";
                 }
                 else if ([button isEqualToString:@"districtBtn"]) {
                    locationCell.districtOutlet.text=@"Not Specified";
                     
                 }
                 else if ([button isEqualToString:@"cityBtn"]) {
                     locationCell.cityOutlet.text=@"Not Specified";
                 }
                 //
                 else if ([button isEqualToString:@"partStateBtn"]) {
                    partnerLocation.partStateOutlet.text=@"Not Specified";
                 }
                 else if ([button isEqualToString:@"partDistrictBtn"]) {
                     partnerLocation.partDistrictOutlet.text=@"Not Specified";
                 }
                 else if ([button isEqualToString:@"partCityBtn"]) {
                    partnerLocation.partCityOutlet.text=@"Not Specified";
                 }
                 
                 _viewForTabie.hidden = true;
//                 
             }
             else if ([status isEqualToString:@"4"])
             {
                  ALERT_DIALOG(@"Alert", result);
                // button = @"";
             //    [self Alert:result];
             }
             else
             {
               //  button = @"";
              //   [self Alert:@"Try again"];
             }
         
       }
     }];
}

-(void)profileServiceCall:(NSString *)url Params:(NSDictionary *)param{
    //raviratna5566@gmail.com
    
     //basicCell.hidden = true;
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:param requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         
        
         if (success)
         {
             
            // basicCell.hidden = false;
             NSDictionary *res_dict = data;
             
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             
             if ([status isEqualToString:@"1"])
             {
                 
                 
                 EditProfileArr = [[NSMutableArray alloc] init];
                 EditProfileArr = [res_dict valueForKey:@"profilelist"];
                 [self idsInitialAllocation:[res_dict valueForKey:@"profilelist"]];
                 [_editProfileTableView reloadData];
 
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


//-(BOOL) textFieldShouldReturn:(UITextField *)textField{
//
//    [textField resignFirstResponder];
//    return YES;
//}

- (IBAction)OkBtnActn:(id)sender {
   // if (selectedCell == partnerBasicCell) {
         [img_select_ary removeAllObjects];
        if ([button isEqualToString:@"lookingForBtn"]) {
            if ([lookingForStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerBasicCell.lookingForOutlet.text =@"";
            NSString *lastCharId = [lookingForStrng substringFromIndex:[lookingForStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                lookingForStrng = [[lookingForStrng substringToIndex:[lookingForStrng length] - 1] mutableCopy];
            }
            PartLookingForId = lookingForStrng;
            partnerBasicCell.lookingForOutlet.text = PartLookingForId;
            lookingForStrng = [@"" mutableCopy];
                 _viewForTabie.hidden = true;
            }
        }
        
        else if ([button isEqualToString:@"partPhysicalStatusBtn"]) {
            if ([partPhysicalStatusStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerBasicCell.partphysicalStatusOutlet.text = @"";
            NSString *lastCharId = [partPhysicalStatusStrng substringFromIndex:[partPhysicalStatusStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partPhysicalStatusStrng = [[partPhysicalStatusStrng substringToIndex:[partPhysicalStatusStrng length] - 1] mutableCopy];
            }
            partPhysicalStatusId = partPhysicalStatusStrng;
            partnerBasicCell.partphysicalStatusOutlet.text = partPhysicalStatusId;
            partPhysicalStatusStrng = [@"" mutableCopy];
                 _viewForTabie.hidden = true;
            }
        }
        
//        else if ([button isEqualToString:@"partMTongueBtn"]) {
//            
//            partnerBasicCell.partMotherTongueOutlet.text = @"";
//            NSString *lastCharId = [partPhysicalStatusStrng substringFromIndex:[partPhysicalStatusStrng length] - 1];
//            if ([lastCharId isEqualToString:@","]) {
//                partPhysicalStatusStrng = [[partPhysicalStatusStrng substringToIndex:[partPhysicalStatusStrng length] - 1] mutableCopy];
//            }
//
//            partMTongueStrngId = partMTongueStrng;
//            partnerBasicCell.partMotherTongueOutlet.text = partMTongueStrngId;
//            partMTongueStrng = [@"" mutableCopy];
//            
//            
//        }
    
        else if ([button isEqualToString:@"partBodyTypeBtn"]){
            if ([partBodyTypeStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerBasicCell.partBodyTypeOutlet.text = @"";
            NSString *lastCharId = [partBodyTypeStrng substringFromIndex:[partBodyTypeStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partBodyTypeStrng = [[partBodyTypeStrng substringToIndex:[partBodyTypeStrng length] - 1] mutableCopy];
            }

            partBodyTypeId = partBodyTypeStrng;
            
            partnerBasicCell.partBodyTypeOutlet.text =partBodyTypeStrng;
            partBodyTypeStrng  = [@"" mutableCopy];
                _viewForTabie.hidden = true;
            }
            
        }
        
        else if ([button isEqualToString:@"partEatHabitsBtn"]){
            if ([partEatHabitsStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerBasicCell.partEatHabitsOutlet.text = @"";
            NSString *lastCharId = [partEatHabitsStrng substringFromIndex:[partEatHabitsStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partEatHabitsStrng = [[partEatHabitsStrng substringToIndex:[partEatHabitsStrng length] - 1] mutableCopy];
            }
            

            partEatHabitsId = partEatHabitsStrng;
            
            partnerBasicCell.partEatHabitsOutlet.text =partEatHabitsStrng;
            partEatHabitsStrng  = [@"" mutableCopy];
                _viewForTabie.hidden = true;
            }
            
        }
        else if ([button isEqualToString:@"partDrinkHabitsBtn"]){
            if ([partDrinkHabitsStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerBasicCell.partDrinkHabitsOUtlet.text = @"";
            NSString *lastCharId = [partDrinkHabitsStrng substringFromIndex:[partDrinkHabitsStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partDrinkHabitsStrng = [[partDrinkHabitsStrng substringToIndex:[partDrinkHabitsStrng length] - 1] mutableCopy];
            }

            partDrinkHabitsId = partDrinkHabitsStrng;
            
            partnerBasicCell.partDrinkHabitsOUtlet.text =partDrinkHabitsStrng;
            partDrinkHabitsStrng  = [@"" mutableCopy];
                _viewForTabie.hidden = true;
            }
            
        }
        
        else if ([button isEqualToString:@"partSmokeHabitsBtn"]){
            if ([partSmokeHabitsStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerBasicCell.partSmokeHabitsOutlet.text = @"";
            NSString *lastCharId = [partSmokeHabitsStrng substringFromIndex:[partSmokeHabitsStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partSmokeHabitsStrng = [[partSmokeHabitsStrng substringToIndex:[partSmokeHabitsStrng length] - 1] mutableCopy];
            }
            partSmokeHabitsId = partSmokeHabitsStrng;
            
            partnerBasicCell.partSmokeHabitsOutlet.text =partSmokeHabitsStrng;
            partSmokeHabitsStrng  = [@"" mutableCopy];
            _viewForTabie.hidden = true;
            }
            
        }
        else  if ([button isEqualToString:@"partskinToneBtn"])
        {
            if ([partSkinToneStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerBasicCell.partSkinToneOutlet.text = @"";
            NSString *lastCharId = [partSkinToneStrng substringFromIndex:[partSkinToneStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partSkinToneStrng = [[partSkinToneStrng substringToIndex:[partSkinToneStrng length] - 1] mutableCopy];
            }
            partSkinToneId = partSkinToneStrng;
            
            partnerBasicCell.partSkinToneOutlet.text =partSkinToneStrng;
            partSkinToneStrng  = [@"" mutableCopy];
            _viewForTabie.hidden = true;
            }
        }
        
        // profession
        
        else if ([button isEqualToString:@"partEducationBtn"]) {
            if ([partEducStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerProfessionCell.partEducationOutlet.text = @"";
            NSString *lastChar = [partEducStrng substringFromIndex:[partEducStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                partEducStrng = [[partEducStrng substringToIndex:[partEducStrng length] - 1] mutableCopy];
            }
            NSString *lastCharId = [partEduIdStrng substringFromIndex:[partEduIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partEduIdStrng = [[partEduIdStrng substringToIndex:[partEduIdStrng length] - 1] mutableCopy];
            }

            
           partnerProfessionCell.partEducationOutlet.text =partEducStrng;
            peduId = partEduIdStrng;
            partEducStrng  = [@"" mutableCopy];
            partEduIdStrng = [@"" mutableCopy];
           _viewForTabie.hidden = true;
            }
        }
        
        else if ([button isEqualToString:@"partOccupationBtn"]) {
            if ([partOcupStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
           partnerProfessionCell.partOccupationOutlet.text = @"";
            NSString *lastChar = [partOcupStrng substringFromIndex:[partOcupStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                partOcupStrng = [[partOcupStrng substringToIndex:[partOcupStrng length] - 1] mutableCopy];
            }
            NSString *lastCharId = [partOcupIdStrng substringFromIndex:[partOcupIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partOcupIdStrng = [[partOcupIdStrng substringToIndex:[partOcupIdStrng length] - 1] mutableCopy];
            }

            partnerProfessionCell.partOccupationOutlet.text =partOcupStrng;
            pOcupId = partOcupIdStrng;
            partOcupStrng  = [@"" mutableCopy];
             partOcupIdStrng  = [@"" mutableCopy];
                _viewForTabie.hidden = true;
            }
                    
    }
        
        else if ([button isEqualToString:@"partDesignationBtn"]) {
            if ([partDesignStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerProfessionCell.partDesignationOutlet.text = @"";
            NSString *lastChar = [partDesignStrng substringFromIndex:[partDesignStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                partDesignStrng = [[partDesignStrng substringToIndex:[partDesignStrng length] - 1] mutableCopy];
            }
            NSString *lastCharId = [partDesignIdStrng substringFromIndex:[partDesignIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partDesignIdStrng = [[partDesignIdStrng substringToIndex:[partDesignIdStrng length] - 1] mutableCopy];
            }
            partnerProfessionCell.partDesignationOutlet.text = partDesignStrng;
             pDesigId = partDesignIdStrng;
            
           partDesignStrng =[@"" mutableCopy];
            partDesignIdStrng =[@"" mutableCopy];
                _viewForTabie.hidden = true;
            }
        
    }
        
        else if ([button isEqualToString:@"partEmplydInBtn"]){
            if ([partEmplydInStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
             partnerProfessionCell.PartEmployedInOutlet.text = @"";
            NSString *lastCharId = [partEmplydInStrng substringFromIndex:[partEmplydInStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partEmplydInStrng = [[partEmplydInStrng substringToIndex:[partEmplydInStrng length] - 1] mutableCopy];
            }

            partEmplydInId = partEmplydInStrng;
             partnerProfessionCell.PartEmployedInOutlet.text = partEmplydInStrng;
                partEmplydInStrng =[@"" mutableCopy];
                _viewForTabie.hidden = true;
            }
        }
        else if ([button isEqualToString:@"partReligionBtn"]) {
            
            if ([partReligionStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerReligiousCell.partReligionOutlet.text = @"";
            NSString *lastChar = [partReligionStrng substringFromIndex:[partReligionStrng length] - 1];
            NSString *lastCharId = [partReligionIdStrng substringFromIndex:[partReligionIdStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                partReligionStrng = [[partReligionStrng substringToIndex:[partReligionStrng length] - 1] mutableCopy];
            }
            if ([lastCharId isEqualToString:@","]) {
                partReligionIdStrng = [[partReligionIdStrng substringToIndex:[partReligionIdStrng length] - 1] mutableCopy];
            }
            partnerReligiousCell.partReligionOutlet.text = partReligionStrng;
            pReligionId = partReligionIdStrng;
 
            partReligionStrng =[@"" mutableCopy];
            partReligionIdStrng =[@"" mutableCopy];
            _viewForTabie.hidden = true;
            }
           }
        else if ([button isEqualToString:@"partCasteBtn"]) {
            if ([partCasteStrng isEqualToString:@""]) {
                ALERT_DIALOG(@"Alert", @"please select atleast one value");
                _viewForTabie.hidden = false;
            }
            else
            {
            partnerReligiousCell.partcasteOutlet.text = @"";
            NSString *lastChar = [partCasteStrng substringFromIndex:[partCasteStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                partCasteStrng = [[partCasteStrng substringToIndex:[partCasteStrng length] - 1] mutableCopy];
            }
            NSString *lastCharId = [partcsteIdStrng substringFromIndex:[partcsteIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                partcsteIdStrng = [[partcsteIdStrng substringToIndex:[partcsteIdStrng length] - 1] mutableCopy];
            }
            partnerReligiousCell.partcasteOutlet.text = partCasteStrng;
            pCaste_Id = partcsteIdStrng;
            
            partCasteStrng =[@"" mutableCopy];
            partcsteIdStrng =[@"" mutableCopy];
                _viewForTabie.hidden = true;
            }
            
        }
    
    else if ([button isEqualToString:@"partStarBtn"]) {
        if ([partStarStrng isEqualToString:@""]) {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            _viewForTabie.hidden = false;
        }
        else
        {
        partnerReligiousCell.partStarOutlet.text = @"";
        NSString *lastChar = [partStarStrng substringFromIndex:[partStarStrng length] - 1];
        if ([lastChar isEqualToString:@","]) {
            partStarStrng = [[partStarStrng substringToIndex:[partStarStrng length] - 1] mutableCopy];
        }
        NSString *lastCharId = [partStarIdStrng substringFromIndex:[partStarIdStrng length] - 1];
        if ([lastCharId isEqualToString:@","]) {
            partStarIdStrng = [[partStarIdStrng substringToIndex:[partStarIdStrng length] - 1] mutableCopy];
        }

       partnerReligiousCell.partStarOutlet.text = partStarStrng;
        pStar_Id = partStarIdStrng;
        
        partStarStrng =[@"" mutableCopy];
        partStarIdStrng =[@"" mutableCopy];
            _viewForTabie.hidden = true;
        }
}
    
    else if ([button isEqualToString:@"partCountryBtn"]) {
        if ([partCountryStrng isEqualToString:@""]) {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            _viewForTabie.hidden = false;
        }
        else
        {
    partnerLocation.partCountryOutlet.text = @"";
        partnerLocation.partStateOutlet.text=@"";
        partnerLocation.partDistrictOutlet.text=@"";
        partnerLocation.partCityOutlet.text=@"";
        
        partStateId=[@"" mutableCopy];
        partStateIdStrng=[@"" mutableCopy];
        
        parDistrict_Id=[@"" mutableCopy];
        partDistrictIdStrng=[@"" mutableCopy];
        
        parCity_Id=[@"" mutableCopy];
        partCityIdStrng=[@"" mutableCopy];
        NSString *lastChar = [partCountryStrng substringFromIndex:[partCountryStrng length] - 1];
        if ([lastChar isEqualToString:@","]) {
            partCountryStrng = [[partCountryStrng substringToIndex:[partCountryStrng length] - 1] mutableCopy];
        }
        NSString *lastCharId = [partCountryIdStrng substringFromIndex:[partCountryIdStrng length] - 1];
        if ([lastCharId isEqualToString:@","]) {
            partCountryIdStrng = [[partCountryIdStrng substringToIndex:[partCountryIdStrng length] - 1] mutableCopy];
        }
      partnerLocation.partCountryOutlet.text = partCountryStrng;
        partCountryId = partCountryIdStrng;
        
        partCountryStrng =[@"" mutableCopy];
        partCountryIdStrng =[@"" mutableCopy];
            _viewForTabie.hidden = true;
        }
    }
    else if ([button isEqualToString:@"partStateBtn"]) {
        if ([partStateStrng isEqualToString:@""]) {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            _viewForTabie.hidden = false;
        }
        else
        {
        partnerLocation.partStateOutlet.text = @"";
        partnerLocation.partDistrictOutlet.text=@"";
        partnerLocation.partCityOutlet.text=@"";
        
        parDistrict_Id=[@"" mutableCopy];
        partDistrictIdStrng=[@"" mutableCopy];
        
        parCity_Id=[@"" mutableCopy];
        partCityIdStrng=[@"" mutableCopy];
        NSString *lastChar = [partStateStrng substringFromIndex:[partStateStrng length] - 1];
        if ([lastChar isEqualToString:@","]) {
            partStateStrng = [[partStateStrng substringToIndex:[partStateStrng length] - 1] mutableCopy];
        }
        NSString *lastCharId = [partStateIdStrng substringFromIndex:[partStateIdStrng length] - 1];
        if ([lastCharId isEqualToString:@","]) {
            partStateIdStrng = [[partStateIdStrng substringToIndex:[partStateIdStrng length] - 1] mutableCopy];
        }
        partnerLocation.partStateOutlet.text= partStateStrng;
        partStateId = partStateIdStrng;
        partStateStrng =[@"" mutableCopy];
        partStateIdStrng =[@"" mutableCopy];
            _viewForTabie.hidden = true;
        }
    }
    
    else if ([button isEqualToString:@"partDistrictBtn"]) {
        if ([partDistrictStrng isEqualToString:@""]) {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            _viewForTabie.hidden = false;
        }
        else
        {
        partnerLocation.partDistrictOutlet.text = @"";
          partnerLocation.partCityOutlet.text=@"";
        parCity_Id=[@"" mutableCopy];
        partCityIdStrng=[@"" mutableCopy];
        NSString *lastChar = [partDistrictStrng substringFromIndex:[partDistrictStrng length] - 1];
        if ([lastChar isEqualToString:@","]) {
            partDistrictStrng = [[partDistrictStrng substringToIndex:[partDistrictStrng length] - 1] mutableCopy];
        }
        NSString *lastCharId = [partDistrictIdStrng substringFromIndex:[partDistrictIdStrng length] - 1];
        if ([lastCharId isEqualToString:@","]) {
            partDistrictIdStrng = [[partDistrictIdStrng substringToIndex:[partDistrictIdStrng length] - 1] mutableCopy];
        }
        partnerLocation.partDistrictOutlet.text= partDistrictStrng;
        parDistrict_Id = partDistrictIdStrng;
        partDistrictStrng =[@"" mutableCopy];
        partDistrictIdStrng =[@"" mutableCopy];
            _viewForTabie.hidden = true;
        }
    }
    else if ([button isEqualToString:@"partCityBtn"]) {
        if ([partCityStrng isEqualToString:@""]) {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            _viewForTabie.hidden = false;
        }
        else
        {
        partnerLocation.partCityOutlet.text = @"";
        NSString *lastChar = [partCityStrng substringFromIndex:[partCityStrng length] - 1];
        if ([lastChar isEqualToString:@","]) {
            partCityStrng = [[partCityStrng substringToIndex:[partCityStrng length] - 1] mutableCopy];
        }
        NSString *lastCharId = [partCityIdStrng substringFromIndex:[partCityIdStrng length] - 1];
        if ([lastCharId isEqualToString:@","]) {
            partCityIdStrng = [[partCityIdStrng substringToIndex:[partCityIdStrng length] - 1] mutableCopy];
        }
        partnerLocation.partCityOutlet.text= partCityStrng;
        parCity_Id = partCityIdStrng;
        partCityStrng =[@"" mutableCopy];
        partCityIdStrng =[@"" mutableCopy];
            _viewForTabie.hidden = true;
        }
    }
     else if ([button isEqualToString:@"partnerMTongue"]) {
         if ([partMTongueStrng isEqualToString:@""]) {
             ALERT_DIALOG(@"Alert", @"please select atleast one value");
             _viewForTabie.hidden = false;
         }
         else
         {
         partnerReligiousCell.partnerMTongueTF.text = @"";
         NSString *lastChar = [partMTongueStrng substringFromIndex:[partMTongueStrng length] - 1];
         if ([lastChar isEqualToString:@","]) {
             partMTongueStrng = [[partMTongueStrng substringToIndex:[partMTongueStrng length] - 1] mutableCopy];
         }
         NSString *lastCharId = [partMTongueIdStrng substringFromIndex:[partMTongueIdStrng length] - 1];
         if ([lastCharId isEqualToString:@","]) {
             partMTongueIdStrng = [[partMTongueIdStrng substringToIndex:[partMTongueIdStrng length] - 1] mutableCopy];
         }
         partnerReligiousCell.partnerMTongueTF.text= partMTongueStrng;
         partnerMTongueId = partMTongueIdStrng;
         partMTongueStrng =[@"" mutableCopy];
         partMTongueIdStrng =[@"" mutableCopy];
             _viewForTabie.hidden = true;
         }
     }

//}
    
//    _viewForTabie.hidden = true;
    
    
    
}

- (IBAction)cancelBtnActn:(id)sender {
     [img_select_ary removeAllObjects];
    _viewForTabie.hidden = true;
    
    if ([button isEqualToString:@"lookingForBtn"]) {
        
        lookingForStrng = [@"" mutableCopy];
        
    }
    
    else if ([button isEqualToString:@"partPhysicalStatusBtn"]) {
        partPhysicalStatusStrng = [@"" mutableCopy];
        
    }
    
    else if ([button isEqualToString:@"partMTongueBtn"]) {
        
        partMTongueStrng = [@"" mutableCopy];
        
    }
    
    else if ([button isEqualToString:@"partBodyTypeBtn"]){
        
        partBodyTypeStrng  = [@"" mutableCopy];
        
    }
    
    else if ([button isEqualToString:@"partEatHabitsBtn"]){
        
        partEatHabitsStrng  = [@"" mutableCopy];
        
    }
    else if ([button isEqualToString:@"partDrinkHabitsBtn"]){
        
        partDrinkHabitsStrng  = [@"" mutableCopy];
        
    }
    
    else if ([button isEqualToString:@"partSmokeHabitsBtn"]){
        
        partSmokeHabitsStrng  = [@"" mutableCopy];
        
    }
    else  if ([button isEqualToString:@"partskinToneBtn"])
    {
        
        partSkinToneStrng  = [@"" mutableCopy];
       //  partSkinToneStrng  = [@"" mutableCopy];
        
    }
    
    else if ([button isEqualToString:@"partEducationBtn"]) {
        
        partEducStrng  = [@"" mutableCopy];
        partEduIdStrng  = [@"" mutableCopy];
        
        
    }
    else if ([button isEqualToString:@"partOccupationBtn"]) {
        
              partOcupStrng  = [@"" mutableCopy];
        partOcupIdStrng  = [@"" mutableCopy];
            }
    
    else if ([button isEqualToString:@"partDesignationBtn"]) {
        
        partDesignStrng =[@"" mutableCopy];
        partDesignIdStrng = [@"" mutableCopy];
        
    }
    
    else if ([button isEqualToString:@"partEmplydInBtn"]){

        
        partEmplydInStrng =[@"" mutableCopy];
        
    }
    else if ([button isEqualToString:@"partReligionBtn"]) {
        
        partReligionStrng =[@"" mutableCopy];
        partReligionIdStrng =[@"" mutableCopy];
        
        
    }
    else if ([button isEqualToString:@"partCasteBtn"]) {
        partCasteStrng =[@"" mutableCopy];
        partcsteIdStrng =[@"" mutableCopy];
    }
    else if ([button isEqualToString:@"partStarBtn"]) {
        partStarStrng =[@"" mutableCopy];
        partStarIdStrng =[@"" mutableCopy];
    }
    else if ([button isEqualToString:@"partCountryBtn"]) {
        partCountryStrng =[@"" mutableCopy];
        partCountryIdStrng =[@"" mutableCopy];
    }
    else if ([button isEqualToString:@"partStateBtn"]) {
        partStateStrng =[@"" mutableCopy];
        partStateIdStrng =[@"" mutableCopy];
    }
    else if ([button isEqualToString:@"partDistrictBtn"]) {
        partDistrictStrng =[@"" mutableCopy];
        partDistrictIdStrng =[@"" mutableCopy];
    }
    else if ([button isEqualToString:@"partCityBtn"]) {
        partCityStrng =[@"" mutableCopy];
        partCityIdStrng =[@"" mutableCopy];
    }
    else if ([button isEqualToString:@"partnerMTongue"]) {
        partMTongueStrng =[@"" mutableCopy];
        partMTongueIdStrng =[@"" mutableCopy];
    }
    
    
}

- (IBAction)datePickerDoneBtn:(id)sender {
    
    _viewForDate.hidden = true;
    
    basicCell.userInteractionEnabled = YES;
    // cell1.DOBtF.text = _datePicker.date;
    _viewForDate.hidden = YES;
    
    // string to age
    NSString *dob = basicCell.dobOutlet.text;
    
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
    
    NSLog(@"%@ ,%ld%@ years",dob,(long)age);
    
    if (age<18) {
        
        basicCell.DOBinvalidLbl.text = @"Invalid Date of Birth";
    }
    else
        basicCell.DOBinvalidLbl.text =@"";
    
    basicCell.dobOutlet.text = [NSString stringWithFormat:@"%@ ,%ld%@",dob,(long)age,@" years"];
    

}

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
   // self.ViewPopUp.hidden = YES;
    
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    // dateFormat.dateStyle = NSDateFormatterMediumStyle;
    
    NSString *dateString =  [dateFormat stringFromDate:_datePicker.date];
    basicCell.dobOutlet.text  = dateString;
}

- (IBAction)submitAction:(id)sender {
    // COMMENTED ALL IF CONDITIONS FOR NOT TO VERIFY ALL FIELDS.
    
   if(selectedCell ==cell1)
   {
       profileTextID = cell1.myOwnOutlet.text;
//       if([profileTextID isEqualToString:@""])
//       {
//          // ALERT_DIALOG(@"Alert", @"please enter profile text");
//           profileTextID=@"";
//            _viewForTabie.hidden = true;
//       }
//       else
//       {
       NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"profile_text":profileTextID};
        [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];
      // }
   }
    else if(selectedCell == basicCell)
    {
        lastNameId = basicCell.lastNameOutlet.text;
        birthTimeId = basicCell.birthTimeOutlet.text;
        birthplaceID = basicCell.birthPlaceOutlet.text;
        firstNameId = basicCell.firstNameOutlet.text;
//        if (birthTimeId.length >=6) {
//            ALERT_DIALOG(@"Alert", @"Please enter valid birth time");
//        }
        
//        if ([birthplaceID isEqualToString:@""]||[birthTimeId isEqualToString:@""]||[firstNameId isEqualToString:@""]||[lastNameId isEqualToString:@""]) {
//            ALERT_DIALOG(@"Alert", @"please enter all fields");
//_viewForTabie.hidden = true;
//        }
//        else
//            {
//        else
//        {
                NSDictionary *params =@{@"matri_id":loggedIn_matri_id,@"firstname":firstNameId,@"lastname":lastNameId,@"physical_status":physicalStatusId,@"weight":weightId,@"height":FromHeightID,@"m_status":mStatusId,@"m_tongue":m_ToungId,@"complexion":skintoneId,@"bodytype":bodyTypeId,@"profileby":profileCreatedId,@"diet":eatingHabitsId,@"drink":drinkingHabitsId,@"smoke":smokingHabitsId,@"b_group":bloodGroupId,@"birthplace":birthplaceID,@"birthtime":birthTimeId,@"reference":referencedById};
        
                [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];
//        }
   }
    else if (selectedCell == religiousCell)
    {
//        if(!(caste_Id.length > 0))
//        {
//           _viewForTabie.hidden = true;
//            ALERT_DIALOG(@"Alert", @"Please Enter Caste");
//           // _viewForTabie.hidden = true;
//        }
//        else
//        {
//            if ([subCaste_Id length]>0) {
//                
//            }
//            else{
//                subCaste_Id = @"";
//            }
//            
//            if ([gothramID isEqualToString:@""]||[padamId isEqualToString:@""]||[rmToungId isEqualToString:@""]||[religionId isEqualToString:@""]||[caste_Id isEqualToString:@""]||[manglikId isEqualToString:@""]||[rstar_Id isEqualToString:@""]||[horoscopeId isEqualToString:@""]||[moonsignId isEqualToString:@""]) {
//            ALERT_DIALOG(@"Alert", @"Please Enter All Required Fields");
//                 _viewForTabie.hidden = true;
//            }
//            else
//            {
                NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"m_tongue":rmToungId,@"religion":religionId,@"caste":caste_Id,@"subcaste":subCaste_Id,@"gothra":gothramID,@"padam":padamId,@"manglik":manglikId,@"star":rstar_Id,@"horoscope":horoscopeId,@"moonsign":moonsignId};
                [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];

          //  ALERT_DIALOG(@"Alert", @"religious cell");
//            }
//        }
    }
    else if (selectedCell == educationCell)
    {
//        if ([eduId isEqualToString:@""]||[ocupId isEqualToString:@""]||[desigId isEqualToString:@""]||[employedInId isEqualToString:@""]||[annualIncomeId isEqualToString:@""]||[eduInDetailId isEqualToString:@""])
//        {
//            ALERT_DIALOG(@"Alert", @"Please Enter All Required Fields");
//             _viewForTabie.hidden = true;
//        }
//        else
//        {
            NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"edu_detail":eduId,@"occupation":ocupId,@"designation":desigId,@"emp_in":employedInId,@"income":annualIncomeId,@"edu_indetail":eduInDetailId};
              [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];
            
      //  }
    }
    else if (selectedCell == locationCell)
    {
        adressId = locationCell.adressOutlet.text;
//            if ([adressId isEqualToString:@""]||[countryId isEqualToString:@""]||[stateId isEqualToString:@""]||[district_Id isEqualToString:@""]||[city_Id isEqualToString:@""]||[residenceStatusId isEqualToString:@""]) {
//                ALERT_DIALOG(@"Alert", @"Please Enter All Required Fields");
//                 _viewForTabie.hidden = true;
//            }
//            else
//            {
                NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"address":adressId,@"country_id":countryId,@"state_id":stateId,@"district_id":district_Id,@"city":city_Id,@"residence":residenceStatusId};
                [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];
                
          //  }
       
      
    }
    else if (selectedCell == familyDetailCell)
    {
//        if ([familyTypeId isEqualToString:@""]||[familyStatusId isEqualToString:@""]||[sistersId isEqualToString:@""]||[marriedSistersId isEqualToString:@""]||[brothersId isEqualToString:@""]||[marriedBrothersId isEqualToString:@""]) {
//            ALERT_DIALOG(@"Alert", @"Please Enter All Required Fields");
//             _viewForTabie.hidden = true;
//        }
//        else{
            NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"family_type":familyTypeId,@"family_status":familyStatusId,@"no_of_sisters":sistersId,@"no_marri_sister":marriedSistersId,@"no_of_brothers":brothersId,@"no_marri_brother":marriedBrothersId};
            [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];

     //   }
    }
    else if (selectedCell == aboutFamilyCell)
    {
        aboutMyfamilyId = aboutFamilyCell.aboutMyFamilyTextview.text;
//        if ([aboutMyfamilyId isEqualToString:@""]) {
//             ALERT_DIALOG(@"Alert", @"Please Enter All Required Fields");
//             _viewForTabie.hidden = true;
//        }
//        else
//        {
            NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"family_details":aboutMyfamilyId};
            [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];
       // }
    }
    
    ////// partner preferences submit Action
    
    else if (selectedCell == partnerBasicCell)
    {
//        if ([PartLookingForId isEqualToString:@""]||[partDrinkHabitsId isEqualToString:@""]||[ageFromID isEqualToString:@""]||[ageToId isEqualToString:@""]||[partPhysicalStatusId isEqualToString:@""]||[partHeightId isEqualToString:@""]||[partHeightToId isEqualToString:@""]||[partBodyTypeId isEqualToString:@""]||[partEatHabitsId isEqualToString:@""]||[partSmokeHabitsId isEqualToString:@""]||[partSkinToneId isEqualToString:@""]) {
//            ALERT_DIALOG(@"Alert", @"Please Enter All Required Fields");
//             _viewForTabie.hidden = true;
//        }
//        else
//        {
            NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"looking_for":PartLookingForId,@"part_frm_age":ageFromID,@"part_to_age":ageToId,@"part_phstatus":partPhysicalStatusId,@"part_height":partHeightId,@"part_height_to":partHeightToId,@"part_height_to":partHeightToId,@"part_bodytype":partBodyTypeId,@"part_diet":partEatHabitsId,@"part_drink":partDrinkHabitsId,@"part_smoke":partSmokeHabitsId,@"part_complexion":partSkinToneId};
            [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];
            
       // }
    }
    else if(selectedCell == partnerProfessionCell)
    {

        
      //  eduInDetailId = partnerProfessionCell.partEduInDetailOutlet.text;
//        if ([peduId isEqualToString:@""]||[pOcupId isEqualToString:@""]||[pDesigId isEqualToString:@""]||[partEmplydInId isEqualToString:@""]||[partIncomeId isEqualToString:@""]) {
//             ALERT_DIALOG(@"Alert", @"Please Enter All Required Fields");
//            _viewForTabie.hidden = true;
//        }
//        else
//        {
            NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"part_edu":peduId,@"part_occupation":pOcupId,@"part_designation":pDesigId,@"part_emp_in":partEmplydInId,@"part_income":partIncomeId};
            [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];
       // }
        
    }
    else if (selectedCell == partnerReligiousCell)
    {
//        if ([partMToungId isEqualToString:@""]||[pReligionId isEqualToString:@""]||[pCaste_Id isEqualToString:@""]||[pStar_Id isEqualToString:@""]||[partManglikId isEqualToString:@""]) {
//            ALERT_DIALOG(@"Alert", @"Please Enter All Required Fields");
//             _viewForTabie.hidden = true;
//        }
//        else
//        {
            NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"part_mtongue":partMToungId,@"part_religion":pReligionId,@"part_caste":pCaste_Id,@"part_star":pStar_Id,@"part_manglik":partManglikId};
            [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];

       // }
    }
    else if (selectedCell == partnerLocation)
    {
//        if([partCountryId isEqualToString:@""]||[partStateId isEqualToString:@""]||[parDistrict_Id isEqualToString:@""]||[parCity_Id isEqualToString:@""]||[partResidenceStatusId isEqualToString:@""])
//        {
//            ALERT_DIALOG(@"Alert", @"Please Enter All Required Fields");
//            _viewForTabie.hidden = true;
//        }
//        else
//        {
            NSDictionary * params =@{@"matri_id":loggedIn_matri_id,@"part_country_living":partCountryId,@"part_state":partStateId,@"part_district":parDistrict_Id,@"part_city":parCity_Id,@"part_resi_status":partResidenceStatusId};
            [self popupServiceCallFor_Post:@"services/api/editProfile" params:params];

       // }
    }

}


-(void)idsInitialAllocation:(NSDictionary *)result_Dict
{
    profileTextID = [result_Dict valueForKey:@"profile_text"];
    firstNameId =[result_Dict valueForKey:@"firstname"];
    lastNameId =[result_Dict valueForKey:@"lastname"];
    birthTimeId =[result_Dict valueForKey:@"birthtime"];
    birthplaceID =[result_Dict valueForKey:@"birthplace"];
    physicalStatusId= [result_Dict valueForKey:@"physical_status"];
    
    weightId=[result_Dict valueForKey:@"weight"];
    
     FromHeightID=[result_Dict valueForKey:@"height"];
     mStatusId=[result_Dict valueForKey:@"m_status"];
     skintoneId=[result_Dict valueForKey:@"complexion"];
     bodyTypeId=[result_Dict valueForKey:@"bodytype"];
    
    profileCreatedId=[result_Dict valueForKey:@"profileby"];
    eatingHabitsId=[result_Dict valueForKey:@"diet"];
    drinkingHabitsId=[result_Dict valueForKey:@"drink"];
    smokingHabitsId=[result_Dict valueForKey:@"smoke"];
    bloodGroupId=[result_Dict valueForKey:@"b_group"];
    referencedById=[result_Dict valueForKey:@"reference"];
    manglikId=[result_Dict valueForKey:@"manglik"];
    religionId=[result_Dict valueForKey:@"religion"];
    m_ToungId = [result_Dict valueForKey:@"m_tongue"];
      caste_Id = [result_Dict valueForKey:@"caste"];
     subCaste_Id = [result_Dict valueForKey:@"subcaste"];
    gothramID=[result_Dict valueForKey:@"gothra"];
    padamId = [result_Dict valueForKey:@"padam"];
    horoscopeId=[result_Dict valueForKey:@"horoscope"];
     rmToungId = [result_Dict valueForKey:@"m_tongue"];
     rstar_Id = [result_Dict valueForKey:@"star"];
    moonsignId = [result_Dict valueForKey:@"moonsign"];
    //Education Cell
     eduId = [result_Dict valueForKey:@"edu_detail"];
     ocupId = [result_Dict valueForKey:@"occupation"];
     employedInId = [result_Dict valueForKey:@"emp_in"];
     annualIncomeId = [result_Dict valueForKey:@"income"];
     desigId = [result_Dict valueForKey:@"designation"];
    eduInDetailId = [result_Dict valueForKey:@"edu_indetail"];
    //Location Cell
    adressId=[result_Dict valueForKey:@"address"];
     countryId = [result_Dict valueForKey:@"country_id"];
     stateId = [result_Dict valueForKey:@"state_id"];
     district_Id = [result_Dict valueForKey:@"district_id"];
     city_Id = [result_Dict valueForKey:@"city"];
    residenceStatusId=[result_Dict valueForKey:@"residence"];
    // ,*,*,*,*,*
    familyTypeId = [result_Dict valueForKey:@"family_type"];
    familyStatusId = [result_Dict valueForKey:@"family_status"];
    sistersId = [result_Dict valueForKey:@"no_of_sisters"];
    marriedSistersId = [result_Dict valueForKey:@"no_marri_sister"];
    brothersId = [result_Dict valueForKey:@"no_of_brothers"];
    marriedBrothersId = [result_Dict valueForKey:@"no_marri_brother"];
    aboutMyfamilyId = [result_Dict valueForKey:@"family_details"];
    //
     PartLookingForId = [result_Dict valueForKey:@"looking_for"];
     ageFromID = [result_Dict valueForKey:@"part_frm_age"];
     ageToId = [result_Dict valueForKey:@"part_to_age"];
     partPhysicalStatusId = [result_Dict valueForKey:@"part_phstatus"];
     partHeightId = [result_Dict valueForKey:@"part_height"];
     partHeightToId=[result_Dict valueForKey:@"part_height_to"];
     partBodyTypeId = [result_Dict valueForKey:@"part_bodytype"];
     partEatHabitsId = [result_Dict valueForKey:@"part_diet"];
     partDrinkHabitsId = [result_Dict valueForKey:@"part_drink"];
     partSmokeHabitsId = [result_Dict valueForKey:@"part_smoke"];
     partSkinToneId = [result_Dict valueForKey:@"part_complexion"];
    partnerEduInDetailId=[result_Dict valueForKey:@"part_edu"];
    peduId=[result_Dict valueForKey:@"part_edu"];
    pOcupId=[result_Dict valueForKey:@"part_occupation"];
    pDesigId=[result_Dict valueForKey:@"part_designation"];
    partEmplydInId=[result_Dict valueForKey:@"part_emp_in"];
    partIncomeId = [result_Dict valueForKey:@"part_income"];
    pCaste_Id= [result_Dict valueForKey:@"part_caste"];

     partMToungId = [result_Dict valueForKey:@"part_mtongue"];
     pReligionId = [result_Dict valueForKey:@"part_religion"];

    
     partCountryId = [result_Dict valueForKey:@"part_country_living"];
     partStateId = [result_Dict valueForKey:@"part_state"];
     parDistrict_Id = [result_Dict valueForKey:@"part_district"];
     parCity_Id = [result_Dict valueForKey:@"part_city"];
     partResidenceStatusId=[result_Dict valueForKey:@"part_resi_status"];
    pStar_Id=[result_Dict valueForKey:@"part_star"];
    partManglikId=[result_Dict valueForKey:@"part_manglik"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
   // [textField becomeFirstResponder];
     [textField resignFirstResponder];
    
    return YES;
}

/*
//use for submit method is value is nill
[self checkIDs_Value:m_ToungId];

-(void)checkIDs_Value:(NSString *)idsStrng
{
    if ([idsStrng isEqual:[NSNull null]]||[idsStrng isEqualToString:@"<nil>"]||idsStrng == nil||idsStrng == NULL||[idsStrng isEqualToString:@""]){
        ALERT_DIALOG(@"Alert", @"Value is Nill");
    }
}
*/
@end
