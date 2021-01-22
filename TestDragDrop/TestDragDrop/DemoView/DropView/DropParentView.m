//
//  DropParentView.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 22/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "DropParentView.h"

@interface DropParentView()<DropTrackingDelegate>

@end

@implementation DropParentView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dropTrackingDelegate = self;
    
    
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[[NSColor systemBrownColor] colorWithAlphaComponent:0.5] CGColor];
    
}

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo {

    return CustomDragOperation_MOVE;
}

- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo {
    return YES;
}





@end
