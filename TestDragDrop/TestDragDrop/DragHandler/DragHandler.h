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
#import "TableViewManager.h"

//NS_ASSUME_NONNULL_BEGIN

@protocol DragTrackingDelegate <NSObject>

@optional

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint;


// Handler in presenting view
// question: delegate and datasource will implement in where => anser: in manager

- (void)didDragTableColumnWithTableManager:(TableViewManager *)manager didDragTableColumn:(NSTableColumn *)tableColumn;
- (void)dragBeginWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session;
- (void)updateDraggingWithTableViewManager:(TableViewManager *)manager updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo;
- (void)dragEndedWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation;
- (BOOL)writeToPasteboardWithTableViewManager:(TableViewManager *)manager writeRowsWithIndexes:(NSIndexSet *)rowIndexes items:(NSArray *)items toPasteboard:(NSPasteboard *)pasteboard;

@end

@interface DragHandler : NSObject

- (instancetype)initWithDragTrackingDelegate:(id<DragTrackingDelegate>)delegate;

// NSViewDragHandler
- (void)handleDragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragEndWithSource:(id)source atPoint:(NSPoint)atPoint;

// TableViewDragHandler
// handle in handler
- (void)handlerDidDragTableColumnWithTableManager:(TableViewManager *)manager didDragTableColumn:(NSTableColumn *)tableColumn;
- (void)handleDragBeginWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes items:(NSArray *)items;
- (void)handleUpdateDraggingWithTableViewManager:(TableViewManager *)manager updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo;
- (void)handleDragEndedWithTableViewManager:(TableViewManager *)manager draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation;
- (BOOL)handleWriteToPasteboardWithTableViewManager:(TableViewManager *)manager writeRowsWithIndexes:(NSIndexSet *)rowIndexes items:(NSArray *)items toPasteboard:(NSPasteboard *)pasteboard;


@end

//NS_ASSUME_NONNULL_END
