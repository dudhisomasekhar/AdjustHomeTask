//
//  PlistDataHandler.h
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlistDataHandler : NSObject

+ (void)createPlistFile;
+ (NSMutableArray *)readDataFromPlist;
+ (void)writeDataToPlist:(NSArray *)dataArray;
+ (NSDictionary *)getDictWithSeconds:(NSString *)seconds andStatus:(BOOL)status;
+ (NSMutableArray *)addOrReplaceObject:(NSDictionary *)dict inArray:(NSMutableArray *)dataArray;
+ (NSDictionary *)filterArray:(NSMutableArray*)dataArray withSeconds:(NSString*)seconds;
@end

NS_ASSUME_NONNULL_END
