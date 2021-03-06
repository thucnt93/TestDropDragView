//
//  DemoDragButton.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 22/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "DemoDragButton.h"

@interface DemoDragButton()<DragTrackingDelegate>

@end

@implementation DemoDragButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dragTrackingDelegate = self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dragTrackingDelegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dragTrackingDelegate = self;
    }
    return self;
}

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint {
    NSLog(@"Button Drag begin with source at point");
    return CustomDragOperation_MOVE;
}


// If go to table view, we should
- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
    NSLog(@"Button Drag move with source at point");
    
    // Disable drag + drop
    return CustomDragOperation_MOVE;
}

- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint {
    
}


@end
