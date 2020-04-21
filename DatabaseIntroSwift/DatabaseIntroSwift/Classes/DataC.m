
#import <Foundation/Foundation.h>
#import "DataC.h"

 @implementation DataC
- (instancetype)initWithID:(int)id
name:(NSString *)name
age:(int)age
avatar:(NSString *)avatar {
    self = [super init];
    if (self) {
        _name = name;
        _id = id;
        _age = age;
        _avatar = avatar;
    }
    return self;
}
 - (void)connect {

 }

 @end
