//
//  Agent_EditProfile.h
//  Smatrimony
//
//  Created by INDOBYTES on 13/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchPopupVIew.h"
#import "JMOTableViewCell.h"
#import "PageViewController.h"
#import "Recent_Members_Cell.h"

@interface Agent_EditProfile : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isMenuActive;
    NSArray *leftMenuArray;
    CGRect leftmenuRect;
}
@property (strong, nonatomic) IBOutlet UIView *leftMenuContentView;
@property (strong, nonatomic) IBOutlet UIView *leftMenuBgView;
@property (strong, nonatomic) IBOutlet searchPopupVIew *leftMenuTable;

@end
