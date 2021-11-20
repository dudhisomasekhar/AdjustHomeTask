//
//  NSURLSession+SynchronousDataTask.m
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import "NSURLSession+SynchronousDataTask.h"

@implementation NSURLSession (SynchronousDataTask)

+ (void)sendSynchronousDataTaskWithUrlRequest:(NSMutableURLRequest*)request onCompletion:(ConnectionCompletion)completionHandler {
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"server error: %@", error);
            completionHandler(nil, error);
            dispatch_semaphore_signal(sema);
        } else {
            completionHandler(data, nil);
            dispatch_semaphore_signal(sema);
        }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

@end
