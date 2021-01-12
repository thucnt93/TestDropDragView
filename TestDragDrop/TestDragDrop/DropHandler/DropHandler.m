//
//  DropHandler.m
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/25/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

#import "DropHandler.h"

#import "DraggableNSView.h"

@interface DropHandler ()
{
    id<DropTrackingDelegate> _dropTrackingDelegate;
    
    CustomDragOperation _dragOperation;
}

@end

@implementation DropHandler

- (instancetype)initWithDropTrackingDelegate:(id<DropTrackingDelegate>)delegate
{
    if (self = [super init])
    {
        _dropTrackingDelegate = delegate;
    }
    
    return self;
}

- (NSDragOperation)handleDraggingUpdated:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget
{
    _dragOperation = CustomDragOperation_NONE;
    
    if ((_dropTrackingDelegate != nil) && [_dropTrackingDelegate respondsToSelector:@selector(dragUpdatedOnTarget:withInfo:)])
    {
        _dragOperation = [_dropTrackingDelegate dragUpdatedOnTarget:onTarget withInfo:draggingInfo];
    }
    
    return [self handleCustomDragOperation:_dragOperation draggingSource:draggingInfo.draggingSource];
}

- (void)handleDraggingExited:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget
{
    [self handleCustomDragOperation:CustomDragOperation_NONE draggingSource:draggingInfo.draggingSource]; //enable disableDragTracking on DraggableNSView
}

- (BOOL)handlePerformDraggingOperation:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget
{
    if (_dropTrackingDelegate != nil && [_dropTrackingDelegate respondsToSelector:@selector(performDropOnTarget:draggingSource:)])
    {
        return [_dropTrackingDelegate performDropOnTarget:onTarget draggingSource:draggingInfo.draggingSource];
    }
    
    return NO;
}


#pragma mark - Handle Custom Operation

- (NSDragOperation)handleCustomDragOperation:(CustomDragOperation)operation draggingSource:(id)draggingSource
{
    if ([draggingSource isKindOfClass:[DraggableNSView class]])
    {
        ((DraggableNSView *)draggingSource).disableDragTracking = (operation != CustomDragOperation_NONE);
    }
    
    NSUInteger allSystemOperations = NSDragOperationCopy
                                    | NSDragOperationLink
                                    | NSDragOperationGeneric
                                    | NSDragOperationPrivate
                                    | NSDragOperationMove
                                    | NSDragOperationDelete
                                    | NSDragOperationNone;
    
    if (operation & allSystemOperations)
    {
        //system operations
        
        return (NSDragOperation) operation;
    }
        
    [DragOperation changeCursorByOperation:operation];
    
    return operation == CustomDragOperation_NONE?NSDragOperationNone:NSDragOperationGeneric;
}


@end
