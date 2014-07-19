//
//  main.m
//  week2
//
//  Created by sunsidew on 2014. 7. 17..
//  Copyright (c) 2014년 sunsidew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "jsonManager.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
//        NSError *jsonError;
        
//        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//        
//
//        NSString *jsonString = @"{ \"id\" : 007, \"name\" : \"james\", \"weapons\" : [ gun, pen ] }";
        NSString *jsonString = @"[{\"key1\":\"obj1\",\"key3\":\"obj3\",\"key2\":\"obj2\"},{\"obj2\":\"key2\",\"obj1\":\"key1\",\"obj3\":\"key3\"}]";
        
        NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", @"key3", nil];
        NSArray *objs = [NSArray arrayWithObjects:@"obj1", @"obj2", @"obj3", nil];
        
        NSArray *_objs = [NSArray arrayWithObjects:objs, @"obj2", @"obj3", nil];
        NSDictionary *_dic = [NSDictionary dictionaryWithObjects:_objs forKeys:keys];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        NSDictionary *dict2 = [NSDictionary dictionaryWithObjects:keys forKeys:objs];
        NSArray *_arr = [NSArray arrayWithObjects:dict, dict2, nil];
        
        jsonManager* MYjm = [[jsonManager alloc] init];

        jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
        //공백 제거
        [MYjm MYJSONSerializationFrom:jsonString];
        
        NSLog(@"%@",[MYjm MYJSONMakerWithArray:_arr]);
        NSLog(@"%@",[MYjm MYJSONMakerWithDictionary:_dic]);
        
    }
    return 0;
}

