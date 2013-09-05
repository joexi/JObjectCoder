//
//  JDecoder.m
//  JUIImage
//
//  Created by Joe on 13-9-5.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "JDecoder.h"

@implementation JDecoder

+ (NSObject *)decodeDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    NSObject *obj = [self objectWithDic:dictionary error:error];
    if (error) {
        return nil;
    }
    return obj;
}

#pragma mark - private method
+ (NSObject *)objectWithDic:(NSDictionary *)dic error:(NSError **)error
{
    Class cls = NSClassFromString([dic valueForKey:Class_Key]);
    NSObject *obj = [[cls alloc] init];
    for (NSString *key in [dic allKeys]) {
        if ([key isEqualToString:Class_Key]) {
            continue;
        }
        NSObject *value = [dic valueForKey:key];
        if ([value isKindOfClass:NSDictionary.class]) {
            [obj setValue:[self objectWithDic:(NSDictionary *)value error:error] forKey:key];
        }
        else
        {
            [obj setValue:value forKey:key];
        }
    }
    return obj;
}
@end
