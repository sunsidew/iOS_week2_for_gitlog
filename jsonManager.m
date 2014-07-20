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
    
    if ([selector isEqualToString: @("{")] || [selector isEqualToString: @("[")]) {
        NSMutableDictionary * divdict = [[NSMutableDictionary alloc] init];
        NSMutableArray * divarray = [[NSMutableArray alloc] init];
        
        int level = 0;
        int f_idx = 0;

        NSObject* key = [[NSObject alloc] init];
        NSObject* value = [[NSObject alloc] init];
        NSObject* object = [[NSObject alloc] init];
        NSString* element = [[NSString alloc] init];
        
        for ( int idx = 0 ; idx < sample.length ; idx++) {
            if ([sample characterAtIndex:idx] == '{' || [sample characterAtIndex:idx] == '[') {
                level++;
            } else if ([sample characterAtIndex:idx] == '}' || [sample characterAtIndex:idx] == ']') {
                level--;
            } else if ([sample characterAtIndex:idx] == ',' && level == 0) {
                if ([selector isEqualToString: @("{")]) {
                    
                    element = [sample substringWithRange:NSMakeRange(f_idx,idx-f_idx)];
                                
                    key = [self MYJSONSerializationFrom:[element substringWithRange:NSMakeRange(0,[element rangeOfString: @":"].location)]];
                    value = [self MYJSONSerializationFrom:[element substringFromIndex:[element rangeOfString: @":"].location+1]];
                
                    [divdict setObject:value forKey:key];
                } else {
                    object = [self MYJSONSerializationFrom:[sample substringWithRange:NSMakeRange(f_idx,idx-f_idx)]];
                    
                    [divarray addObject:object];
                }

                f_idx = idx+1;
            }
        }
        
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
