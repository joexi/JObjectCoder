JObjectCoder
============
A lightweight framework for writing and reading object to/from local files.


###Provide
* saving instance to local.
* instantiation a local file into instance.
* support complicate model-kind class (each class should derive frome NSObject). 
* support decoding NSArray,NSDictionary object.
* few api to remeber, easy to use.

###TODO

* support reference concept-same instance encoding to the same file.

###Environment
 * iOS SDK 6.1
 * Xcode 4.6.3
 * ARC Mode
 

###API
* JDecoder

```Objective-C
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
```

* JEncoder

```Objective-C
/**
 Encode object to dictionary witch can be archived.
 @param object origin object.
 @param error record some error while encoding.
 @return structured dictionary.
 */
+ (NSDictionary *)encodeObject:(NSObject *)object error:(NSError**)error;


/**
 Directly encode an object and save as a file.
 @param path path for saving.
 @param error record some error while encoding
 @return null.
 */
+ (void)encodeObject:(NSObject *)object toFile:(NSString *)path error:(NSError **)error;
```

###Code Sample
```Obejctive-C
    NSString *path = [[PathHelper documentDirectoryPath] stringByAppendingPathComponent:@"1.txt"];
    Test *t = [[Test alloc]init];
    [JEncoder encodeObject:t toFile:path error:nil];
    Test *t2 = (Test *)[JDecoder decodeWithContentsOfFile:path error:nil];
```


