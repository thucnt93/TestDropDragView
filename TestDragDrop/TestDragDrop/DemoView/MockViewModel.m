//
//  MockViewModel.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "MockViewModel.h"

@implementation MockViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.provider = [[DataProvider alloc] initProviderForOwner:self];
        self.modelsList = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
