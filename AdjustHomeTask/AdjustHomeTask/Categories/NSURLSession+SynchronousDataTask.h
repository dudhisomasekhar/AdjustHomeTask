//
//  NSURLSession+SynchronousDataTask.h
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

typedef void(^ConnectionCompletion)(id _Nullable response, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSession (SynchronousDataTask)

+ (void)sendSynchronousDataTaskWithUrlRequest:(NSMutableURLRequest*)request onCompletion:(ConnectionCompletion)completionHandler;

@end

NS_ASSUME_NONNULL_END
