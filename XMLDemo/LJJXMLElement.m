//
//  LJJXMLElement.m
//  XMLDemo
//
//  Created by Jun on 13-12-13.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import "LJJXMLElement.h"

@interface LJJXMLElement()
{
    NSMutableArray * _elements;
    
}

@end

@implementation LJJXMLElement
//@synthesize elements = _elements;

- (NSArray *)elements {
    if (_elements == nil) {
        _elements = [NSMutableArray array];
    }
    return _elements;
}

- (void)addElement:(LJJXMLElement *)element {
    [(NSMutableArray *)self.elements addObject:element];
}

@end
