//
//  NAIPS.h
//  naips_testing
//
//  Created by Iain Blair on 14/08/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAIPS : NSObject

+(NSString*) POSTStringFromArray: (NSArray *) parameters;
+(NSString*) stringBetweenTagString: (NSString*) tag textWithTags: (NSString*) text returnWithTags: (BOOL) withTags;

+(NSURLRequest*) requestFromUsername: (NSString*) username andPassword: (NSString*) password;
+(NSURLRequest*) locationBriefingRequestFromLocation: (NSString*) location;

+(NSInteger) NAIPSErrFromString: (NSString*) text;
+(BOOL) string: (NSString*) aString existsIn: (NSString*) text;

+(NSDictionary*) NAIPSErrorDict;
+(NSDictionary*) NAIPSStatusDict;
+(NSURLRequest*) requestFromArray: (NSArray*) theArray;




@end
