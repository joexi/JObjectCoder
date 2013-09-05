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

+ (NSDictionary *)encodeObject:(NSObject *)object error:(NSError**)error;

@end
