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
 
    NSMutableString* sample = (NSMutableString* ) jsonString;
    NSLog(@"s:%@",[jsonString substringToIndex:1]);
    
    NSLog(@"t:%@",sample);
    NSLog(@"t:%d",[sample length]);
    
    NSString* selector = [jsonString substringToIndex:1]; // array, dictionary 구분
    sample = [sample substringWithRange:NSMakeRange(1, [sample length]-2)]; // trim
    
    NSLog(@"%@",sample);
    
    NSObject* result = [[NSObject alloc] init];
    NSLog(@"class:%@",result.class);

    if ([selector isEqualToString: @("{")]) {
        NSLog(@"It's Dictionary");
    } else if ([selector isEqualToString: @("[")]) {
        NSLog(@"It's Array");
        
        int level = 0;
        int f_idx = 0;
        
        for ( int idx = 0 ; idx < sample.length ; idx++) {
            if ([sample characterAtIndex:idx] == '{' || [sample characterAtIndex:idx] == '[') {
                level++;
            } else if ([sample characterAtIndex:idx] == '}' || [sample characterAtIndex:idx] == ']') {
                level--;
            } else if ([sample characterAtIndex:idx] == ',' && level == 0) {
                NSLog(@"%@\n",[sample substringWithRange:NSMakeRange(f_idx,idx)]);
                f_idx = idx;
            }
        }
        
        NSLog(@"%@\n",[sample substringFromIndex:f_idx]);
        
//        char nowstring[[sample length]+1];
//        NSUInteger len = [sample length];
//        
//        char c_buffer[len+1];
//        [sample getCharacters:c_buffer range:NSMakeRange(0, len)];
//        
//        NSLog(@"getCharacters:range: with char buffer");
//        for(int i = 0; i < len; i++) {
//            NSLog(@"Byte %d: %c", i, c_buffer[i]);
//        }
//
//        
//        [sample getCharacters:nowstring range:NSMakeRange(0, [sample length])];
//        
//        for (int i = 0 ; i < len ; i++) {
//            NSLog(@"%d : ",i);
//            NSLog(@"%c\n",nowstring[i]);
//            if ([selchar isEqualToString: @("{")] || [selchar isEqualToString: @("[")]) {
//                
//            } else if ([selchar isEqualToString: @("}")] || [selchar isEqualToString: @("]")]) {
//                
//            } else if (sample[i] == ",") {
//                
//            }
//        }
        
        
//        NSArray* _result = [sample componentsSeparatedByString:@","];
//        for (int i = 0 ; i < [_result count] ; i++) {
////            jsonString substringToIndex:1])
//            NSLog(@"%@\n",_result[i]);
//        }
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
