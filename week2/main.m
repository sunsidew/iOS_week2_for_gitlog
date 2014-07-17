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
//        NSString *jsonString = @"{ \"id\" : 007, \"name\" : \"james\", \"weapons\" : [ gun, pen ] }";
//        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                        @"valueOne", @"keyOne", @"valueTwo", @"keyTwo", nil];
//        
        NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", @"key3", nil];
        NSArray *objs = [NSArray arrayWithObjects:@"obj1", @"obj2", @"obj3", nil];
        
        NSArray *_objs = [NSArray arrayWithObjects:objs, @"obj2", @"obj3", nil];
        NSDictionary *_dic = [NSDictionary dictionaryWithObjects:_objs forKeys:keys];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        NSDictionary *dict2 = [NSDictionary dictionaryWithObjects:keys forKeys:objs];
        NSArray *_arr = [NSArray arrayWithObjects:dict, dict2, nil];
        
        jsonManager* MYjm = [[jsonManager alloc] init];
        NSLog(@"%@",[MYjm MYJSONMakerWithArray:_arr]);
        NSLog(@"%@",[MYjm MYJSONMakerWithDictionary:_dic]);
        
    }
    return 0;
}

