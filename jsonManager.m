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
    NSMutableString* sample = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // 공백제거
    NSString* selector = [sample substringToIndex:1]; // array, dictionary 구분

    if ([selector isEqualToString: @("{")] || [selector isEqualToString: @("[")]) {
        sample = [sample substringWithRange:NSMakeRange(1, sample.length-2)]; // trim;
        
        char idxchar;
        int level = 0;
        int f_idx = 0;
        NSString* element = [[NSString alloc] init];
        
        NSMutableDictionary * divdict = [[NSMutableDictionary alloc] init];
        NSObject* key = [[NSObject alloc] init];
        NSObject* value = [[NSObject alloc] init];

        NSMutableArray * divarray = [[NSMutableArray alloc] init];
        NSObject* object = [[NSObject alloc] init];
        
        for ( int idx = 0 ; idx < sample.length ; idx++) {
            idxchar = [sample characterAtIndex:idx];
            if (idxchar == '{' || idxchar == '[') {
                level++;
            } else if (idxchar == '}' || idxchar == ']') {
                level--;
            } else if (idxchar == ',' && level == 0) {
                element = [sample substringWithRange:NSMakeRange(f_idx,idx-f_idx)];

                if ([selector isEqualToString: @("{")]) {
                    key = [self MYJSONSerializationFrom:[element substringWithRange:NSMakeRange(0,[element rangeOfString: @":"].location)]];
                    value = [self MYJSONSerializationFrom:[element substringFromIndex:[element rangeOfString: @":"].location+1]];
                    [divdict setObject:value forKey:key];
                } else {
                    object = [self MYJSONSerializationFrom:element];
                    
                    [divarray addObject:object];
                }

                f_idx = idx+1;
            }
        }
        
        // 마지막 element 삽입 작업
        
        element = [sample substringFromIndex:f_idx];
        
        if ([selector isEqualToString: @("{")]) {
        
            key = [self MYJSONSerializationFrom:[element substringWithRange:NSMakeRange(0,[element rangeOfString: @":"].location)]];
            value = [self MYJSONSerializationFrom:[element substringFromIndex:[element rangeOfString: @":"].location+1]];

            [divdict setObject:value forKey:key];
        
            return divdict;
        } else {
            object = [self MYJSONSerializationFrom:element];
            [divarray addObject:object];
        
            return divarray;
        }
        
    } else {
        return [sample stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    }
}

- (NSString*) MYJSONMakerWithArray:(NSArray*)array {
    NSMutableString* result = [[NSMutableString alloc] init];
    NSObject *object = [[NSObject alloc] init];
    
    [result appendString: @"["];
    for (int i = 0 ; i < [array count] ; i++) {
        object = array[i];
        
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
    NSObject *object = [[NSObject alloc] init];
    
    [result appendString: @"{"];
    for (id key in dictionary) {
        object = [dictionary objectForKey:key];
        
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
