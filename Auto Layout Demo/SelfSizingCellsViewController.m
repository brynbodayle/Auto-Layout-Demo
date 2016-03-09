//
//  SelfSizingCellsViewController.m
//  Auto Layout Demo
//
//  Created by Bryn Bodayle on March/8/2016.
//  Copyright © 2016 Bryn Bodayle. All rights reserved.
//

#import "SelfSizingCellsViewController.h"
#import "SelfSizingTableViewCell.h"
#import "Helpers.h"

static const NSUInteger SelfSizingCellsViewControllerNumberOfItems = 10;

@interface SelfSizingCellsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *descriptions;

@end

@implementation SelfSizingCellsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 81.0f;
    
    [self generateSampleText];
}

- (void)generateSampleText {
    
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *descriptions = [NSMutableArray array];
    
    for(NSUInteger index = 0; index < SelfSizingCellsViewControllerNumberOfItems; index++) {
        
        NSString *title = SampleText(10, 50);
        NSString *description = SampleText(10, 100);
        
        [titles addObject:title];
        [descriptions addObject:description];
    }
    
    self.titles = titles;
    self.descriptions = descriptions;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelfSizingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SelfSizingTableViewCell class]) forIndexPath:indexPath];
    
    cell.titleLabel.text = self.titles[indexPath.row];
    cell.descriptionLabel.text = self.descriptions[indexPath.row];
    
    return cell;
}


@end
