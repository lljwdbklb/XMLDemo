//
//  LJJXMLTool.h
//  XMLDemo
//
//  Created by Jun on 13-12-13.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJJXMLTool;
@class LJJXMLElement;
@protocol LJJXMLToolDelegate <NSObject>

- (void)parseDidStartInTool:(LJJXMLTool *)tool;

- (void)tool:(LJJXMLTool *)tool didEndParsedAt:(LJJXMLElement *)element;

@end


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


@property (weak, nonatomic) id<LJJXMLToolDelegate> delegate;
/**
 *  构造方法
 *  自动调用parse
 *
 *  @param url      解析地址URL
 *  @param delegate 代理
 *
 *  @return 当前对象
 */
- (id)initWithURL:(NSURL *)url delegate:(id<LJJXMLToolDelegate>)delegate;

- (BOOL)parse;

@end
