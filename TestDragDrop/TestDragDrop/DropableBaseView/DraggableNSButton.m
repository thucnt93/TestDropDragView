//
//  DraggableNSButton.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//


#import "DraggableNSButton.h"
#import "Helper.h"

@implementation DraggableNSButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor brownColor] CGColor];
    
    [self registerForDraggedTypes:[NSArray arrayWithObjects:(id)kUTTypeData, NSPasteboardTypeFileURL, nil]];
}

- (NSImage *)imageRepresentative
{
    NSBitmapImageRep *imageRep = [self bitmapImageRepForCachingDisplayInRect:[self visibleRect]];
    [self cacheDisplayInRect:[self visibleRect] toBitmapImageRep:imageRep];
    NSImage *image = [[NSImage alloc] initWithCGImage:[imageRep CGImage] size:[self visibleRect].size];
    
    return image;
}

- (void)setDraggingSessionWithEvent:(NSEvent *)event
{
    //    if (self.draggingEnabled && _dragEnabled) {
    NSPasteboardItem *pbItem = [NSPasteboardItem new];
    [pbItem setDataProvider:self forTypes:[NSArray arrayWithObjects:(id)kUTTypeData, nil]];
    
    NSString *titleStringButton;
    if (self.title == nil) {
        titleStringButton = self.stringValue;
    } else {
        titleStringButton = self.title;
    }
    NSData *data = [titleStringButton dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [pbItem setData:data forType:NSPasteboardTypeString];
    NSDraggingItem *dragItem = [[NSDraggingItem alloc] initWithPasteboardWriter:pbItem];
    NSRect draggingRect = [self visibleRect];
    
    [dragItem setDraggingFrame:draggingRect contents:[self imageRepresentative]];
    
    //create a dragging session with our drag item and ourself as the source.
    NSDraggingSession *draggingSession = [self beginDraggingSessionWithItems:[NSArray arrayWithObject:dragItem] event:event source:self];
    
    //causes the dragging item to slide back to the source if the drag fails.
    draggingSession.animatesToStartingPositionsOnCancelOrFail = YES;
    draggingSession.draggingFormation = NSDraggingFormationNone;
    //    }
}

- (BOOL)acceptsFirstMouse:(NSEvent *)event
{
    return YES;
}

- (BOOL)acceptsFirstResponder
{
    return YES;
}

- (void)mouseUp:(NSEvent *)event {
    // Do nothing but it need to catch event mouseDragged
}

- (void)mouseDown:(NSEvent *)event {
    
}

- (void)mouseDragged:(NSEvent *)event
{
    [self setDraggingSessionWithEvent:event];
    [super mouseDragged:event];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    
    return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    
    return YES;
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    
}

- (NSDragOperation)draggingSession:(nonnull NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context {
    
    return NSDragOperationEvery;
}


@end
