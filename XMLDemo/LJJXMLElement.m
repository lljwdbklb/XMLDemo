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
    NSMutableString * lever = [NSMutableString string];
    for (NSInteger i = 0; i < self.index + 1; i ++) {
        [lever appendString:@"\t"];
    }
    //错误原因：在此调用了父类对象，存在死循环而出现运行出错。
    return [NSString stringWithFormat:@"%@<LJJXMLElement: %p, name: %@, value: %@, index: %d, node: %@, parent: %p, elements: %@>",lever,self,_name,_value,_index,_node?@"YES":@"NO",_parent,_elements];
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
                LJJXMLElement * e = obj2;
//                [json appendFormat:@"%@,",[obj2 json]];
                if (e.node) {//是节点
                    [json appendFormat:@"%@",[e json]];
                    NSLog(@"%@",[e json]);
                } else {
                    [json appendFormat:@"%@\t\"%@\"",lever,e.value];
                }
                [json appendFormat:@",\n"];
            }];
            //去掉最后一个逗号
            [json deleteCharactersInRange:NSMakeRange(json.length - 2, 2)];
            [json appendFormat:@"\n%@]",lever];
        } else {//非数组
            LJJXMLElement * e = elements[0];
            if (e.node) {//是节点
                [json appendFormat:@"%@",[e json]];
//                NSLog(@"%@",[e json]);
            } else {//不是节点
                [json appendFormat:@"\"%@\"",e.value];
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

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.value = [aDecoder decodeObjectForKey:@"value"];
        _elements = [aDecoder decodeObjectForKey:@"elements"];
        _node = [aDecoder decodeBoolForKey:@"node"];
        for (LJJXMLElement * element in _elements) {
            element.parent = self;
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    if (self.value && self.value.length > 0) {
        [aCoder encodeObject:self.value forKey:@"value"];
    }
    if (self.elements && self.elements.count > 0) {
        [aCoder encodeObject:self.elements forKey:@"elements"];
    }
    [aCoder encodeBool:_node forKey:@"node"];
}


- (id)objectIsValue:(BOOL)flag {
    NSMutableDictionary * dictM = [NSMutableDictionary dictionary];
    
//    [dictM setObject:self.name forKey:@"name"];
    if (self.value.length > 0) {
//        if (flag) return self.value;
        [dictM setObject:self.value forKey:self.name];
    } else if (_elements.count > 0) {
//        NSMutableArray * subArrayM = [NSMutableArray array];
//        for (LJJXMLElement * element in _elements) {
//            [subArrayM addObject:[element objects]];
//        }
//        [dictM setObject:subArrayM forKey:@"elements"];
        NSArray * names = [[self subElementNames] allObjects];
        if (names.count > 1) {
            
            for (NSString * name in names) {
                NSArray * subElements = [self subElementWithName:name];
//                for (LJJXMLElement * element in subElements) {
////                    [subDictM setDictionary:[element objects]];
//                    [dictM setObject:[element objectIsValue:YES] forKey:element.name];
//                }
                
                for (LJJXMLElement * element in subElements) {
                    //                    [subDictM setDictionary:[element objects]];
                    NSDictionary * dict = [element objectIsValue:YES];
//                    [dictM setObject:dict[key] forKey:key];
                    if (dict.count == 1) {
                        NSString * key = [dict allKeys][0];
                        [dictM setObject:dict[key] forKey:key];
                    } else {
                        [dictM setObject:dict forKey:element.name];
                    }
                }
                
            }
//            [dictM setObject:subDictM forKey:self.name];
        } else if(names.count == 1) {
            NSMutableArray * subArrayM = [NSMutableArray array];
            NSArray * subElements = [self subElementWithName:names[0]];
            for (LJJXMLElement * element in subElements) {
                [subArrayM addObject:[element objectIsValue:YES]];
            }
            if (flag) return @{names[0]:subArrayM};
            [dictM setObject:@{names[0]:subArrayM} forKey:self.name];
        }
    }
    return dictM;
}
@end
