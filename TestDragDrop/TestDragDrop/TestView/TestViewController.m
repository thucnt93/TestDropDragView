//
//  TestViewController.m
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/25/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

#import "TestViewController.h"

#import "DroppableNSView.h"
#import "DropHandler.h"

@interface TestViewController ()<DropTrackingDelegate>

@property (weak) IBOutlet DroppableNSView *dropView;
@property (weak) IBOutlet DroppableNSView *customDropView;

@end

@implementation TestViewController

- (void)awakeFromNib
{
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    
    self.dropView.wantsLayer = YES;
    self.dropView.layer.backgroundColor = [NSColor yellowColor].CGColor;
    self.dropView.dropTrackingDelegate = self;
    
    self.customDropView.wantsLayer = YES;
    self.customDropView.layer.backgroundColor = [NSColor orangeColor].CGColor;
    self.customDropView.dropTrackingDelegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
}

#pragma mark - DropTrackingDelegate

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo
{
    NSLog(@"Tracking drag view");
    ///
    /// The last view that have a last visible cursor ==> we can have last id view
    
    
    // At here we will have a point of vie
    //  AppDelegate: have a imported view: then app will have an place to import view
    //
    return onTarget == self.customDropView? CustomDragOperation_LINK: ((CustomDragOperation) NSDragOperationCopy);
    
}

- (BOOL)performDropOnTarget:(id)onTarget draggingSource:(id)draggingSource
{
    
    /// to catch up perform drop on view when
    NSLog(@"performDropOnTarget");
    
    return YES;
}


@end
