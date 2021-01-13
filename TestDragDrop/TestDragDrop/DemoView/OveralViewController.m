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
#import "DropableNSButton.h"

@interface OveralViewController ()<TableViewManagerProtocols, DragTrackingDelegate, DropTrackingDelegate> {
    TableViewManager *_tableViewManager;
    MockViewModel *_mockViewModel;
}

@property (weak) IBOutlet DropableNSButton *dragButton;
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
    NSArray *initArray = @[@"TEST", @"TEST3",@"TEST3",@"TEST3",@"TEST3",@"TEST3",@"TEST3"];
    
    NSArray *models = [[NSMutableArray alloc] initWithArray:initArray];
    
    _mockViewModel = [[MockViewModel alloc] initWithModel:models];
    [_mockViewModel setupProvider];
    [_mockViewModel buildDataSource];
    
    
    _tableViewManager = [[TableViewManager alloc] initWithTableView:self.tableView source:self provider:_mockViewModel.provider dragTrackingDelegates:self dropTrackingDelegates:self];
    
}

- (NSTableRowView *)tableViewManager:(TableViewManager *)manager rowViewForRow:(NSInteger)row byItem:(id)item {
    NSTableRowView *view = [[NSTableRowView alloc] initWithFrame:NSMakeRect(0, 0, 200, 40)];
    return  view;
}

- (NSUserInterfaceItemIdentifier)tableViewManager:(TableViewManager *)manager makeViewWithIdentifierForRow:(NSInteger)row byItem:(id)item {
    return @"CELLDEMO";
}

#pragma mark Drag - Drop tracking Delegate

- (void)dragBeginWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session {
    
    NSLog(@"OveralViewController - dragBeginWithTableViewManager");
    
}

- (void)updateDraggingWithTableViewManager:(TableViewManager *)manager updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo {
    
    NSLog(@"OveralViewController - updateDraggingWithTableViewManager");
}

- (void)dragEndedWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    
    NSLog(@"OveralViewController - dragEndedWithTableViewManager");
}

@end
