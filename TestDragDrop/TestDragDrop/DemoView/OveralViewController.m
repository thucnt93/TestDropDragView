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

@interface OveralViewController ()<TableViewManagerProtocols, DragTrackingDelegate, DropTrackingDelegate> {
    TableViewManager *_tableViewManager;
    MockViewModel *_mockViewModel;
    NSMutableArray *_accounts;
}

@property (weak) IBOutlet NSTextField *resLabel;
@property (weak) IBOutlet DraggableNSButton *dragButton;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet DroppableNSView *nsView;
@property (weak) IBOutlet DraggableNSView *nsDraggableView;

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
    
    NSArray *initArray = @[@"TEST", @"TEST1",@"TEST2",@"TEST3",@"TEST4",@"TEST5",@"TEST6", @"TEST7"];
    _accounts = [[NSMutableArray alloc] initWithArray:initArray];
    NSArray *models = [[NSMutableArray alloc] initWithArray:initArray];
    _mockViewModel = [[MockViewModel alloc] initWithModel:models];
    [_mockViewModel setupProvider];
    [_mockViewModel buildDataSource];
    
    [self setupTrackingDragDrop];
}

- (void)setupTrackingDragDrop {
    
    _tableViewManager = [[TableViewManager alloc] initWithTableView:self.tableView source:self provider:_mockViewModel.provider dragTrackingDelegates:self dropTrackingDelegates:self];
    
    self.nsView.dropTrackingDelegate = self;
    
    self.nsDraggableView.dragTrackingDelegate = self;
}

- (CGFloat)tableViewManager:(TableViewManager *)manager heightOfRow:(NSInteger)row byItem:(id)item {
    return 40.0;
}

// TAKE A NOTE, SHOULD REMOVE THIS FUNCTION
- (NSUserInterfaceItemIdentifier)tableViewManager:(TableViewManager *)manager makeViewWithIdentifierForRow:(NSInteger)row byItem:(id)item {
    return @"";
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

- (NSDragOperation)validateDropWithTableViewManager:(TableViewManager *)manager validateDrop:(id<NSDraggingInfo>)draggingInfo proposedItem:(id)item proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    NSDragOperation ret = NSDragOperationMove;
    if (dropOperation == NSTableViewDropAbove) {
        NSPasteboard *pboard = [draggingInfo draggingPasteboard];
        
        if ([[pboard types] containsObject:(id)kUTTypeData] || [[pboard types] containsObject:NSPasteboardTypeURL]) {
            ret = NSDragOperationGeneric;
        }
    }
    manager.tableView.draggingDestinationFeedbackStyle = NSTableViewDraggingDestinationFeedbackStyleGap;
    return ret;
}

- (BOOL)acceptDropWithTableViewManager:(TableViewManager *)manager acceptDrop:(id<NSDraggingInfo>)draggingInfo item:(id)item row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation{
    NSPasteboard *pasteBoard = draggingInfo.draggingPasteboard;
    NSString *dragMee = [pasteBoard stringForType:NSPasteboardTypeString];
    [_accounts insertObject:dragMee atIndex:row];
    [self.tableView reloadData];
    return YES;
}

#pragma mark - NSVIEW DRAG

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    return CustomDragOperation_STOP;
}

- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    return CustomDragOperation_STOP;
}

- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    self.resLabel.stringValue = @"";
    
}

#pragma mark - NSVIEW DROP

// Find out info about this view when return NO;
- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo {
    NSLog(@"perform drag and drop");
    NSLog(@"dragUpdatedOnTarget");
    NSString *draggingInfoString = [draggingInfo.draggingPasteboard stringForType:NSPasteboardTypeString];
    self.resLabel.stringValue = draggingInfoString;
    return YES;
}


//TODO: Update cursor here, validate here
- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo {
    
    return CustomDragOperation_MOVE;
}



@end
