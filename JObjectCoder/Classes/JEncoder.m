//
//  JEncoder.m
//  JUIImage
//
//  Created by Joe on 13-9-5.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "JEncoder.h"
#import "objc/objc.h"
#import "objc/message.h"

@implementation JEncoder


#pragma mark - public method

+ (NSDictionary *)encodeObject:(NSObject *)object error:(NSError**)error
{
    NSDictionary *dic = [self dictionaryWithObject:object error:error];
    if (error) {
        return nil;
    }
    return dic;
}

+ (void)encodeObject:(NSObject *)object toFile:(NSString *)path error:(NSError **)error
{
    NSDictionary *dic = [self encodeObject:object error:error];
    [NSKeyedArchiver archiveRootObject:dic toFile:path];
}

#pragma mark - private method

+ (BOOL)isValid:(id)obj
{
    if ([obj isKindOfClass:[NSString class]] ||
        [obj isKindOfClass:[NSValue class]]) {
        return YES;
    }
    return NO;
}

+ (NSArray *)arrayWithObject:(NSArray *)object error:(NSError **)error
{
    NSMutableArray *ary = [NSMutableArray array];
    for (NSObject *child in object) {
        if ([self isValid:child]) {
            [ary addObject:child];
        }
        else {
            if ([child isKindOfClass:[NSArray class]]) {
                [ary addObject:[self arrayWithObject:(NSArray *)child error:error]];
            }
            else {
                NSDictionary *d = [self dictionaryWithObject:child error:error];
                NSLog(@"%@",d);
                [ary addObject:[self dictionaryWithObject:child error:error]];
            }
        }
    }
    return ary;
}

+ (NSDictionary *)dictionaryWithObject:(NSObject *)object error:(NSError **)error
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:NSStringFromClass([object class]) forKey:Class_Key];
    
    unsigned int count = 0;
    Class cls = [object class];
    while(cls != [NSObject class]) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            for (NSString *key in [(NSDictionary *)object allKeys]) {
                NSObject *value = [object valueForKey:key];
                if ([self isValid:value]) {
                    [dic setValue:value forKey:key];
                }
                else {
                    [dic setValue:[self dictionaryWithObject:value error:error] forKey:key];
                }
            }
        }
        else if ([object isKindOfClass:[NSArray class]]) {
            
            if (error) {
                *error = [NSError errorWithDomain:@"" code:Error_Code_Class userInfo:nil];
            }
            //@mark TODO
        }
        else {
            Ivar *ivars = class_copyIvarList(cls, &count);
            for (int i = 0; i < count; i++) {
                Ivar ivar = ivars[i];
                const char *name = ivar_getName(ivar);
                NSString *varKey = [NSString stringWithUTF8String:name];
                NSObject *varValue = [object valueForKey:varKey];
                if ([self isValid:varValue]) {
                    [dic setValue:varValue forKey:varKey];
                }
                else {
                    if ([varValue isKindOfClass:[NSArray class]]) {
                        [dic setValue:[self arrayWithObject:(NSArray *)varValue error:error] forKey:varKey];
                    }
                    else {
                        [dic setValue:[self dictionaryWithObject:varValue error:error] forKey:varKey];
                    }
                }
            }
        }
        cls = class_getSuperclass(cls);
    }
    return dic;
}
@end
