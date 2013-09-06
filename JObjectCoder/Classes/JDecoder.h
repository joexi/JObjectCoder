//
//  JDecoder.h
//  JUIImage
//
//  Created by Joe on 13-9-5.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCoderConfig.h"
@interface JDecoder : NSObject

/**
 Decode an Dictionary into object
 @param dictionary the dictionary after encoding an object.
 @param error record some error while decoding
 @return origin object before encoding.
 */
+ (NSObject *)decodeDictionary:(NSDictionary *)dictionary error:(NSError **)error;


/**
 Directly load object from local files
 @param path path of the file.
 @param error record some error while decoding
 @return origin object before encoding.
 */
+ (NSObject *)decodeWithContentsOfFile:(NSString *)path error:(NSError **)error;
@end
