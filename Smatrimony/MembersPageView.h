//
//  MembersPageView.h
//  Smatrimony
//
//  Created by INDOBYTES on 31/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgentDetailCell.h"
#import "STParsing.h"

//@protocol backPageNavigationProtocol <NSObject>
//
//@optional
//-(void)editPageController;
//
//@end

@interface MembersPageView : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) NSInteger index;
//@property (weak, nonatomic) IBOutlet UILabel *textValue;
//@property(weak , nonatomic) id<backPageNavigationProtocol>protocolObj;;
@end
