//
//  JEncoder.h
//  JUIImage
//
//  Created by Joe on 13-9-5.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCoderConfig.h"
@interface JEncoder : NSObject

/**
 Encode object to dictionary witch can be archived.
 @param object origin object.
 @param error record some error while encoding.
 @return structured dictionary.
 */
+ (NSDictionary *)encodeObject:(NSObject *)object error:(NSError**)error;

/**
 Encode object to dictionary witch can be archived.
 @param object origin object.
 @param configHandler handle the config.
 @return structured dictionary.
 */
+ (NSDictionary *)encodeObject:(NSObject *)object error:(NSError**)error configHandler:(NSDictionary *(^)(id value))configHandler;

/**
 Directly encode an object and save as a file.
 @param path path for saving.
 @param error record some error while encoding
 @return null.
 */
+ (void)encodeObject:(NSObject *)object toFile:(NSString *)path error:(NSError **)error;

@end
