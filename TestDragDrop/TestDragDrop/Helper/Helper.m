//
//  Helper.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "Helper.h"

@implementation Helper


+ (instancetype)sharedInstance
{
    static Helper *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[Helper alloc] init];
    });
    return  shared;
}


- (NSImage *)snapshotWithView:(NSView *)view {
    NSData *pdfData = [view dataWithPDFInsideRect: view.bounds];
    NSImage *image = [[NSImage alloc] initWithData:pdfData];
    if (image != nil) {
        return image;
    }
    return [[NSImage alloc] init];
}

- (void)addAutoResizingView:(NSView *)containerView toView:(NSView *)toView
{
    if (containerView != nil)
    {
        [toView addSubview:containerView];
        
        [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [toView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)]];
        [toView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)]];
        
        // Should force update view constraints for update UI correctly.
        // [FM-1270] Show flashing for Flo app when open with Compact mode.
        [toView layoutSubtreeIfNeeded];
        [toView.superview layoutSubtreeIfNeeded];
    }
}

@end
