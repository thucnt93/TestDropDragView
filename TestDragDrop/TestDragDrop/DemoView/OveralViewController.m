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
    NSMutableArray *_accounts;
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
    NSArray *initArray = @[@"TEST", @"TEST1",@"TEST2",@"TEST3",@"TEST4",@"TEST5",@"TEST6", @"TEST7"];
    _accounts = [[NSMutableArray alloc] initWithArray:initArray];
    NSArray *models = [[NSMutableArray alloc] initWithArray:initArray];
    _mockViewModel = [[MockViewModel alloc] initWithModel:models];
    [_mockViewModel setupProvider];
    [_mockViewModel buildDataSource];
    _tableViewManager = [[TableViewManager alloc] initWithTableView:self.tableView source:self provider:_mockViewModel.provider dragTrackingDelegates:self dropTrackingDelegates:self];
}

- (CGFloat)tableViewManager:(TableViewManager *)manager heightOfRow:(NSInteger)row byItem:(id)item {
    return 40.0;
}

/*
- (NSUserInterfaceItemIdentifier)tableViewManager:(TableViewManager *)manager makeViewWithIdentifierForRow:(NSInteger)row byItem:(id)item {
    return @"CELLDEMO";
}
 */

- (NSTableRowView *)tableViewManager:(TableViewManager *)manager rowViewForRow:(NSInteger)row byItem:(id)item {
    NSTextField *label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 280, 40)];
    label.stringValue = _accounts[row];
    NSTableRowView *rowView = [[NSTableRowView alloc] initWithFrame:NSMakeRect(0, 0, 280, 40)];
    [rowView addSubview:label];
    return rowView;
}

#pragma mark Drag tracking Delegate

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

/*
- (BOOL)writeToPasteboardWithTableViewManager:(TableViewManager *)manager writeRowsWithIndexes:(NSIndexSet *)rowIndexes items:(NSArray *)items toPasteboard:(NSPasteboard *)pasteboard {

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
        [pasteboard declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString] owner:self];
        [pasteboard setData:data forType:NSPasteboardTypeString];
//        sourceIndex = [rowIndexes firstIndex];
    return YES;
}
 */


#pragma mark Drop tracking Delegate

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
    NSLog(@"Did accept drop %@", dragMee);
    [_accounts insertObject:dragMee atIndex:row];
    [self.tableView reloadData];
    return YES;
}

@end
