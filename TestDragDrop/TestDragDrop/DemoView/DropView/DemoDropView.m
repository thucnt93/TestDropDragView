//
//  DemoDropView.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 20/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "DemoDropView.h"
#import "NSView+init.h"

@interface DemoDropView()<DropTrackingDelegate>

@property (weak) IBOutlet NSTextField *titleLabel;
@property BOOL logicEnable;

@end

@implementation DemoDropView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor systemYellowColor] CGColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dropTrackingDelegate = self;
    [self updateResultString:@"Drag here"];
}

- (void)updateResultString: (NSString *)string {
    self.titleLabel.stringValue = string;
}

- (void)updateDropEnable: (BOOL)enable {
    self.logicEnable = enable;
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

#pragma mark - NSVIEW DROP DESTINATION IMPLEMENT

- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo
{
    NSString *draggingInfoString = [draggingInfo.draggingPasteboard stringForType:NSPasteboardTypeString];
    [self updateResultString:draggingInfoString];
    return YES;
}

//TODO: Update cursor here, validate here
- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo {
    if (_logicEnable) {
        return CustomDragOperation_ALLOW;
    }
    return CustomDragOperation_STOP;
}







@end
