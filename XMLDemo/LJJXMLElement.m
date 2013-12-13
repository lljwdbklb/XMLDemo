//
//  LJJXMLElement.m
//  XMLDemo
//
//  Created by Jun on 13-12-13.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import "LJJXMLElement.h"

//#import "NSArray+Log.h"

@interface LJJXMLElement()
{
    NSMutableArray * _elements;
}

@end

@implementation LJJXMLElement



- (NSArray *)elements {
    return _elements;
}

- (void)addElement:(LJJXMLElement *)element {
    if (_elements == nil) {
        _elements = [NSMutableArray array];
    }
    [_elements addObject:element];
}

- (NSArray *)subElementWithName:(NSString *)name {
    NSMutableArray * arrayM = [NSMutableArray array];
    
    [_elements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LJJXMLElement * element = obj;
        if ([element.name isEqualToString:name]) {
            [arrayM addObject:element];
        }
    }];
    
    return arrayM;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<LJJXMLElement: %p, name: %@, value: %@, index: %d, node: %@, parent: %@, elements: %p>",self,_name,_value,_index,_node?@"YES":@"NO",_parent,_elements];
}

@end
