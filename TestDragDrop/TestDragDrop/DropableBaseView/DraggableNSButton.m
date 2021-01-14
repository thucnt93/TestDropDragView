//
//  DraggableNSButton.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

/*
 
 Change cursor
 
 Change behavior drag drop -> tableView drag
 
 Cancel + escap + notification error
 
 Drag/Drop end event + webView(webView let after)
 
 Drag at session + drop at session
 
 Disable drag/ Disable drop
 
 */


#import "DraggableNSButton.h"
#import "Helper.h"

@implementation DraggableNSButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor brownColor] CGColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerForDraggedTypes:[NSArray arrayWithObjects:(id)kUTTypeData, NSFilenamesPboardType, nil]];
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
    
    /*
     
     */
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

- (void)pasteboard:(NSPasteboard *)sender provideDataForType:(NSPasteboardType)type {
    
}

- (void)pasteboard:(NSPasteboard *)pasteboard item:(NSPasteboardItem *)item provideDataForType:(NSPasteboardType)type {
    //    NSData *pdfData = [self dataWithPDFInsideRect: self.bounds];
    //
    //    [pasteboard setData:pdfData forType:(id)kUTTypeData];
    NSString *titleStringButton;
    if (self.title == nil) {
        titleStringButton = self.stringValue;
    } else {
        titleStringButton = self.title;
    }
    
    NSData *data = [titleStringButton dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [pasteboard setData:data forType:NSPasteboardTypeString];
}



- (NSDragOperation)draggingSession:(nonnull NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context {
    
    return NSDragOperationEvery;
}



@end
