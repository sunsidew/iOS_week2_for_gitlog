//
//  jsonManager.h
//  week2
//
//  Created by sunsidew on 2014. 7. 17..
//  Copyright (c) 2014년 sunsidew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jsonManager : NSObject

- (NSObject*) MYJSONSerializationFrom:(NSString *)jsonString;
- (NSString*) MYJSONMakerWithArray:(NSArray*)array;
- (NSString*) MYJSONMakerWithDictionary:(NSDictionary*)dictionary;

@end
