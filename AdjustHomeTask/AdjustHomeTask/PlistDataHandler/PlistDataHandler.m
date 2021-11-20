//
//  PlistDataHandler.m
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import "PlistDataHandler.h"
#import "AppUtility.h"
#import "Constants.h"
#import "NSString+Helper.h"

#define kPlistFileName @"PlistData.plist"

@implementation PlistDataHandler

+ (NSString *)plistFilePath {
    NSString *documentDirPath =  [AppUtility getDocumentDirectoryPath];
    NSString *plistFilePath = [documentDirPath stringByAppendingPathComponent:kPlistFileName];
    return plistFilePath;
}

+ (void)createPlistFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *destinationFilePath = [PlistDataHandler plistFilePath];
    if ([fileManager fileExistsAtPath:destinationFilePath]) {
        return;
    }
    NSString *resourceFilePath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    NSError * error;
    [fileManager copyItemAtPath:resourceFilePath toPath:destinationFilePath error:&error];
    if (error) {
        NSLog(@"error %@", error.localizedDescription);
    }
}

+ (NSMutableArray *)readDataFromPlist {
    return [NSMutableArray arrayWithContentsOfFile:[PlistDataHandler plistFilePath]];
}

+ (void)writeDataToPlist:(NSArray *)dataArray {
    [dataArray writeToFile:[PlistDataHandler plistFilePath] atomically:YES];
}

+ (NSDictionary *)getDictWithSeconds:(NSString *)seconds andStatus:(BOOL)status {
    if ([AppUtility isNull:seconds] || [seconds trimWhiteChars].length == 0) {
        return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:seconds forKey:kSeconds];
    [dict setValue:[NSNumber numberWithBool:status] forKey:kUploadStatus];
    return dict;
}

+ (NSMutableArray *)addOrReplaceObject:(NSDictionary*)dict inArray:(NSMutableArray *)dataArray {
    if ([AppUtility isNull:dict] || [AppUtility isNull:dataArray]) {
        return nil;
    }
    NSDictionary *filteredDictionary = [PlistDataHandler filterArray:dataArray withSeconds:[dict objectForKey:kSeconds]];
    if (filteredDictionary != nil) {
        NSUInteger index = [dataArray indexOfObject: filteredDictionary];
        [dataArray replaceObjectAtIndex:index withObject:dict];
    }else {
        [dataArray addObject:dict];
    }
    return  dataArray;
}

+ (NSDictionary *)filterArray:(NSMutableArray*)dataArray withSeconds:(NSString*)seconds {
    if ([AppUtility isNull:dataArray] || [AppUtility isNull:seconds] || [seconds trimWhiteChars].length == 0) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"seconds = %@", seconds];
    NSDictionary *filteredDictionary = [dataArray filteredArrayUsingPredicate:predicate].firstObject;
    return filteredDictionary;
}

@end
