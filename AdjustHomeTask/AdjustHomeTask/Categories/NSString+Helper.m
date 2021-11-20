//
//  NSString+Helper.m
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

- (NSString*)trimWhiteChars {
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
