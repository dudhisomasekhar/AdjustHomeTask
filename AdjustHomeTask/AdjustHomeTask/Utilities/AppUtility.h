//
//  AppUtilities.h
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppUtility : NSObject

+ (NSString*)getFormattedDateStringFromDate:(NSDate*)date withFormat:(NSString*)format;
+ (BOOL)isNull:(id)object;
+ (NSString *)getDocumentDirectoryPath;

@end

NS_ASSUME_NONNULL_END
