//
//  NSView+init.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 20/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "NSView+init.h"

@implementation NSView (Init)

- (NSString *)nibName {
    return NSStringFromClass(self.class);
}

- (instancetype)createFromNib {
    NSArray *nibs;
    [[NSBundle mainBundle] loadNibNamed:[self nibName] owner:self topLevelObjects:&nibs];
    id view = nil;
    for ( id object in nibs) {
        if ([object isKindOfClass:self.class]) {
            view = object;
            break;
        }
    }
    return view;
}

@end
 
