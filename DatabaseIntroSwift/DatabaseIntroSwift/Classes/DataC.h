#import <Foundation/Foundation.h>

@interface DataC : NSObject

@property(nonatomic, readwrite) int id;  // Property
@property(nonatomic, readwrite) NSString* name;  // Property
@property(nonatomic, readwrite) int age;  // Property
@property(nonatomic, readwrite) NSString* avatar;  // Property
- (instancetype)initWithID:(int)id
name:(NSString *)name
age:(int)age
avatar:(NSString *)avatar;
@end
