//
//  DropHandler.h
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/25/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "DragOperation.h"

//NS_ASSUME_NONNULL_BEGIN

@protocol DropTrackingDelegate <NSObject>

@optional

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo;
- (BOOL)performDropOnTarget:(id)onTarget draggingSource:(id)draggingSource;

@end

@interface DropHandler : NSObject

- (instancetype)initWithDropTrackingDelegate:(id<DropTrackingDelegate>)delegate;

- (NSDragOperation)handleDraggingUpdated:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (void)handleDraggingExited:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (BOOL)handlePerformDraggingOperation:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;

@end

//NS_ASSUME_NONNULL_END
