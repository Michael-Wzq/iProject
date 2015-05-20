//
//  AnnouncementViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/18.
//  Copyright (c) 2014年 michael. All rights reserved.
//
#import "AFNetworking.h"
#import "PageViewController.h"
#import "AnnouncementViewController.h"
#import "AnnouncementTableViewCell.h"
static int numberOfPages = 3;
@interface AnnouncementViewController ()
@property (strong,nonatomic) NSMutableArray *announceArray;
@property (strong,nonatomic) NSMutableDictionary *announceDic;
@property (strong,nonatomic) NSTimer *timer;
@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation AnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self jasonRequest];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.50f target:self selector:@selector(runTimePage) userInfo:nil repeats:YES ];
    
    NSMutableArray *controllers = [[ NSMutableArray alloc] init];
    for (unsigned i = 0 ; i < numberOfPages; i++) {
        [controllers    addObject:[NSNull null]];
    }
    self.imageViews = controllers;
    
    //scrollView
   
    
   
    self.scrollView.bounces = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    //pagecontrol
    self.pageControl.numberOfPages =[self.imageViews count];
    self.pageControl.currentPage = 0;
    
    
    // loadScrollViewWithPage
    for (int i = 0 ; i < [self.imageViews count]; i++) {
        PageViewController *controller = [self.imageViews objectAtIndex:i];
    
    if ((NSNull *) controller == [NSNull null]) {
        controller = [[PageViewController alloc] initWithPageNumber:i];
        [self.imageViews replaceObjectAtIndex:i withObject:controller];
    }
    
    if (!controller.view.superview) {
        controller.view.frame = CGRectMake(320*i+320, 0, 320, 190);
        [self.scrollView addSubview:controller.view];
    }

   
     }
    PageViewController *controller = [[PageViewController alloc] initWithPageNumber:0];
    controller.view.frame = CGRectMake(0, 0, 320, 190);
    [self.scrollView addSubview:controller.view];
    PageViewController *controller1 = [[PageViewController alloc] initWithPageNumber:((int)[self.imageViews count]-1)];

    controller.view.frame = CGRectMake(320*([self.imageViews count]+1), 0, 320, 190);
     [self.scrollView addSubview:controller1.view];
    
    [self.scrollView setContentSize:CGSizeMake(320 * ([self.imageViews count] + 2), 190)];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,190) animated:NO];
    
    
     UINib *nib = [UINib nibWithNibName:@"AnnouncementTableViewCell" bundle:nil];
    [self.anonunceTable registerNib:nib forCellReuseIdentifier:@"announceCell"];
    self.anonunceTable.delegate=self;
    self.anonunceTable.dataSource=self;
    
    
}

- (void)jasonRequest{
    NSString *str = [staticStr stringByAppendingString:@"notice"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.announceDic = responseObject;
        
        
       
        
        if ([self.announceDic objectForKey:@"status"] ) {
            NSLog(@"有公告");
            
            self.announceArray = [self.announceDic objectForKey:@"list"];
            
        }
        if (![self.announceDic objectForKey:@"status"]) {
            NSLog(@"暂无公告");
            self.announceArray = [self.announceDic objectForKey:@"mes"];
      
        }
        
        [self.anonunceTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}











    


- (void)scrollViewDidScroll:(UIScrollView *)sender{
    
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/([self.imageViews count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    self.pageControl.currentPage = page;
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ ([self.imageViews count]+2)) / pagewidth) + 1;
   
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320 * [self.imageViews count],0,320,190) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([self.imageViews count]+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,190) animated:NO]; // 最后+1,循环第1页
    }
    [self.timer invalidate];
}
- (IBAction)changePage:(id)sender {
   
    int page = (int)self.pageControl.currentPage;
//    [self loadScrollViewWithPage:page];
//    [self loadScrollViewWithPage:page+1];
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];

}

// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)self.pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(320*(page+1),0,320,190) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    int page = (int)self.pageControl.currentPage; // 获取当前的page
    page++;
    page = page > 2 ? 0 : page ;
    self.pageControl.currentPage = page;
    [self turnPage];
}









#pragma tableviewmethod
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [self.announceArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AnnouncementTableViewCell   *cell = [self.anonunceTable dequeueReusableCellWithIdentifier:@"announceCell"];
    if(cell==nil){
        cell = [[AnnouncementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"announceCell"];}
    
    cell.announceTitle.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.announceArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
    cell.announceDate.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.announceArray objectAtIndex:indexPath.row] objectForKey:@"date"]];
   // cell.announceContent.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.announceArray objectAtIndex:indexPath.row] objectForKey:@"content"]];
    

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
