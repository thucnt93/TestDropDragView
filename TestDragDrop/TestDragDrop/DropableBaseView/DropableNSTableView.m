//
//  DropableNSTableView.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 11/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "DropableNSTableView.h"
#import "TableViewManager.h"

@interface DropableNSTableView() {
    
}

@end

@implementation DropableNSTableView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    
    return NSDragOperationNone;
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    
}


@end
