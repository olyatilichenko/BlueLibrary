//
//  ViewController.m
//  BlueLibrary
//
//  Created by Eli Ganem on 31/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import "ViewController.h"
#import "LibraryAPI.h"
#import "Album+TableRepresentation.h"
#import "HorizontalScroller.h"
#import "AlbumView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, HorizontalScrollerDelegate>
{
    UITableView * dataTable;
    NSArray * allAlbums;
    NSDictionary * currentAlbumData;
    int currentAlbumIndex;
    HorizontalScroller * scroller;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1
    self.view.backgroundColor = [UIColor colorWithRed:0.76f green:0.81f blue:0.87f alpha:1.f];
    currentAlbumIndex = 0;
    
    // 2
    allAlbums = [[LibraryAPI sharedInstance] albums];
    
    // 3
    // UITableView, который отображает данные альбома
    CGRect frame = CGRectMake(0.f, 120.f, self.view.frame.size.width, self.view.frame.size.height - 120.f);
    dataTable = [[UITableView alloc] initWithFrame:frame
                                             style:UITableViewStyleGrouped];
    dataTable.delegate = self;
    dataTable.dataSource = self;
    dataTable.backgroundView = nil;
    [self.view addSubview:dataTable];
    scroller = [[HorizontalScroller alloc] initWithFrame:CGRectMake(0.f, 20.f, self.view.frame.size.width, 120.f)];
    scroller.backgroundColor = [UIColor colorWithRed:0.24f green:0.35f blue:0.49f alpha:1];
    scroller.delegate = self;
    [self.view addSubview:scroller];
    
    [self reloadScroller];
    [self showDataForAlbumAtIndex:currentAlbumIndex];
}

- (void)showDataForAlbumAtIndex:(int)albumIndex
{
    // Защита от дурака: убедимся, что запрошенный индекс меньше числа альбомов
    if (albumIndex < allAlbums.count)
    {
        // Берём альбом:
        Album * album = allAlbums[albumIndex];
        // Сохраняем данные альбома, чтобы позже показать в TableView:
        currentAlbumData = [album tr_tableRepresentation];
    }
    else
    {
        currentAlbumData = nil;
    }
    
    // У нас есть данные, которые нам нужны. Обновляем TableView
    [dataTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [currentAlbumData[@"titles"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = currentAlbumData[@"titles"][indexPath.row];
    cell.detailTextLabel.text = currentAlbumData[@"values"][indexPath.row];
    
    return cell;
}

#pragma mark - HorizontalScrollerDelegate methods

- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(int)index
{
    currentAlbumIndex = index;
    [self showDataForAlbumAtIndex:index];
}
- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller
{
    return allAlbums.count;
}
- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(int)index
{
    Album * album = allAlbums[index];
    return [[AlbumView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f) albumCover:album.coverUrl];
}
- (void)reloadScroller
{
    allAlbums = [[LibraryAPI sharedInstance] albums];
    if (currentAlbumIndex < 0)
        currentAlbumIndex = 0;
    else if (currentAlbumIndex >= allAlbums.count)
        currentAlbumIndex = allAlbums.count - 1;
    [scroller reload];
    
    [self showDataForAlbumAtIndex:currentAlbumIndex];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
