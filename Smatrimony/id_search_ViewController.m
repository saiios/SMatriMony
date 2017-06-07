//
//  id_search_ViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 13/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "id_search_ViewController.h"
#import "search_TableViewCell.h"
#import "age_TableViewCell.h"
#import "height_TableViewCell.h"
#import "STParsing.h"


@interface id_search_ViewController ()
{
    NSUserDefaults *user_inf;
    NSString *button,*selectType,*loggedIn_matri_id,*heightStrng,*heightToStrng;
    NSMutableString *maritalStatusStrng,*cuntryStatusString,*physicalStatusStrng,*religionStrng,*religionIdStrng,*mTongueStrng,*mTongueIdStrng,*starStrng,*starIdStrng,*eduStrng,*eduIdStrng,*ocpStrng,*ocpIdStrng,*stateStrng,*stateIdStrng,*cuntryIdString,*eatinStrng,*drinkStrng,*smokeStrng,*districtStrng,*districtIdStrng,*cityStrng,*cityIdStrng,*castStrng,*castIdStrng;
    NSArray *maritalStatusArr,*physicalStatusArr,*eatingArr,*drinkingArr,*heightArr,*religionArr,*MTongueArr,*starArr,*eduArr,*ocpArr,*annualIncmArr,*countryArr,*stateArr,*districtArr,*cityArr,*castArr;
    NSMutableArray *ageArr,*ProfileArr;
    NSString *countryId,*maritalStatusId,*physicalStatusId,*eatingId,*drinkingId,*smokingId,*ageFromId,*ageToId,*heightFromId,*heightToId,*incomFromID,*incomToID,*religionId,*mTongueId,*starId,*eduId,*ocpID,*stateId,*districtId,*cityId,*castId; //IDs
    NSMutableArray *searchArr,*globalArr,*selectArr,*idsArr;
    BOOL isFiltered;
    search_TableViewCell * serchTableCell;
    age_TableViewCell *ageCell;
    height_TableViewCell *heightCell;
    UITableViewCell *selectedCell,*checkCell,*cell;
    int i;
    NSArray *heightServiceArr,*sheightArr;
}

@end

@implementation id_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self initialValues];
    user_inf = [NSUserDefaults standardUserDefaults];
    img_select_ary=[[NSMutableArray alloc]init];
    loggedIn_matri_id = [user_inf valueForKey:@"matri_id"];
    NSDictionary *params = @{@"matri_id":loggedIn_matri_id};
    [self profileServiceCall:@"services/api/memberProfile" Params:params];
    self.popView.hidden = true;
    _searchMainTableView.allowsSelection = NO;
    

}
-(void)initialValues
{
    cuntryStatusString=[@"" mutableCopy];
    cuntryIdString=[@"" mutableCopy];
    maritalStatusStrng=[@"" mutableCopy];
    physicalStatusStrng=[@"" mutableCopy];
    religionStrng=[@""mutableCopy];
    religionIdStrng=[@""mutableCopy];
    mTongueStrng=[@""mutableCopy];
    mTongueIdStrng=[@""mutableCopy];
    starIdStrng=[@""mutableCopy];
    starStrng=[@""mutableCopy];
    eduStrng=[@""mutableCopy];
    eduIdStrng=[@""mutableCopy];
    ocpStrng=[@""mutableCopy];
    ocpIdStrng=[@""mutableCopy];
    stateStrng=[@""mutableCopy];
    stateIdStrng=[@""mutableCopy];
    eatinStrng=[@""mutableCopy];
    drinkStrng=[@""mutableCopy];
    smokeStrng=[@""mutableCopy];
    districtStrng=[@"" mutableCopy];
    districtIdStrng=[@""mutableCopy];
    cityIdStrng=[@"" mutableCopy];
    cityStrng=[@"" mutableCopy];
    castStrng=[@"" mutableCopy];
    castIdStrng=[@"" mutableCopy];
    heightStrng=@"";
    heightToStrng=@"";
    _searchBar.delegate = self;
    searchArr=[NSMutableArray new];
    selectArr=[NSMutableArray new];
    idsArr=[NSMutableArray new];
    sheightArr = [[NSMutableArray alloc]initWithObjects:@"Below 4 ft",@"4 ft 06 in",@"4 ft 07 in",@"4 ft 08 in",@"4 ft 09 in",@"4 ft 10 in",@"4 ft 11 in",@"5 ft 0 in",@"5 ft 01 in",@"5 ft 02 in",@"5 ft 03 in",@"5 ft 04 in",@"5 ft 05 in",@"5 ft 06 in",@"5 ft 07 in",@"5 ft 08 in",@"5 ft 09 in",@"5 ft 10 in",@"5 ft 11 in",@"6 ft 0 in",@"6 ft 01 in",@"6 ft 02 in",@"6 ft 03 in",@"6 ft 04 in",@"6 ft 05 in",@"6 ft 06 in",@"6 ft 07 in",@"6 ft 08 in",@"6 ft 09 in",@"6 ft 10 in",@"6 ft 11 in",@"7 ft 00 in",@"Above 7 ft", nil];
    heightServiceArr = [[NSMutableArray alloc]initWithObjects:@"48",@"54",@"55",@"56",@"57",@"58",@"59",@"60",@"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"80",@"81",@"82",@"83",@"84",nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    // Do the search...
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [searchArr removeAllObjects];
    [idsArr removeAllObjects];
    if (searchText.length == 0) {
        isFiltered = NO;
        [_popupTableView reloadData];
    }
    else
    {
        isFiltered = YES;
        if([button isEqualToString:@"religionBtn"])
        {
            [self checkPredicate:searchText key:@"religion_name" mainArr:religionArr];
        }
        else if([button isEqualToString:@"MTongueBtn"])
        {
            [self checkPredicate:searchText key:@"mtongue_name" mainArr:MTongueArr];
        }
        else if([button isEqualToString:@"castebtn"])
        {
            [self checkPredicate:searchText key:@"caste_name" mainArr:castArr];
        }
        else if([button isEqualToString:@"starBtn"])
        {
            [self checkPredicate:searchText key:@"stars_name" mainArr:starArr];
        }
        else if([button isEqualToString:@"CountryBtn"])
        {
            [self checkPredicate:searchText key:@"country_name" mainArr:countryArr];
        }
        else if([button isEqualToString:@"stateBtn"])
        {
            [self checkPredicate:searchText key:@"state_name" mainArr:stateArr];
        }
        else if([button isEqualToString:@"DistrictBtn"])
        {
            [self checkPredicate:searchText key:@"district_name" mainArr:districtArr];
        }
        else if([button isEqualToString:@"cityBtn"])
        {
            [self checkPredicate:searchText key:@"city_name" mainArr:cityArr];
        }
        else if([button isEqualToString:@"educationBtn"])
        {
            [self checkPredicate:searchText key:@"edu_name" mainArr:eduArr];
        }
        else if([button isEqualToString:@"occupationBtn"])
        {
            [self checkPredicate:searchText key:@"ocp_name" mainArr:ocpArr];
        }
    }
}

-(void)checkPredicate:(NSString *)searchText key:(NSString *)key mainArr:(NSArray *)mainArr
{
    NSMutableArray * results1=[[NSMutableArray alloc]init];
    NSPredicate* p = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", searchText];
    for (i=0; i<[mainArr count]; i++) {
        NSString *name = [[mainArr valueForKey:key] objectAtIndex:i];
        [results1 addObject:name];
    }
    NSArray *results = [results1 filteredArrayUsingPredicate:p];
    for(int j=0;j<[results count];j++)
    {
        for (int k=0; k<[mainArr count]; k++) {
            if ([[results objectAtIndex:j]isEqualToString:[NSString stringWithFormat:@"%@",[[mainArr valueForKey:key] objectAtIndex:k]]]) {
                NSString *strngID = [[mainArr valueForKey:@"religion_id"]objectAtIndex:k];
                [ idsArr addObject:strngID];
            }
        }
    }
    searchArr = [results mutableCopy];
    [_popupTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _searchMainTableView) {
        return 1;
    }
    else
    {
    if([button isEqualToString:@"maritalStatusBtn"])
        return [maritalStatusArr count ];
    else if ([button isEqualToString:@"physicalStatusBtn"]) {
        return [physicalStatusArr count];
    }
    else if ([button isEqualToString:@"eatingBtn"]) {
        return [eatingArr count];
    }
    else if ([button isEqualToString:@"drinkingBtn"]) {
        return [drinkingArr count];
    }
    else if ([button isEqualToString:@"smokingBtn"]) {
        return [drinkingArr count];
    }
    else if ([button isEqualToString:@"ageBtn"]) {
        return 1;    }
    else if ([button isEqualToString:@"heightBtn"]) {
        return 1;    }
    else if ([button isEqualToString:@"annualIncomeBtn"]) {
        return 1;    }
    else if ([button isEqualToString:@"ageFromBtn"]||[button isEqualToString:@"ageToBtn"]){
        return [ageArr count];
    }
    else if ([button isEqualToString:@"heightFromBtn"]||[button isEqualToString:@"heightToBtn"]){
      return [heightArr count];
    }
    else if ([button isEqualToString:@"religionBtn"]) {
        if (isFiltered == NO) {
             return [religionArr count];
        }
        else
            return [searchArr count];
        }
    else if ([button isEqualToString:@"MTongueBtn"])
    {
        if (isFiltered == NO) {
            return [MTongueArr count];
        }
        else
            return [searchArr count];
    }
    else if ([button isEqualToString:@"starBtn"])
    {
        if (isFiltered == NO) {
            return [starArr count];
        }
        else
            return [searchArr count];
    }
    else if ([button isEqualToString:@"educationBtn"]){
        
        if (isFiltered == NO) {
            return [eduArr count];
        }
        else
            return [searchArr count];
        }
    else if ([button isEqualToString:@"occupationBtn"])
        {
            if (isFiltered == NO) {
                return [ocpArr count];
            }
            else
                return [searchArr count];
        }
    else if ([button isEqualToString:@"CountryBtn"]){
        if (isFiltered == NO) {
            return [countryArr count];
        }
        else
            return [searchArr count];
        }
    else if ([button isEqualToString:@"stateBtn"]) {
            if (isFiltered == NO) {
                return [stateArr count];
            }
            else
                return [searchArr count];
        }
    else if ([button isEqualToString:@"DistrictBtn"]){
            if (isFiltered == NO) {
                return [districtArr count];
            }
            else
                return [searchArr count];
        }
    else if ([button isEqualToString:@"cityBtn"]){
        if (isFiltered == NO) {
            return [cityArr count];
        }
        else
            return [searchArr count];
        }
    else if ([button isEqualToString:@"castebtn"]){
            if (isFiltered == NO) {
                return [castArr count];
            }
            else
                return [searchArr count];
        }
    else
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.searchMainTableView)
     {
        static NSString *simpleTableIdentifier = @"search_TableViewCell";
        serchTableCell = (search_TableViewCell *)[_searchMainTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
         if (serchTableCell == nil)
             {
                 NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"search_TableViewCell" owner:self options:nil];
                 serchTableCell = (search_TableViewCell *)[nib objectAtIndex:0];
             }
         [ serchTableCell.ageBtn addTarget:self action:@selector(ageBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.heightBtn addTarget:self action:@selector(heightBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.maritalStatusBtn addTarget:self action:@selector(maritalStatusBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.religionBtn addTarget:self action:@selector(religionBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.castebtn addTarget:self action:@selector(castebtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.MTongueBtn addTarget:self action:@selector(MTongueBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.starBtn addTarget:self action:@selector(starBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.CountryBtn addTarget:self action:@selector(CountryBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.DistrictBtn addTarget:self action:@selector(DistrictBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.stateBtn addTarget:self action:@selector(stateBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.cityBtn addTarget:self action:@selector(cityBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.educationBtn addTarget:self action:@selector(educationBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.occupationBtn addTarget:self action:@selector(occupationBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.physicalStatusBtn addTarget:self action:@selector(physicalStatusBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.eatingBtn addTarget:self action:@selector(eatingBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.drinkingBtn addTarget:self action:@selector(drinkingBtnAction) forControlEvents:UIControlEventTouchUpInside];
         [ serchTableCell.smokingBtn addTarget:self action:@selector(smokingBtnAction) forControlEvents:UIControlEventTouchUpInside];
         NSString * heightStrngId = [ProfileArr  valueForKey:@"part_height"];
         NSString * heightTostrngId = [ProfileArr  valueForKey:@"part_height_to"];
        
         for (int j=0;j<heightServiceArr.count; j++) {
            if ([heightStrngId isEqualToString:[heightServiceArr objectAtIndex:j]]) {
                heightStrng=[sheightArr objectAtIndex:j];
            }
            if ([heightTostrngId isEqualToString:[heightServiceArr objectAtIndex:j]]) {
                heightToStrng=[sheightArr objectAtIndex:j];
            }
         }
         serchTableCell.ageLabel.text = [NSString stringWithFormat:@"%@-%@ Years",[ProfileArr valueForKey:@"part_frm_age"],[ProfileArr valueForKey:@"part_to_age"]];
         serchTableCell.heightLabel.text = [NSString stringWithFormat:@"%@-%@",heightStrng,heightToStrng];
         serchTableCell.maritalStatusLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"looking_for"]];
         serchTableCell.religionLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_religion_names"]];
         serchTableCell.casteLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_caste_names"]];
         serchTableCell.countryLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_country"]];
         serchTableCell.stateLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_state_names"]];
         serchTableCell.districtLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_district_names"]];
        serchTableCell.cityLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_city_names"]];
        serchTableCell.MTongueLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_mtongue_names"]];
        serchTableCell.starLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_star_names"]];
        serchTableCell.educationLAbel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_education"]];
        serchTableCell.occupationLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_occupation_names"]];
        serchTableCell.physicalStatusLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_phstatus"]];
        serchTableCell.eatingLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_diet"]];
        serchTableCell.drinkingLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_drink"]];
        serchTableCell.smokingLabel.text = [NSString stringWithFormat:@"%@",[ProfileArr valueForKey:@"part_smoke"]];
        
        return serchTableCell;
    } // if condition close
    else if(tableView == self.popupTableView)
    {
        if ([button isEqualToString:@"ageBtn"])
            {
                static NSString *simpleTableIdentifier = @"age_TableViewCell";
                ageCell = (age_TableViewCell *)[_popupTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
                //   ageCell.accessoryType = UITableViewCellAccessoryNone;
                if (ageCell == nil)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"age_TableViewCell" owner:self options:nil];
                    ageCell = (age_TableViewCell *)[nib objectAtIndex:0];
                }
                ageCell.selectionStyle = UITableViewCellSelectionStyleNone;
                [ ageCell.ageFromBtn addTarget:self action:@selector(ageFromBtnAction) forControlEvents:UIControlEventTouchUpInside ];
                [ageCell.ageToBtn addTarget:self action:@selector(ageToBtnAction) forControlEvents:UIControlEventTouchUpInside];
            checkCell = ageCell;
            selectedCell = ageCell;
            return ageCell;
            }

        else if ([button isEqualToString:@"heightBtn"])
            {
                static NSString *simpleTableIdentifier = @"height_TableViewCell";
                heightCell = (height_TableViewCell *)[_popupTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
                if (heightCell == nil)
                   {
                       NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"height_TableViewCell" owner:self options:nil];
                       heightCell = (height_TableViewCell *)[nib objectAtIndex:0];
                   }
                heightCell.selectionStyle = UITableViewCellSelectionStyleNone;
                [ heightCell.heightFromBtn addTarget:self action:@selector(heightFromBtnAction) forControlEvents:UIControlEventTouchUpInside];
                [heightCell.heightToBtn addTarget:self action:@selector(heightToBtnAction) forControlEvents:UIControlEventTouchUpInside];
                checkCell = heightCell;
                selectedCell = heightCell;
                return heightCell;
            }
       else
        {
        static NSString *MyIdentifier = @"MyIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
       // cell.accessoryType = UITableViewCellAccessoryNone;
            if (cell == nil)
              {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
              }
            if ([img_select_ary containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            {
                cell.imageView.image = [UIImage imageNamed:@"check-box-with-check-sign.png"];
            }
            else
            {
                cell.imageView.image  = [UIImage imageNamed:@"check-box-empty.png"];
            }
            if ([button isEqualToString:@"maritalStatusBtn"]) {
                cell.textLabel.text = [maritalStatusArr objectAtIndex:indexPath.row];
            }
            else if ([button isEqualToString:@"physicalStatusBtn"]) {
                cell.textLabel.text = [physicalStatusArr objectAtIndex:indexPath.row];
            }
            else if ([button isEqualToString:@"eatingBtn"]) {
                cell.textLabel.text = [eatingArr objectAtIndex:indexPath.row];
            }
            else if ([button isEqualToString:@"drinkingBtn"]) {
                cell.textLabel.text = [drinkingArr objectAtIndex:indexPath.row];
            }
            else if ([button isEqualToString:@"smokingBtn"]) {
                cell.textLabel.text = [drinkingArr objectAtIndex:indexPath.row];
            }
            else if ([button isEqualToString:@"religionBtn"]) {
                if (isFiltered == NO) {
              cell.textLabel.text=[[religionArr objectAtIndex:indexPath.row]valueForKey:@"religion_name"];
                }
                else
                   {
                    cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
                    }
            }
            else if ([button isEqualToString:@"MTongueBtn"])
               {
                   if (isFiltered == NO) {
                       cell.textLabel.text=[[MTongueArr objectAtIndex:indexPath.row]valueForKey:@"mtongue_name"];
                   }
                   else
                      {
                          cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
                      }
               }
            else if ([button isEqualToString:@"starBtn"])
            {
             if (isFiltered == NO) {
            cell.textLabel.text=[[starArr objectAtIndex:indexPath.row]valueForKey:@"stars_name"];
             }
             else
             {
                 cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
             }
        }
        else if ([button isEqualToString:@"educationBtn"]){
             if (isFiltered == NO) {
            cell.textLabel.text=[[eduArr objectAtIndex:indexPath.row]valueForKey:@"edu_name"];
             }
             else
             {
                 cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
             }
        }
        else if ([button isEqualToString:@"occupationBtn"])
        {
            if (isFiltered == NO) {
            cell.textLabel.text=[[ocpArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
            }
            else
            {
                cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
            }
        }
        else if ([button isEqualToString:@"CountryBtn"]){
            if (isFiltered == NO) {
            cell.textLabel.text=[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
            }
            else
            {
                cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
            }
        }
        else if ([button isEqualToString:@"stateBtn"]) {
            if (isFiltered == NO) {
                    cell.textLabel.text=[[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"];
            }
            else
            {
                cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
            }
           
        }
        else if ([button isEqualToString:@"DistrictBtn"]){
            if (isFiltered == NO) {
                cell.textLabel.text=[[districtArr objectAtIndex:indexPath.row]valueForKey:@"district_name"];
            }
            else
            {
                cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
            }
           
        }
        else if ([button isEqualToString:@"cityBtn"]){
             if (isFiltered == NO) {
           cell.textLabel.text=[[cityArr objectAtIndex:indexPath.row]valueForKey:@"city_name"];
             }
             else
             {
                 cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
             }
        }
        else if ([button isEqualToString:@"castebtn"]){
             if (isFiltered == NO) {
                cell.textLabel.text=[[castArr objectAtIndex:indexPath.row]valueForKey:@"caste_name"];
             }
             else
             {
                 cell.textLabel.text=[searchArr objectAtIndex:indexPath.row];
             }
            }
            
             return cell;
        } // else
    }
    else
    {
        static NSString *MyIdentifier = @"MyIdentifier1";
        
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
       //cell1.accessoryType = UITableViewCellAccessoryNone;
        
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        if ([button isEqualToString:@"ageFromBtn"]||[button isEqualToString:@"ageToBtn"]) {
           cell1.textLabel.text = [NSString stringWithFormat:@"%@",[ageArr objectAtIndex:indexPath.row]];
        }
         else if ([button isEqualToString:@"heightFromBtn"]||[button isEqualToString:@"heightToBtn"]){
          cell1.textLabel.text = [NSString stringWithFormat:@"%@",[heightArr objectAtIndex:indexPath.row]];
             
        }
     /*   else if ([button isEqualToString:@"incomeFromBtn"]||[button isEqualToString:@"incomeToBtn"]){
             cell1.textLabel.text = [NSString stringWithFormat:@"%@",[annualIncmArr objectAtIndex:indexPath.row]];
        }*/
        return cell1;
    }
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:
(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        [img_select_ary removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        cell = (UITableViewCell*)[_popupTableView cellForRowAtIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"check-box-empty.png"];
    
    if([button isEqualToString:@"maritalStatusBtn"])
    {
        maritalStatusId = [maritalStatusArr objectAtIndex:indexPath.row];
        
        NSString *str= [maritalStatusArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([maritalStatusStrng containsString:add]) {
            maritalStatusStrng = [[maritalStatusStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
            
        }
        else{
            maritalStatusStrng= [[maritalStatusStrng stringByAppendingString:add] mutableCopy];
            
        }
        
        //self.popView.hidden = true;
    }
    else if ([button isEqualToString:@"religionBtn"])
    {
        if(isFiltered == NO)
        {
            if (indexPath.row == 0)
            {
                religionIdStrng=[[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_id"];
                serchTableCell.religionLabel.text=[[religionArr objectAtIndex:indexPath.row]valueForKey:@"religion_name"];
                serchTableCell.MTongueLabel.text=@"Any";
                serchTableCell.casteLabel.text=@"Any";
                mTongueId=@"";
                mTongueIdStrng=[@"" mutableCopy];
                castId=@"";
                castIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                
            }
            else
            {
                NSString *str= [[religionArr objectAtIndex:indexPath.row]valueForKey:@"religion_name"];
                NSString *add =[NSString stringWithFormat:@"%@,",str];
                
                if ([religionStrng containsString:add])
                {
                    religionStrng = [[religionStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                    NSIndexPath* selection = [tableView indexPathForSelectedRow];
                    
                    [selectArr removeObject:selection];
                }
                else{
                    religionStrng= [[religionStrng stringByAppendingString:add] mutableCopy];
                    NSIndexPath* selection = [tableView indexPathForSelectedRow];
                    [selectArr addObject:selection];
                }
                NSString *addId =[NSString stringWithFormat:@"%@,",[[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_id"]];
                if ([religionIdStrng containsString:addId]) {
                    
                    religionIdStrng = [[religionIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
                
                else{
                    
                    religionIdStrng= [[religionIdStrng stringByAppendingString:addId] mutableCopy];
                }
                serchTableCell.MTongueLabel.text=@"";
                serchTableCell.casteLabel.text=@"";
                mTongueId=@"";
                mTongueIdStrng=[@"" mutableCopy];
                castId=@"";
                castIdStrng=[@"" mutableCopy];
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                religionIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.religionLabel.text=[searchArr objectAtIndex:indexPath.row];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else
            {
                if ([religionStrng containsString:add]) {
                    religionStrng = [[religionStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    religionStrng= [[religionStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([religionIdStrng containsString:addId]) {
                religionIdStrng = [[religionIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                religionIdStrng= [[religionIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
        //  religionId = [[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_id"];
        
    }
 
    else if ([button isEqualToString:@"eatingBtn"]) {
        serchTableCell.eatingLabel.text = [eatingArr objectAtIndex:indexPath.row];
        NSString *str= [eatingArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([eatinStrng containsString:add]) {
            eatinStrng = [[eatinStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            eatinStrng= [[eatinStrng stringByAppendingString:add] mutableCopy];
        }
        eatingId = [eatingArr objectAtIndex:indexPath.row];
        //    self.popView.hidden = true;
    }
    else if ([button isEqualToString:@"drinkingBtn"]) {
        NSString *str= [drinkingArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([drinkStrng containsString:add]) {
            drinkStrng = [[drinkStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            drinkStrng= [[drinkStrng stringByAppendingString:add] mutableCopy];
        }
        
        drinkingId = [drinkingArr objectAtIndex:indexPath.row];
        // self.popView.hidden = true;
    }
    else if ([button isEqualToString:@"smokingBtn"]) {
        //serchTableCell.smokingLabel.text = [drinkingArr objectAtIndex:indexPath.row];
        NSString *str= [drinkingArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([smokeStrng containsString:add]) {
            smokeStrng = [[smokeStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            smokeStrng= [[smokeStrng stringByAppendingString:add] mutableCopy];
        }
        smokingId = [drinkingArr objectAtIndex:indexPath.row];
        // self.popView.hidden = true;
    }
    
    else if ([button isEqualToString:@"MTongueBtn"])
    {
        if(isFiltered == NO)
        {
            if (indexPath.row == 0) {
                
                mTongueIdStrng=[[MTongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_id"];
                serchTableCell.MTongueLabel.text=[[MTongueArr objectAtIndex:indexPath.row]valueForKey:@"mtongue_name"];
                serchTableCell.casteLabel.text=@"Any";
                castId=@"";
                castIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
            }
            else
            {
                NSString *str= [[MTongueArr objectAtIndex:indexPath.row]valueForKey:@"mtongue_name"];
                NSString *add =[NSString stringWithFormat:@"%@,",str];
                
                if ([mTongueStrng containsString:add]) {
                    mTongueStrng = [[mTongueStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    mTongueStrng= [[mTongueStrng stringByAppendingString:add] mutableCopy];
                }
                
                NSString *addId =[NSString stringWithFormat:@"%@,",[[MTongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_id"]];
                if ([mTongueIdStrng containsString:addId]) {
                    
                    mTongueIdStrng = [[mTongueIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
                
                else{
                    
                    mTongueIdStrng= [[mTongueIdStrng stringByAppendingString:addId] mutableCopy];
                }
                serchTableCell.casteLabel.text=@"";
                castId=@"";
                castIdStrng=[@""mutableCopy];
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                mTongueIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.MTongueLabel.text=[searchArr objectAtIndex:indexPath.row];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([mTongueStrng containsString:add]) {
                    mTongueStrng = [[mTongueStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    mTongueStrng= [[mTongueStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([mTongueIdStrng containsString:addId]) {
                mTongueIdStrng = [[mTongueIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                mTongueIdStrng= [[mTongueIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
        
    }
    else if ([button isEqualToString:@"starBtn"])
    {
        if(isFiltered == NO){
            
            if (indexPath.row == 0) {
                starIdStrng=[[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_id"];
                serchTableCell.starLabel.text=[[starArr objectAtIndex:indexPath.row]valueForKey:@"stars_name"];
                self.popView.hidden = true;
            }
            else
            {
                NSString *str= [[starArr objectAtIndex:indexPath.row]valueForKey:@"stars_name"];
                NSString *add =[NSString stringWithFormat:@"%@,",str];
                if ([starStrng containsString:add]) {
                    starStrng = [[starStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    starStrng= [[starStrng stringByAppendingString:add] mutableCopy];
                }
                NSString *addId =[NSString stringWithFormat:@"%@,",[[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_id"]];
                if ([starIdStrng containsString:addId]) {
                    starIdStrng = [[starIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
                else{
                    
                    starIdStrng= [[starIdStrng stringByAppendingString:addId] mutableCopy];
                }
                
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                starIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.starLabel.text=[searchArr objectAtIndex:indexPath.row];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([starStrng containsString:add]) {
                    starStrng = [[starStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    starStrng= [[starStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([starIdStrng containsString:addId]) {
                starIdStrng = [[starIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                starIdStrng= [[starIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
    }
    
    else if ([button isEqualToString:@"educationBtn"]){
        if(isFiltered == NO){
            if (indexPath.row == 0) {
                serchTableCell.educationLAbel.text=[[eduArr objectAtIndex:indexPath.row]valueForKey:@"edu_name"];
                eduIdStrng=[[eduArr objectAtIndex:indexPath.row] valueForKey:@"edu_id"];
                self.popView.hidden = true;
                eduId=@"";
                eduIdStrng=[@""mutableCopy];
            }
            else
            {
                NSString *str= [[eduArr objectAtIndex:indexPath.row]valueForKey:@"edu_name"];
                NSString *add =[NSString stringWithFormat:@"%@,",str];
                
                if ([eduStrng containsString:add]) {
                    eduStrng = [[eduStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    eduStrng= [[eduStrng stringByAppendingString:add] mutableCopy];
                }
                NSString *addId =[NSString stringWithFormat:@"%@,",[[eduArr objectAtIndex:indexPath.row-1] valueForKey:@"edu_id"]];
                if ([eduIdStrng containsString:addId]) {
                    eduIdStrng = [[eduIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
                else{
                    eduIdStrng= [[eduIdStrng stringByAppendingString:addId] mutableCopy];
                }
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                eduIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.educationLAbel.text=[searchArr objectAtIndex:indexPath.row];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([eduStrng containsString:add]) {
                    eduStrng = [[eduStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    eduStrng= [[eduStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([eduIdStrng containsString:addId]) {
                eduIdStrng = [[eduIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                eduIdStrng= [[eduIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
    }
    else if ([button isEqualToString:@"occupationBtn"])
    {
        if(isFiltered == NO){
            if (indexPath.row == 0) {
                serchTableCell.occupationLabel.text=[[ocpArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
                ocpIdStrng=[[ocpArr objectAtIndex:indexPath.row] valueForKey:@"ocp_id"];
                self.popView.hidden = true;
                ocpID=@"";
                ocpIdStrng=[@""mutableCopy];
            }
            else
            {
                NSString *str= [[ocpArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
                NSString *add =[NSString stringWithFormat:@"%@,",str];
                
                if ([ocpStrng containsString:add]) {
                    ocpStrng = [[ocpStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    ocpStrng= [[ocpStrng stringByAppendingString:add] mutableCopy];
                }
                NSString *addId =[NSString stringWithFormat:@"%@,",[[ocpArr objectAtIndex:indexPath.row] valueForKey:@"ocp_id"]];
                if ([ocpIdStrng containsString:addId]) {
                    
                    ocpIdStrng = [[ocpIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
                else{
                    
                    ocpIdStrng= [[ocpIdStrng stringByAppendingString:addId] mutableCopy];
                }
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                ocpIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.occupationLabel.text=[searchArr objectAtIndex:indexPath.row];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([ocpStrng containsString:add]) {
                    ocpStrng = [[ocpStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    ocpStrng= [[ocpStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([ocpIdStrng containsString:addId]) {
                ocpIdStrng = [[ocpIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                ocpIdStrng= [[ocpIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
    }
    
    else if ([button isEqualToString:@"CountryBtn"]){
        if(isFiltered == NO){
            if (indexPath.row == 0) {
                serchTableCell.countryLabel.text=[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
                countryId=@"";
                cuntryIdString=[@"" mutableCopy];
                serchTableCell.stateLabel.text=@"Any";
                stateId=@"";
                stateIdStrng=[@"" mutableCopy];
                serchTableCell.districtLabel.text=@"Any";
                districtId=@"";
                districtIdStrng=[@"" mutableCopy];
                serchTableCell.cityLabel.text=@"Any";
                cityId=@"";
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
            }
            else
            {
                NSString*str=[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
                NSString*add=[NSString stringWithFormat:@"%@," ,str];
                if ([cuntryStatusString containsString:add ]) {
                    cuntryStatusString=[[cuntryStatusString stringByReplacingOccurrencesOfString:add withString:@""]    mutableCopy];
                }
                else{
                    cuntryStatusString=[[cuntryStatusString stringByAppendingString:add]mutableCopy];
                }
                NSString*str1=[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_id"];
                NSString*add1=[NSString stringWithFormat:@"%@," ,str1];
                if ([cuntryIdString containsString:add1 ]) {
                    cuntryIdString=[[cuntryIdString stringByReplacingOccurrencesOfString:add1 withString:@""]mutableCopy];
                }
                else{
                    cuntryIdString=[[cuntryIdString stringByAppendingString:add1]mutableCopy];
                }
                serchTableCell.stateLabel.text=@"";
                stateId=@"";
                stateIdStrng=[@"" mutableCopy];
                serchTableCell.districtLabel.text=@"";
                districtId=@"";
                districtIdStrng=[@"" mutableCopy];
                serchTableCell.cityLabel.text=@"";
                cityId=@"";
                cityIdStrng=[@"" mutableCopy];
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                cuntryIdString=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.countryLabel.text=[searchArr objectAtIndex:indexPath.row];
                countryId=@"";
                cuntryIdString=[@"" mutableCopy];
                serchTableCell.stateLabel.text=@"Any";
                stateId=@"";
                stateIdStrng=[@"" mutableCopy];
                serchTableCell.districtLabel.text=@"Any";
                districtId=@"";
                districtIdStrng=[@"" mutableCopy];
                serchTableCell.cityLabel.text=@"Any";
                cityId=@"";
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([cuntryStatusString containsString:add]) {
                    cuntryStatusString = [[cuntryStatusString stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    cuntryStatusString= [[cuntryStatusString stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([cuntryIdString containsString:addId]) {
                cuntryIdString = [[cuntryIdString stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                cuntryIdString= [[cuntryIdString stringByAppendingString:addId] mutableCopy];
            }
        }
    }
    
    else if ([button isEqualToString:@"stateBtn"]) {
        if(isFiltered == NO){
            if (indexPath.row == 0) {
                serchTableCell.stateLabel.text=[[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"];
                stateId=@"";
                serchTableCell.districtLabel.text=@"Any";
                districtId=@"";
                serchTableCell.cityLabel.text=@"Any";
                cityId=@"";
                stateIdStrng=[@"" mutableCopy];
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                
            }
            else{
                NSString *str= [[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"];
                NSString *add =[NSString stringWithFormat:@"%@,",str];
                if ([stateStrng containsString:add]) {
                    stateStrng = [[stateStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    stateStrng= [[stateStrng stringByAppendingString:add] mutableCopy];
                }
                NSString *addId =[NSString stringWithFormat:@"%@,",[[stateArr objectAtIndex:indexPath.row] valueForKey:@"state_id"]];
                if ([stateIdStrng containsString:addId]) {
                    stateIdStrng = [[stateIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
                else{
                    stateIdStrng= [[stateIdStrng stringByAppendingString:addId] mutableCopy];
                }
                serchTableCell.districtLabel.text=@"";
                districtId=@"";
                serchTableCell.cityLabel.text=@"";
                cityId=@"";
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                stateIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.stateLabel.text=[searchArr objectAtIndex:indexPath.row];
                stateId=@"";
                serchTableCell.districtLabel.text=@"Any";
                districtId=@"";
                serchTableCell.cityLabel.text=@"Any";
                cityId=@"";
                stateIdStrng=[@"" mutableCopy];
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([stateStrng containsString:add]) {
                    stateStrng = [[stateStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    stateStrng= [[stateStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([stateIdStrng containsString:addId]) {
                stateIdStrng = [[stateIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                stateIdStrng= [[stateIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
    }
    else if ([button isEqualToString:@"DistrictBtn"]) {
        if(isFiltered == NO){
            if (indexPath.row == 0) {
                serchTableCell.districtLabel.text=[[districtArr objectAtIndex:indexPath.row]valueForKey:@"district_name"];
                
                serchTableCell.cityLabel.text=@"Any";
                districtId=@"";
                cityId=@"";
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                
            }
            else{
                
                NSString *str= [[districtArr objectAtIndex:indexPath.row]valueForKey:@"district_name"];
                NSString *add =[NSString stringWithFormat:@"%@,",str];
                
                if ([districtStrng containsString:add]) {
                    districtStrng = [[districtStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    districtStrng= [[districtStrng stringByAppendingString:add] mutableCopy];
                }
                NSString *addId =[NSString stringWithFormat:@"%@,",[[districtArr objectAtIndex:indexPath.row] valueForKey:@"district_id"]];
                if ([districtIdStrng containsString:addId]) {
                    
                    districtIdStrng = [[districtIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
                
                else{
                    
                    districtIdStrng= [[districtIdStrng stringByAppendingString:addId] mutableCopy];
                }
                serchTableCell.cityLabel.text=@"";
                cityId=@"";
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                districtIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.districtLabel.text=[searchArr objectAtIndex:indexPath.row];
                districtId=@"";
                serchTableCell.cityLabel.text=@"Any";
                cityId=@"";
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([districtStrng containsString:add]) {
                    districtStrng = [[districtStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    districtStrng= [[districtStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([districtIdStrng containsString:addId]) {
                districtIdStrng = [[districtIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                districtIdStrng= [[districtIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
        
    }
    else if ([button isEqualToString:@"cityBtn"]){
        if(isFiltered == NO){
            if (indexPath.row == 0) {
                serchTableCell.cityLabel.text=[[cityArr objectAtIndex:indexPath.row]valueForKey:@"city_name"];
                cityId=@"";
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                
            }
            else{
                
                NSString *str= [[cityArr objectAtIndex:indexPath.row]valueForKey:@"city_name"];
                NSString *add =[NSString stringWithFormat:@"%@,",str];
                
                if ([cityStrng containsString:add]) {
                    cityStrng = [[cityStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    cityStrng= [[cityStrng stringByAppendingString:add] mutableCopy];
                }
                NSString *addId =[NSString stringWithFormat:@"%@,",[[cityArr objectAtIndex:indexPath.row] valueForKey:@"city_id"]];
                if ([cityIdStrng containsString:addId]) {
                    cityIdStrng = [[cityIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
                else{
                    cityIdStrng= [[cityIdStrng stringByAppendingString:addId] mutableCopy];
                }
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                cityIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.cityLabel.text=[searchArr objectAtIndex:indexPath.row];
                cityId=@"";
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([cityStrng containsString:add]) {
                    cityStrng = [[cityStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    cityStrng= [[cityStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([cityIdStrng containsString:addId]) {
                cityIdStrng = [[cityIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                cityIdStrng= [[cityIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
        
    }
    
    
    else if ([button isEqualToString:@"castebtn"]){
        if(isFiltered == NO){
            if (indexPath.row == 0) {
                serchTableCell.casteLabel.text=@"Any";
                castId=@"";
                castIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
            }
            else{
                NSString *str= [[castArr objectAtIndex:indexPath.row]valueForKey:@"caste_name"];
                NSString *add =[NSString stringWithFormat:@"%@,",str];
                if ([castStrng containsString:add]) {
                    castStrng = [[castStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    castStrng= [[castStrng stringByAppendingString:add] mutableCopy];
                }
                NSString *addId =[NSString stringWithFormat:@"%@,",[[castArr objectAtIndex:indexPath.row] valueForKey:@"caste_id"]];
                if ([castIdStrng containsString:addId]) {
                    castIdStrng = [[castIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
                else{
                    castIdStrng= [[castIdStrng stringByAppendingString:addId] mutableCopy];
                }
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                castIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.casteLabel.text=[searchArr objectAtIndex:indexPath.row];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([castStrng containsString:add]) {
                    castStrng = [[castStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    castStrng= [[castStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([castIdStrng containsString:addId]) {
                castIdStrng = [[castIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                castIdStrng= [[castIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
        
    }

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == _popupTableView)
    {
        UITableViewCell *Pcell = [tableView cellForRowAtIndexPath:indexPath];
        if([selectType isEqualToString:@"multiple"])
        {
            self.popupTableView.allowsMultipleSelection = YES;
            
            
                [img_select_ary addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                
                 cell = (UITableViewCell*)[_popupTableView cellForRowAtIndexPath:indexPath];
                cell.imageView.image = [UIImage imageNamed:@"check-box-with-check-sign.png"];
            
        }
        else
        {
            if((checkCell == ageCell)||(checkCell == heightCell))
            {
                self.popView.hidden = false;
            }
            else
                self.popView.hidden = true;
        
        }
     
        
 if([button isEqualToString:@"maritalStatusBtn"])
    {
        maritalStatusId = [maritalStatusArr objectAtIndex:indexPath.row];
        
        NSString *str= [maritalStatusArr objectAtIndex:indexPath.row];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([maritalStatusStrng containsString:add]) {
            maritalStatusStrng = [[maritalStatusStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            
            
        }
        else{
            maritalStatusStrng= [[maritalStatusStrng stringByAppendingString:add] mutableCopy];
            
        }

        //self.popView.hidden = true;
    }
 else if ([button isEqualToString:@"religionBtn"])
 {
     if(isFiltered == NO)
     {
         if (indexPath.row == 0)
         {
             religionIdStrng=[[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_id"];
             serchTableCell.religionLabel.text=[[religionArr objectAtIndex:indexPath.row]valueForKey:@"religion_name"];
             serchTableCell.MTongueLabel.text=@"Any";
             serchTableCell.casteLabel.text=@"Any";
             mTongueId=@"";
             mTongueIdStrng=[@"" mutableCopy];
             castId=@"";
             castIdStrng=[@"" mutableCopy];
             self.popView.hidden = true;
             
         }
         else
         {
             NSString *str= [[religionArr objectAtIndex:indexPath.row]valueForKey:@"religion_name"];
             NSString *add =[NSString stringWithFormat:@"%@,",str];
             
             if ([religionStrng containsString:add])
             {
                 religionStrng = [[religionStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                 NSIndexPath* selection = [tableView indexPathForSelectedRow];
                 
                 [selectArr removeObject:selection];
             }
             else{
                 religionStrng= [[religionStrng stringByAppendingString:add] mutableCopy];
                 NSIndexPath* selection = [tableView indexPathForSelectedRow];
                 [selectArr addObject:selection];
             }
             NSString *addId =[NSString stringWithFormat:@"%@,",[[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_id"]];
             if ([religionIdStrng containsString:addId]) {
                 
                 religionIdStrng = [[religionIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
             }
             
             else{
                 
                 religionIdStrng= [[religionIdStrng stringByAppendingString:addId] mutableCopy];
             }
             serchTableCell.MTongueLabel.text=@"";
             serchTableCell.casteLabel.text=@"";
             mTongueId=@"";
             mTongueIdStrng=[@"" mutableCopy];
             castId=@"";
             castIdStrng=[@"" mutableCopy];
         }
     }
     else
     {
         NSString *str= [searchArr objectAtIndex:indexPath.row];
         NSString *add =[NSString stringWithFormat:@"%@,",str];
         if ([str isEqualToString:@"Any"]) {
             religionIdStrng=[searchArr objectAtIndex:indexPath.row];
             serchTableCell.religionLabel.text=[searchArr objectAtIndex:indexPath.row];
             self.popView.hidden = true;
             [self.searchBar endEditing:YES];
         }
         else
         {
             if ([religionStrng containsString:add]) {
                 religionStrng = [[religionStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
             }
             else{
                 religionStrng= [[religionStrng stringByAppendingString:add] mutableCopy];
             }
         }
         NSString *strId= [idsArr objectAtIndex:indexPath.row];
         NSString *addId =[NSString stringWithFormat:@"%@,",strId];
         if ([religionIdStrng containsString:addId]) {
             religionIdStrng = [[religionIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
         }
         else{
             religionIdStrng= [[religionIdStrng stringByAppendingString:addId] mutableCopy];
         }
     }
     //  religionId = [[religionArr objectAtIndex:indexPath.row] valueForKey:@"religion_id"];
     
 }
 
 else if ([button isEqualToString:@"physicalStatusBtn"]) {
     //serchTableCell.physicalStatusLabel.text = [physicalStatusArr objectAtIndex:indexPath.row];
//     NSString *str= [physicalStatusArr objectAtIndex:indexPath.row];
//     NSString *add =[NSString stringWithFormat:@"%@,",str];
//
//     if ([physicalStatusStrng containsString:add]) {
//         physicalStatusStrng = [[physicalStatusStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
//     }
//     else{
//         physicalStatusStrng= [[physicalStatusStrng stringByAppendingString:add] mutableCopy];
//     }
//     physicalStatusId =  [physicalStatusArr objectAtIndex:indexPath.row];
     
     
     //for single seletion
     
     
     serchTableCell.physicalStatusLabel.text = [physicalStatusArr objectAtIndex:indexPath.row];
     physicalStatusId =  [physicalStatusArr objectAtIndex:indexPath.row];
     self.popView.hidden = true;
 }
 else if ([button isEqualToString:@"eatingBtn"]) {
     serchTableCell.eatingLabel.text = [eatingArr objectAtIndex:indexPath.row];
     NSString *str= [eatingArr objectAtIndex:indexPath.row];
     NSString *add =[NSString stringWithFormat:@"%@,",str];
     
     if ([eatinStrng containsString:add]) {
         eatinStrng = [[eatinStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
     }
     else{
         eatinStrng= [[eatinStrng stringByAppendingString:add] mutableCopy];
     }
     eatingId = [eatingArr objectAtIndex:indexPath.row];
 //    self.popView.hidden = true;
    }
 else if ([button isEqualToString:@"drinkingBtn"]) {
     NSString *str= [drinkingArr objectAtIndex:indexPath.row];
     NSString *add =[NSString stringWithFormat:@"%@,",str];
     
     if ([drinkStrng containsString:add]) {
         drinkStrng = [[drinkStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
     }
     else{
         drinkStrng= [[drinkStrng stringByAppendingString:add] mutableCopy];
     }

     drinkingId = [drinkingArr objectAtIndex:indexPath.row];
    // self.popView.hidden = true;
 }
 else if ([button isEqualToString:@"smokingBtn"]) {
     //serchTableCell.smokingLabel.text = [drinkingArr objectAtIndex:indexPath.row];
     NSString *str= [drinkingArr objectAtIndex:indexPath.row];
     NSString *add =[NSString stringWithFormat:@"%@,",str];
     
     if ([smokeStrng containsString:add]) {
         smokeStrng = [[smokeStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
     }
     else{
         smokeStrng= [[smokeStrng stringByAppendingString:add] mutableCopy];
     }
     smokingId = [drinkingArr objectAtIndex:indexPath.row];
    // self.popView.hidden = true;
 }
   
        else if ([button isEqualToString:@"MTongueBtn"])
    {
        if(isFiltered == NO)
        {
        if (indexPath.row == 0) {
            
            mTongueIdStrng=[[MTongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_id"];
            serchTableCell.MTongueLabel.text=[[MTongueArr objectAtIndex:indexPath.row]valueForKey:@"mtongue_name"];
                     serchTableCell.casteLabel.text=@"Any";
                castId=@"";
                castIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
        }
        else
        {
        NSString *str= [[MTongueArr objectAtIndex:indexPath.row]valueForKey:@"mtongue_name"];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([mTongueStrng containsString:add]) {
            mTongueStrng = [[mTongueStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            mTongueStrng= [[mTongueStrng stringByAppendingString:add] mutableCopy];
        }
        
            NSString *addId =[NSString stringWithFormat:@"%@,",[[MTongueArr objectAtIndex:indexPath.row] valueForKey:@"mtongue_id"]];
        if ([mTongueIdStrng containsString:addId]) {
            
            mTongueIdStrng = [[mTongueIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
        }
        
        else{
            
            mTongueIdStrng= [[mTongueIdStrng stringByAppendingString:addId] mutableCopy];
        }
            serchTableCell.casteLabel.text=@"";
            castId=@"";
            castIdStrng=[@""mutableCopy];
        }
        }
        else
         {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                mTongueIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.MTongueLabel.text=[searchArr objectAtIndex:indexPath.row];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([mTongueStrng containsString:add]) {
                    mTongueStrng = [[mTongueStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    mTongueStrng= [[mTongueStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([mTongueIdStrng containsString:addId]) {
                mTongueIdStrng = [[mTongueIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                mTongueIdStrng= [[mTongueIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }

    }
    else if ([button isEqualToString:@"starBtn"])
    {
       if(isFiltered == NO){
           
        if (indexPath.row == 0) {
            starIdStrng=[[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_id"];
            serchTableCell.starLabel.text=[[starArr objectAtIndex:indexPath.row]valueForKey:@"stars_name"];
            self.popView.hidden = true;
            }
        else
        {
            NSString *str= [[starArr objectAtIndex:indexPath.row]valueForKey:@"stars_name"];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([starStrng containsString:add]) {
                starStrng = [[starStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            }
            else{
                starStrng= [[starStrng stringByAppendingString:add] mutableCopy];
            }
            NSString *addId =[NSString stringWithFormat:@"%@,",[[starArr objectAtIndex:indexPath.row] valueForKey:@"stars_id"]];
            if ([starIdStrng containsString:addId]) {
                starIdStrng = [[starIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                    }
            else{
            
                starIdStrng= [[starIdStrng stringByAppendingString:addId] mutableCopy];
            }

            }
        }
       else
       {
           NSString *str= [searchArr objectAtIndex:indexPath.row];
           NSString *add =[NSString stringWithFormat:@"%@,",str];
           if ([str isEqualToString:@"Any"]) {
               starIdStrng=[searchArr objectAtIndex:indexPath.row];
               serchTableCell.starLabel.text=[searchArr objectAtIndex:indexPath.row];
               self.popView.hidden = true;
               [self.searchBar endEditing:YES];
           }
           else  {
               if ([starStrng containsString:add]) {
                   starStrng = [[starStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
               }
               else{
                   starStrng= [[starStrng stringByAppendingString:add] mutableCopy];
               }
           }
           NSString *strId= [idsArr objectAtIndex:indexPath.row];
           NSString *addId =[NSString stringWithFormat:@"%@,",strId];
           if ([starIdStrng containsString:addId]) {
               starIdStrng = [[starIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
           }
           else{
               starIdStrng= [[starIdStrng stringByAppendingString:addId] mutableCopy];
           }
       }
    }
        
    else if ([button isEqualToString:@"educationBtn"]){
        if(isFiltered == NO){
        if (indexPath.row == 0) {
            serchTableCell.educationLAbel.text=[[eduArr objectAtIndex:indexPath.row]valueForKey:@"edu_name"];
            eduIdStrng=[[eduArr objectAtIndex:indexPath.row] valueForKey:@"edu_id"];
            self.popView.hidden = true;
            eduId=@"";
            eduIdStrng=[@""mutableCopy];
            }
        else
          {
            NSString *str= [[eduArr objectAtIndex:indexPath.row]valueForKey:@"edu_name"];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
        
            if ([eduStrng containsString:add]) {
                eduStrng = [[eduStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            }
            else{
                eduStrng= [[eduStrng stringByAppendingString:add] mutableCopy];
            }
            NSString *addId =[NSString stringWithFormat:@"%@,",[[eduArr objectAtIndex:indexPath.row-1] valueForKey:@"edu_id"]];
            if ([eduIdStrng containsString:addId]) {
                eduIdStrng = [[eduIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
            else{
                eduIdStrng= [[eduIdStrng stringByAppendingString:addId] mutableCopy];
            }
         }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                eduIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.educationLAbel.text=[searchArr objectAtIndex:indexPath.row];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([eduStrng containsString:add]) {
                    eduStrng = [[eduStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    eduStrng= [[eduStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([eduIdStrng containsString:addId]) {
                eduIdStrng = [[eduIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                eduIdStrng= [[eduIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
    }
    else if ([button isEqualToString:@"occupationBtn"])
    {
     if(isFiltered == NO){
        if (indexPath.row == 0) {
            serchTableCell.occupationLabel.text=[[ocpArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
            ocpIdStrng=[[ocpArr objectAtIndex:indexPath.row] valueForKey:@"ocp_id"];
            self.popView.hidden = true;
            ocpID=@"";
            ocpIdStrng=[@""mutableCopy];
        }
        else
        {
        NSString *str= [[ocpArr objectAtIndex:indexPath.row]valueForKey:@"ocp_name"];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([ocpStrng containsString:add]) {
            ocpStrng = [[ocpStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            ocpStrng= [[ocpStrng stringByAppendingString:add] mutableCopy];
        }
        NSString *addId =[NSString stringWithFormat:@"%@,",[[ocpArr objectAtIndex:indexPath.row] valueForKey:@"ocp_id"]];
        if ([ocpIdStrng containsString:addId]) {
            
            ocpIdStrng = [[ocpIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
        else{
            
            ocpIdStrng= [[ocpIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
     }
     else
     {
         NSString *str= [searchArr objectAtIndex:indexPath.row];
         NSString *add =[NSString stringWithFormat:@"%@,",str];
         if ([str isEqualToString:@"Any"]) {
             ocpIdStrng=[searchArr objectAtIndex:indexPath.row];
             serchTableCell.occupationLabel.text=[searchArr objectAtIndex:indexPath.row];
             self.popView.hidden = true;
             [self.searchBar endEditing:YES];
         }
         else  {
             if ([ocpStrng containsString:add]) {
                 ocpStrng = [[ocpStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
             }
             else{
                 ocpStrng= [[ocpStrng stringByAppendingString:add] mutableCopy];
             }
         }
         NSString *strId= [idsArr objectAtIndex:indexPath.row];
         NSString *addId =[NSString stringWithFormat:@"%@,",strId];
         if ([ocpIdStrng containsString:addId]) {
             ocpIdStrng = [[ocpIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
         }
         else{
             ocpIdStrng= [[ocpIdStrng stringByAppendingString:addId] mutableCopy];
         }
     }
    }

    else if ([button isEqualToString:@"CountryBtn"]){
        if(isFiltered == NO){
        if (indexPath.row == 0) {
            serchTableCell.countryLabel.text=[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
            countryId=@"";
            cuntryIdString=[@"" mutableCopy];
            serchTableCell.stateLabel.text=@"Any";
            stateId=@"";
            stateIdStrng=[@"" mutableCopy];
            serchTableCell.districtLabel.text=@"Any";
            districtId=@"";
            districtIdStrng=[@"" mutableCopy];
            serchTableCell.cityLabel.text=@"Any";
            cityId=@"";
            cityIdStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
        else
        {
            NSString*str=[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_name"];
            NSString*add=[NSString stringWithFormat:@"%@," ,str];
            if ([cuntryStatusString containsString:add ]) {
                cuntryStatusString=[[cuntryStatusString stringByReplacingOccurrencesOfString:add withString:@""]    mutableCopy];
            }
            else{
                cuntryStatusString=[[cuntryStatusString stringByAppendingString:add]mutableCopy];
            }
            NSString*str1=[[countryArr objectAtIndex:indexPath.row]valueForKey:@"country_id"];
            NSString*add1=[NSString stringWithFormat:@"%@," ,str1];
            if ([cuntryIdString containsString:add1 ]) {
                cuntryIdString=[[cuntryIdString stringByReplacingOccurrencesOfString:add1 withString:@""]mutableCopy];
            }
            else{
                cuntryIdString=[[cuntryIdString stringByAppendingString:add1]mutableCopy];
                }
                serchTableCell.stateLabel.text=@"";
                stateId=@"";
                stateIdStrng=[@"" mutableCopy];
                serchTableCell.districtLabel.text=@"";
                districtId=@"";
                districtIdStrng=[@"" mutableCopy];
                serchTableCell.cityLabel.text=@"";
                cityId=@"";
                cityIdStrng=[@"" mutableCopy];
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
        }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                cuntryIdString=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.countryLabel.text=[searchArr objectAtIndex:indexPath.row];
                countryId=@"";
                cuntryIdString=[@"" mutableCopy];
                serchTableCell.stateLabel.text=@"Any";
                stateId=@"";
                stateIdStrng=[@"" mutableCopy];
                serchTableCell.districtLabel.text=@"Any";
                districtId=@"";
                districtIdStrng=[@"" mutableCopy];
                serchTableCell.cityLabel.text=@"Any";
                cityId=@"";
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([cuntryStatusString containsString:add]) {
                    cuntryStatusString = [[cuntryStatusString stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    cuntryStatusString= [[cuntryStatusString stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([cuntryIdString containsString:addId]) {
                cuntryIdString = [[cuntryIdString stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                cuntryIdString= [[cuntryIdString stringByAppendingString:addId] mutableCopy];
            }
        }
    }
        
    else if ([button isEqualToString:@"stateBtn"]) {
        if(isFiltered == NO){
            if (indexPath.row == 0) {
                serchTableCell.stateLabel.text=[[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"];
                stateId=@"";
                serchTableCell.districtLabel.text=@"Any";
                districtId=@"";
                serchTableCell.cityLabel.text=@"Any";
                cityId=@"";
                stateIdStrng=[@"" mutableCopy];
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;

            }
          else{
             NSString *str= [[stateArr objectAtIndex:indexPath.row]valueForKey:@"state_name"];
             NSString *add =[NSString stringWithFormat:@"%@,",str];
             if ([stateStrng containsString:add]) {
                stateStrng = [[stateStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            }
            else{
                stateStrng= [[stateStrng stringByAppendingString:add] mutableCopy];
            }
             NSString *addId =[NSString stringWithFormat:@"%@,",[[stateArr objectAtIndex:indexPath.row] valueForKey:@"state_id"]];
             if ([stateIdStrng containsString:addId]) {
                stateIdStrng = [[stateIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
            else{
                stateIdStrng= [[stateIdStrng stringByAppendingString:addId] mutableCopy];
                }
                serchTableCell.districtLabel.text=@"";
                districtId=@"";
                serchTableCell.cityLabel.text=@"";
                cityId=@"";
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
         }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                stateIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.stateLabel.text=[searchArr objectAtIndex:indexPath.row];
                stateId=@"";
                serchTableCell.districtLabel.text=@"Any";
                districtId=@"";
                serchTableCell.cityLabel.text=@"Any";
                cityId=@"";
                stateIdStrng=[@"" mutableCopy];
                districtIdStrng=[@"" mutableCopy];
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([stateStrng containsString:add]) {
                    stateStrng = [[stateStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    stateStrng= [[stateStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([stateIdStrng containsString:addId]) {
                stateIdStrng = [[stateIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                stateIdStrng= [[stateIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }
    }
    else if ([button isEqualToString:@"DistrictBtn"]) {
      if(isFiltered == NO){
        if (indexPath.row == 0) {
            serchTableCell.districtLabel.text=[[districtArr objectAtIndex:indexPath.row]valueForKey:@"district_name"];
           
            serchTableCell.cityLabel.text=@"Any";
             districtId=@"";
            cityId=@"";
            districtIdStrng=[@"" mutableCopy];
            cityIdStrng=[@"" mutableCopy];
            self.popView.hidden = true;

        }
        else{

        NSString *str= [[districtArr objectAtIndex:indexPath.row]valueForKey:@"district_name"];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([districtStrng containsString:add]) {
            districtStrng = [[districtStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            districtStrng= [[districtStrng stringByAppendingString:add] mutableCopy];
        }
        NSString *addId =[NSString stringWithFormat:@"%@,",[[districtArr objectAtIndex:indexPath.row] valueForKey:@"district_id"]];
        if ([districtIdStrng containsString:addId]) {
            
            districtIdStrng = [[districtIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
        }
        
        else{
            
            districtIdStrng= [[districtIdStrng stringByAppendingString:addId] mutableCopy];
        }
            serchTableCell.cityLabel.text=@"";
            cityId=@"";
        }
      }
      else
      {
          NSString *str= [searchArr objectAtIndex:indexPath.row];
          NSString *add =[NSString stringWithFormat:@"%@,",str];
          if ([str isEqualToString:@"Any"]) {
              districtIdStrng=[searchArr objectAtIndex:indexPath.row];
              serchTableCell.districtLabel.text=[searchArr objectAtIndex:indexPath.row];
              districtId=@"";
              serchTableCell.cityLabel.text=@"Any";
              cityId=@"";
              districtIdStrng=[@"" mutableCopy];
              cityIdStrng=[@"" mutableCopy];
              self.popView.hidden = true;
              [self.searchBar endEditing:YES];
          }
          else  {
              if ([districtStrng containsString:add]) {
                  districtStrng = [[districtStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
              }
              else{
                  districtStrng= [[districtStrng stringByAppendingString:add] mutableCopy];
              }
          }
          NSString *strId= [idsArr objectAtIndex:indexPath.row];
          NSString *addId =[NSString stringWithFormat:@"%@,",strId];
          if ([districtIdStrng containsString:addId]) {
              districtIdStrng = [[districtIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
          }
          else{
              districtIdStrng= [[districtIdStrng stringByAppendingString:addId] mutableCopy];
          }
      }

    }
    else if ([button isEqualToString:@"cityBtn"]){
        if(isFiltered == NO){
        if (indexPath.row == 0) {
            serchTableCell.cityLabel.text=[[cityArr objectAtIndex:indexPath.row]valueForKey:@"city_name"];
            cityId=@"";
            cityIdStrng=[@"" mutableCopy];
            self.popView.hidden = true;
            
        }
        else{

        NSString *str= [[cityArr objectAtIndex:indexPath.row]valueForKey:@"city_name"];
        NSString *add =[NSString stringWithFormat:@"%@,",str];
        
        if ([cityStrng containsString:add]) {
            cityStrng = [[cityStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
        }
        else{
            cityStrng= [[cityStrng stringByAppendingString:add] mutableCopy];
        }
        NSString *addId =[NSString stringWithFormat:@"%@,",[[cityArr objectAtIndex:indexPath.row] valueForKey:@"city_id"]];
            if ([cityIdStrng containsString:addId]) {
            cityIdStrng = [[cityIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                cityIdStrng= [[cityIdStrng stringByAppendingString:addId] mutableCopy];
            }
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                cityIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.cityLabel.text=[searchArr objectAtIndex:indexPath.row];
                cityId=@"";
                cityIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([cityStrng containsString:add]) {
                    cityStrng = [[cityStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    cityStrng= [[cityStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([cityIdStrng containsString:addId]) {
                cityIdStrng = [[cityIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                cityIdStrng= [[cityIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }

    }
        
        
    else if ([button isEqualToString:@"castebtn"]){
        if(isFiltered == NO){
            if (indexPath.row == 0) {
                serchTableCell.casteLabel.text=@"Any";
                castId=@"";
                castIdStrng=[@"" mutableCopy];
                self.popView.hidden = true;
                }
        else{
            NSString *str= [[castArr objectAtIndex:indexPath.row]valueForKey:@"caste_name"];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([castStrng containsString:add]) {
                castStrng = [[castStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
            }
            else{
                castStrng= [[castStrng stringByAppendingString:add] mutableCopy];
            }
            NSString *addId =[NSString stringWithFormat:@"%@,",[[castArr objectAtIndex:indexPath.row] valueForKey:@"caste_id"]];
            if ([castIdStrng containsString:addId]) {
                castIdStrng = [[castIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
                }
            else{
                castIdStrng= [[castIdStrng stringByAppendingString:addId] mutableCopy];
                }
            }
        }
        else
        {
            NSString *str= [searchArr objectAtIndex:indexPath.row];
            NSString *add =[NSString stringWithFormat:@"%@,",str];
            if ([str isEqualToString:@"Any"]) {
                castIdStrng=[searchArr objectAtIndex:indexPath.row];
                serchTableCell.casteLabel.text=[searchArr objectAtIndex:indexPath.row];
                self.popView.hidden = true;
                [self.searchBar endEditing:YES];
            }
            else  {
                if ([castStrng containsString:add]) {
                    castStrng = [[castStrng stringByReplacingOccurrencesOfString:add withString:@""] mutableCopy];
                }
                else{
                    castStrng= [[castStrng stringByAppendingString:add] mutableCopy];
                }
            }
            NSString *strId= [idsArr objectAtIndex:indexPath.row];
            NSString *addId =[NSString stringWithFormat:@"%@,",strId];
            if ([castIdStrng containsString:addId]) {
                castIdStrng = [[castIdStrng stringByReplacingOccurrencesOfString:addId withString:@""] mutableCopy];
            }
            else{
                castIdStrng= [[castIdStrng stringByAppendingString:addId] mutableCopy];
            }
        }

      }
   }
    else
    {
        if ([button isEqualToString:@"ageFromBtn"]) {
            ageCell.ageFromLabel.text = [NSString stringWithFormat:@"%@",[ageArr objectAtIndex:indexPath.row]];
            ageFromId = [NSString stringWithFormat:@"%@",[ageArr objectAtIndex:indexPath.row]];
            self.smallPopupTableView.hidden=true;
        }
        else if ([button isEqualToString:@"ageToBtn"]) {
            ageCell.ageToLabel.text = [NSString stringWithFormat:@"%@",[ageArr objectAtIndex:indexPath.row]];
            ageToId = [NSString stringWithFormat:@"%@",[ageArr objectAtIndex:indexPath.row]];
            self.smallPopupTableView.hidden=true;
        }
        else if ([button isEqualToString:@"heightFromBtn"]) {
            heightCell.heightFromLabel.text = [NSString stringWithFormat:@"%@",[heightArr objectAtIndex:indexPath.row]];
            heightFromId = [NSString stringWithFormat:@"%@",[heightServiceArr objectAtIndex:indexPath.row]];
            self.smallPopupTableView.hidden=true;
        }
        else if ([button isEqualToString:@"heightToBtn"])
        {
            heightCell.heightToLabel.text = [NSString stringWithFormat:@"%@",[heightArr objectAtIndex:indexPath.row]];
            heightToId = [NSString stringWithFormat:@"%@",[heightServiceArr objectAtIndex:indexPath.row]];
            self.smallPopupTableView.hidden=true;
            
        }
      /*  else if ([button isEqualToString:@"incomeFromBtn"]){
            incomeCell.incomeFromLabel.text = [NSString stringWithFormat:@"%@",[annualIncmArr objectAtIndex:indexPath.row]];
            incomFromID = [NSString stringWithFormat:@"%@",[annualIncmArr objectAtIndex:indexPath.row]];
            self.smallPopupTableView.hidden=true;
        }
        else if ([button isEqualToString:@"incomeToBtn"]){
            incomeCell.incomeToLabel.text = [NSString stringWithFormat:@"%@",[annualIncmArr objectAtIndex:indexPath.row]];
            incomToID = [NSString stringWithFormat:@"%@",[annualIncmArr objectAtIndex:indexPath.row]];
            self.smallPopupTableView.hidden=true;
        }*/
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _searchMainTableView)
    {
    return 1000;
    }
    else
    {
        if ([button isEqualToString:@"ageBtn"]) {
            return 145;
        }
        else if ([button isEqualToString:@"heightBtn"]) {
            return 145;
        }
        else if ([button isEqualToString:@"annualIncomeBtn"]) {
            return 145;
        }
        else
        {
            return 48;
        }
    }
}

#pragma mark - buttonActionMethods

-(void)maritalStatusBtnAction
{
    
    button = @"maritalStatusBtn";
    selectType =  @"multiple";
   // _popupTableView.allowsSelection = NO;
    //  selectType =  @"";
    [self popupsServiceHandiler];
}

-(void)physicalStatusBtnAction
{
    
    button = @"physicalStatusBtn";
    selectType =  @"multiple";
    //  selectType =  @"";
    [self popupsServiceHandiler];
}
//
-(void)eatingBtnAction
{
    button = @"eatingBtn";
   selectType =  @"multiple";
    //  selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)drinkingBtnAction
{
    button = @"drinkingBtn";
   selectType =  @"multiple";
    //  selectType =  @"";
    [self popupsServiceHandiler];
}
-(void)smokingBtnAction
{
    button = @"smokingBtn";
    selectType =  @"multiple";
    //  selectType =  @"";
    [self popupsServiceHandiler];
}
//
-(void)ageBtnAction
{
    button = @"ageBtn";
    //  selectType =  @"multiple";
    //  selectType =  @"";
 // _popupTableView.allowsSelection = NO;
    [self.searchBar setUserInteractionEnabled:NO];
    [self popupsServiceHandiler];
}
//
-(void)ageFromBtnAction
{
    
    button = @"ageFromBtn";
   
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =false;

}
-(void)ageToBtnAction
{
    button = @"ageToBtn";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =false;
   
}
//
-(void)heightBtnAction
{
    button = @"heightBtn";
  // _popupTableView.allowsSelection = NO;
    [self.searchBar setUserInteractionEnabled:NO];
    [self popupsServiceHandiler];
}
//
-(void)heightFromBtnAction
{
    button = @"heightFromBtn";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =false;
}
-(void)heightToBtnAction
{
    button = @"heightToBtn";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =false;
}
-(void)religionBtnAction
{
   // _popupTableView.allowsSelection = YES;
    button = @"religionBtn";
    selectType =  @"multiple";
    [self popupsServiceHandiler];
     self.smallPopupTableView.hidden =true;
}
-(void)MTongueBtnAction
{
    if([serchTableCell.religionLabel.text isEqualToString:@"Any"])
    {
        ALERT_DIALOG(@"Alert", @"please change Religion");
    }
    else
    {
    button = @"MTongueBtn";
    selectType =  @"multiple";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =true;
    }
}
-(void)starBtnAction
{
    button = @"starBtn";
    selectType =  @"multiple";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =true;
}
-(void)educationBtnAction
{
    button = @"educationBtn";
    selectType =  @"multiple";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =true;
}
-(void)occupationBtnAction
{
    button = @"occupationBtn";
     selectType =  @"multiple";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =true;
}
/*-(void)annualIncomeBtnAction
{
    button = @"annualIncomeBtn";
    selectType=@"";
    [self.searchBar setUserInteractionEnabled:NO];
    [self popupsServiceHandiler];
}

-(void)incomeFromBtnAction
{
    button = @"incomeFromBtn";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =false;
}
-(void)incomeToBtnAction
{
    button = @"incomeToBtn";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =false;
}*/
//
-(void)CountryBtnAction
{
    button = @"CountryBtn";
    selectType=@"multiple";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =true;
}
-(void)stateBtnAction
{
    if ([serchTableCell.countryLabel.text isEqualToString:@"Any"]) {
        ALERT_DIALOG(@"Alert", @"Please change Country");
    }
    else
    {
    
    if([serchTableCell.countryLabel.text isEqualToString:@""])
    {
        ALERT_DIALOG(@"Alert", @"Please enter Country");
    }
    else
    {
    button = @"stateBtn";
        selectType =  @"multiple";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =true;
    }
    }
}

-(void)DistrictBtnAction
{
    if ([serchTableCell.stateLabel.text isEqualToString:@"Any"]) {
        ALERT_DIALOG(@"Alert", @"Please change State");
    }
else
{
    if([serchTableCell.countryLabel.text isEqualToString:@""]||[serchTableCell.stateLabel.text isEqualToString:@""])
    {
        ALERT_DIALOG(@"Alert", @"Please enter Country and State");
    }
    else
    {
    button = @"DistrictBtn";
    selectType =  @"multiple";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =true;
    }
    }
}
-(void)cityBtnAction
{
   if ([serchTableCell.districtLabel.text isEqualToString:@"Any"]) {
       ALERT_DIALOG(@"Alert", @"Please change District");
   }
    else
    {
    if([serchTableCell.countryLabel.text isEqualToString:@""]||[serchTableCell.stateLabel.text isEqualToString:@""]||[serchTableCell.districtLabel.text isEqualToString:@""])
    {
        ALERT_DIALOG(@"Alert", @"Please enter Country,State and District");
    }
    else
    {
    button = @"cityBtn";
        selectType =  @"multiple";
    [self popupsServiceHandiler];
    self.smallPopupTableView.hidden =true;
    }
   }
}
-(void)castebtnAction
{
    if ([serchTableCell.MTongueLabel.text isEqualToString:@"Any"]) {
        ALERT_DIALOG(@"Alert", @"Please change Mother Tongue");
    }
    else
    {
    button = @"castebtn";
    if ([serchTableCell.religionLabel.text isEqualToString:@""]||[serchTableCell.MTongueLabel.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"Please enter Religion and Mother Tongue");
    }
    else
    {
        [self popupsServiceHandiler];
         selectType =  @"multiple";
        self.smallPopupTableView.hidden =true;
    }
    }
}

-(void)idsInitialAllocation:(NSDictionary *)result_Dict
{
     //profileTextID = [result_Dict valueForKey:@"profile_text"];
    ageToId = [result_Dict valueForKey:@"part_to_age"];
    ageFromId = [result_Dict valueForKey:@"part_frm_age"];
    heightToId = [result_Dict valueForKey:@"part_height_to"];
    heightFromId = [result_Dict valueForKey:@"part_height"];
    maritalStatusId = [result_Dict valueForKey:@"looking_for"];
    religionId = [result_Dict valueForKey:@"part_religion"];
    castId = [result_Dict valueForKey:@"part_caste"];
    stateId = [result_Dict valueForKey:@"part_state"];
    mTongueId = [result_Dict valueForKey:@"part_mtongue"];
    starId = [result_Dict valueForKey:@"part_star"];
    countryId = [result_Dict valueForKey:@"part_country_living"];
    stateId = [result_Dict valueForKey:@"part_state"];
    districtId = [result_Dict valueForKey:@"part_district"];
    cityId = [result_Dict valueForKey:@"part_city"];
    eduId = [result_Dict valueForKey:@"part_edu"];
    ocpID = [result_Dict valueForKey:@"part_occupation"];
    physicalStatusId = [result_Dict valueForKey:@"part_phstatus"];
    eatingId = [result_Dict valueForKey:@"part_diet"];
    drinkingId = [result_Dict valueForKey:@"part_drink"];
    smokingId = [result_Dict valueForKey:@"part_smoke"];
    // = [result_Dict valueForKey:@"part_drink"];
}


#pragma mark - serviceCalls

-(void)popupsServiceHandiler
{
    self.popView.hidden = false;
    [self.view endEditing:YES];
    
    if ([button isEqualToString:@"maritalStatusBtn"]) {
        
        
        maritalStatusArr = [[NSMutableArray alloc]initWithObjects:@"UnMarried",@"Widow/Widower",@"Divorced",@"Separated", nil];
        [self.popupTableView reloadData];

    }
  else if ([button isEqualToString:@"physicalStatusBtn"]) {
      physicalStatusArr = [[NSMutableArray alloc]initWithObjects:@"Any",@"Normal",@"Physically Challenged", nil];
        [self.popupTableView reloadData];
        
    }
    //
  else if ([button isEqualToString:@"eatingBtn"]) {
  eatingArr = [[NSMutableArray alloc]initWithObjects:@"All",@"Vegetarian",@"Non Vegetarian",@"Eggetarian", nil];
      [self.popupTableView reloadData];
      
  }
  else if ([button isEqualToString:@"drinkingBtn"]) {
      drinkingArr = [[NSMutableArray alloc]initWithObjects:@"No",@"Occasionally",@"Yes", nil];
      [self.popupTableView reloadData];
      
  }
    //
  else if ([button isEqualToString:@"smokingBtn"]) {
      drinkingArr = [[NSMutableArray alloc]initWithObjects:@"No",@"Occasionally",@"Yes", nil];
      [self.popupTableView reloadData];
      
  }
  else if ([button isEqualToString:@"ageBtn"]) {
      [self.popupTableView reloadData];
      
  }
  else if ([button isEqualToString:@"heightBtn"]) {
      [self.popupTableView reloadData];
      
  }
 /* else if ([button isEqualToString:@"annualIncomeBtn"]) {
      [self.popupTableView reloadData];
  }*/

  else if ([button isEqualToString:@"ageFromBtn"]||[button isEqualToString:@"ageToBtn"]){
      ageArr = [[NSMutableArray alloc]init];
      for (int i=18; i<=60; i++) {
          [ageArr addObject:@(i)];
      }
      [self.smallPopupTableView reloadData];
  }

  else if ([button isEqualToString:@"heightFromBtn"]||[button isEqualToString:@"heightToBtn"]){
      heightArr = [[NSMutableArray alloc]initWithObjects:@"Below 4 ft",@"4 ft 06 in",@"4 ft 07 in",@"4 ft 08 in",@"4 ft 09 in",@"4 ft 10 in",@"4 ft 11 in",@"5 ft 0 in",@"5 ft 01 in",@"5 ft 02 in",@"5 ft 03 in",@"5 ft 04 in",@"5 ft 05 in",@"5 ft 06 in",@"5 ft 07 in",@"5 ft 08 in",@"5 ft 09 in",@"5 ft 10 in",@"5 ft 11 in",@"6 ft 0 in",@"6 ft 01 in",@"6 ft 02 in",@"6 ft 03 in",@"6 ft 04 in",@"6 ft 05 in",@"6 ft 06 in",@"6 ft 07 in",@"6 ft 08 in",@"6 ft 09 in",@"6 ft 10 in",@"6 ft 11 in",@"7 ft 00 in",@"Above 7 ft", nil];
      [self.smallPopupTableView reloadData];
  }
 /* else if ([button isEqualToString:@"incomeFromBtn"]||[button isEqualToString:@"incomeToBtn"]){
     annualIncmArr   = [[NSMutableArray alloc]initWithObjects:@"Rs 10,000 - 50,000",@"Rs 50,000 - 1,00,000",@"Rs 1,00,000 - 2,00,000",@"Rs 2,00,000 - 5,00,000",@"Rs 5,00,000 - 10,00,000",@"Rs 10,00,000 - 50,00,000",@"Rs 50,00,000 - 1,00,00,000",@"Above Rs 1,00,00,000",@"Does Not Matter", nil];
      [self.smallPopupTableView reloadData];
  }*/
  else if ([button isEqualToString:@"religionBtn"]) {
      [self popupServiceCall:@"services/api/dropdownlist"];
      
  }
  else if ([button isEqualToString:@"MTongueBtn"]) {
      [self popupServiceCall:@"services/api/dropdownlist"];
      
  }
  else if ([button isEqualToString:@"starBtn"]) {
      [self popupServiceCall:@"services/api/dropdownlist"];
      
  }
  else if ([button isEqualToString:@"educationBtn"]) {
      [self popupServiceCall:@"services/api/dropdownlist"];
      
  }
  else if ([button isEqualToString:@"occupationBtn"]) {
      [self popupServiceCall:@"services/api/dropdownlist"];
      
  }
  else if ([button isEqualToString:@"CountryBtn"]) {
      [self popupServiceCall:@"services/api/dropdownlist"];
  }
  else if ([button isEqualToString:@"stateBtn"])    {
      NSDictionary *params = @{@"country_id": countryId};
      [self popupServiceCall:@"services/api/statesList" params:params];
  }

  else if ([button isEqualToString:@"DistrictBtn"])    {
      NSDictionary *params = @{@"country_id": countryId,@"state_id":stateId};
      [self popupServiceCall:@"services/api/districtlist" params:params];
  }
    //
  else if ([button isEqualToString:@"cityBtn"])    {
      NSDictionary *params = @{@"country_id": countryId,@"state_id":stateId,@"district_id":districtId};
      [self popupServiceCall:@"services/api/citiesList" params:params];
  }
    // , NSDictionary *params = ;
   // [self popupServiceCall:@"services/api/casteList" params:params];
  else if ([button isEqualToString:@"castebtn"])    {
      NSDictionary *params = @{@"religion_id": religionId,@"m_tongue":mTongueId};
      [self popupServiceCall:@"services/api/casteList" params:params];
  }
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
                 
               //  ALERT_DIALOG(@"alert", @"succes");
                 
                 if ([button isEqualToString:@"stateBtn"]) {
                     stateArr = [[NSMutableArray alloc] init];
                     stateArr=[res_dict valueForKey:@"statelist"];
                     NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                     [dict setValue:@"Any" forKey:@"state_name"];
                     [dict setValue:@"" forKey:@"state_id"];
                     [dict setValue:@"APPROVED" forKey:@"status"];
                     
                     NSMutableArray *tempArr =[NSMutableArray new];
                     
                     [tempArr addObject:dict];
                     [tempArr addObjectsFromArray:stateArr];
                     stateArr= tempArr;

                     
                     [_popupTableView reloadData];
                 }
                 else if ([button isEqualToString:@"DistrictBtn"]){
                     districtArr = [[NSMutableArray alloc] init];
                     districtArr=[res_dict valueForKey:@"districtlist"];
                     NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                     [dict setValue:@"Any" forKey:@"district_name"];
                     [dict setValue:@"" forKey:@"district_id"];
                     [dict setValue:@"APPROVED" forKey:@"status"];
                     
                     NSMutableArray *tempArr =[NSMutableArray new];
                     
                     [tempArr addObject:dict];
                     [tempArr addObjectsFromArray:districtArr];
                     districtArr= tempArr;

                     [_popupTableView reloadData];
                 }
                 else if ([button isEqualToString:@"cityBtn"]){
                     cityArr = [[NSMutableArray alloc] init];
                     cityArr=[res_dict valueForKey:@"citylist"];
                     NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                     [dict setValue:@"Any" forKey:@"city_name"];
                     [dict setValue:@"" forKey:@"city_id"];
                     [dict setValue:@"APPROVED" forKey:@"status"];
                     
                     NSMutableArray *tempArr =[NSMutableArray new];
                     
                     [tempArr addObject:dict];
                     [tempArr addObjectsFromArray:cityArr];
                     cityArr= tempArr;
                     

                     [_popupTableView reloadData];

                 }
                 else if ([button isEqualToString:@"castebtn"]){
                     castArr = [[NSMutableArray alloc] init];
                     castArr=[res_dict valueForKey:@"castelist"];
                     NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                     [dict setValue:@"Any" forKey:@"caste_name"];
                     [dict setValue:@"" forKey:@"caste_id"];
                     [dict setValue:@"APPROVED" forKey:@"status"];
                     
                     NSMutableArray *tempArr =[NSMutableArray new];
                     
                     [tempArr addObject:dict];
                     [tempArr addObjectsFromArray:castArr];
                     castArr= tempArr;
                     [_popupTableView reloadData];
                     
                 }
             }
             else
             {
                 ALERT_DIALOG(@"Alert", result);
             }
         }
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
                if ([button isEqualToString:@"religionBtn"]) {
                     religionArr=[popUPList valueForKey:@"religionslist"];
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:@"Any" forKey:@"religion_name"];
                    [dict setValue:@"" forKey:@"religion_id"];
                    [dict setValue:@"APPROVED" forKey:@"status"];
                    
                    NSMutableArray *tempArr =[NSMutableArray new];
                    
                    [tempArr addObject:dict];
                    [tempArr addObjectsFromArray:religionArr];
                    religionArr= tempArr;
                     [_popupTableView reloadData];
                 }
                else if ([button isEqualToString:@"MTongueBtn"])
                {
                    MTongueArr=[popUPList valueForKey:@"languageslist"];
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:@"Any" forKey:@"mtongue_name"];
                    [dict setValue:@"" forKey:@"mtongue_id"];
                    [dict setValue:@"APPROVED" forKey:@"status"];
                    
                    NSMutableArray *tempArr =[NSMutableArray new];
                    
                    [tempArr addObject:dict];
                    [tempArr addObjectsFromArray:MTongueArr];
                    MTongueArr= tempArr;
                    [_popupTableView reloadData];
                }
                else if ([button isEqualToString:@"starBtn"])
                {
                    starArr=[popUPList valueForKey:@"starslist"];
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:@"Any" forKey:@"stars_name"];
                    [dict setValue:@"" forKey:@"stars_id"];
                    [dict setValue:@"APPROVED" forKey:@"status"];
                    
                    NSMutableArray *tempArr =[NSMutableArray new];
                    
                    [tempArr addObject:dict];
                    [tempArr addObjectsFromArray:starArr];
                    starArr= tempArr;
                    
                    
                    
                    [_popupTableView reloadData];
                }
                else if ([button isEqualToString:@"educationBtn"]){
                    eduArr=[popUPList valueForKey:@"educationlist"];
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:@"Any" forKey:@"edu_name"];
                    [dict setValue:@"" forKey:@"edu_id"];
                    [dict setValue:@"APPROVED" forKey:@"status"];
                    
                    NSMutableArray *tempArr =[NSMutableArray new];
                    
                    [tempArr addObject:dict];
                    [tempArr addObjectsFromArray:eduArr];
                    eduArr= tempArr;

                    [_popupTableView reloadData];
                }
                else if ([button isEqualToString:@"occupationBtn"]){
                    ocpArr=[popUPList valueForKey:@"occupationlist"];
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:@"Any" forKey:@"ocp_name"];
                    [dict setValue:@"" forKey:@"ocp_id"];
                    [dict setValue:@"APPROVED" forKey:@"status"];
                    
                    NSMutableArray *tempArr =[NSMutableArray new];
                    
                    [tempArr addObject:dict];
                    [tempArr addObjectsFromArray:ocpArr];
                    ocpArr= tempArr;

                    [_popupTableView reloadData];
                }
                else if ([button isEqualToString:@"CountryBtn"]){
                    countryArr=[popUPList valueForKey:@"countrieslist"];
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:@"Any" forKey:@"country_name"];
                    [dict setValue:@"" forKey:@"country_id"];
                    [dict setValue:@"APPROVED" forKey:@"status"];
                    
                    NSMutableArray *tempArr =[NSMutableArray new];
                    
                    [tempArr addObject:dict];
                    [tempArr addObjectsFromArray:countryArr];
                    countryArr = tempArr;
                    
                    [_popupTableView reloadData];
                }
             }
         }
     }];
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
                [self idsInitialAllocation:[res_dict valueForKey:@"profilelist"]];
                [_searchMainTableView reloadData];
                 
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

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelAction:(id)sender
{
    [img_select_ary removeAllObjects];

    isFiltered = NO;
    [self.searchBar setText:@""];
    if (selectedCell == ageCell) {
        ageCell.ageFromLabel.text=@"";
        ageCell.ageToLabel.text=@"";
        self.smallPopupTableView.hidden =true;
    }
   else if (selectedCell == heightCell) {
        self.smallPopupTableView.hidden =true;
    }
  /* else if (selectedCell == incomeCell) {
       self.smallPopupTableView.hidden =true;
   }*/
    self.popView.hidden = true;
}
-(void)setaccessoryType:(UITableViewCellAccessoryType)accessoryType
{
    
}
- (IBAction)okAction:(id)sender
{
    [img_select_ary removeAllObjects];
    isFiltered = NO;
    [self.searchBar setText:@""];
//    UITableViewCell *cell = [_popupTableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:0]];
   // cell.accessoryType = UITableViewCellAccessoryNone;
    if ([button isEqualToString:@"maritalStatusBtn"]) {
        if([maritalStatusStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
           // _popupTableView.hidden =false;
        }
        else
        {
        serchTableCell.maritalStatusLabel.text =@"";
            NSString *lastCharId = [maritalStatusStrng substringFromIndex:[maritalStatusStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                maritalStatusStrng = [[maritalStatusStrng substringToIndex:[maritalStatusStrng length] - 1] mutableCopy];
            }
        maritalStatusId = maritalStatusStrng;
        serchTableCell.maritalStatusLabel.text = maritalStatusId;
        maritalStatusStrng = [@"" mutableCopy];
            self.popView.hidden = true;
        }
    }
    else if ([button isEqualToString:@"CountryBtn"])
    {
        if([cuntryStatusString isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
        serchTableCell.countryLabel.text=@"";
            NSString *lastCharId = [cuntryIdString substringFromIndex:[cuntryIdString length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                cuntryIdString = [[cuntryIdString substringToIndex:[cuntryIdString length] - 1] mutableCopy];
            }
            NSString *lastChar = [cuntryStatusString substringFromIndex:[cuntryStatusString length] - 1];
            if ([lastChar isEqualToString:@","]) {
                cuntryStatusString = [[cuntryStatusString substringToIndex:[cuntryStatusString length] - 1] mutableCopy];
            }
        countryId=cuntryIdString;
        serchTableCell.countryLabel.text=cuntryStatusString;
        cuntryStatusString=[@"" mutableCopy];
            self.popView.hidden = true;
        }
    }
    else if ([button isEqualToString:@"physicalStatusBtn"])
    {
        if([physicalStatusStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
        serchTableCell.physicalStatusLabel.text=@"";
            NSString *lastCharId = [physicalStatusStrng substringFromIndex:[physicalStatusStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                physicalStatusStrng = [[physicalStatusStrng substringToIndex:[physicalStatusStrng length] - 1] mutableCopy];
            }
        physicalStatusId=physicalStatusStrng;
        serchTableCell.physicalStatusLabel.text=physicalStatusId;
        physicalStatusStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
    }
    else if ([button isEqualToString:@"religionBtn"])
    {
        if([religionStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
        serchTableCell.religionLabel.text=@"";
            NSString *lastCharId = [religionIdStrng substringFromIndex:[religionIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                religionIdStrng = [[religionIdStrng substringToIndex:[religionIdStrng length] - 1] mutableCopy];
            }
            NSString *lastChar = [religionStrng substringFromIndex:[religionStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                religionStrng = [[religionStrng substringToIndex:[religionStrng length] - 1] mutableCopy];
            }
        religionId=religionIdStrng;
        serchTableCell.religionLabel.text=religionStrng;
        religionStrng=[@"" mutableCopy];
            religionIdStrng=[@""mutableCopy];
            self.popView.hidden = true;
        }
    }
    else if ([button isEqualToString:@"MTongueBtn"])
    {
        if([mTongueStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
        serchTableCell.MTongueLabel.text=@"";
            NSString *lastCharId = [mTongueIdStrng substringFromIndex:[mTongueIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                mTongueIdStrng = [[mTongueIdStrng substringToIndex:[mTongueIdStrng length] - 1] mutableCopy];
            }
            NSString *lastChar = [mTongueStrng substringFromIndex:[mTongueStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                mTongueStrng = [[mTongueStrng substringToIndex:[mTongueStrng length] - 1] mutableCopy];
            }
        mTongueId=mTongueIdStrng;
        serchTableCell.MTongueLabel.text=mTongueStrng;
        mTongueStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
    }
    else if ([button isEqualToString:@"starBtn"])
    {
        if([starStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
            
        serchTableCell.starLabel.text=@"";
            NSString *lastCharId = [starIdStrng substringFromIndex:[starIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                starIdStrng = [[starIdStrng substringToIndex:[starIdStrng length] - 1] mutableCopy];
            }
            NSString *lastChar = [starStrng substringFromIndex:[starStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                starStrng = [[starStrng substringToIndex:[starStrng length] - 1] mutableCopy];
            }
        starId=starIdStrng;
        serchTableCell.starLabel.text=starStrng;
        starStrng=[@"" mutableCopy];
             self.popView.hidden = true;
        }
    }//
    else if ([button isEqualToString:@"educationBtn"])
    {
        if([eduStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
        serchTableCell.educationLAbel.text=@"";
            NSString *lastCharId = [eduIdStrng substringFromIndex:[eduIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                eduIdStrng = [[eduIdStrng substringToIndex:[eduIdStrng length] - 1] mutableCopy];
            }
            NSString *lastChar = [eduStrng substringFromIndex:[eduStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                eduStrng = [[eduStrng substringToIndex:[eduStrng length] - 1] mutableCopy];
            }
        eduId=eduIdStrng;
        serchTableCell.educationLAbel.text=eduStrng;
        eduStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
        
    }
    else if ([button isEqualToString:@"occupationBtn"])
    {
        if([ocpStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
        serchTableCell.occupationLabel.text=@"";
            NSString *lastCharId = [ocpIdStrng substringFromIndex:[ocpIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                ocpIdStrng = [[ocpIdStrng substringToIndex:[ocpIdStrng length] - 1] mutableCopy];
            }
            NSString *lastChar = [ocpStrng substringFromIndex:[ocpStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                ocpStrng = [[ocpStrng substringToIndex:[ocpStrng length] - 1] mutableCopy];
            }
        ocpID=ocpIdStrng;
        serchTableCell.occupationLabel.text=ocpStrng;
        ocpStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
    }
    else if ([button isEqualToString:@"stateBtn"])
    {
        if([stateStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
            serchTableCell.stateLabel.text=@"";
            NSString *lastCharId = [stateIdStrng substringFromIndex:[stateIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                stateIdStrng = [[stateIdStrng substringToIndex:[stateIdStrng length] - 1] mutableCopy];
            }
            NSString *lastChar = [stateStrng substringFromIndex:[stateStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                stateStrng = [[stateStrng substringToIndex:[stateStrng length] - 1] mutableCopy];
            }
            stateId=stateIdStrng;
            serchTableCell.stateLabel.text=stateStrng;
            stateStrng=[@"" mutableCopy];
            stateIdStrng=[@"" mutableCopy ];
            self.popView.hidden = true;
        }
    }
    
    else if ([button isEqualToString:@"eatingBtn"])
    {
        if([eatinStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
            serchTableCell.eatingLabel.text=@"";
            NSString *lastChar = [eatinStrng substringFromIndex:[eatinStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                eatinStrng = [[eatinStrng substringToIndex:[eatinStrng length] - 1] mutableCopy];
            }
            eatingId=eatinStrng;
            serchTableCell.eatingLabel.text=eatinStrng;
            stateStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
    }
    else if ([button isEqualToString:@"drinkingBtn"])
    {
        if([drinkStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
            serchTableCell.drinkingLabel.text=@"";
            NSString *lastChar = [drinkStrng substringFromIndex:[drinkStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                drinkStrng = [[drinkStrng substringToIndex:[drinkStrng length] - 1] mutableCopy];
            }
            drinkingId=drinkStrng;
            serchTableCell.drinkingLabel.text=drinkStrng;
            drinkStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
    }//
    else if ([button isEqualToString:@"smokingBtn"])
    {
        if([smokeStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
            serchTableCell.smokingLabel.text=@"";
            NSString *lastChar = [smokeStrng substringFromIndex:[smokeStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                smokeStrng = [[smokeStrng substringToIndex:[smokeStrng length] - 1] mutableCopy];
            }
            smokingId=smokeStrng;
            serchTableCell.smokingLabel.text=smokeStrng;
            smokeStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
    }//
    else if ([button isEqualToString:@"DistrictBtn"])
    {
        if([districtStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
            serchTableCell.districtLabel.text=@"";
            NSString *lastCharId = [districtIdStrng substringFromIndex:[districtIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                districtIdStrng = [[districtIdStrng substringToIndex:[districtIdStrng length] - 1] mutableCopy];
            }
            NSString *lastChar = [districtStrng substringFromIndex:[districtStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                districtStrng = [[districtStrng substringToIndex:[districtStrng length] - 1] mutableCopy];
            }
            districtId=districtIdStrng;
            serchTableCell.districtLabel.text=districtStrng;
            districtStrng=[@"" mutableCopy];
            districtIdStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
    }
    else if ([button isEqualToString:@"cityBtn"])
    {
        if([cityStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
            serchTableCell.cityLabel.text=@"";
            NSString *lastCharId = [cityIdStrng substringFromIndex:[cityIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                cityIdStrng = [[cityIdStrng substringToIndex:[cityIdStrng length] - 1] mutableCopy];
            }
            NSString *lastChar = [cityStrng substringFromIndex:[cityStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                cityStrng = [[cityStrng substringToIndex:[cityStrng length] - 1] mutableCopy];
            }
            cityId=cityIdStrng;
            serchTableCell.cityLabel.text=cityStrng;
            cityStrng=[@"" mutableCopy];
            cityIdStrng=[@""mutableCopy];
            self.popView.hidden = true;
        }
    }
//
    else if ([button isEqualToString:@"castebtn"])
    {
        if([castStrng isEqualToString:@""])
        {
            ALERT_DIALOG(@"Alert", @"please select atleast one value");
            // _popupTableView.hidden =false;
        }
        else
        {
           
            serchTableCell.casteLabel.text=@"";
            NSString *lastCharId = [castIdStrng substringFromIndex:[castIdStrng length] - 1];
            if ([lastCharId isEqualToString:@","]) {
                castIdStrng = [[castIdStrng substringToIndex:[castIdStrng length] - 1] mutableCopy];
            }
            NSString *lastChar = [castStrng substringFromIndex:[castStrng length] - 1];
            if ([lastChar isEqualToString:@","]) {
                castStrng = [[castStrng substringToIndex:[castStrng length] - 1] mutableCopy];
            }
            castId=castIdStrng;
            serchTableCell.casteLabel.text=castStrng;
            castStrng=[@"" mutableCopy];
            self.popView.hidden = true;
        }
    }
    
    if(selectedCell == ageCell &&!(selectedCell == nil) )
    {
        if ([ageCell.ageFromLabel.text isEqualToString:@""]||[ageCell.ageToLabel.text isEqualToString:@""]) {
            ALERT_DIALOG(@"Alert",@"please enter all details" );
        }
        else
        {
             self.popView.hidden = true;
            serchTableCell.ageLabel.text = [NSString stringWithFormat:@"%@-%@ Years",ageCell.ageFromLabel.text,ageCell.ageToLabel.text];
        }
        
    }
    if(selectedCell == heightCell &&!(selectedCell == nil) )
    {
        if ([heightCell.heightFromLabel.text isEqualToString:@""]||[heightCell.heightToLabel.text isEqualToString:@""]) {
            ALERT_DIALOG(@"Alert",@"please enter all details" );
        }
        else
        {
            self.popView.hidden = true;
            serchTableCell.heightLabel.text = [NSString stringWithFormat:@"%@-%@",heightCell.heightFromLabel.text,heightCell.heightToLabel.text];
        }
        
    }
   /* if(selectedCell == incomeCell)
    {
        if ([incomeCell.incomeFromLabel.text isEqualToString:@""]||[incomeCell.incomeToLabel.text isEqualToString:@""]) {
            ALERT_DIALOG(@"Alert",@"please enter all details" );
        }
        else
        {
            self.popView.hidden = true;
            serchTableCell.annualIncomeLabel.text = [NSString stringWithFormat:@"%@-%@",incomeCell.incomeFromLabel.text,incomeCell.incomeToLabel.text];
        }
        
    }*/
}

- (IBAction)submitAction:(id)sender {
    if ([serchTableCell.ageLabel.text isEqualToString:@""]||[serchTableCell.maritalStatusLabel.text isEqualToString:@""]||[serchTableCell.religionLabel.text isEqualToString:@""]||[serchTableCell.MTongueLabel.text isEqualToString:@""]||[serchTableCell.casteLabel.text isEqualToString:@""]||[serchTableCell.starLabel.text isEqualToString:@""]||[serchTableCell.countryLabel.text isEqualToString:@""]||[serchTableCell.stateLabel.text isEqualToString:@""]||[serchTableCell.districtLabel.text isEqualToString:@""]||[serchTableCell.cityLabel.text isEqualToString:@""]||[serchTableCell.educationLAbel.text isEqualToString:@""]||[serchTableCell.occupationLabel.text isEqualToString:@""]||[serchTableCell.physicalStatusLabel.text isEqualToString:@""]||[serchTableCell.eatingLabel.text isEqualToString:@""]||[serchTableCell.drinkingLabel.text isEqualToString:@""]||[serchTableCell.smokingLabel.text isEqualToString:@""]||[serchTableCell.annualIncomeLabel.text isEqualToString:@""]||[serchTableCell.heightLabel.text isEqualToString:@""]) {
        ALERT_DIALOG(@"Alert", @"please enter all required fields");
    }
    else
    {
       
        
        NSDictionary * params =@{@"fromage":ageFromId,@"toage":ageToId,@"m_status":maritalStatusId,@"religion":religionId,@"caste":castId,@"state":stateId,@"country":countryId,@"city":cityId,@"education":eduId,@"occupation":ocpID,@"m_tongue":mTongueId,@"physical_status":physicalStatusId,@"diet":eatingId,@"drinking":drinkingId,@"smoking":smokingId,@"fromincome":@"0",@"toincome":@"0",@"fromheight":heightFromId,@"toheight":heightToId,@"district_id":districtId,@"star":starId,@"matri_id":loggedIn_matri_id };
       [self popupServiceCall:@"services/api/advancedSearch" params:params];
    }
    
}


@end
