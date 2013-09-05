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

#pragma mark - private method

+ (BOOL)isValid:(id)obj
{
    if ([obj isKindOfClass:[NSString class]] ||
        [obj isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    return NO;
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
            *error = [NSError errorWithDomain:@"" code:Error_Code_Class userInfo:nil];
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
                    [dic setValue:[self dictionaryWithObject:varValue error:error] forKey:varKey];
                }
            }
        }
        cls = class_getSuperclass(cls);
    }
    return dic;
}
@end
