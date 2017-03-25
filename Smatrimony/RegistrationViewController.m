//
//  RegistrationViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 03/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "RegistrationViewController.h"
#import "Register_1.h"
#import "Register_2.h"
#import "Register_3.h"
#import "STParsing.h"
#import "URLS.h"
#import "LoginViewController.h"

@interface RegistrationViewController ()
{
    Register_1 *cell1;
     Register_2 *cell2;
     Register_3 *cell3;
    NSDateFormatter *dateFormat;
    
    NSMutableArray *religionsDict;
    NSMutableArray *languagetArr;
    NSMutableArray *castArr;
    NSMutableArray *sub_castArr;
     NSMutableArray *profileFORArr;
    NSMutableArray *countryArr;
    NSMutableArray *stateArr;
    NSMutableArray *distArr;
     NSMutableArray *cityArr;
    
    NSMutableArray *genderArr;
    NSMutableArray*maritualStatusArr;
     NSMutableArray*heightArr;
    NSMutableArray*heightServiceArr;
    NSMutableArray*weightArr;
    
     NSMutableArray*employedInArr;
    NSMutableArray*AnualIncomeArr;
     NSMutableArray*familyTypeArr;
     NSMutableArray*familyStatusArr;
    
    
    
     NSMutableArray *educationArr;
     NSMutableArray *occupationArr;
     NSMutableArray *disignationArr;

    
    
     NSString *religion_Id;
     NSString *language_Id;
    NSString *caste_Id;
    NSString *sub_caste_Id;
     NSString *country_Id;
    NSString *state_Id;
    NSString *district_Id;
     NSString *city_Id;
     NSString *education_Id;
     NSString *height_Id;
    NSString *occupation_Id;
    NSString *fatherOccupation_Id;
    NSString *motherOccupation_Id;
     NSString *designation_Id;
    
    NSString *checkMobile;

    
    NSString *clicked;
     NSString *validateMobile;
    
    
    
    NSString *registerPage;//to handle page
    NSString *fName,*lName,*email,*Password,*mobileNo,*Dob,*religion,*caste,*subcaste,*profilrFor,*motherTounge;
    
     NSString *country,*state,*district,*city,*residence,*address,*gender,*maritalStatus,*height,*weight;
    
     NSString *education,*employedIn,*occupation,*designation,*annualIncome,*familyType,*familyStatus,*fatherName,*fatherOcupation,*motherName,*motherOccupation;
    
    BOOL passwordShow;
    BOOL keyboardIsShown;
    int scrollHeight;
    
}

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    passwordShow = false;
    registerPage = @"1";
    [_RegisterTableView reloadData];
    
  
    _ViewDatePicker.hidden = YES;
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    
    dateFormat = [[NSDateFormatter alloc] init];
  //  [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setDateFormat:@"MMMM d, YYYY"];
  //  [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    
    
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
   
    
   // self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = [NSDate date];
    cell1.mobileNoTF.delegate = self;
    
    religionsDict = [[NSMutableArray alloc]init];
    languagetArr = [[NSMutableArray alloc]init];
    
    keyboardIsShown = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
   
    
   }

-(void)passwordShowBtnclick
{
    if (passwordShow == YES) {
         cell1.passwordTF.secureTextEntry = YES;
        passwordShow = NO;
    }
    
    else
    {
         cell1.passwordTF.secureTextEntry =NO ;
    passwordShow = YES;
    }
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
    
    if (tableView == _RegisterTableView) {
        return 1;
    }
    
    
    else//popup tableview4656444
        
        
        if ([clicked isEqualToString:@"ReligionClick"]) {
            
            return [religionsDict count];
        }

        
      else  if ([clicked isEqualToString:@"motherToungClick"]) {
          
            return [languagetArr count];
        }
    
    else if ([clicked isEqualToString:@"casteClick"])
    {
        return [castArr count];
    }
    
    else if ([clicked isEqualToString:@"profileForClick"])
    {
        return [profileFORArr count];
    }
    
    else if ([clicked isEqualToString:@"subCasteClick"])
    {
        return [sub_castArr count];
    }
    
    else if ([clicked isEqualToString:@"profileForClick"])
    {
        return [profileFORArr count];
    }
    
    else if ([clicked isEqualToString:@"countryBtnClick"]) {//countrieslist
        
        return [countryArr count];
       
    }
    
    else if ([clicked isEqualToString:@"stateBtnClick"]) {//stateBtnClick
        
       return [stateArr count];
    }
    
    else if ([clicked isEqualToString:@"districtBtnClick"]) {//districtBtnClick
        
        return [distArr count];
    }
    
    else if ([clicked isEqualToString:@"cityBtnClick"]) {//cityBtnClick
        
         return [cityArr count];
           }
    
    else if ([clicked isEqualToString:@"genderBtnClick"]) {//genderBtnClick
        
         return [genderArr count];
       
    }
    
    else if ([clicked isEqualToString:@"MaritalStatusBtnClick"]) {//MaritalStatusBtnClick
         return [maritualStatusArr count];
       
    }
    
    else if ([clicked isEqualToString:@"heightBtnClick"]) {//heightBtnClick
        
        return [heightArr count];
    }
    
    else if ([clicked isEqualToString:@"weightBtnClick"]) {//weightBtnClick
        
         return [weightArr count];
       
    }
    
    else if ([clicked isEqualToString:@"educationBtnClick"]) {//
        
        return [educationArr count];
        
    }
    
    else if ([clicked isEqualToString:@"employedIn_BtnClick"]) {//
        
        return [employedInArr count];
        
    }
    
    else if ([clicked isEqualToString:@"designationBtnClick"]) {//
        
        return [disignationArr count];
        
    }
    
    else if ([clicked isEqualToString:@"incomeBtnClick"]) {//
        
        return [AnualIncomeArr count];
        
    }
    
    else if ([clicked isEqualToString:@"familyTypeBtnClick"]) {//
        
        return [familyTypeArr count];
        
    }
    
    else if ([clicked isEqualToString:@"familyStatusBtnClick"]) {//
        
        return [familyStatusArr count];
        
    }
    
    
    else if ([clicked isEqualToString:@"occupationBtnClick"]) {//
        
        return [occupationArr count];
        
    }
    
    else if ([clicked isEqualToString:@"fatherOccupationBtnClick"]) {//
        
        return [occupationArr count];
        
    }
    
    else if ([clicked isEqualToString:@"motherOccupationBtnClick"]) {//
        
        return [occupationArr count];
        
    }

    
   else
       return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (tableView == _PopUpTableView) {
         
         static NSString *MyIdentifier = @"MyIdentifier";
         
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
         
         if (cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
         }
         if (religionsDict.count>0 && [clicked isEqualToString:@"ReligionClick"]) {
             
         
          cell.textLabel.text =[[religionsDict objectAtIndex:indexPath.row]valueForKey:@"religion_name"];
         }
        else if (languagetArr.count>0 && [clicked isEqualToString:@"motherToungClick"]) {
             
             
             cell.textLabel.text =[[languagetArr objectAtIndex:indexPath.row]valueForKey:@"mtongue_name"];
         }
         
        else if (castArr.count>0 && [clicked isEqualToString:@"casteClick"]) {
            
            cell.textLabel.text =[[castArr objectAtIndex:indexPath.row]valueForKey:@"caste_name"];
        }
        else if (sub_castArr.count>0 && [clicked  isEqualToString:@"subCasteClick"]) {
            
            cell.textLabel.text =[[sub_castArr objectAtIndex:indexPath.row]valueForKey:@"subcaste_name"];
        }
         
        else if ( [clicked isEqualToString:@"profileForClick"]) {
            
            cell.textLabel.text =[profileFORArr objectAtIndex:indexPath.row];
        }
         
        else if (countryArr.count>0 &&[clicked isEqualToString:@"countryBtnClick"]) {//countrieslist
            
            cell.textLabel.text =[[countryArr objectAtIndex:indexPath.row] valueForKey:@"country_name"];
            
            
        }
         
        else if (stateArr.count>0 &&[clicked isEqualToString:@"stateBtnClick"]) {//stateBtnClick
            
             cell.textLabel.text =[[stateArr objectAtIndex:indexPath.row] valueForKey:@"state_name"];
            
                    }
         
        else if (distArr.count>0 &&[clicked isEqualToString:@"districtBtnClick"]) {//districtBtnClick
             cell.textLabel.text =[[distArr objectAtIndex:indexPath.row] valueForKey:@"district_name"];
           
        }
         
        else if (cityArr.count>0 &&[clicked isEqualToString:@"cityBtnClick"]) {//cityBtnClick
            
            cell.textLabel.text =[[cityArr objectAtIndex:indexPath.row] valueForKey:@"city_name"];
        }
         
        else if ([clicked isEqualToString:@"genderBtnClick"]) {//genderBtnClick
            
             cell.textLabel.text =[genderArr objectAtIndex:indexPath.row];
            
        }
         
        else if ([clicked isEqualToString:@"MaritalStatusBtnClick"]) {//MaritalStatusBtnClick
            
             cell.textLabel.text =[maritualStatusArr objectAtIndex:indexPath.row];
           
                    }
         
        else if ([clicked isEqualToString:@"heightBtnClick"]) {//heightBtnClick
              cell.textLabel.text =[heightArr objectAtIndex:indexPath.row];
                    }
         
        else if ([clicked isEqualToString:@"weightBtnClick"]) {//weightBtnClick
            
            cell.textLabel.text =[NSString stringWithFormat:@"%@ Kg",[weightArr objectAtIndex:indexPath.row]];
            
        }
         
      //cell 3 buttons
         
        else if (educationArr.count>0 &&[clicked isEqualToString:@"educationBtnClick"]) {//districtBtnClick
            
            cell.textLabel.text =[[educationArr objectAtIndex:indexPath.row] valueForKey:@"edu_name"];
            
        }
         
       
        else if (employedInArr.count>0 &&[clicked isEqualToString:@"employedIn_BtnClick"]) {//districtBtnClick
            
            cell.textLabel.text =[employedInArr objectAtIndex:indexPath.row];
            
        }
         
         
         
        else if (familyTypeArr.count>0 &&[clicked isEqualToString:@"familyTypeBtnClick"]) {//
            
            cell.textLabel.text =[familyTypeArr objectAtIndex:indexPath.row];
            
        }
        else if (familyStatusArr.count>0 &&[clicked isEqualToString:@"familyStatusBtnClick"]) {//
            
            cell.textLabel.text =[familyStatusArr objectAtIndex:indexPath.row];
            
        }
         
        else if (occupationArr.count>0 &&[clicked isEqualToString:@"occupationBtnClick"]) {//districtBtnClick
            
            cell.textLabel.text =[[occupationArr objectAtIndex:indexPath.row] valueForKey:@"ocp_name"];
            
        }
         
        else if (disignationArr.count>0 &&[clicked isEqualToString:@"designationBtnClick"]) {//districtBtnClick
            
            cell.textLabel.text =[[disignationArr objectAtIndex:indexPath.row] valueForKey:@"desg_name"];
            
        }
         
         
         
        else if (occupationArr.count>0 &&[clicked isEqualToString:@"fatherOccupationBtnClick"]) {//districtBtnClick
            
            cell.textLabel.text =[[occupationArr objectAtIndex:indexPath.row] valueForKey:@"ocp_name"];
            
        }
         
        else if (occupationArr.count>0 &&[clicked isEqualToString:@"motherOccupationBtnClick"]) {//districtBtnClick
            
            cell.textLabel.text =[[occupationArr objectAtIndex:indexPath.row] valueForKey:@"ocp_name"];
            
        }
         
         
         /*
          educationBtnClick
          employedIn_BtnClick
          occupationBtnClick
          designationBtnClick
          incomeBtnClick
          familyTypeBtnClick
          familyStatusBtnClick
          fatherOccupationBtnClick
          motherOccupationBtnClick
          */
         
        
         
         
         return cell;

     }
    
     else{
    
    if ([registerPage isEqualToString:@"1"]) {
        
    
    static NSString *simpleTableIdentifier = @"Register1";
    
    cell1 = (Register_1 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
        cell1.mobileNoTF.delegate = self;

    if (cell1 == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Register_1" owner:self options:nil];
        cell1 = (Register_1 *)[nib objectAtIndex:0];
        
    }
         [cell1.religionBtnOutlet addTarget:self action:@selector(ReligionClick) forControlEvents:UIControlEventTouchUpInside];
        
         [cell1.motherToung addTarget:self action:@selector(motherToungClick) forControlEvents:UIControlEventTouchUpInside];
        
         [cell1.caste addTarget:self action:@selector(casteClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell1.profileFor addTarget:self action:@selector(profileForClick) forControlEvents:UIControlEventTouchUpInside];
        
          [cell1.dateOfBirth addTarget:self action:@selector(dateOfBirthClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell1.subCaste addTarget:self action:@selector(subCasteClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell1.passwordShowBtn addTarget:self action:@selector(passwordShowBtnclick) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        // first cell details
        
        
        //fname
       if ([fName isEqual:[NSNull null]]||[fName isEqualToString:@"<nil>"]||fName == nil||fName == NULL||[fName isEqualToString:@""]) {
                   }
        else
        {
             cell1.firstNameTF.text = fName;
        }
        
         //lname
       if ([lName isEqual:[NSNull null]]||[lName isEqualToString:@"<nil>"]||lName == nil||lName == NULL||[lName isEqualToString:@""]) {
           
        }
        
       else
       {
            cell1.lastNameTF.text = lName;
       }
        
        //email
        if ([email isEqual:[NSNull null]]||[email isEqualToString:@"<nil>"]||email == nil||email == NULL||[email isEqualToString:@""]) {
            
            
        }
        else
        {
            cell1.emailTF.text = email;
        }
       // password
        if ([Password isEqual:[NSNull null]]||[Password isEqualToString:@"<nil>"]||Password == nil||Password == NULL||[Password isEqualToString:@""]) {
            
            
        }
        
        else
        {
            cell1.passwordTF.text = Password;
        }
        
        //mobile
        if ([mobileNo isEqual:[NSNull null]]||[mobileNo isEqualToString:@"<nil>"]||mobileNo == nil||mobileNo == NULL||[mobileNo isEqualToString:@""]) {
            
                    }
        
        else
        {
            cell1.mobileNoTF.text = mobileNo;
        }
//dob
        if ([Dob isEqual:[NSNull null]]||[Dob isEqualToString:@"<nil>"]||Dob == nil||Dob == NULL||[Dob isEqualToString:@""]) {
            
            
        }
        
        else
        {
            cell1.DOBtF.text = Dob;
        }
//religion
        if ([religion isEqual:[NSNull null]]||[religion isEqualToString:@"<nil>"]||religion == nil||religion == NULL||[religion isEqualToString:@""]) {
            
            
        }
        
        else
        {
            cell1.religionTF.text = religion;
        }
//caste
        if ([caste isEqual:[NSNull null]]||[caste isEqualToString:@"<nil>"]||caste == nil||caste == NULL||[caste isEqualToString:@""]) {
            
            
        }
        
        else
        {
            cell1.castTF.text = caste;
        }

//profile for
        
        if ([profilrFor isEqual:[NSNull null]]||[profilrFor isEqualToString:@"<nil>"]||profilrFor == nil||profilrFor == NULL||[profilrFor isEqualToString:@""]) {
            
            
        }
        
        else
        {
            cell1.profileForTF.text = profilrFor;
        }
//mother tounge
        
        if ([motherTounge isEqual:[NSNull null]]||[motherTounge isEqualToString:@"<nil>"]||motherTounge == nil||motherTounge == NULL||[motherTounge isEqualToString:@""]) {
            
            
        }
        
        else
        {
            cell1.motherToungeTF.text = motherTounge;
        }

        
        
        
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell1;

}
   else if ([registerPage isEqualToString:@"2"]) {
        
        
        static NSString *simpleTableIdentifier = @"Register2";
        
        cell2 = (Register_2 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        
        if (cell2 == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Register_2" owner:self options:nil];
            cell2 = (Register_2 *)[nib objectAtIndex:0];
         
        }
       

       
//       countryBtnClick
//       stateBtnClick
//       districtBtnClick
//       cityBtnClick
//       genderBtnClick
//       MaritalStatusBtnClick
//       heightBtnClick
//       weightBtnClick
       
       
        [cell2.countryBtn addTarget:self action:@selector(countryBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
        [cell2.stateBtn addTarget:self action:@selector(stateBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       [cell2.districtBtn addTarget:self action:@selector(districtBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       [cell2.cityBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [cell2.genderBtn addTarget:self action:@selector(genderBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       [cell2.MaritalStatusBtn addTarget:self action:@selector(MaritalStatusBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       [cell2.heightBtn addTarget:self action:@selector(heightBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       [cell2.weightBtn addTarget:self action:@selector(weightBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
       
       
         cell2.countryTF.text = country;
         cell2.stateTF.text =  state;
         cell2.districtTF.text=district;
         cell2.cityTf.text=city;
         cell2.residenceTF.text=residence;
         cell2.addressTF.text=address;
         cell2.genderTF.text=gender;
         cell2.maritualTF.text=maritalStatus;
         cell2.heightTF.text=height;
         cell2.weightTF.text=weight;
       
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;

    }
    else
    {
        
        static NSString *simpleTableIdentifier = @"Register3";
        
        cell3 = (Register_3 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        /*
        educationBtnClick
        employedIn_BtnClick
        occupationBtnClick
        designationBtnClick
        incomeBtnClick
        familyTypeBtnClick
        familyStatusBtnClick
        fatherOccupationBtnClick
        motherOccupationBtnClick
         */
        
        if (cell3 == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Register_3" owner:self options:nil];
            cell3 = (Register_3 *)[nib objectAtIndex:0];
            
             [cell3.educationBtn addTarget:self action:@selector(educationBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
             [cell3.employedIn_Btn addTarget:self action:@selector(employedIn_BtnClick) forControlEvents:UIControlEventTouchUpInside];
            
              [cell3.occupationBtn addTarget:self action:@selector(occupationBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
              [cell3.designationBtn addTarget:self action:@selector(designationBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [cell3.incomeBtn addTarget:self action:@selector(incomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
             [cell3.familyTypeBtn addTarget:self action:@selector(familyTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [cell3.familyStatusBtn addTarget:self action:@selector(familyStatusBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [cell3.fatherOccupationBtn addTarget:self action:@selector(fatherOccupationBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
             [cell3.motherOccupationBtn addTarget:self action:@selector(motherOccupationBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            cell3.educationTF.text = education;
            cell3.employedTF.text =  employedIn;
            cell3.ocupationTF.text=occupation;
            cell3.designationTF.text=designation;
            cell3.annualIncomeTF.text=annualIncome;
            cell3.familyTF.text=familyType;
            cell3.familyStatusTF.text=familyStatus;
            cell3.fatherNameTF.text=fatherName;
            cell3.fatherOccupationTF.text=fatherOcupation;
            cell3.motherNameTF.text=motherName;
             cell3.motherOccupationTF.text=motherOccupation;
            
            
        }
        
         cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell3;
        
    }
}
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _RegisterTableView) {
         return 520;
    }
    else
        return 44;
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _PopUpTableView) {
        
        if ([clicked isEqualToString:@"ReligionClick"]) {
            
            cell1.religionTF.text =  [[religionsDict objectAtIndex:indexPath.row] valueForKey:@"religion_name"];
            religion_Id = [[religionsDict objectAtIndex:indexPath.row] valueForKey:@"religion_id"];
           
        }
        
        else if ([clicked isEqualToString:@"motherToungClick"]) {
            
             cell1.motherToungeTF.text = [[languagetArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_name"];
            language_Id = [[languagetArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_id"];
            
        }
        
        else if ([clicked isEqualToString:@"casteClick"]) {
            
            cell1.castTF.text = [[castArr objectAtIndex:indexPath.row] valueForKey:@"caste_name"];
            caste_Id = [[castArr objectAtIndex:indexPath.row] valueForKey:@"caste_id"];
            
            }
        else if ([clicked isEqualToString:@"subCasteClick"]) {
            
            cell1.subCasteTF.text = [[sub_castArr objectAtIndex:indexPath.row] valueForKey:@"subcaste_name"];
            sub_caste_Id = [[sub_castArr objectAtIndex:indexPath.row] valueForKey:@"subcaste_id"];
            
        }
        
        
        else if ([clicked isEqualToString:@"profileForClick"]) {
            
            cell1.profileForTF.text = [profileFORArr objectAtIndex:indexPath.row];
            
        }
        
     
        
    
    
    // cell 2
    
    else if ([clicked isEqualToString:@"countryBtnClick"]) {//countrieslist
        
        cell2.countryTF.text = [[countryArr objectAtIndex:indexPath.row] valueForKey:@"country_name"];
        
         country_Id = [[countryArr objectAtIndex:indexPath.row] valueForKey:@"country_id"];
        
        
    }
    
    else if ([clicked isEqualToString:@"stateBtnClick"]) {//stateBtnClick
        
        cell2.stateTF.text = [[stateArr objectAtIndex:indexPath.row] valueForKey:@"state_name"];
        
        state_Id = [[stateArr objectAtIndex:indexPath.row] valueForKey:@"state_id"];
        
        
    }
    
    else if ([clicked isEqualToString:@"districtBtnClick"]) {//districtBtnClick
        
        cell2.districtTF.text = [[distArr objectAtIndex:indexPath.row] valueForKey:@"district_name"];
        
        district_Id = [[distArr objectAtIndex:indexPath.row] valueForKey:@"district_id"];
        
    }
    
    else if ([clicked isEqualToString:@"cityBtnClick"]) {//cityBtnClick
        
        cell2.cityTf.text = [[cityArr objectAtIndex:indexPath.row] valueForKey:@"city_name"];
        
        city_Id = [[cityArr objectAtIndex:indexPath.row] valueForKey:@"city_id"];
        
        
    }
    
    else if ([clicked isEqualToString:@"genderBtnClick"]) {//genderBtnClick
        
         cell2.genderTF.text = [genderArr objectAtIndex:indexPath.row];
        
    }
    
    else if ([clicked isEqualToString:@"MaritalStatusBtnClick"]) {//MaritalStatusBtnClick
        
         cell2.maritualTF.text = [maritualStatusArr objectAtIndex:indexPath.row];
        
        
    }
    
    else if ([clicked isEqualToString:@"heightBtnClick"]) {//heightBtnClick
        
        cell2.heightTF.text = [heightArr objectAtIndex:indexPath.row];
        
       height_Id= [heightServiceArr objectAtIndex:indexPath.row];
        
    }
    
    else if ([clicked isEqualToString:@"weightBtnClick"]) {//weightBtnClick
        
        cell2.weightTF.text = [NSString stringWithFormat:@"%@ Kg",[weightArr objectAtIndex:indexPath.row]];
        
    }
        
        //cell 3
    else if ([clicked isEqualToString:@"educationBtnClick"]) {//cityBtnClick
        
        cell3.educationTF.text = [[educationArr objectAtIndex:indexPath.row] valueForKey:@"edu_name"];
        
        education_Id = [[educationArr objectAtIndex:indexPath.row] valueForKey:@"edu_id"];
        
        
    }
        
    else if ([clicked isEqualToString:@"employedIn_BtnClick"]) {//cityBtnClick
        
        cell3.employedTF.text = [employedInArr objectAtIndex:indexPath.row];
        
        
    }
        
    else if ([clicked isEqualToString:@"occupationBtnClick"]) {//cityBtnClick
        
                cell3.ocupationTF.text = [[occupationArr objectAtIndex:indexPath.row] valueForKey:@"ocp_name"];
        
                occupation_Id = [[occupationArr objectAtIndex:indexPath.row] valueForKey:@"ocp_id"];
        
        
    }
        
    else if ([clicked isEqualToString:@"designationBtnClick"]) {//
        
        cell3.designationTF.text = [[disignationArr objectAtIndex:indexPath.row] valueForKey:@"desg_name"];
        
        designation_Id = [[disignationArr objectAtIndex:indexPath.row] valueForKey:@"desg_id"];
        
        
    }
        
    else if ([clicked isEqualToString:@"fatherOccupationBtnClick"]) {//cityBtnClick
        
        cell3.fatherOccupationTF.text = [[occupationArr objectAtIndex:indexPath.row] valueForKey:@"ocp_name"];
        
        fatherOccupation_Id = [[occupationArr objectAtIndex:indexPath.row] valueForKey:@"ocp_id"];
        
        
    }
        
    else if ([clicked isEqualToString:@"motherOccupationBtnClick"]) {//cityBtnClick
        
        cell3.motherOccupationTF.text = [[occupationArr objectAtIndex:indexPath.row] valueForKey:@"ocp_name"];
        
        motherOccupation_Id = [[occupationArr objectAtIndex:indexPath.row] valueForKey:@"ocp_id"];
        
        
    }
        
    else if (familyTypeArr.count>0 &&[clicked isEqualToString:@"familyTypeBtnClick"]) {//
        
       cell3.familyTF.text =[familyTypeArr objectAtIndex:indexPath.row];
        
    }
    else if (familyStatusArr.count>0 &&[clicked isEqualToString:@"familyStatusBtnClick"]) {//
        
       cell3.familyStatusTF.text =[familyStatusArr objectAtIndex:indexPath.row];
        
    }
        
        //cell 3
        
        /*
         educationBtnClick
         employedIn_BtnClick
         occupationBtnClick
         designationBtnClick
         incomeBtnClick
         familyTypeBtnClick
         familyStatusBtnClick
         fatherOccupationBtnClick
         motherOccupationBtnClick
         */
        
       
    
    _ViewPopUp.hidden = YES;

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

- (IBAction)ContinueBtnActn:(id)sender {
    
    if ([registerPage isEqualToString:@"1"]) {
       
        if ([self valide_Email]== YES && [cell1.DOBinvalidLbl.text isEqualToString:@""])//Invalid Date of Birth
            
        {
            if (cell1.firstNameTF.text.length == 0 ||cell1.lastNameTF.text.length == 0 ||cell1.passwordTF.text.length == 0 ||cell1.mobileNoTF.text.length == 0 ||cell1.DOBtF.text.length == 0||cell1.religionTF.text.length == 0||cell1.castTF.text.length == 0 ||cell1.profileForTF.text.length == 0||cell1.motherToungeTF.text.length == 0) {
                
                ALERT_DIALOG(@"Alert", @"Please enter required fields");
                
            }
            
            else if (cell1.mobileNoTF.text.length <= 9)
            {
                 ALERT_DIALOG(@"Alert", @"Invalid mobile Number");
            }
            
            else if (cell1.passwordTF.text.length <= 5)
            {
                ALERT_DIALOG(@"Alert", @"password should be minimum 6 characters");
            }
            
            else{
            
            fName = cell1.firstNameTF.text;
            lName = cell1.lastNameTF.text;
            email = cell1.emailTF.text;
            Password = cell1.passwordTF.text;
            mobileNo = cell1.mobileNoTF.text;
            Dob = cell1.DOBtF.text;
            religion = cell1.religionTF.text;
            caste = cell1.castTF.text;
            subcaste = cell1.subCasteTF.text;
            profilrFor = cell1.profileForTF.text;
            motherTounge = cell1.motherToungeTF.text;
                NSString *emailToValidate;
                
                if (cell1.emailTF.text.length==0) {
                    
                    emailToValidate = @"";
                }
                
                else
                {
                    emailToValidate = cell1.emailTF.text;
                }
            checkMobile = @"yes";
                
    NSDictionary *params = @{@"email":emailToValidate,@"mobile":cell1.mobileNoTF.text};
                
        [self popupServiceCallFor_Post:@"services/api/checkAccount" params:params];
                
          //showed at service success page
//            registerPage = @"2";
//            [_RegisterTableView reloadData];
                
            }
            
        }
        
        else{
            
            if ([cell1.DOBinvalidLbl.text isEqualToString:@""]) {
                 ALERT_DIALOG(@"Alert", @"Age should be atleast 18 years old");
                            }
            
           
        }
    }
    
    else if ([registerPage isEqualToString:@"2"])
    {
                    if (cell2.countryTF.text.length == 0 ||cell2.stateTF.text.length == 0 ||cell2.districtTF.text.length == 0 ||cell2.cityTf.text.length == 0 ||cell2.residenceTF.text.length == 0||cell2.addressTF.text.length == 0||cell2.genderTF.text.length == 0 ||cell2.maritualTF.text.length == 0||cell2.heightTF.text.length == 0 ||cell2.weightTF.text.length == 0) {
                        
                        ALERT_DIALOG(@"Alert", @"please enter Required Fields");
                        
                    }
        
        else if ([cell2.countryTF.text isEqualToString:@"No Data found"])
        {
            
        }
        
        else if ([cell2.stateTF.text isEqualToString:@"No Data found"])
        {
            ALERT_DIALOG(@"Alert", @"No states avilable for selected Country");
        }
        
        else if ([cell2.districtTF.text isEqualToString:@"No Data found"])
        {
            
            ALERT_DIALOG(@"Alert", @"No Districts avilable for selected State");
            
        }
        
        else if ([cell2.cityTf.text isEqualToString:@"No Data found"])
        {
            
             ALERT_DIALOG(@"Alert", @"No Cities avilable for selected Districts");
            
        }

        
        
        
        else
        {
        
        country = cell2.countryTF.text;
        state = cell2.stateTF.text;
        district = cell2.districtTF.text;
        city = cell2.cityTf.text;
        residence = cell2.residenceTF.text;
        address = cell2.addressTF.text;
        gender = cell2.genderTF.text;
        maritalStatus = cell2.maritualTF.text;
        height = cell2.heightTF.text;
        weight = cell2.weightTF.text;

        
            registerPage = @"3";
         [_RegisterTableView reloadData];
            
        }
    }
    
    else
    {
        
         if (cell3.educationTF.text.length == 0 ||cell3.employedTF.text.length == 0 ||cell3.ocupationTF.text.length == 0 ||cell3.designationTF.text.length == 0 ||cell3.annualIncomeTF.text.length == 0||cell3.familyTF.text.length == 0||cell3.familyStatusTF.text.length == 0 ||cell3.fatherNameTF.text.length == 0||cell3.motherNameTF.text.length == 0 ||cell3.motherOccupationTF.text.length == 0) {
             
              ALERT_DIALOG(@"Alert", @"please enter Required Fields");
             
         }
        
        else
        {
        education = cell3.educationTF.text;
        employedIn = cell3.employedTF.text;
        occupation = cell3.ocupationTF.text;
        designation = cell3.designationTF.text;
        annualIncome = cell3.annualIncomeTF.text;
        familyType = cell3.familyTF.text;
        familyStatus = cell3.familyStatusTF.text;
        fatherName = cell3.fatherNameTF.text;
        fatherOcupation = cell3.fatherOccupationTF.text;
        motherName = cell3.motherNameTF.text;
         motherOccupation = cell3.motherOccupationTF.text;
       
        
        [self RegisterServiceCall];
            
        }
    }
    
   
}

- (IBAction)backClick:(id)sender {
    
    if ([registerPage isEqualToString:@"3"]) {
        registerPage = @"2";
        
        education = cell3.educationTF.text;
        employedIn = cell3.employedTF.text;
        occupation = cell3.ocupationTF.text;
        designation = cell3.designationTF.text;
        annualIncome = cell3.annualIncomeTF.text;
        familyType = cell3.familyTF.text;
        familyStatus = cell3.familyStatusTF.text;
        fatherName = cell3.fatherNameTF.text;
        fatherOcupation = cell3.fatherOccupationTF.text;
        motherName = cell3.motherNameTF.text;
        motherOccupation = cell3.motherOccupationTF.text;
        
        [_RegisterTableView reloadData];
    }
    
    else if ([registerPage isEqualToString:@"2"]) {
        registerPage = @"1";
        
        country = cell2.countryTF.text;
        state = cell2.stateTF.text;
        district = cell2.districtTF.text;
        city = cell2.cityTf.text;
        residence = cell2.residenceTF.text;
        address = cell2.addressTF.text;
        gender = cell2.genderTF.text;
        maritalStatus = cell2.maritualTF.text;
        height = cell2.heightTF.text;
        weight = cell2.weightTF.text;
        
        [_RegisterTableView reloadData];
    }
    else
    {
        
        fName = cell1.firstNameTF.text;
        lName = cell1.lastNameTF.text;
        email = cell1.emailTF.text;
        Password = cell1.passwordTF.text;
        mobileNo = cell1.mobileNoTF.text;
        Dob = cell1.DOBtF.text;
        religion = cell1.religionTF.text;
        caste = cell1.castTF.text;
        subcaste = cell1.subCasteTF.text;
        profilrFor = cell1.profileForTF.text;
        motherTounge = cell1.motherToungeTF.text;

        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}



- (IBAction)datePicker_DoneBtnActn:(id)sender {
    cell1.userInteractionEnabled = YES;
   // cell1.DOBtF.text = _datePicker.date;
    _ViewDatePicker.hidden = YES;
    
    // string to age
    NSString *dob = cell1.DOBtF.text;

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
        
        cell1.DOBinvalidLbl.text = @"Invalid Date of Birth";
    }
    else
        cell1.DOBinvalidLbl.text =@"";
  
     cell1.DOBtF.text = [NSString stringWithFormat:@"%@ ,%ld%@",dob,(long)age,@" years"];
  
}

 #pragma mark - Button Clicks

-(void)ReligionClick
{
   
    clicked = @"ReligionClick";
    cell1.castTF.text = @"";
     [self popupsServiceHandiler];
}

-(void)motherToungClick
{
   
     clicked = @"motherToungClick";
    cell1.castTF.text = @"";
     [self popupsServiceHandiler];
}

-(void)casteClick
{
    if ([cell1.motherToungeTF.text isEqualToString:@""]||[cell1.religionTF.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"Please select Religion And Mother Tounge");
    }
    else
    {
    clicked = @"casteClick";
        cell1.subCasteTF.text = @"";
     [self popupsServiceHandiler];
    }
}

-(void)profileForClick
{
    
    clicked = @"profileForClick";
    _ViewDatePicker.hidden = YES;
    
     [self popupsServiceHandiler];
    [_PopUpTableView reloadData];
    self.ViewPopUp.hidden = false;

   
}

-(void)dateOfBirthClick
{
    cell1.userInteractionEnabled = false;
    cell1.DOBtF.inputView = _datePicker;
     _ViewDatePicker.hidden = false;
    self.ViewPopUp.hidden = YES;
    
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *dateString =  [dateFormat stringFromDate:_datePicker.date];
    cell1.DOBtF.text  = dateString;
    
}

-(void)subCasteClick
{
    clicked = @"subCasteClick";
    if ([cell1.castTF.text isEqualToString:@""]||[cell1.castTF.text isEqualToString:@"No Data found"]) {
        ALERT_DIALOG(@"Alert", @"please select Caste");
        
    }
    else
    {
    
    [self popupsServiceHandiler];
        
    }
    
}


-(void)countryBtnClick
{
    clicked = @"countryBtnClick";
    
    cell2.stateTF.text = @"";
    cell2.districtTF.text = @"";
    cell2.cityTf.text = @"";
    
    [self popupsServiceHandiler];
}

-(void)stateBtnClick
{
    clicked = @"stateBtnClick";
    cell2.districtTF.text = @"";
    cell2.cityTf.text = @"";
    
    if ([cell2.countryTF.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"please select Country ");
        
    }
    
    else
    [self popupsServiceHandiler];
    
}

-(void)districtBtnClick
{
    
    clicked = @"districtBtnClick";
     cell2.cityTf.text = @"";
    
    if ([cell2.countryTF.text isEqualToString:@""]||[cell2.stateTF.text isEqualToString:@""]||[cell2.stateTF.text isEqualToString:@"No Data found"]) {
        
        ALERT_DIALOG(@"Alert", @"Please Select Country And State");
        
    }
    
    else
        [self popupsServiceHandiler];
    
}

-(void)cityBtnClick
{
    clicked = @"cityBtnClick";
    
    if ([cell2.countryTF.text isEqualToString:@""]||[cell2.stateTF.text isEqualToString:@""]||[cell2.districtTF.text isEqualToString:@""]||[cell2.districtTF.text isEqualToString:@"No Data found"]) {
        
        ALERT_DIALOG(@"Alert", @"Please Select District");
        
    }
    
    else
        [self popupsServiceHandiler];
    
    }

-(void)genderBtnClick
{
    clicked = @"genderBtnClick";
    
     [self popupsServiceHandiler];
}

-(void)MaritalStatusBtnClick
{
    clicked = @"MaritalStatusBtnClick";
     [self popupsServiceHandiler];
}

-(void)heightBtnClick
{
    clicked = @"heightBtnClick";
     [self popupsServiceHandiler];
}

-(void)weightBtnClick
{
    clicked = @"weightBtnClick";
     [self popupsServiceHandiler];
}

//       countryBtnClick
//       stateBtnClick
//       districtBtnClick
//       cityBtnClick
//       genderBtnClick
//       MaritalStatusBtnClick
//       heightBtnClick
//       weightBtnClick

//cell 3 buttons

/*
 educationBtnClick
 employedIn_BtnClick
 occupationBtnClick
 designationBtnClick
 incomeBtnClick
 familyTypeBtnClick
 familyStatusBtnClick
 fatherOccupationBtnClick
 motherOccupationBtnClick
 */

-(void)educationBtnClick
{
    clicked = @"educationBtnClick";
    [self popupsServiceHandiler];
}

-(void)employedIn_BtnClick
{
    clicked = @"employedIn_BtnClick";
    [self popupsServiceHandiler];
}

-(void)occupationBtnClick
{
    clicked = @"occupationBtnClick";
    [self popupsServiceHandiler];
}

-(void)designationBtnClick
{
    clicked = @"designationBtnClick";
    [self popupsServiceHandiler];
}

-(void)incomeBtnClick
{
    clicked = @"incomeBtnClick";
    [self popupsServiceHandiler];
}

-(void)familyTypeBtnClick
{
    clicked = @"familyTypeBtnClick";
    [self popupsServiceHandiler];
}

-(void)familyStatusBtnClick
{
    clicked = @"familyStatusBtnClick";
    [self popupsServiceHandiler];
}

-(void)fatherOccupationBtnClick
{
    clicked = @"fatherOccupationBtnClick";
    [self popupsServiceHandiler];
}

-(void)motherOccupationBtnClick
{
    clicked = @"motherOccupationBtnClick";
    [self popupsServiceHandiler];
}


- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
  self.ViewPopUp.hidden = YES;
 
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
   
   // dateFormat.dateStyle = NSDateFormatterMediumStyle;
    
    NSString *dateString =  [dateFormat stringFromDate:_datePicker.date];
   cell1.DOBtF.text  = dateString;
}




-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL)valide_Email
{
    NSString *email_str = [cell1.emailTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if  ( [email_str length]==0)
    {
       // [self Alert :@"Email should not be empty."];
        return YES;
    }
    
    else
    {
     if ([self NSStringIsValidEmail:email_str]== NO)
    {
        [self Alert :@"Email should be valid."];
        return NO;
    }
    }
    return YES;
}



- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (cell1.mobileNoTF) {
        
    
    
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 10;
    }
    else return 0;
}

-(void)viewDidAppear:(BOOL)animated{
    
   //  scrollHeight = self.view.frame.size.height;
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
    viewFrame.size.height -= (keyboardSize.height - 0);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}
 #pragma mark - service Calls



-(void)popupsServiceHandiler
{
    _ViewDatePicker.hidden = YES;
    self.ViewPopUp.hidden = false;
    self.PopUpTableView.hidden = false;
    [self.view endEditing:YES];
    
    if ([clicked isEqualToString:@"ReligionClick"]) {
        
        [self popupServiceCall:@"services/api/dropdownlist"];

        }
    
   else if ([clicked isEqualToString:@"motherToungClick"]) {
        
        [self popupServiceCall:@"services/api/dropdownlist"];
        
    }
    
   else if ([clicked isEqualToString:@"casteClick"]) {
       
        NSDictionary *params = @{@"religion_id": religion_Id,@"m_tongue":language_Id};
       
        [self popupServiceCallFor_Post:@"services/api/casteList" params:params];
       
   }
    
   else if ([clicked isEqualToString:@"subCasteClick"]) {
       
       NSDictionary *params = @{@"caste_id": caste_Id};
       
       [self popupServiceCallFor_Post:@"services/api/subcasteList" params:params];
       
   }
    
       else if ([clicked isEqualToString:@"profileForClick"]) {
           
         profileFORArr = [[NSMutableArray alloc]initWithObjects:@"Myself",@"Son",@"Daughter",@"Brother",@"Sister",@"Relative",@"Friend", nil];
           
           [_PopUpTableView reloadData];
       }
    
     // cell 2 buttons
    //       countryBtnClick
    //       stateBtnClick
    //       districtBtnClick
    //       cityBtnClick
    //       genderBtnClick
    //       MaritalStatusBtnClick
    //       heightBtnClick
    //       weightBtnClick
    
       else if ([clicked isEqualToString:@"countryBtnClick"]) {//countrieslist
           
           
            [self popupServiceCall:@"services/api/dropdownlist"];
       }
    
       else if ([clicked isEqualToString:@"stateBtnClick"]) {//stateBtnClick
           
           NSDictionary *params = @{@"country_id": country_Id};
            [self popupServiceCallFor_Post:@"services/api/statesList" params:params];
           
       }
    
       else if ([clicked isEqualToString:@"districtBtnClick"]) {//districtBtnClick
           
           NSDictionary *params = @{@"state_id": state_Id,@"country_id":country_Id};
           
           [self popupServiceCallFor_Post:@"services/api/districtList" params:params];
           
       }
    
       else if ([clicked isEqualToString:@"cityBtnClick"]) {//cityBtnClick
           
           
           NSDictionary *params = @{@"state_id": state_Id,@"country_id":country_Id,@"district_id":district_Id};
           
           [self popupServiceCallFor_Post:@"services/api/citiesList" params:params];
           
                }
    
       else if ([clicked isEqualToString:@"genderBtnClick"]) {//genderBtnClick
           
           genderArr = [[NSMutableArray alloc]initWithObjects:@"Female",@"Male", nil];
           
           [_PopUpTableView reloadData];
       }
       else if ([clicked isEqualToString:@"MaritalStatusBtnClick"]) {//MaritalStatusBtnClick
           
           maritualStatusArr = [[NSMutableArray alloc]initWithObjects:@"Unmarried",@"Widow/Widower",@"Divorcee",@"Separated", nil];
           
           [_PopUpTableView reloadData];
       }
       else if ([clicked isEqualToString:@"heightBtnClick"]) {//heightBtnClick
           
           heightArr = [[NSMutableArray alloc]initWithObjects:@"Below 4 ft",@"4 ft 06 in",@"4 ft 07 in",@"4 ft 08 in",@"4 ft 09 in",@"4 ft 10 in",@"4 ft 11 in",@"5 ft 0 in",@"5 ft 01 in",@"5 ft 02 in",@"5 ft 03 in",@"5 ft 04 in",@"5 ft 05 in",@"5 ft 06 in",@"5 ft 07 in",@"5 ft 08 in",@"5 ft 09 in",@"5 ft 10 in",@"5 ft 11 in",@"6 ft 0 in",@"6 ft 01 in",@"6 ft 02 in",@"6 ft 03 in",@"6 ft 04 in",@"6 ft 05 in",@"6 ft 06 in",@"6 ft 07 in",@"6 ft 08 in",@"6 ft 09 in",@"6 ft 10 in",@"6 ft 11 in",@"7 ft 00 in",@"Above 7 ft", nil];
           
           heightServiceArr = [[NSMutableArray alloc]initWithObjects:@"48",@"54",@"55",@"56",@"57",@"58",@"59",@"60",@"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"80",@"81",@"82",@"83",@"84",nil];
           
           
           [_PopUpTableView reloadData];
       }
       else if ([clicked isEqualToString:@"weightBtnClick"]) {//weightBtnClick
           
           weightArr = [[NSMutableArray alloc]init];
           
           NSMutableArray *array = [[NSMutableArray alloc] init];
           
           for (NSUInteger i = 40; i < 120; i++)
           {
               [array addObject:@(i)];
           }
           
           weightArr = array;
           
           [_PopUpTableView reloadData];
       }
    
    //cell 3
    
    /*
     educationBtnClick
     employedIn_BtnClick
     occupationBtnClick
     designationBtnClick
     incomeBtnClick
     familyTypeBtnClick
     familyStatusBtnClick
     fatherOccupationBtnClick
     motherOccupationBtnClick
     */
    
       else if ([clicked isEqualToString:@"educationBtnClick"]) {//districtBtnClick
           
          [self popupServiceCall:@"services/api/dropdownlist"];
           
       }
    
       else if ([clicked isEqualToString:@"employedIn_BtnClick"]) {//districtBtnClick
           
           employedInArr = [[NSMutableArray alloc]initWithObjects:@"Private",@"Government",@"Business",@"Defence",@"Not Employed",@"Others", nil];
           
           [_PopUpTableView reloadData];
           
       }
    
       else if ([clicked isEqualToString:@"designationBtnClick"]) {//districtBtnClick
           
           [self popupServiceCall:@"services/api/dropdownlist"];
           
       }
    
       else if ([clicked isEqualToString:@"incomeBtnClick"]) {//districtBtnClick
           
           AnualIncomeArr = [[NSMutableArray alloc]initWithObjects:@"Rs 10,000 - 50,000",@"Rs 50,000 - 1,00,000",@"Rs 1,00,000 - 2,00,000",@"Rs 2,00,000 - 5,00,000",@"Rs 5,00,000 - 10,00,000",@"Rs 10,00,000 - 50,00,000",@"Rs 50,00,000 - 1,00,00,000",@"Above Rs 1,00,00,000", nil];
           
           [_PopUpTableView reloadData];
           
       }
    
    
       else if ([clicked isEqualToString:@"familyTypeBtnClick"]) {//districtBtnClick
           
           familyTypeArr = [[NSMutableArray alloc]initWithObjects:@"Separate Family",@"Joint Family", nil];
           
           [_PopUpTableView reloadData];
           
       }
    
       else if ([clicked isEqualToString:@"familyStatusBtnClick"]) {//districtBtnClick
           
           familyStatusArr = [[NSMutableArray alloc]initWithObjects:@"Rich",@"Upper Middle Class",@"Middle Class",@"Lower Middle Class",@"Poor Family", nil];
           
           [_PopUpTableView reloadData];
           
       }
    
    
    
    

   else if ([clicked isEqualToString:@"occupationBtnClick"]) {
        
        [self popupServiceCall:@"services/api/dropdownlist"];
        
    }
    
   else if ([clicked isEqualToString:@"fatherOccupationBtnClick"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
       
   }
    

   else if ([clicked isEqualToString:@"motherOccupationBtnClick"]) {
       
       [self popupServiceCall:@"services/api/dropdownlist"];
       
   }

   
    
    
    
   
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
                 
                 if ([clicked isEqualToString:@"ReligionClick"]) {
                     
                     religionsDict=[popUPList valueForKey:@"religionslist"];
                 }
                 
                else if ([clicked isEqualToString:@"motherToungClick"]) {
                    
                     languagetArr=[popUPList valueForKey:@"languageslist"];
                 }
                 
                 // cell 2
                 
                else if ([clicked isEqualToString:@"countryBtnClick"]) {
                    
                    countryArr=[popUPList valueForKey:@"countrieslist"];
                }
                 
                 // cell 2 buttons
                 //       countryBtnClick
                 //       stateBtnClick
                 //       districtBtnClick
                 //       cityBtnClick
                 //       genderBtnClick
                 //       MaritalStatusBtnClick
                 //       heightBtnClick
                 //       weightBtnClick
                 
                 //cell 3
                 
                 /*
                  educationBtnClick
                  employedIn_BtnClick
                  occupationBtnClick
                  designationBtnClick
                  incomeBtnClick
                  familyTypeBtnClick
                  familyStatusBtnClick
                  fatherOccupationBtnClick
                  motherOccupationBtnClick
                  */
                 
                else if ([clicked isEqualToString:@"educationBtnClick"]) {
                    educationArr = [[NSMutableArray alloc]init];
                    educationArr=[popUPList valueForKey:@"educationlist"];
                }
                 
                else if ([clicked isEqualToString:@"designationBtnClick"]) {
                    disignationArr = [[NSMutableArray alloc]init];
                    disignationArr=[popUPList valueForKey:@"designationlist"];
                }
                  
                 
                 
                 
                  else if ([clicked isEqualToString:@"occupationBtnClick"]) {
                      
                      occupationArr = [[NSMutableArray alloc]init];
                      occupationArr=[popUPList valueForKey:@"occupationlist"];
                  }
                 
                 
                  else if ([clicked isEqualToString:@"fatherOccupationBtnClick"]) {
                      
                      occupationArr = [[NSMutableArray alloc]init];
                      occupationArr=[popUPList valueForKey:@"occupationlist"];
                  }
                 
                 
                  else if ([clicked isEqualToString:@"motherOccupationBtnClick"]) {
                      
                      occupationArr = [[NSMutableArray alloc]init];
                      occupationArr=[popUPList valueForKey:@"occupationlist"];
                  }
                 
                 
                 
                 
                 [_PopUpTableView reloadData];
             }
             
             
             
             
             else if ([status isEqualToString:@"0"]||[status isEqualToString:@"3"])
             {
                 [self Alert:result];
             }
             else if ([status isEqualToString:@"2"])
             {
                 [self Alert:@"Under Review!"];
                  _ViewPopUp.hidden = YES;
             }
             
         }
         else
         {
             [self Alert:@"Something went wrong"];
             _ViewPopUp.hidden = YES;
         }
     }];
}

-(void)popupServiceCallFor_Post:(NSString *)url params:(NSDictionary *)params
{
    //raviratna5566@gmail.com
   
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:url parameters:params requestNumber:WUS_Register showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
            
             NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
             
             NSString *result=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"result"]];
             
             if ([status isEqualToString:@"1"])
             {
                // check valid no and mail
                 
                 if ( [clicked isEqualToString: @"registration"]) {
                     
                      clicked = @"";
                     
                     LoginViewController *lgvc  =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                        [self.navigationController pushViewController:lgvc animated:YES];
                     
                      ALERT_DIALOG(@"Success", @"Registration done successfully");
                     
                 }
                 if ([registerPage isEqualToString:@"1"] &&  [checkMobile isEqualToString:@"yes"]) {
                     registerPage = @"2";
                     
                     
                       clicked = @"";
                     
                [_RegisterTableView reloadData];
                 }
                 
            if ([clicked isEqualToString:@"casteClick"]) {
                     
                    castArr = [[NSMutableArray alloc] init];
            castArr = [res_dict valueForKey:@"castelist"];
                     [_PopUpTableView reloadData];
                 }
                 
        else if ([clicked isEqualToString:@"subCasteClick"]) {
            sub_castArr = [[NSMutableArray alloc] init];
            sub_castArr = [res_dict valueForKey:@"subcastelist"];
            [_PopUpTableView reloadData];
            
            }
                 
        else if ([clicked isEqualToString:@"stateBtnClick"]) {
             stateArr = [[NSMutableArray alloc] init];
            stateArr=[res_dict valueForKey:@"statelist"];
             [_PopUpTableView reloadData];
        }
                 
        else if ([clicked isEqualToString:@"districtBtnClick"]) {
            distArr = [[NSMutableArray alloc] init];
            distArr=[res_dict valueForKey:@"districtlist"];
            
            [_PopUpTableView reloadData];
            
        }
        else if ([clicked isEqualToString:@"cityBtnClick"]) {
            
             cityArr = [[NSMutableArray alloc] init];
            cityArr = [res_dict valueForKey:@"citylist"];
             [_PopUpTableView reloadData];
            
        }
                 
                 
                //
                 
                 else
                 {
                    
                     
                 }
             }
             else if ([status isEqualToString:@"0"]||[status isEqualToString:@"3"])
             {
                 [self Alert:result];
                  if ([clicked isEqualToString:@"casteClick"]) {
                 
                  }
                 
                else if ( [clicked isEqualToString: @"registration"]) {
                    
                    clicked = @"";
                     
                     ALERT_DIALOG(@"Success", @"Your not at created. Please try again");
                    
                 }
                
                 _ViewPopUp.hidden = YES;
             }
             
             
             else if ([status isEqualToString:@"2"])
             {
                 [self Alert:@"Under Review!"];
                 
                 if ( [clicked isEqualToString: @"registration"]) {
                       clicked = @"";
                     
                     ALERT_DIALOG(@"Alert", @"Your Email id is already Exist");
                 }
                 
                 
                 
                  if ([clicked isEqualToString:@"casteClick"]) {
                      cell1.castTF.text = result;
                     
                  }
                 
                  else if ([clicked isEqualToString:@"stateBtnClick"]) {
                      
                       cell2.stateTF.text = result;
                     
                  }
                  else if ([clicked isEqualToString:@"districtBtnClick"]) {
                      
                      cell2.districtTF.text = result;
                      
                  }
                  else if ([clicked isEqualToString:@"cityBtnClick"]) {
                      
                      cell2.cityTf.text = result;
                      
                  }


                  _ViewPopUp.hidden = YES;
                 
             }
             else if ([status isEqualToString:@"4"])
             {
                   clicked = @"";
                 [self Alert:result];
             }
             else
             {
                   clicked = @"";
                 [self Alert:@"Try again"];
             }
         }
         else
         {
             clicked = @"";
             [self Alert:@"Something went wrong"];
               _ViewPopUp.hidden = YES;
         }
     }];
}
// register service call

-(void)RegisterServiceCall
{
    
    self.PopUpTableView.hidden = true;
    self.ViewPopUp.hidden = true;
    
     clicked = @"registration";
    
    NSString *gendervalidate;
    if ([cell2.genderTF.text isEqualToString:@"Male"]) {
       gendervalidate =@"Groom";
        
    }
    else
        gendervalidate = @"Bride";
    NSString *emal;
    
    if (cell1.emailTF.text.length == 0) {
        
        emal = @"";
    }
    
    else
    {
        
        emal = cell1.emailTF.text;
        
    }
    
    NSString *str = cell2.weightTF.text;
    
    str = [str stringByReplacingOccurrencesOfString:@" Kg"
                                         withString:@""];
    
    if ([sub_caste_Id isEqual:[NSNull null]]||[sub_caste_Id isEqualToString:@"<nil>"]||sub_caste_Id == nil||sub_caste_Id == NULL||[sub_caste_Id isEqualToString:@""]) {
        
        sub_caste_Id =@"";
    }
    
   // [self NSStringIsValidEmail:cell1.emailTF.text];
    NSDictionary *params = @{@"email":emal,@"password":cell1.passwordTF.text,@"firstname":cell1.firstNameTF.text,@"lastname":cell1.lastNameTF.text,@"religion":religion_Id,@"caste":caste_Id,@"subcaste":sub_caste_Id,@"country_id":country_Id,@"state_id":state_Id,@"city":city_Id,@"gender":gendervalidate,@"m_tongue":language_Id,@"m_status":cell2.maritualTF.text,@"residence":cell2.residenceTF.text,@"edu_detail":education_Id,@"height":height_Id,@"occupation":occupation_Id,@"mother_occupation":motherOccupation_Id,@"designation":designation_Id,@"birthdate":cell1.DOBtF.text,@"father_name":cell3.fatherNameTF.text,@"mother_name":cell3.motherNameTF.text,@"father_occupation":fatherOccupation_Id,@"mobile":cell1.mobileNoTF.text,@"weight":str,@"income":cell3.annualIncomeTF.text,@"emp_in":cell3.employedTF.text,@"address":cell2.addressTF.text,@"profileby":cell1.profileForTF.text};
    
    [self popupServiceCallFor_Post:@"services/api/registration" params:params];
   
}

/*

 height [int (64,65)]
 weight
 
 */

@end
