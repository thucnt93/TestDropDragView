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

// change dragging info to object, have many param, option param
// ke thua if needed
// create object
- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo;
- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo;


// name change function, remove manager, adding param
- (CustomDragOperation)validateDropWithTableViewManager:(TableViewManager *)manager validateDrop:(id<NSDraggingInfo>)draggingInfo proposedItem:(nullable id)item proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation;
- (BOOL)acceptDropWithTableViewManager:(TableViewManager *)manager acceptDrop:(id<NSDraggingInfo>_Nullable)draggingInfo item:(nullable id)item row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation;
@end

@interface DropHandler : NSObject
- (instancetype)initWithDropTrackingDelegate:(id<DropTrackingDelegate>)delegate;

// NSViewDropFunction
#pragma mark - NSView drop handler action
- (NSDragOperation)handleDraggingUpdated:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (void)handleDraggingExited:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (BOOL)handlePerformDraggingOperation:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;

#pragma mark - NSTableViewDrop handler action
- (NSDragOperation)handleValidateDropWithTableViewManager:(TableViewManager *)manager validateDrop:(id<NSDraggingInfo>)draggingInfo proposedItem:(nullable id)item proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation;
- (BOOL)handleAcceptDropWithTableViewManager:(TableViewManager *)manager acceptDrop:(id<NSDraggingInfo>_Nullable)draggingInfo item:(nullable id)item row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation;



#pragma mark - NSCollection drag/drop handler



#pragma mark - NSOutlineView drag/drop handler

@end

//NS_ASSUME_NONNULL_END
