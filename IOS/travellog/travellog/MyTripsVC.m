//
//  MyTripsVC.m
//  travellog
//
//  Created by Cullen on 20/6/15.
//  Copyright (c) 2015 Cullen. All rights reserved.
//

#import "MyTripsVC.h"
#import "NewsItem.h"
#import "CSWebBrowserVC.h"
#import "CreateMediaVC.h"

@interface MyTripsVC ()
@property (nonatomic, strong) NSArray *inProgressTrips;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation MyTripsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *newBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(new:)];
    self.navigationItem.leftBarButtonItem = newBtn;
    
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}


- (void)refresh:(id)sender {
    if (!self.isLoading) {
        [self.refreshControl endRefreshing];
    } else {
        [self.refreshControl endRefreshing];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    id archives = [[NSUserDefaults standardUserDefaults] objectForKey:@"todoTrips"];
    
    if ([archives isKindOfClass:[NSArray class]]) {
        self.inProgressTrips = [NSArray arrayWithArray:archives];
    } else {
        self.inProgressTrips = @[@{@"id": @"1", @"dates": @"21 Jun 2015 - ", @"destination": @"Thailand", }];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    } else {
        return [self.inProgressTrips count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Completed";
    } else {
        return @"In Progress";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTripCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row%2 == 1) {
            [cell.textLabel setText:@"Dubai"];
            [cell.detailTextLabel setText:@"31 Mar 2015 - 26 Apr 2015"];
        } else {
            [cell.textLabel setText:@"Hong Kong"];
            [cell.detailTextLabel setText:@"21 Jun 2015 - 26 Jun 2015"];
        }
        
    } else {
        NSDictionary *item = [self.inProgressTrips objectAtIndex:indexPath.row];
        [cell.textLabel setText:item[@"destination"]];
        [cell.detailTextLabel setText:item[@"dates"]];
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CSWebBrowserVC *brvc = [[CSWebBrowserVC alloc] initWith:[NSURL URLWithString:@"http://www.google.com"] andTitle:@"Trip"];
        brvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:brvc animated:YES];
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"To Do" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Attach Media", @"Edit", @"Complete", @"Delete", nil];
        actionSheet.tag = indexPath.row;
        actionSheet.destructiveButtonIndex = 3;
        [actionSheet showInView:self.view];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            //Attach Media
        {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Create" bundle:nil];
            CreateMediaVC *createMedia = [sb instantiateViewControllerWithIdentifier:@"CreateMediaVC"];
            
            //  CreateTripVC *createVC = [nav.viewControllers firstObject];
            
            [self.navigationController pushViewController:createMedia animated:YES];
        }
            break;
        case 1:
            //Edit
            break;
        case 2:
            //complete
            break;
        case 3:
            //delete
        {
            NSMutableArray *temArray = [NSMutableArray arrayWithArray:self.inProgressTrips];
            [temArray removeObjectAtIndex:actionSheet.tag];
            
            self.inProgressTrips = [temArray copy];
            [self.tableView reloadData];

        }
            break;
        default:
            break;
    }
}


- (void)new:(id)barBtn {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Create" bundle:nil];
    UINavigationController *nav = [sb instantiateViewControllerWithIdentifier:@"createTripNav"];
    
    //  CreateTripVC *createVC = [nav.viewControllers firstObject];
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
}

@end
