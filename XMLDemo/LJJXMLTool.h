//
//  LJJXMLTool.h
//  XMLDemo
//
//  Created by Jun on 13-12-13.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJJXMLElement;
@interface LJJXMLTool : NSObject
/**
 *  构造方法
 *
 *  @param url 解析地址URL
 *
 *  @return 当前对象
 */
- (id)initWithURL:(NSURL *)url;

//根元素
@property (readonly, nonatomic)LJJXMLElement * rootElement;


@end
