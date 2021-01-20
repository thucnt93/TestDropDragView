//
//  Helper.h
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface Helper : NSObject
+ (instancetype)sharedInstance;
- (NSImage *)snapshotWithView:(NSView *)view;
- (void)addAutoResizingView:(NSView *)subView toView:(NSView *)containerView;
@end

NS_ASSUME_NONNULL_END
