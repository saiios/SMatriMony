//
//  HoroScopeViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 23/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoroScopeViewController : UIViewController
- (IBAction)backClick:(id)sender;
@property(strong,nonatomic)NSString *html;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
