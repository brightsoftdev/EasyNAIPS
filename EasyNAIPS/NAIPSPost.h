//
//  NAIPSPost.h
//  taf
//
//  Created by Iain Blair on 25/08/12.
//
//

#import <Foundation/Foundation.h>
#import "NAIPSObject.h"

@class NAIPSObject;

@interface NAIPSPost : NSObject
{
    NSURLConnection *connection;
    NSMutableData *receivedData;
}

@property (nonatomic, weak) NAIPSObject* myObject;

@property (nonatomic, strong, readonly) NSError* connectionError;
@property (nonatomic, strong, readonly) NSString* receivedString;

-(void) go;
-(void) cancel;

@end
