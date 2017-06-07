//
//  pdfViewViewController.m
//  Steeloncall_Seller
//
//  Created by INDOBYTES on 10/01/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import "pdfViewViewController.h"

@interface pdfViewViewController ()

@end

@implementation pdfViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//
    _shareBtn.hidden = YES;
    _activityView .frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_activityView];
    
    NSURL *targetURL = [NSURL URLWithString:_orderUrl];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask ,YES );
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"invoic.doc"];
    //[_pdfView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    
  //  NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    //[_pdfView loadRequest:request];
    //[_pdfView setScalesPageToFit:YES];
    
    [_pdfView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL fileURLWithPath:path]cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:3.0]];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
      [_activityView removeFromSuperview];
    _shareBtn.hidden =YES;
    //Stop or remove progressbar and show error
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activityView removeFromSuperview];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    BOOL isDir = NO;
    NSError *error;
    //You must check if this directory exist every time
    if (! [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir   == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    filePath = [cachePath stringByAppendingPathComponent:@"someName.pdf"];
    //webView.request.URL contains current URL of UIWebView, don't forget to set outlet for it
    NSData *pdfFile = [NSData dataWithContentsOfURL:webView.request.URL];
    [pdfFile writeToFile:filePath atomically:YES];
    _shareBtn.hidden =NO;
}

- (IBAction)remove:(id)sender {
 
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)sharePdf:(id)sender {
    
    
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    NSArray *objectsToShare = @[url];
//    
//    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
//    
//    // Exclude all activities except AirDrop.
//    NSArray *excludedActivities = @[
//                                    UIActivityTypePostToWeibo,
//                                     UIActivityTypeCopyToPasteboard,
//                                    UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,
//                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
//                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
//    controller.excludedActivityTypes = excludedActivities;
    
    // Present the controller
   // [self presentViewController:controller animated:YES completion:nil];

    
    NSData *pdfData = [NSData dataWithContentsOfFile:filePath];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"Test", pdfData] applicationActivities:nil];
    
    [self presentViewController:activityViewController animated:YES completion:nil];

    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
