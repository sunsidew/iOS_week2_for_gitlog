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

- (id) MYJSONSerializationFrom:(NSString *)jsonString {
    id result;
//    NSArray * fileList = [self NXAllFilesInDir:path];
//    NSUInteger count = [fileList count];
//    
//    for(int i = 0 ; i < count ; i++) {
//        NSLog(@"%@", [fileList objectAtIndex:i]);
//    }
    return result;
}

- (NSString*) MYJSONMakerWithArray:(NSArray*)array {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString: @"["];
    for (int i = 0 ; i < [array count] ; i++) {
        NSObject* object = array[i];
        
        if ([object isKindOfClass:NSArray.class]) {
            object = [self MYJSONMakerWithArray:object];
        }
        else if ([object isKindOfClass:NSDictionary.class]) {
            object = [self MYJSONMakerWithDictionary:object];
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
            object = [self MYJSONMakerWithArray:object];
        }
        else if ([object isKindOfClass:NSDictionary.class]) {
            object = [self MYJSONMakerWithDictionary:object];
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
