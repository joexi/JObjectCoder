JObjectCoder
============
A lightweight framework for writing and reading object to/from local files.

###API
* JDecoder

```Objective-c
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

```Objective-c
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



