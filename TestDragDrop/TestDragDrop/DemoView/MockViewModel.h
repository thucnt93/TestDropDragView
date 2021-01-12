//
//  MockViewModel.h
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockViewModel : NSObject

@property (nonatomic) DataProvider * _Nonnull provider;

@property (nonatomic) NSMutableArray * _Nullable modelsList;

@end

NS_ASSUME_NONNULL_END
