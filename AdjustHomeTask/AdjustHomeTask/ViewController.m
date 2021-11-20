//
//  ViewController.m
//  AdjustHomeTask
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import "ViewController.h"
#import "AppUtility.h"
#import "NetworkWrapper.h"
#import "Constants.h"
#import "PlistDataHandler.h"
#import "ResponseData.h"
#import "NSString+Helper.h"

#define kSecondsFormat  @"ss"
@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *plistDataArray;

@end

@implementation ViewController
@synthesize plistDataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    plistDataArray = [PlistDataHandler readDataFromPlist];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
}
- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)handleClickButtonAction:(id)sender {
    // get seconds from the current time
    NSDate *currentDate = [NSDate date];
    NSString * seconds = [AppUtility getFormattedDateStringFromDate:currentDate withFormat:kSecondsFormat];
    NSLog(@"currentDate: %@, seconds: %@",currentDate, seconds);
    if ([AppUtility isNull:seconds] || [seconds trimWhiteChars].length == 0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        NSDictionary *filteredDictionary = [PlistDataHandler filterArray: strongSelf->plistDataArray withSeconds:seconds];
        if (filteredDictionary == nil) {
            NSDictionary * dataDict = [PlistDataHandler getDictWithSeconds:seconds andStatus:false];
            strongSelf->plistDataArray = [PlistDataHandler addOrReplaceObject:dataDict inArray:strongSelf->plistDataArray];
            [strongSelf sendNetworkRequestForSeconds:seconds];
        }else {
            NSLog(@"Warning: Request uploaded already for %@. ", seconds);
        }
    });
    
}

- (void)sendNetworkRequestForSeconds:(NSString*)seconds {
    RequestModel *request = [[RequestModel alloc] init];
    request.seconds = [seconds copy];
    __weak typeof(self) weakSelf = self;
    [NetworkWrapper sendNetworkRequestWithParams:request andCompletion:^(id  _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            ResponseData *responseData = (ResponseData*) response;
            NSLog(@"Upload Successful for \n seconds %@ with id %d", responseData.seconds,responseData.id);
            [weakSelf writeDataToPlistWithSeconds:responseData.seconds andStatus:true];
        }else {
            NSLog(@"Error: %@", error.localizedDescription);
            [weakSelf writeDataToPlistWithSeconds:request.seconds andStatus:false];
        }
    }];
}

- (void)writeDataToPlistWithSeconds:(NSString *)seconds andStatus:(BOOL)status {
    plistDataArray = [PlistDataHandler addOrReplaceObject:[PlistDataHandler getDictWithSeconds:seconds andStatus:status] inArray:plistDataArray];
    [PlistDataHandler writeDataToPlist:plistDataArray];
}


#pragma mark - UIApplication Delegates
- (void) applicationDidEnterBackground:(NSNotification*)notification {
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [PlistDataHandler writeDataToPlist:plistDataArray];
    });
}
- (void) applicationWillEnterForeground:(NSNotification*)notification {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uploadStatus == %@", @NO];
            NSArray *filteredArray = [strongSelf->plistDataArray filteredArrayUsingPredicate:predicate];
            for (NSDictionary *dict in filteredArray) {
                [self sendNetworkRequestForSeconds:[dict objectForKey:kSeconds]];
            }
        }
    });
}


@end
