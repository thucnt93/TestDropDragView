//
//  DropHandler.h
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/25/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "TableViewManager.h"
#import "DragOperation.h"

//NS_ASSUME_NONNULL_BEGIN

@protocol DropTrackingDelegate <NSObject>

@optional
- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo;
- (BOOL)performDropOnTarget:(id)onTarget draggingSource:(id)draggingSource;
- (NSDragOperation)validateDropWithTableViewManager:(TableViewManager *)manager validateDrop:(id<NSDraggingInfo>)draggingInfo proposedItem:(nullable id)item proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation;
- (BOOL)acceptDropWithTableViewManager:(TableViewManager *)manager acceptDrop:(id<NSDraggingInfo>_Nullable)draggingInfo item:(nullable id)item row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation;
@end

@interface DropHandler : NSObject

- (instancetype)initWithDropTrackingDelegate:(id<DropTrackingDelegate>)delegate;

// NSViewDropFunction
- (NSDragOperation)handleDraggingUpdated:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (void)handleDraggingExited:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (BOOL)handlePerformDraggingOperation:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;

// NSTableViewDropFunction
- (NSDragOperation)handleValidateDropWithTableViewManager:(TableViewManager *)manager validateDrop:(id<NSDraggingInfo>)draggingInfo proposedItem:(nullable id)item proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation;
- (BOOL)handleAcceptDropWithTableViewManager:(TableViewManager *)manager acceptDrop:(id<NSDraggingInfo>_Nullable)draggingInfo item:(nullable id)item row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation;




// NSCollection drag/drop handler



// NSOutlineView drag/drop handler

@end

//NS_ASSUME_NONNULL_END
