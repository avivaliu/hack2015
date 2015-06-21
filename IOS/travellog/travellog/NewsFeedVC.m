//
//  NewsFeedVC.m
//  travellog
//
//  Created by Cullen on 20/6/15.
//  Copyright (c) 2015 Cullen. All rights reserved.
//

#import "NewsFeedVC.h"
#import "NewsItem.h"
#import "NewsCell.h"
#import "IRHTTPClient.h"
#import "Constants.h"
#import "CSWebBrowserVC.h"


@interface NewsFeedVC ()

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation NewsFeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NewsFeed";
   self.searchDisplayController.displaysSearchBarInNavigationBar = YES;

    UIBarButtonItem *newBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(new:)];
   self.navigationItem.leftBarButtonItem = newBtn;

    UIBarButtonItem *filterBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bar_button_icon_filter"] style:UIBarButtonItemStylePlain  target:self action:@selector(new:)];

    self.navigationItem.rightBarButtonItem = filterBtn;

    self.items = [[NSMutableArray alloc] init];
    
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    [self refresh:nil];
}

- (void)refresh:(id)sender {
    if (!self.isLoading) {
        [self loadData];
    } else {
        [self.refreshControl endRefreshing];
    }
}

- (void)loadData {
    
    NSString *requestStr = [SeverUrl stringByAppendingString:@"newsfeed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestStr]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
//    op.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];

    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", [responseObject class]);
        [self.items removeAllObjects];

        if ([responseObject isKindOfClass:[NSArray class]]) {
           // "article_url": "blogs/travellog02",
       
            for (NSDictionary *dict in responseObject) {
                NewsItem *item = [[NewsItem alloc] init];
                item.title  = dict[@"title"];
                item.authorProfileUrl = dict[@"author_url"];
                item.duration = dict[@"duration"];
                item.location = dict[@"location"];
                item.coverImageUrl = dict[@"cover_media"];
                item.brief = dict[@"description"];
                [self.items addObject:item];
            }
            for (NSDictionary *dict in responseObject) {
                NewsItem *item = [[NewsItem alloc] init];
                item.title  = dict[@"title"];
                item.authorProfileUrl = dict[@"author_url"];
                item.duration = dict[@"duration"];
                item.location = dict[@"location"];
                item.coverImageUrl = dict[@"cover_media"];
                item.brief = dict[@"description"];
                [self.items addObject:item];
            }
        }
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.items = nil;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
}


- (void)new:(id)barBtn {
    
   UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Create" bundle:nil];
   UINavigationController *nav = [sb instantiateViewControllerWithIdentifier:@"createTripNav"];

  //  CreateTripVC *createVC = [nav.viewControllers firstObject];

    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == self.tableView) {
        return [self.items count];
    } else {
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        [cell setItem:[self.items objectAtIndex:indexPath.row]];
        return cell;
    } else {
        static NSString *SearchCellIdentifier = @"NewsSearchCell";

        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:SearchCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchCellIdentifier];
        }
        
        [cell.textLabel setText:@"Hong Kong"];
        [cell.detailTextLabel setText:@"Hong Kong, 20-21 Jun 2015"];
        return cell;
        
    }
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.items count]) {
        NewsItem *item = [self.items objectAtIndex:indexPath.row];
        CSWebBrowserVC *brvc = [[CSWebBrowserVC alloc] initWith:[NSURL URLWithString:@"http://www.google.com"] andTitle:item.title];
        brvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:brvc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
