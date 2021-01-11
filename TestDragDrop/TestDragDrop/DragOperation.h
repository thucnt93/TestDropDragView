//
//  DragOperation.h
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/25/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

//NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CustomDragOperation)
{
    CustomDragOperation_STOP        = 128,
    CustomDragOperation_MOVE        = 128 << 1,
    CustomDragOperation_LINK        = 128 << 2,
    CustomDragOperation_LEFT        = 128 << 3,
    CustomDragOperation_RIGHT       = 128 << 4,
    CustomDragOperation_NONE        = 128 << 10,
};

@interface DragOperation : NSObject

+ (void)changeCursorByOperation:(CustomDragOperation)operation;

@end

//NS_ASSUME_NONNULL_END
