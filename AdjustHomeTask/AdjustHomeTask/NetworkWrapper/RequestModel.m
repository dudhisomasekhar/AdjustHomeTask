//
//  RequestModel.m
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import "RequestModel.h"

static NSString* const kSeconds = @"seconds";

@implementation RequestModel

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.seconds forKey:kSeconds];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if ((self=[super init]))
    {
        self.seconds = [coder decodeObjectForKey:kSeconds];
    }
    return  self;
}

@end
