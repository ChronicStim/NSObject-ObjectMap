//
//  TestHelpers.m
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "NSObject+ObjectMap.h"
#import <XCTest/XCTest.h>

typedef NS_ENUM(NSInteger, DataType) {
    DataTypeXML,
    DataTypeJSON,
    DataTypeSOAP
};

@interface ObjectMapTestCase : XCTestCase

@end

@implementation ObjectMapTestCase

- (void)testObject:(id)obj withDeserializedVersion:(id)deserializedObj forMethodNamed:(NSString *)methodName dataType:(DataType)type {
    //Test all properties
    for (NSString *propertyName in [deserializedObj propertyDictionary]) {
        if ([[deserializedObj valueForKey:propertyName] isKindOfClass:[NSDate class]]) {
            XCTAssertEqualWithAccuracy([[obj valueForKey:propertyName] timeIntervalSince1970], [[deserializedObj valueForKey:propertyName] timeIntervalSince1970], 0.01, @"Failed %@ serialization/deserialization test for method named: %@. Failed on property %@", [self stringForType:type], methodName, propertyName);
        }
        else {
            XCTAssertEqualObjects([obj valueForKey:propertyName], [deserializedObj valueForKey:propertyName], @"Failed %@ serialization/deserialization test for method named: %@. Failed on property %@", [self stringForType:type], methodName, propertyName);
        }
    }
}


- (NSString *)stringForType:(DataType)type {
    switch (type) {
        case DataTypeXML:
            return @"XML";
            break;
        case DataTypeJSON:
            return @"JSON";
            break;
        case DataTypeSOAP:
            return @"SOAP";
            break;
        default:
            return @"";
            break;
    }
}


@end