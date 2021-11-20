//
//  AppUtilities.m
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import "AppUtility.h"
#import "NSString+Helper.h"
@implementation AppUtility

+ (NSString*)getFormattedDateStringFromDate:(NSDate*)date withFormat:(NSString*)format {
    if ([AppUtility isNull:date] || [AppUtility isNull:format] || [format trimWhiteChars].length == 0) {
        return  @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    NSString *formattedStr = [dateFormatter stringFromDate:date];
    return  formattedStr;
}

+ (BOOL)isNull:(id)object {
    return object == nil || object == (id)[NSNull null];
}

+ (NSString *)getDocumentDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return  documentsPath;
}


@end
