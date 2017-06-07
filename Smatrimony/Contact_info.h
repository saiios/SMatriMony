//
//  Contact_info.h
//  Smatrimony
//
//  Created by INDOBYTES on 20/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Contact_info : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *Email;
@property (strong, nonatomic) IBOutlet UITextField *phone_number;

@property (strong , nonatomic) NSString * emailId;
@property (strong , nonatomic) NSString * phn;

@end
