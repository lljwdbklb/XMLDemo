//
//  LJJViewController.m
//  XMLDemo
//
//  Created by Jun on 13-12-11.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import "LJJViewController.h"

#import "LJJXMLElement.h"
//#import "NSString+Helper.h"

#import "LJJXMLTool.h"


@interface LJJViewController ()<NSXMLParserDelegate,LJJXMLToolDelegate>
{
//    NSXMLParser * _parser;
//    
//    BOOL _isParser;
//    //当前元素
//    LJJXMLElement * _currentElement;
//    //当前节点元素
//    LJJXMLElement * _currentNodeElement;
//    //根元素
//    LJJXMLElement * _rootElement;
//    //下标
//    NSInteger _index;
    
    LJJXMLTool * _tool;
    
}

@end

@implementation LJJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    _parser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://www.w3school.com.cn/example/xmle/simple.xml"]];
//    [_parser setDelegate:self];
//    
//    [_parser parse];
    
    
    _tool = [[LJJXMLTool alloc]initWithURL:[NSURL URLWithString:@"http://www.w3school.com.cn/example/xmle/cd_catalog.xml"] delegate:self];
    
}

- (void)parseDidStartInTool:(LJJXMLTool *)tool {
    NSLog(@"开始解析");
}

- (void)tool:(LJJXMLTool *)tool didEndParsedAt:(LJJXMLElement *)element {
    NSLog(@"结束解析");
//    NSLog(@"%@",element); // 这句运行有错误
    NSLog(@"%@",[element json]);
    
    [[element json] writeToFile:@"/Users/jun/Desktop/123.json" atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

//#pragma mark 开始解析
//- (void)parserDidStartDocument:(NSXMLParser *)parser {
//    NSLog(@"开始解析");
//}
//
//#pragma mart 正在开始解析
//- (void)parser:(NSXMLParser *)parser
//didStartElement:(NSString *)elementName
//  namespaceURI:(NSString *)namespaceURI
// qualifiedName:(NSString *)qName
//    attributes:(NSDictionary *)attributeDict
//{
//    if (_isParser) {
//        //添加到上个节点
//        //        [_currentNodeElement addElement:_currentElement];
//        
//        //设置为当前节点
//        _currentNodeElement = _currentElement;
//        //设置为节点元素
//        _currentNodeElement.node = YES;
//    }
//    
//    LJJXMLElement * element = [[LJJXMLElement alloc]init];
//    element.name = elementName;
//    element.index = _index ++;
//    element.parent = _currentNodeElement;
//    
//    _currentElement = element;
//    [_currentNodeElement addElement:element];
//    
//    if (_rootElement == nil) { //第一个节点元素
//        _rootElement = element;
//        //设置为节点元素
//        _rootElement.node = YES;
//        //设置当前根节点
//        _currentNodeElement = _rootElement;
//    }
//    
//    
//    _isParser = YES;
//    NSLog(@"开始解析3----------");
////    NSLog(@"shouldReportNamespacePrefixes --- %d",[parser shouldReportNamespacePrefixes]);
//    NSLog(@"elementName -- %@",elementName);
//    NSLog(@"-----------------\n");
//}
//
//#pragma mark 解析数据
//- (void)parser:(NSXMLParser *)parser
//foundCharacters:(NSString *)string {
//    if (!_isParser) {
//        return;
//    }
//    //值为空退出此次解析
//    if (string == nil || [[string trimString] isEqualToString:@""]) {
//        return;
//    }
//    
//    _currentElement.value = string;
//    
//    NSLog(@"foundCharacters解析6----------");
////    NSLog(@"shouldReportNamespacePrefixes --- %d",[parser shouldReportNamespacePrefixes]);
//    NSLog(@"%d -- %d",[parser lineNumber],[parser columnNumber]);
//    NSLog(@"string -- %@",string);
//    NSLog(@"-----------------\n");
//}
//
//#pragma mart 正在结束解析
//- (void)parser:(NSXMLParser *)parser
// didEndElement:(NSString *)elementName
//  namespaceURI:(NSString *)namespaceURI
// qualifiedName:(NSString *)qName
//{
//    _isParser = NO;
//    _index --;
//    
//    //解析结束
//    if ([_rootElement.name isEqualToString:elementName]) {//如果是根
//        return;
//    } else if ([_currentNodeElement.name isEqualToString:elementName]) {
//        _currentNodeElement = _currentNodeElement.parent;
//    } else {
////        [_currentNodeElement addElement:_currentElement];
//        _currentNodeElement = _currentElement.parent;
//    }
//    
//    NSLog(@"结束解析4----------");
////    NSLog(@"shouldReportNamespacePrefixes --- %d",[parser shouldReportNamespacePrefixes]);
//    NSLog(@"elementName -- %@",elementName);
//    NSLog(@"-----------------\n\n");
//}
//
//- (void)parserDidEndDocument:(NSXMLParser *)parser {
//    NSLog(@"结束解析");
//    [parser abortParsing];
//}


@end
