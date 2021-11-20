//
//  NetworkWrapper.m
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import "NetworkWrapper.h"
#import "NSURLSession+SynchronousDataTask.h"
#import "ResponseData.h"

static NSString* const secondsUrlStr = @"https://jsonplaceholder.typicode.com/posts";

#define TIME_OUT_INTERVAL               30
#define METHOD_TYPE_POST                @"POST"
#define CONTENT_TYPE_KEY                @"Content-Type"
#define CONTENT_TYPE_VALUE              @"application/x-www-form-urlencoded"
#define kSECONDS_KEY                    @"seconds"
@implementation NetworkWrapper

+ (void)sendNetworkRequestWithParams:(RequestModel*)requestParams andCompletion:(ConnectionCompletion)completionHandler {
    
    NSMutableURLRequest *request = [NetworkWrapper createSecondsUrlRequestWithParams:requestParams];
    [NSURLSession sendSynchronousDataTaskWithUrlRequest:request onCompletion:^(id  _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
        }else {
            NSError *error;
            ResponseData *responseData = [NetworkWrapper handleResponseData:response withError:&error];
            if (error) {
                completionHandler(nil, error);
            }else{
                completionHandler(responseData, nil);
            }
        }
    }];
}

+ (NSMutableURLRequest*)createSecondsUrlRequestWithParams:(RequestModel*)params {
    
    // Create url request with Url
    NSURL * url = [NSURL URLWithString:secondsUrlStr];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIME_OUT_INTERVAL];
    // SET HTTP METHOD
    [urlRequest setHTTPMethod:METHOD_TYPE_POST];
    // SET HTTP HEADERS
    [urlRequest setValue:CONTENT_TYPE_VALUE forHTTPHeaderField:CONTENT_TYPE_KEY];
    // Set HTTP Body
    NSString * bodyStr = [NSString stringWithFormat:@"%@=%@",kSECONDS_KEY, params.seconds];
    [urlRequest setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    return urlRequest;
}

+ (ResponseData *)handleResponseData:(id)data withError:(NSError **) error {
    NSError *parseError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    ResponseData *responseData = [[ResponseData alloc] init];
    if (parseError == nil) {
        [responseData setValuesForKeysWithDictionary:responseDictionary];
    }
    return responseData;
}
@end
