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
    NSLog(@"gggg%@",self.items);

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
#pragma mark collectionview data source
- (NSInteger)numberOfViewsInCollectionView:(UWCollectionView *)collectionView
{
    return [self.items count];
  
}

- (UWCollectionViewCell *)collectionView:(UWCollectionView *)collectionView viewAtIndex:(NSInteger)index
{
    UWView *_itemCell = (UWView *)[collectionView dequeueReusableView];
    
    if (_itemCell == nil) {
        _itemCell = [[UWView alloc] initWithFrame:CGRectZero];
    }
    
    
    
    Book * book = [self.items objectAtIndex:index];
    //    NSLog(@"%@",book.thumb);
    NSMutableString * str = [NSMutableString stringWithFormat:@"http://a.cdn123.net/img/m/%@@2x",book.thumb];
    NSLog(@"%@",str);
    NSURL * url = [NSURL URLWithString:str];
    [_itemCell.button setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Default.png"]];
    _itemCell.button.tag= index;
    [_itemCell.button addTarget:self action:@selector(_pus:) forControlEvents:UIControlEventTouchUpInside];
    
    return _itemCell;
}
- (void)_pus:(id)sender
{
    NSLog(@"%@",sender);
    UIButton *button = (UIButton *)sender;
    Book * book = [items objectAtIndex:button.tag];
    RecommendBookDetilViewController * _detail = [[RecommendBookDetilViewController alloc]init];
    _detail._urlString = book.url;
    _detail.book = book;
    [self.navigationController pushViewController:_detail animated:YES];
    NSLog(@"%@",book.url);
}
@end
