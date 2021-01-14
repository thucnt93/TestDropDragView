//
//  DragHandler.m
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/24/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

#import "DragHandler.h"

@interface DragHandler ( )
{
    id<DragTrackingDelegate> _trackingDelegate;
}

@end

@implementation DragHandler

-(instancetype)initWithDragTrackingDelegate:(id<DragTrackingDelegate>)delegate
{
    if (self = [super init])
    {
        _trackingDelegate = delegate;
    }
    
    return self;
}


- (void)handleDragBeginWithSource:(id)source atPoint:(NSPoint)atPoint
{
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(dragBeginWithSource:atPoint:)])
    {
        CustomDragOperation operation = [_trackingDelegate dragBeginWithSource:source atPoint:atPoint];
        
        [DragOperation changeCursorByOperation:operation];
    }
}

- (void)handleDragMoveWithSource:(id)source atPoint:(NSPoint)atPoint
{
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(dragMoveWithSource:atPoint:)])
    {
        CustomDragOperation operation = [_trackingDelegate dragMoveWithSource:source atPoint:atPoint];
    
        [DragOperation changeCursorByOperation:operation];
    }
}

- (void)handleDragEndWithSource:(id)source atPoint:(NSPoint)atPoint
{
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(dragEndWithSource:atPoint:)])
    {
         [_trackingDelegate dragEndWithSource:source atPoint:atPoint];
    }
    
    [DragOperation changeCursorByOperation:NSNotFound];
}


#pragma mark - TableView DRAG

- (void)handlerDidDragTableColumnWithTableManager:(TableViewManager *)manager didDragTableColumn:(NSTableColumn *)tableColumn {
    
    NSLog(@"handle did drag table column");
}

- (void)handleDragBeginWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes items:(NSArray *)items {
    
    NSLog(@"handle begin dragging session");
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(dragBeginWithTableViewManager:draggingSession:)])
    {
         [_trackingDelegate dragBeginWithTableViewManager:manager draggingSession:session];
    }
}

- (void)handleUpdateDraggingWithTableViewManager:(TableViewManager *)manager updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo {
    
    NSLog(@"handle update draging session");
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(updateDraggingWithTableViewManager:updateDraggingItemsForDrag:)])
    {
        [_trackingDelegate updateDraggingWithTableViewManager:manager updateDraggingItemsForDrag:draggingInfo];
    }
}

- (void)handleDragEndedWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    
    NSLog(@"handle ended draggingSession");
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(dragEndedWithTableViewManager:draggingSession:endedAtPoint:operation:)])
    {
        [_trackingDelegate dragEndedWithTableViewManager:manager draggingSession:session endedAtPoint:screenPoint operation:operation];
    }
}


- (BOOL)handleWriteToPasteboardWithTableViewManager:(TableViewManager *)manager writeRowsWithIndexes:(NSIndexSet *)rowIndexes items:(NSArray *)items toPasteboard:(NSPasteboard *)pasteboard {
    
    NSLog(@"handle writeRowsWithIndexes");
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(writeToPasteboardWithTableViewManager:writeRowsWithIndexes:items:toPasteboard:)])
    {
        [_trackingDelegate writeToPasteboardWithTableViewManager:manager writeRowsWithIndexes:rowIndexes items:items toPasteboard:pasteboard];
    }
    
    return YES;
}

- (id<NSPasteboardWriting>)handlePasteboardWriterWithTableViewManager:(TableViewManager *)manager writeRow:(NSInteger)row item:(id<ListSupplierProtocol>)item {
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(pasteboardWriterWithTableViewManager:writeRow:item:)])
    {
        return [_trackingDelegate pasteboardWriterWithTableViewManager:manager writeRow:row item:item];
    }
    
    return nil;
}




@end
