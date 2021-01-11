//
//  DragHandler.h
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/24/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "DragOperation.h"

//NS_ASSUME_NONNULL_BEGIN

@protocol DragTrackingDelegate <NSObject>

@optional

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint;

@end

@interface DragHandler : NSObject

- (instancetype)initWithDragTrackingDelegate:(id<DragTrackingDelegate>)delegate;

- (void)handleDragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragEndWithSource:(id)source atPoint:(NSPoint)atPoint;

@end

//NS_ASSUME_NONNULL_END
