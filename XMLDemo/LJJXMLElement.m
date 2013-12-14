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

- (NSSet *)subElementNames {
    NSMutableSet * names = [NSMutableSet set];
    
    [_elements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LJJXMLElement * element = obj;
        [names addObject:element.name];
    }];
    
    return names;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<LJJXMLElement: %p, name: %@, value: %@, index: %d, node: %@, parent: %@, elements: %@>",self,_name,_value,_index,_node?@"YES":@"NO",_parent,_elements];
}

- (NSString *)json {
    NSMutableString * json = [NSMutableString string];
    
    //用于格式排列
    NSMutableString * lever = [NSMutableString string];
    for (NSInteger i = 0; i < self.index + 1; i ++) {
        [lever appendString:@"\t"];
    }
    
    if (self.index == 0) {//为根节点
        [json appendString:@"{\n"];
        [json appendFormat:@"\"%@\":",self.name];
    }
    
    [json appendFormat:@"\n%@{\n",lever];
    
    //1.子元素集
    NSSet * names = self.subElementNames;
    [names enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [json appendFormat:@"%@\"%@\":",lever,obj];
        NSArray * elements = [self subElementWithName:obj];
        if (elements.count > 1) {//数组
            [json appendFormat:@"[\n"];
            [elements enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx, BOOL *stop) {
                [json appendFormat:@"%@,",[obj2 json]];
            }];
            //去掉最后一个逗号
            [json deleteCharactersInRange:NSMakeRange(json.length - 1, 1)];
            [json appendFormat:@"\n%@]",lever];
        } else {//非数组
            LJJXMLElement * element = elements[0];
            if (element.node) {//是节点
                [json appendFormat:@"\"%@\"",[element json]];
            } else {//不是节点
                [json appendFormat:@"\"%@\"",element.value];
            }
        }
        [json appendFormat:@",\n"];
    }];
    //去掉最后一个逗号
    [json deleteCharactersInRange:NSMakeRange(json.length - 2, 2)];
    
    [json appendFormat:@"\n%@}",lever];
    
    if (self.index == 0) {
        [json appendString:@"\n}\n"];
    }
    return json;
}

@end
