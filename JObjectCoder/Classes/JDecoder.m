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

+ (NSObject *)decodeWithContentsOfFile:(NSString *)path error:(NSError **)error;
{
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return [self decodeDictionary:dic error:error];
}

#pragma mark - private method
+ (NSArray *)arrayWithArray:(NSArray *)ary error:(NSError **)error
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSObject *value in ary) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            [array addObject:[self objectWithDic:(NSDictionary *)value error:error]];
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            [array addObject:[self arrayWithArray:(NSArray *)value error:error]];
        }
        else
        {
            [array addObject:value];
        }
    }
    return array;
}

+ (NSObject *)objectWithDic:(NSDictionary *)dic error:(NSError **)error
{
    Class cls = NSClassFromString([dic valueForKey:Class_Key]);
    NSObject *obj = [[cls alloc] init];
    for (NSString *key in [dic allKeys]) {
        if ([key isEqualToString:Class_Key]) {
            continue;
        }
        NSObject *value = [dic valueForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            [obj setValue:[self objectWithDic:(NSDictionary *)value error:error] forKey:key];
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            [obj setValue:[self arrayWithArray:(NSArray *)value error:nil] forKey:key];
        }
        else
        {
            [obj setValue:value forKey:key];
        }
    }
    return obj;
}
@end
