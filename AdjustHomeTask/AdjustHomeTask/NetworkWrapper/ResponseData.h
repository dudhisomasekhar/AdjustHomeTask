//
//  ResponseData.h
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResponseData : NSObject <NSCopying>

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *seconds;

@end

NS_ASSUME_NONNULL_END
