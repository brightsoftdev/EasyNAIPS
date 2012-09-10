//
//  NAIPSObject.h
//  taf
//
//  Created by Iain Blair on 22/08/12.
//
//

#import <Foundation/Foundation.h>
#import "NAIPSPost.h"
#import "NAIPSObjectQueue.h"

@class NAIPSPost;
@class NAIPSObjectQueue;

@interface NAIPSObject : NSObject <NSCoding>
{
    NSError* error;
    NSString* text;
    
    // This keyString is for the parent string. So if this NAIPSObject was to be a TAF, keyString would be the TAF airport.
    NSString* keyString;
    
    NSString* keyStringDescription;
}


@property (nonatomic, strong, readonly) NAIPSPost* post;
@property (nonatomic, strong) NSDate* timestamp;

@property (nonatomic, weak) NAIPSObjectQueue* queue;

-(NSString*) keyString;
-(NSError*) error;
-(NSString*) text;
-(NSString*) longTimestampString;
-(NSString*) shortTimestampString;
-(NSString*) dateString;
-(NSString*) keyStringDescription;


-(id) initWithKeyString: (NSString*) key;

// Overrides
-(NSURLRequest*) postRequest;
-(void) NAIPSPostConnectionDidFinishLoading;
-(void) NAIPSPostConnectionDidFailWithError;

@end
