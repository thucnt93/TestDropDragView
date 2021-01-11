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

@end
