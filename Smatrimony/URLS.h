//
//  URLS.h
//
//  Created by administrator on 30/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#ifndef URLS_h
#define URLS_h
#import "AFNetworking/AFNetworking.h"
#import "UIImageView+AFNetworking.h"

//Constants
//production
//#define MAIN_Url  @"https://steeloncall.com/calculate/service/"
//#define UserOrder_Url  @"https://steeloncall.com/calculate/userservice/"
//#define Banners_Url @"https://steeloncall.com/"
//#define MAIN_Url1  @"https://steeloncall.com/calculate/service/"

//staging
#define Banners_Url @"http://stg.steeloncall.com/"
#define UserOrder_Url @"http://stg.steeloncall.com/calculate/userservice/"
#define MAIN_Url  @"http://www.smatrimony.com/services/"
#define register_Url  @"http://www.smatrimony.com/"
#define AGENT_MAIN_Url  @"http://www.smatrimony.com/services/agent/"

//#define NSLog

#define ALERT_DIALOG(__title__,__message__) \
do\
{\
UIAlertController * alert= [UIAlertController alertControllerWithTitle:(__title__) message:(__message__) preferredStyle:UIAlertControllerStyleAlert];UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];[alert addAction:ok];[self presentViewController:alert animated:YES completion:nil];\
} while ( 0 )

typedef enum
{
   WS_MAIN,
    WUS_Login,
    WUS_FPwd,
    WUS_Feedback,
    WUS_D_AC,
    WUS_S_story,
    WUS_Change_pwd,
    WUS_logout,
    WUS_editProfile,
    WUS_Sent_mail,
    WUS_Block_list,
    WUS_unblock,
    WUS_getPopUPData,
    WUS_Register,
    WUS_PROFILE,

} WSENUM;

#endif /* URLS_h */
