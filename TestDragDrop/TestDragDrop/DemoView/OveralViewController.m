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
#import "DraggableNSButton.h"
#import "DroppableNSView.h"
#import "DraggableNSView.h"
#import "DemoDropView.h"
#import "DemoDragView.h"
#import "Helper.h"

@interface OveralViewController ()<TableViewManagerProtocols, DragTrackingDelegate, DropTrackingDelegate> {
    TableViewManager *_tableViewManager;
    MockViewModel *_mockViewModel;
    NSMutableArray *_accounts;
    BOOL _enableDrop;
    DemoDropView *_demoDropView;
    DemoDragView *_demoDragView;
}

@property (weak) IBOutlet DraggableNSButton *dragButton;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSView *dropableView;
@property (weak) IBOutlet NSView *nsDraggableView;
@property (weak) IBOutlet NSSwitch *switchEnableDrop;

@property (weak) IBOutlet DroppableNSView *parentView;


@end

@implementation OveralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self setUpView];
}

- (void)setUpView {
    _enableDrop = NO;
    self.dropableView.wantsLayer = YES;
    self.dropableView.layer.backgroundColor = [[NSColor brownColor] CGColor];
    
    NSArray *initArray = @[@"TEST", @"TEST1",@"TEST2",@"TEST3",@"TEST4",@"TEST5",@"TEST6", @"TEST7"];
    _accounts = [[NSMutableArray alloc] initWithArray:initArray];
    NSArray *models = [[NSMutableArray alloc] initWithArray:initArray];
    _mockViewModel = [[MockViewModel alloc] initWithModel:models];
    [_mockViewModel setupProvider];
    [_mockViewModel buildDataSource];
    
    [self setupTrackingDragDrop];
}

- (void)viewWillAppear {
    [super viewWillAppear];
    _demoDropView = [[DemoDropView alloc] init];
    [[Helper sharedInstance] addAutoResizingView:_demoDropView toView:self.dropableView];
    _demoDragView = [[DemoDragView alloc] init];
    [[Helper sharedInstance] addAutoResizingView:_demoDragView toView:self.nsDraggableView];
    
}

- (IBAction)enableDrop:(id)sender {
    _enableDrop = ((NSSwitch *)sender).state;
    [_demoDropView updateDropEnable:_enableDrop];
}

- (void)setupTrackingDragDrop {
    _tableViewManager = [[TableViewManager alloc] initWithTableView:self.tableView source:self provider:_mockViewModel.provider];
    [_tableViewManager setDragTrackingDelegate:self];
    [_tableViewManager setDropTrackingDelegate:self];
}

- (CGFloat)tableViewManager:(TableViewManager *)manager heightOfRow:(NSInteger)row byItem:(id)item {
    return 40.0;
}

- (NSTableRowView *)tableViewManager:(TableViewManager *)manager rowViewForRow:(NSInteger)row byItem:(id)item {
    NSTextField *label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 280, 40)];
    label.stringValue = _accounts[row];
    NSTableRowView *rowView = [[NSTableRowView alloc] initWithFrame:NSMakeRect(0, 0, 280, 40)];
    [rowView addSubview:label];
    return rowView;
}

#pragma mark Drag tracking Delegate TABLEVIEW

- (void)dragBeginWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session {
    NSLog(@"OveralViewController - dragBeginWithTableViewManager");
}

- (void)updateDraggingWithTableViewManager:(TableViewManager *)manager updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo {
    NSLog(@"OveralViewController - updateDraggingWithTableViewManager");
    
}

- (void)dragEndedWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    NSLog(@"OveralViewController - dragEndedWithTableViewManager");
}

- (id<NSPasteboardWriting>)pasteboardWriterWithTableViewManager:(TableViewManager *)manager writeRow:(NSInteger)row item:(id<ListSupplierProtocol>)item {
    NSLog(@"Account element: %@", _accounts[row]);
    return _accounts[row];
}

#pragma mark Drop tracking Delegate TABLEVIEW

- (CustomDragOperation)validateDropWithTableViewManager:(TableViewManager *)manager validateDrop:(id<NSDraggingInfo>)draggingInfo proposedItem:(id)item proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    
    self.dragButton.disableDragTracking = YES;
    
    CustomDragOperation ret = CustomDragOperation_ALLOW;
    if (_enableDrop) {
        ret = CustomDragOperation_ALLOW;
        NSLog(@"=========THUC=====: ALLOW operation");
    } else {
        ret = CustomDragOperation_STOP;
        NSLog(@"=========THUC=====: stop operation");
    }
    manager.tableView.draggingDestinationFeedbackStyle = NSTableViewDraggingDestinationFeedbackStyleGap;
    return ret;
}

- (BOOL)acceptDropWithTableViewManager:(TableViewManager *)manager acceptDrop:(id<NSDraggingInfo>)draggingInfo item:(id)item row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation{
    
    if (_enableDrop) {
        NSPasteboard *pasteBoard = draggingInfo.draggingPasteboard;
        NSString *dragMeeButton = [pasteBoard stringForType:NSPasteboardTypeString];
        [_accounts insertObject:dragMeeButton atIndex:row];
        [self.tableView reloadData];
        return YES;
    }
    
    return NO;
}

@end
