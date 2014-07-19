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
    
    NSObject* result;
    
    if ([selector isEqualToString: @("{")]) {
        NSLog(@"It's Dictionary");
        NSMutableDictionary * divdict = [[NSMutableDictionary alloc] init];
        
        int level = 0;
        int f_idx = 0;
        NSString* keyandobj = [[NSString alloc] init];
        
        for ( int idx = 0 ; idx < sample.length ; idx++) {
            if ([sample characterAtIndex:idx] == '{' || [sample characterAtIndex:idx] == '[') {
                level++;
            } else if ([sample characterAtIndex:idx] == '}' || [sample characterAtIndex:idx] == ']') {
                level--;
            } else if ([sample characterAtIndex:idx] == ',' && level == 0) {
                keyandobj = [sample substringWithRange:NSMakeRange(f_idx,idx-f_idx)];
                NSLog(@"%d ~ %d",f_idx,idx);
                NSLog(@"Str : %@", keyandobj);
                NSLog(@"Key => %@",[keyandobj substringWithRange:NSMakeRange(0,[keyandobj rangeOfString: @":"].location)]);
                NSLog(@"Object => %@",[keyandobj substringFromIndex:[keyandobj rangeOfString: @":"].location+1]);
//                [dict setObject:@"Foo" forKey:@"Key_1"];
//                [divdict addObject:[sample substringWithRange:NSMakeRange(f_idx,idx)]];
                f_idx = idx+1;
            }
        }
        
        NSLog(@"%d ~ %d",f_idx,sample.length);
        keyandobj = [sample substringFromIndex:f_idx+1];
        NSLog(@"Key => %@",[keyandobj substringWithRange:NSMakeRange(0,[keyandobj rangeOfString: @":"].location)]);
        NSLog(@"Object => %@",[keyandobj substringFromIndex:[keyandobj rangeOfString: @":"].location+1]);
        
        NSLog(@"%@",sample);
//        for (int i = 0 ; i < [divdict count] ; i++) {
//            NSLog(@"=%@=\n",divdict[i]);
//        }

    } else if ([selector isEqualToString: @("[")]) {
        NSMutableArray * divarray = [[NSMutableArray alloc] init];
        
        int level = 0;
        int f_idx = 0;
        
        for ( int idx = 0 ; idx < sample.length ; idx++) {
            if ([sample characterAtIndex:idx] == '{' || [sample characterAtIndex:idx] == '[') {
                level++;
            } else if ([sample characterAtIndex:idx] == '}' || [sample characterAtIndex:idx] == ']') {
                level--;
            } else if ([sample characterAtIndex:idx] == ',' && level == 0) {
                [divarray addObject:[sample substringWithRange:NSMakeRange(f_idx,idx-f_idx)]];
                f_idx = idx+1;
            }
        }
        [divarray addObject:[sample substringFromIndex:f_idx+1]];
        
        for (int i = 0 ; i < [divarray count] ; i++) {
            NSLog(@"=%@=\n",divarray[i]);
        }
    }
    
    return result;
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
