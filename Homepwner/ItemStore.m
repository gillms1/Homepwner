//
//  ItemStore.m
//  Homepwner
//
//  Created by Sunny on 27/05/2015.
//  Copyright (c) 2015 Sunny. All rights reserved.
//

#import "ItemStore.h"
#import "BNRItem.h"

@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation ItemStore

+(instancetype)sharedStore
{
    static ItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc]initPrivate];
    }
    
    return sharedStore;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [ItemStore sharedStore]" userInfo:nil];
    return nil;
}

-(instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _privateItems = [[NSMutableArray alloc]init];
    }
    
    return self;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    //Get a pointer to object being moved so you can re-insert it
    BNRItem *item = self.privateItems[fromIndex];
    
    //Remove item from the array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    //Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
