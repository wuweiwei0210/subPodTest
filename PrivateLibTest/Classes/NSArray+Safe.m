//
//  NSArray+Safe.m
//  iOS-Category
//
//  Created by 庄BB的MacBook on 2018/5/18.
//  Copyright © 2018年 BBFC. All rights reserved.
//

#import "NSArray+Safe.h"


@implementation NSArray (Safe)

+ (instancetype)safeArrayWithObject:(id)object {
    if (object == nil) {
        return [self array];
    } else {
        return [self arrayWithObject:object];
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    } else {
        return [self objectAtIndex:index];
    }
}

- (NSUInteger)safeIndexOfObject:(id)anObject {
    if (anObject == nil) {
        return NSNotFound;
    } else {
        return [self indexOfObject:anObject];
    }
}

- (NSArray *)safeSubarrayWithRange:(NSRange)range {
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location + length > self.count) {
        //超过了边界,就获取从loction开始所有的item
        if ((location + length) > self.count) {
            length = (self.count - location);
            return [self safeSubarrayWithRange:NSMakeRange(location, length)];
        }
        
        return nil;
    } else {
        return [self subarrayWithRange:range];
    }
}

- (id)objectAtIndex:(NSInteger)index valueClass:(Class)valueClass {
    if (self.count == 0) {
        return nil;
    }
    
    if (index < 0) {
        return nil;
    }
    
    if (valueClass == NULL) {
        return nil;
    }
    
    if (index < self.count) {
        id value = [self objectAtIndex:index];
        
        if (!value) {
            return nil;
        }
        
        if (valueClass == [NSArray class] && [value isKindOfClass:[NSArray class]]) {
            return [NSArray arrayWithArray:value];
        }
        
        if (![value isKindOfClass:valueClass]) {
            return nil;
        }
        
        return value;
        
    }
    
    return nil;
}

@end
