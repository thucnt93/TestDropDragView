//
//  DemoDragView.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 20/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "DemoDragView.h"
#import "NSView+init.h"

@interface DemoDragView()<DragTrackingDelegate>


@end

@implementation DemoDragView

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
        self = [self createFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self createFromNib];
    }
    return self;
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
// - (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
//
//     NSLog(@"Drag move with source at point");
//
//     NSPoint locationInwindow = [self.tableView.window convertPointFromScreen:atPoint];
//     NSPoint point = [self.tableView convertPoint:locationInwindow fromView:nil];
//     if (NSPointInRect(point, self.tableView.bounds)) {
//         return CustomDragOperation_STOP;
//     }
//     return CustomDragOperation_MOVE;
// }

 - (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint {
     
     NSLog(@"Drag end with source at point");
     
 //    self.resLabel.stringValue = @"";
 //    self.resLabel.stringValue = @"DRAG END AT POINT";
 }


@end
