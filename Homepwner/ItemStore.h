//
//  ItemStore.h
//  Homepwner
//
//  Created by Sunny on 27/05/2015.
//  Copyright (c) 2015 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface ItemStore : NSObject

+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (NSArray *)allItems;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex: (NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;

@end
