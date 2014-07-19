//
//  jsonManager.m
//  week2
//
//  Created by sunsidew on 2014. 7. 17..
//  Copyright (c) 2014년 sunsidew. All rights reserved.
//

#import "jsonManager.h"

@implementation jsonManager

- (id)init
{
    self = [super init];
    if (self) {
        // init
    }
    return self;
    //    return [super init];
}

- (NSObject*) MYJSONSerializationFrom:(NSString *)jsonString {

    NSMutableString* sample = [jsonString substringWithRange:NSMakeRange(1, jsonString.length-2)]; // trim;
    NSString* selector = [jsonString substringToIndex:1]; // array, dictionary 구분
    
    if ([selector isEqualToString: @("{")]) {
        NSMutableDictionary * divdict = [[NSMutableDictionary alloc] init];
        
        int level = 0;
        int f_idx = 0;
        NSString* keyandobj = [[NSString alloc] init];
        NSObject* dickey = [[NSObject alloc] init];
        NSObject* dicvalue = [[NSObject alloc] init];
        
        for ( int idx = 0 ; idx < sample.length ; idx++) {
            if ([sample characterAtIndex:idx] == '{' || [sample characterAtIndex:idx] == '[') {
                level++;
            } else if ([sample characterAtIndex:idx] == '}' || [sample characterAtIndex:idx] == ']') {
                level--;
            } else if ([sample characterAtIndex:idx] == ',' && level == 0) {
                keyandobj = [sample substringWithRange:NSMakeRange(f_idx,idx-f_idx)];
                                
                dickey = [self MYJSONSerializationFrom:[keyandobj substringWithRange:NSMakeRange(0,[keyandobj rangeOfString: @":"].location)]];
                dicvalue = [self MYJSONSerializationFrom:[keyandobj substringFromIndex:[keyandobj rangeOfString: @":"].location+1]];
                
                [divdict setObject:dicvalue forKey:dickey];

                f_idx = idx+1;
            }
        }
        
        
        keyandobj = [sample substringFromIndex:f_idx];
        
        dickey = [self MYJSONSerializationFrom:[keyandobj substringWithRange:NSMakeRange(0,[keyandobj rangeOfString: @":"].location)]];
        dicvalue = [self MYJSONSerializationFrom:[keyandobj substringFromIndex:[keyandobj rangeOfString: @":"].location+1]];

        [divdict setObject:dicvalue forKey:dickey];
        
        return divdict;


    } else if ([selector isEqualToString: @("[")]) {
        NSMutableArray * divarray = [[NSMutableArray alloc] init];
        NSObject* object = [[NSObject alloc] init];

        int level = 0;
        int f_idx = 0;
        for ( int idx = 0 ; idx < sample.length ; idx++) {
            if ([sample characterAtIndex:idx] == '{' || [sample characterAtIndex:idx] == '[') {
                level++;
            } else if ([sample characterAtIndex:idx] == '}' || [sample characterAtIndex:idx] == ']') {
                level--;
            } else if ([sample characterAtIndex:idx] == ',' && level == 0) {
//                if ([object isKindOfClass:NSArray.class]) {
//                    object = [NSString stringWithFormat:@"\"%@\"",object];
//                }
                
                object = [self MYJSONSerializationFrom:[sample substringWithRange:NSMakeRange(f_idx,idx-f_idx)]];

                [divarray addObject:object];
                f_idx = idx+1;
            }
        }
        
        object = [self MYJSONSerializationFrom:[sample substringFromIndex:f_idx]];
        [divarray addObject:object];
        
        return divarray;
    } else {
        return [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    }
}

- (NSString*) MYJSONMakerWithArray:(NSArray*)array {
    NSMutableString* result = [[NSMutableString alloc] init];
    
    [result appendString: @"["];
    for (int i = 0 ; i < [array count] ; i++) {
        NSObject* object = array[i];
        
        if ([object isKindOfClass:NSArray.class]) {
            object = [self MYJSONMakerWithArray:(NSArray*) object];
        }
        else if ([object isKindOfClass:NSDictionary.class]) {
            object = [self MYJSONMakerWithDictionary:(NSDictionary*) object];
        }
        else {
            object = [NSString stringWithFormat:@"\"%@\"",object];
        }

        [result appendString: [NSString stringWithFormat:@"%@,",object]];
    }
    
    [result deleteCharactersInRange:NSMakeRange([result length]-1, 1)];
    [result appendString: @"]"];
    
    return (NSString *)result;
}

- (NSString*) MYJSONMakerWithDictionary:(NSDictionary*)dictionary {
    NSMutableString *result = [[NSMutableString alloc] init];
    //NSObject *object = [[NSObject alloc] init];
    
    [result appendString: @"{"];
    for (id key in dictionary) {
        NSObject* object = [dictionary objectForKey:key];
        
        if ([object isKindOfClass:NSArray.class]) {
            object = [self MYJSONMakerWithArray:(NSArray*) object];
        }
        else if ([object isKindOfClass:NSDictionary.class]) {
            object = [self MYJSONMakerWithDictionary:(NSDictionary*) object];
        }
        else {
            object = [NSString stringWithFormat:@"\"%@\"",object];
        }

        [result appendString: [NSString stringWithFormat:@"\"%@\":%@,", key, object]];
    }
    
    [result deleteCharactersInRange:NSMakeRange([result length]-1, 1)];
    [result appendString: @"}"];
    
    return (NSString *)result;
}


@end
