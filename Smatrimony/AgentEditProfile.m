//
//  AgentEditProfile.m
//  Smatrimony
//
//  Created by INDOBYTES on 07/06/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "AgentEditProfile.h"

@interface AgentEditProfile ()
{
    NSArray * menuArr;
    int presentIndex;
    NSIndexPath *path;
}
@end

@implementation AgentEditProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_collectionViewOutlet registerNib:[UINib nibWithNibName:@"AgentDetailTitleCell" bundle:nil] forCellWithReuseIdentifier:@"AgentDetailTitleCell"];

     menuArr = [[NSArray alloc]initWithObjects:@"Basic Details",@"Upload Photos",@"Partner",nil];
    [self createTabsView];
    [self pageViewHandler];
}
#pragma mark - collection View

-(void)createTabsView
{
  
    self.collectionViewOutlet.backgroundColor = [UIColor clearColor];
    self.collectionViewOutlet.showsHorizontalScrollIndicator =NO;
    
    //  self.tabsView.pagingEnabled =YES;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:10];
    
    // not iPad pro
    float kk = self.view.frame.size.width/4;
    [flowLayout setItemSize:CGSizeMake(kk, 60)];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0,0,0)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionViewOutlet setCollectionViewLayout:flowLayout];
    [self.collectionViewOutlet reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [menuArr count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifierValue = @"AgentDetailTitleCell";
    AgentDetailTitleCell * cellObj = (AgentDetailTitleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifierValue forIndexPath:indexPath];
        if (cellObj == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AgentDetailTitleCell" owner:self options:nil];
            cellObj = (AgentDetailTitleCell *)[nib objectAtIndex:0];
        }
    cellObj.nameTitleLabel.text = [menuArr objectAtIndex:indexPath.item];
    return cellObj;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AgentEditProfilePageView *childViewController = [[AgentEditProfilePageView alloc] initWithNibName:@"AgentEditProfilePageView" bundle:nil];
    NSArray *viewControllers = [NSArray arrayWithObject:childViewController];
    childViewController.index = indexPath.row;
    //  initialViewController.contentArray =@[@"",@""];
    
    //initialViewController.currentIndex =presentIndex;
    if(presentIndex != indexPath.row)
    {
        if (presentIndex < indexPath.row)
        {
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
        else{
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
        }
        
    }
    presentIndex =(int)indexPath.row;
    
    [self.collectionViewOutlet scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [collectionView reloadData];
    
}

#pragma mark - PageView Delegates

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
  NSUInteger index = [(AgentEditProfilePageView *)viewController index];
    AgentEditProfilePageView *childViewController = [[AgentEditProfilePageView alloc] initWithNibName:@"AgentEditProfilePageView" bundle:nil];
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    childViewController.index = index;
    return childViewController;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [(AgentEditProfilePageView *)viewController index];
    AgentEditProfilePageView *childViewController = [[AgentEditProfilePageView alloc] initWithNibName:@"AgentEditProfilePageView" bundle:nil];
    index++;
    childViewController.index = index;
    if (index == [menuArr count])
    {
        return nil;
    }
    return childViewController;
}
-(void)pageViewHandler
{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.view.autoresizesSubviews =YES;
    
    //self.pageController.view.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    // MembersPageView *initialViewController = [self viewControllerAtIndex:0];
    
    //    initialViewController.delegate =self;
    //    initialViewController.contentArray = @[@"test",@"tets"];
    //
    
    AgentEditProfilePageView *childViewController = [[AgentEditProfilePageView alloc] initWithNibName:@"MembersPageView" bundle:nil];
    NSArray *viewControllers = [NSArray arrayWithObject:childViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.pageViewOutlet addSubview:self.pageController.view];
    [self.pageController.view setFrame:CGRectMake(0,0,self.pageViewOutlet.bounds.size.width, self.pageViewOutlet.bounds.size.height)];
    
    [self.pageController didMoveToParentViewController:self];
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed)
    {
        NSUInteger currentIndex = [[self.pageController.viewControllers lastObject] index];
        path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        presentIndex = (int)currentIndex;
        
        
        if (presentIndex <= menuArr.count-1) {
            
            
            [self.collectionViewOutlet scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:presentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            [self.collectionViewOutlet reloadData];
            
        }
    }
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

@end
