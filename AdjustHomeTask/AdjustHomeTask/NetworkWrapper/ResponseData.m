//
//  ResponseData.m
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import "ResponseData.h"

@implementation ResponseData

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    ResponseData *responseDataCopy =   [[[self class] allocWithZone:zone] init];
    if (!responseDataCopy) {
        return nil;
    }
    responseDataCopy->_id = _id;
    responseDataCopy->_seconds = [_seconds copyWithZone:zone];
    return  responseDataCopy;
}

@end
