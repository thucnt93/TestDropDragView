//
//  AppDelegate.m
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/24/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

#import "AppDelegate.h"

#import "DragOperation.h"

#import "DraggableView.h"

#import "TestViewController.h"

#import "OutsideViewContronller.h"

@interface AppDelegate ()
{
    TestViewController *_testCtrler;
    OutsideViewContronller *outsideViewController;
}

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSView *testView;

@property (weak) IBOutlet DraggableView *dragView;

@property (weak) IBOutlet NSView *outsideView;

@property (weak) IBOutlet DraggableView *imageSource;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    _testCtrler = [TestViewController new];
    
    [self addAutoResizingView:_testCtrler.view toView:_testView];
    
    self.dragView.dragTrackingDelegate = self;
    self.imageSource.dragTrackingDelegate = self;
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
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

#pragma mark - DragTrackingDelegate

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint
{
    NSPoint locationInWindow = [_testCtrler.view.window convertPointFromScreen:atPoint];
    
    NSPoint point = [_testCtrler.view convertPoint:locationInWindow fromView:nil];
    
    if (NSPointInRect(point, _testCtrler.view.bounds))
    {
        return CustomDragOperation_MOVE;
    }
    
    return CustomDragOperation_STOP;
}

- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint
{
    
    /// HERE we have left and right:
    /// How to know what action is:
    /// cursor combine with drop update
    ///
    
    NSPoint locationInWindow = [_testCtrler.view.window convertPointFromScreen:atPoint];
    
    NSPoint point = [_testCtrler.view convertPoint:locationInWindow fromView:nil];
    
    if (NSPointInRect(point, _testCtrler.view.bounds))
    {
        return CustomDragOperation_MOVE;
    }
    
    if (locationInWindow.x <= 40)
    {
        return CustomDragOperation_LEFT;
    }
    
    float maxWidth = _testCtrler.view.window.frame.size.width - 40;
    
    if (locationInWindow.x >= maxWidth)
    {
        return CustomDragOperation_RIGHT;
    }
    
    return CustomDragOperation_STOP;
}

- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint
{
    NSLog(@"=====================Dragging WILL END AT=====================: @......");
    NSLog(@"Drag End at [%lf, %lf]", atPoint.x, atPoint.y);
    // At this view, we have an action
    // The question is: how to control action base on cursor position
    // How to decide action base on
    
    // 1. Base on point of dragView, we
    
    // Save last point to Global instance,
    // Then we have last window point,
    // Then check what is view contain that point, then present
    
    if (outsideViewController == nil) {
        outsideViewController = [[OutsideViewContronller alloc] init];
        [self addAutoResizingView:outsideViewController.view toView:self.outsideView];
    }
    
    [DragOperation changeCursorByOperation:CustomDragOperation_NONE];
    
    // At here, we push a callback to that view
}

@end
