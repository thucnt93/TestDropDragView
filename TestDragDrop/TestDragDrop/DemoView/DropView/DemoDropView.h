//
//  DemoDropView.h
//  TestDragDrop
//
//  Created by Thuc Nguyen on 20/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "DroppableNSView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoDropView : DroppableNSView

- (void)updateResultString: (NSString *)string;
- (void)updateDropEnable: (BOOL)enable;

@end

NS_ASSUME_NONNULL_END
