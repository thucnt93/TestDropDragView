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
    BOOL _enableDrop;
}

@property (weak) IBOutlet NSTextField *resLabel;
@property (weak) IBOutlet DraggableNSButton *dragButton;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet DroppableNSView *nsView;
@property (weak) IBOutlet DraggableNSView *nsDraggableView;
@property (weak) IBOutlet NSTextField *titleDragView;
@property (weak) IBOutlet NSSwitch *switchEnableDrop;

@end

@implementation OveralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self setUpView];
}

- (void)setUpView {
    _enableDrop = NO;
    self.resLabel.stringValue = @"";
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

- (IBAction)enableDrop:(id)sender {
    _enableDrop = ((NSSwitch *)sender).state;
}

- (void)setupTrackingDragDrop {
    
    _tableViewManager = [[TableViewManager alloc] initWithTableView:self.tableView source:self provider:_mockViewModel.provider dragTrackingDelegates:self dropTrackingDelegates:self];
    
    self.nsView.dropTrackingDelegate = self;
    self.nsDraggableView.dragTrackingDelegate = self;
    self.nsDraggableView.titleData = self.titleDragView.stringValue;
    
    self.dragButton.dragTrackingDelegate = self;
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
    
    CustomDragOperation ret;
    if (_enableDrop) {
        ret = CustomDragOperation_ALLOW;
        NSLog(@"=========THUC=====: left operation");
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

#pragma mark - NSVIEW DRAG SOURCE IMPLEMENT
///////////////////////////////////////////////////////////////////////////////////////////////
// At here we can change cursor dependence on bound View / OR note needed to change cursor,
// because in drop destination we have a validation function in drag update to determine cursor
- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint {
    NSLog(@"Drag begin with source at point");
    return CustomDragOperation_MOVE;
}

/*
 Should not change cursor here because it trace location and set flash cursor
 Only optional
 */
//- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
//
//    NSLog(@"Drag move with source at point");
//
//    NSPoint locationInwindow = [self.tableView.window convertPointFromScreen:atPoint];
//    NSPoint point = [self.tableView convertPoint:locationInwindow fromView:nil];
//    if (NSPointInRect(point, self.tableView.bounds)) {
//        return CustomDragOperation_STOP;
//    }
//    return CustomDragOperation_MOVE;
//}

- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    NSLog(@"Drag end with source at point");
    
//    self.resLabel.stringValue = @"";
    self.resLabel.stringValue = @"DRAG END AT POINT";
}

#pragma mark - NSVIEW DROP DESTINATION IMPLEMENT
///////////////////////////////////////////////////////////////////////////////////////////////
// Find out info about this view when return NO;
- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo
{
    NSLog(@"perform drag and drop");
    NSString *draggingInfoString = [draggingInfo.draggingPasteboard stringForType:NSPasteboardTypeString];
    self.resLabel.stringValue = draggingInfoString;
    return YES;
}

//TODO: Update cursor here, validate here
- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo {

    NSLog(@"dragUpdatedOnTarget with info");

    if (_enableDrop) {
        return CustomDragOperation_ALLOW;
    }
    return CustomDragOperation_STOP;
}

@end
