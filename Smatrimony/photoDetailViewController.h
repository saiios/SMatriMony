//
//  photoDetailViewController.h
//  Smatrimony
//
//  Created by INDOBYTES on 24/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

//protocol
@protocol senddataProtocol <NSObject>

-(void)sendDataToA:(NSMutableArray *)array; //I am thinking my data is NSArray, you can use another object for store your information.

@end

@interface photoDetailViewController : UIViewController
//protocol


@property(nonatomic,assign)id delegate;


@property (strong,nonatomic)NSMutableArray *images;
@property (strong, nonatomic) IBOutlet UIButton *backClick;
- (IBAction)likeHerBtnActn:(id)sender;

- (IBAction)sortListBtnActn:(id)sender;
- (IBAction)chatNowBtnActn:(id)sender;

- (IBAction)sendintrstBtnActn:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *sendInterestBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *chatNowBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *sortListBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *likeHerBtnOutlet;

@end
