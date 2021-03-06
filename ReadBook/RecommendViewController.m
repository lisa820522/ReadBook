//
//  RecommendViewController.m
//  ReadBook
//
//  Created by carry on 13-4-15.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "RecommendViewController.h"
#import "UWCollectionViewLayout.h"
#import "UWView.h"
#import "DefaultManager.h"
#import "Book.h"
#import "UIButton+WebCache.h"
#import "RecommendBookDetilViewController.h"
@interface RecommendViewController ()
@property(nonatomic,retain)UIColor *color;
@property(nonatomic,retain)UIColor *textColor;
@end

@implementation RecommendViewController
@synthesize items;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"本周热门";
                
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    if (iPhone5) {
        UWCollectionViewLayout *_layout = [[UWCollectionViewLayout alloc] init];
        _layout.itemSize = CGSizeMake(105, 138);
        _layout.minimumInteritemSpacing = 0.0f;
        _layout.minimumLineSpacing = 0.0f;
        _layout.sectionInset = UIEdgeInsetsMake(2.5f, 2.5f, 0.0f, 0.0f);
        UWCollectionView *_collectionView = [[UWCollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-100) collectionViewLayout:_layout];
        _collectionView.collectionViewDataSource = self;
        _collectionView.collectionViewDelegate = self;
        [self.view addSubview:_collectionView];
        [_collectionView release],_collectionView = nil;
        [_layout release],_layout = nil;
        self.items = [[DefaultManager defaultManager]bookList];
    }else{
       UWCollectionViewLayout *_layout = [[UWCollectionViewLayout alloc] init];
    _layout.itemSize = CGSizeMake(105, 138);
    _layout.minimumInteritemSpacing = 0.0f;
    _layout.minimumLineSpacing = 0.0f;
    _layout.sectionInset = UIEdgeInsetsMake(2.5f, 2.5f, 0.0f, 0.0f);
 UWCollectionView *_collectionView = [[UWCollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 380) collectionViewLayout:_layout];
    _collectionView.collectionViewDataSource = self;
    _collectionView.collectionViewDelegate = self;
    [self.view addSubview:_collectionView];
       [_collectionView release],_collectionView = nil;
    [_layout release],_layout = nil;  
    self.items = [[DefaultManager defaultManager]bookList];
//    NSLog(@"gggg%@",self.items);
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_changetextColor:) name:KNSNotificationChangeTextColor object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_changebackgroundColor:) name:KNSNotificationChangebackgroundColor object:nil];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)_changebackgroundColor:(NSNotification *)notification
{
    self.color=[notification object];
}
-(void)_changetextColor:(NSNotification *)notification
{
    self.textColor = [notification object];
}

#pragma mark collectionview data source
- (NSInteger)numberOfViewsInCollectionView:(UWCollectionView *)collectionView
{
    return [self.items count];
  
}

- (UWCollectionViewCell *)collectionView:(UWCollectionView *)collectionView viewAtIndex:(NSInteger)index
{
    UWView *_itemCell = (UWView *)[collectionView dequeueReusableView];
    
    if (_itemCell == nil) {
        _itemCell = [[[UWView alloc] initWithFrame:CGRectZero]autorelease];
    }
    
    
      
    
    Book * book = [self.items objectAtIndex:index];
    NSMutableString * str = [NSMutableString stringWithFormat:@"http://a.cdn123.net/img/r/%@",book.thumb];
    NSURL * url = [NSURL URLWithString:str];
    [_itemCell.button setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Default.png"]];
    _itemCell.button.tag= index;
    [_itemCell.button addTarget:self action:@selector(_pus:) forControlEvents:UIControlEventTouchUpInside];
    
    return _itemCell;
}
- (void)_pus:(id)sender
{
    UIButton *button = (UIButton *)sender;
    Book * book = [items objectAtIndex:button.tag];
    RecommendBookDetilViewController * _detail = [[RecommendBookDetilViewController alloc]init];
    //书网址
    _detail._urlString = book.url;
    //书图片
    _detail.str = [NSMutableString stringWithFormat:@"http://a.cdn123.net/img/r/%@",book.thumb];
    //书id
    _detail.bookid = [NSString stringWithFormat:@"%@",book.iD];
    _detail.title = book.name;
    _detail.textColor = self.textColor;
    _detail.color = self.color;
     [self.navigationController pushViewController:_detail animated:YES];
     _detail.label.text = [NSString stringWithFormat:@"作者:%@\n简介:%@",book.author,book.intro];
    [_detail release];
}
@end
