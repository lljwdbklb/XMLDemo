//
//  LJJXMLTool.m
//  XMLDemo
//
//  Created by Jun on 13-12-13.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import "LJJXMLTool.h"

#import "LJJXMLElement.h"

#import "NSString+Helper.h"

@interface LJJXMLTool()<NSXMLParserDelegate>
{
    NSXMLParser * _parser;
    
    BOOL _isParser;
    //当前元素
    LJJXMLElement * _currentElement;
    //当前节点元素
    LJJXMLElement * _currentNodeElement;
    //根元素
    LJJXMLElement * _rootElement;
    //下标
    NSInteger _index;
}
@end

@implementation LJJXMLTool

- (id)initWithData:(NSData *)data {
    if (self = [super init]) {
        _parser = [[NSXMLParser alloc]initWithData:data];
        [_parser setDelegate:self];
    }
    return self;
}

- (id)initWithData:(NSData *)data delegate:(id<LJJXMLToolDelegate>)delegate {
    if (self = [self initWithData:data]) {
        self.delegate = delegate;
        [self parse];
    }
    return self;
}

- (id)initWithURL:(NSURL *)url {
     NSAssert(url != nil, @"URL 不能为空！");
    if (self = [super init]) {
        _parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
        [_parser setDelegate:self];
    }
    return self;
}

- (id)initWithURL:(NSURL *)url delegate:(id<LJJXMLToolDelegate>)delegate{
    if (self = [self initWithURL:url]) {
        self.delegate = delegate;
        if (![self parse]) {
            NSLog(@"%@",_parser.parserError.localizedDescription);
        }
    }
    return self;
}

- (BOOL)parse {
    return [_parser parse];
}

#pragma mark xmlParser 代理
#pragma mark 开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    if ([self.delegate respondsToSelector:@selector(parseDidStartInTool:)]) {
        [self.delegate parseDidStartInTool:self];
    }
}

#pragma mart 正在开始解析
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if (_isParser) {
        
        //设置为当前节点
        _currentNodeElement = _currentElement;
        //设置为节点元素
        _currentNodeElement.node = YES;
    }
    
    LJJXMLElement * element = [[LJJXMLElement alloc]init];
    element.name = elementName;
    element.index = _index ++;
    element.parent = _currentNodeElement;
    
    _currentElement = element;
    [_currentNodeElement addElement:element];
    
    if (_rootElement == nil) { //第一个节点元素
        _rootElement = element;
        //设置为节点元素
        _rootElement.node = YES;
        //设置当前根节点
        _currentNodeElement = _rootElement;
    }
    _isParser = YES;
}

#pragma mark 解析数据
- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    if (!_isParser) {
        return;
    }
    //值为空退出此次解析
    if (string == nil || [[string trimString] isEqualToString:@""]) {
        return;
    }
    
    _currentElement.value = string;
}

#pragma mart 正在结束当前解析
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    _isParser = NO;
    _index --;
    
    //解析结束
    if ([_rootElement.name isEqualToString:elementName]) {//如果是根
        return;
    } else if ([_currentNodeElement.name isEqualToString:elementName]) {
        _currentNodeElement = _currentNodeElement.parent;
    } else {
        //        [_currentNodeElement addElement:_currentElement];
        _currentNodeElement = _currentElement.parent;
    }
}
#pragma mark 结束解析
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if ([self.delegate respondsToSelector:@selector(tool:didEndParsedAt:)] ) {
        [self.delegate tool:self didEndParsedAt:_rootElement];
    }
    
//    NSLog(@"%@",_rootElement);
}
#pragma mark 解析失败
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"error --- %@",parseError.localizedDescription);
}
#pragma mark 确认错误发生
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    NSLog(@"error --- %@",validationError.localizedDescription);
}
@end
