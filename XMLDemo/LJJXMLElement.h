//
//  LJJXMLElement.h
//  XMLDemo
//
//  Created by Jun on 13-12-13.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJJXMLElement : NSObject <NSCoding>
//标签名
@property (copy, nonatomic)                     NSString        * name;
//标签值 若该标签为节点标签值为空
@property (copy, nonatomic)                     NSString        * value;
//标书点
@property (assign, nonatomic)                   NSInteger       index;

//是否是节点
@property (assign, nonatomic, getter = isNode)  BOOL            node;
//父节点
@property (weak, nonatomic)                     LJJXMLElement   * parent;

//所有子标签
@property (strong, readonly, nonatomic)         NSArray         * elements;
/**
 *  获取指定子元素集
 *
 *  @param name 元素名
 *
 *  @return 方法子元素集
 */
- (NSArray *)subElementWithName:(NSString *)name;
//子元素名
@property (strong, readonly, nonatomic)         NSSet           * subElementNames;

/**
 *  添加一个元素
 *
 *  @param element 元素
 */
- (void)addElement:(LJJXMLElement *)element;

/**
 *  转换成json
 */
- (NSString *)json;
/**
 *  解析成数据类型
 *
 *  @param flag YES返回值 NO返回字典
 *
 *  @return 返回数据
 */
- (id/* NSDictionary* */)objectIsValue:(BOOL)flag;
@end
