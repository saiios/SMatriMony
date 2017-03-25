//
//  All_photos.h
//  Smatrimony
//
//  Created by INDOBYTES on 28/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "CRToastView.h"
#import "Pic_Cell.h"
#import "Feedback_cell.h"

@interface All_photos : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSUserDefaults *user_inf;
    NSDictionary *All_pics_dict;
    NSArray *all_keys;
    NSString *matri_id,*selected_pic,*change_img_name,*gender;
    NSMutableArray *table_ary;
    UITapGestureRecognizer *singleFingerTap;
    int selected_id,selected_pic_ind;
    UIImage *chosenImage;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *table_height;
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *collection_view;
@property (strong, nonatomic) IBOutlet UITableView *table;
@end
