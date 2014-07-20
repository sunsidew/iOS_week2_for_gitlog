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
        // ------ pdf 자료 첨부 샘플 테스트 ------
        
        NSString* sample_1 = @"{ \"id\" : 007, \"name\" : \"james\", \"weapons\" : [ gun, pen ] }";
        NSString* sample_2 = @"[ { \"id\": \"001\", \"name\" : \"john\" }, { \"id\": \"007\", \"name\" : \"james\" } ]";
        
        jsonManager* MYjm = [[jsonManager alloc] init];

//        아래 코드를 사용할 경우 컨텐츠 내부의 공백(ex: " james ")도 모두 제거되는 문제가 있으므로 각 element마다 공백을 trim 하는 방식으로 변경
        
//        sample_1 = [sample_1 stringByReplacingOccurrencesOfString:@" " withString:@""];
//        sample_2 = [sample_2 stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSObject* parsed;
        parsed = [MYjm MYJSONSerializationFrom:sample_1];
        NSLog(@"sample_1: %@",[MYjm MYJSONMakerWithDictionary:[MYjm MYJSONSerializationFrom:sample_1]]);
        
        parsed = [MYjm MYJSONSerializationFrom:sample_2];
        NSLog(@"sample_2: %@",[MYjm MYJSONMakerWithArray:[MYjm MYJSONSerializationFrom:sample_2]]);
        
        
        // ------ 추가 샘플 테스트 ------
        
        NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", @"key3", nil];
        NSArray *objs = [NSArray arrayWithObjects:@"obj1", [NSNumber numberWithInt:2222], @"obj3", nil];
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjects:keys forKeys:objs];
        NSDictionary* dic2 = [NSDictionary dictionaryWithObjects:keys forKeys:objs];
        
        NSArray *arr_arr = [NSArray arrayWithObjects:objs, @"obj2", @"obj3", nil];
        NSDictionary* dic_arr = [NSDictionary dictionaryWithObjects:arr_arr forKeys:keys];
        NSArray *arr_dic = [NSArray arrayWithObjects:dic2, @"middle", dic, nil];
        NSDictionary* dic_dic = [NSDictionary dictionaryWithObjects:arr_dic forKeys:keys];
        
        // #2 test
        
        NSLog(@"array in array : %@",[MYjm MYJSONMakerWithArray:arr_arr]);
        NSLog(@"array in dict : %@",[MYjm MYJSONMakerWithArray:arr_dic]);
        
        NSLog(@"dict in array : %@",[MYjm MYJSONMakerWithDictionary:dic_arr]);
        NSLog(@"dict in dict : %@",[MYjm MYJSONMakerWithDictionary:dic_dic]);
        
        // #1 test
        
        NSLog(@"a.i.a : %@",[MYjm MYJSONMakerWithArray:[MYjm MYJSONSerializationFrom:[MYjm MYJSONMakerWithArray:arr_arr]]]);
        NSLog(@"a.i.d : %@",[MYjm MYJSONMakerWithArray:[MYjm MYJSONSerializationFrom:[MYjm MYJSONMakerWithArray:arr_dic]]]);
        NSLog(@"d.i.a : %@",[MYjm MYJSONMakerWithDictionary:[MYjm MYJSONSerializationFrom:[MYjm MYJSONMakerWithDictionary:dic_arr]]]);
        NSLog(@"d.i.d : %@",[MYjm MYJSONMakerWithDictionary:[MYjm MYJSONSerializationFrom:[MYjm MYJSONMakerWithDictionary:dic_dic]]]);
    }
    return 0;
}

