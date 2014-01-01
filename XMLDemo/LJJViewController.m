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
    
//    LJJXMLTool * _tool;
    
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
    
    
//    _tool = [[LJJXMLTool alloc]initWithURL:[NSURL URLWithString:@"http://www.w3school.com.cn/example/xmle/cd_catalog.xml"] delegate:self];
    //http://api.caipiao.163.com/period.html?product=caipiao_client&mobileType=iphone&ver=3.20&channel=appstore&apiVer=1.1&apiLevel=1&deviceId=5477BCBD-7AD6-4278-AEDF-2B02C140132A&ifCurrent=1&totalStatusSupport=1&product=caipiao_client&mobileType=iphone&ver=3.20&channel=appstore&apiVer=1.1&apiLevel=1&deviceId=5477BCBD-7AD6-4278-AEDF-2B02C140132A
    //http://www.w3school.com.cn/example/xmle/cd_catalog.xml
    //http://www.w3school.com.cn/example/xmle/simple.xml
    NSURL * url = [NSURL URLWithString:@"http://api.caipiao.163.com/period.html?product=caipiao_client&mobileType=iphone&ver=3.20&channel=appstore&apiVer=1.1&apiLevel=1&deviceId=5477BCBD-7AD6-4278-AEDF-2B02C140132A&ifCurrent=1&totalStatusSupport=1&product=caipiao_client&mobileType=iphone&ver=3.20&channel=appstore&apiVer=1.1&apiLevel=1&deviceId=5477BCBD-7AD6-4278-AEDF-2B02C140132A"];
//    _tool = [[LJJXMLTool alloc]initWithURL:url delegate:self];
    
    
    [LJJXMLTool parseXMLWithURL:url success:^(LJJXMLElement *element) {
        NSLog(@"%@",[element json]);
    } failed:^(NSError *error) {
        NSLog(@"error --- %@",error.localizedDescription);
    }];
    
    
}

//- (void)parseDidStartInTool:(LJJXMLTool *)tool {
//    NSLog(@"开始解析");
//}
//
//- (void)tool:(LJJXMLTool *)tool didEndParsedAt:(LJJXMLElement *)element {
//    NSLog(@"结束解析");
//    NSLog(@"%@",[element json]);
//    [[element json] writeToFile:@"/Users/jun/Desktop/123.json" atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    [[element objectIsValue:NO] writeToFile:@"/Users/jun/Desktop/123.plist" atomically:YES];
//}


@end
