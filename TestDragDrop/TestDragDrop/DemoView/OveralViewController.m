//
//  OveralViewController.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "OveralViewController.h"
#import "TableViewManager.h"
#import "MockViewModel.h"

@interface OveralViewController ()<TableViewManagerProtocols> {
    TableViewManager *_tableViewManager;
    MockViewModel *_mockViewModel;
}

@property (weak) IBOutlet NSButton *dragButton;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSView *nsView;

@end

@implementation OveralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self setUpView];
}

- (void)setUpView {
    self.nsView.wantsLayer = YES;
    self.nsView.layer.backgroundColor = [[NSColor brownColor] CGColor];
    
    _mockViewModel = [[MockViewModel alloc] init];
    _tableViewManager = [[TableViewManager alloc] initWithTableView:self.tableView source:self provider:_mockViewModel.provider];
}

- (NSTableRowView *)tableViewManager:(TableViewManager *)manager rowViewForRow:(NSInteger)row byItem:(id)item {
    
    return  nil;
}

- (NSUserInterfaceItemIdentifier)tableViewManager:(TableViewManager *)manager makeViewWithIdentifierForRow:(NSInteger)row byItem:(id)item {
    
    return @"";
}

@end
