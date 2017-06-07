//
//  Safe_Matrimony_ViewController.m
//  Smatrimony
//
//  Created by INDOBYTES on 22/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Safe_Matrimony_ViewController.h"

@interface Safe_Matrimony_ViewController ()

@end

@implementation Safe_Matrimony_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
