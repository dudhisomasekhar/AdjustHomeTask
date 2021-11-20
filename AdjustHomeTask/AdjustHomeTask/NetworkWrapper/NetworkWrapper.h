//
//  NetworkWrapper.h
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import <Foundation/Foundation.h>
#import "RequestModel.h"
#import "Constants.h"


NS_ASSUME_NONNULL_BEGIN

@interface NetworkWrapper : NSObject

+ (void)sendNetworkRequestWithParams:(RequestModel*)requestParams andCompletion:(ConnectionCompletion)completionHandler;

@end

NS_ASSUME_NONNULL_END
