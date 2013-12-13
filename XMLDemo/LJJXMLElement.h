//
//  LJJXMLElement.h
//  XMLDemo
//
//  Created by Jun on 13-12-13.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJJXMLElement : NSObject
//标签名
@property (copy, nonatomic)         NSString * name;
//标签值 若该标签为节点标签值为空
@property (copy, nonatomic)         NSString * value;

@property (assign, nonatomic)       NSInteger index;

//是否是节点
@property (assign, nonatomic, getter = isNode)       BOOL node;

@property (assign, nonatomic)       LJJXMLElement * parent;

//子标签
@property (readonly, nonatomic)     NSArray * elements;

/**
 *  添加一个元素
 *
 *  @param element 元素
 */
- (void)addElement:(LJJXMLElement *)element;
@end
