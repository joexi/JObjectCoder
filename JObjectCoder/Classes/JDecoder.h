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

+ (NSObject *)decodeDictionary:(NSDictionary *)dictionary error:(NSError **)error;

@end
