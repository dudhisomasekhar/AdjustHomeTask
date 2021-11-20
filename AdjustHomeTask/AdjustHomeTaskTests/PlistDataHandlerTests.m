//
//  PlistDataHandlerTests.m
//  AdjustHomeTaskTests
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import <XCTest/XCTest.h>
#import "PlistDataHandler.h"

@interface PlistDataHandlerTests : XCTestCase

@end

@implementation PlistDataHandlerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
- (void)testGetDictWithSeconds_nil {
    
    NSDictionary *dict = [PlistDataHandler getDictWithSeconds:@"" andStatus:false];
    XCTAssertNil(dict);
    
    NSString *nilStr;
    NSDictionary *dict1 = [PlistDataHandler getDictWithSeconds:nilStr andStatus:false];
    XCTAssertNil(dict1);
    
}
- (void)testGetDictWithSeconds_Success {
    
    NSDictionary *dict = [PlistDataHandler getDictWithSeconds:@"45" andStatus:false];
    XCTAssertNotNil(dict);
    XCTAssertTrue([[dict objectForKey:@"seconds"] isEqualToString:@"45"]);
}

- (void)testFilterArray_nil {
    // scenario - 1 : when both nil
    NSMutableArray *nilArray;
    NSDictionary *dict = [PlistDataHandler filterArray:nilArray withSeconds:@""];
    XCTAssertNil(dict);
    // scenario - 2 :  when str is empty
    NSMutableArray * dataArray = [NSMutableArray array];
    NSDictionary *dict1 = [PlistDataHandler filterArray:dataArray withSeconds:@""];
    XCTAssertNil(dict1);
    // scenario - 3 :  when array is empty
    NSDictionary *dict2 = [PlistDataHandler filterArray:nilArray withSeconds:@"45"];
    XCTAssertNil(dict2);
}

- (void)testFilterArray_Success {
    
    NSDictionary *dict = [PlistDataHandler filterArray:[self getDataArray] withSeconds:@"35"];
    XCTAssertNotNil(dict);
    XCTAssertTrue([[dict objectForKey:@"seconds"] isEqualToString:@"35"]);
}

- (void)testAddOrReplaceObject_nil {
    // scenario - 1 : when both nil
    NSMutableArray *nilArray;
    NSDictionary *nilDict;
    NSMutableArray *outputArray = [PlistDataHandler addOrReplaceObject:nilDict inArray:nilArray];
    XCTAssertNil(outputArray);
    // scenario - 2 :  when dict is empty
    NSMutableArray * dataArray = [NSMutableArray array];
    NSMutableArray *outputArray1 = [PlistDataHandler addOrReplaceObject:nilDict inArray:dataArray];
    XCTAssertNil(outputArray1);
    // scenario - 3 :  when array is empty
    NSMutableArray *outputArray2 = [PlistDataHandler addOrReplaceObject:[NSDictionary dictionary] inArray:nilArray];
    XCTAssertNil(outputArray2);
}

- (void)testAddOrReplaceObject_Success {
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"36" forKey:@"seconds"];
    [dict setValue:[NSNumber numberWithBool:YES] forKey:@"uploadStatus"];
    
    // scenario - 1 : Add object
    NSMutableArray *outputArray = [PlistDataHandler addOrReplaceObject:dict inArray:[self getDataArray]];
    XCTAssertNotNil(outputArray);
    XCTAssertEqual(outputArray.count, 3);
    
    NSMutableDictionary * dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setValue:@"36" forKey:@"seconds"];
    [dict1 setValue:[NSNumber numberWithBool:NO] forKey:@"uploadStatus"];
    
    // scenario - 2 : Replace object
    NSMutableArray *outputArray1 = [PlistDataHandler addOrReplaceObject:dict inArray:[self getDataArray]];
    XCTAssertNotNil(outputArray1);
    XCTAssertEqual(outputArray1.count, 3);
    
}

- (NSMutableArray*)getDataArray {
    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"35" forKey:@"seconds"];
    [dict setValue:[NSNumber numberWithBool:YES] forKey:@"uploadStatus"];
    NSMutableDictionary * dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setValue:@"45" forKey:@"seconds"];
    [dict1 setValue:[NSNumber numberWithBool:NO] forKey:@"uploadStatus"];
    
    [dataArray addObject:dict];
    [dataArray addObject:dict1];
    
    return  dataArray;
}

@end
