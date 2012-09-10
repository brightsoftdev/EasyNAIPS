//
//  NAIPSObject.m
//  taf
//
//  Created by Iain Blair on 22/08/12.
//
//

#import "NAIPSObject.h"
#import "NAIPS.h"
@implementation NAIPSObject

@synthesize timestamp;
@synthesize post;
@synthesize queue;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        
        keyString = [aDecoder decodeObjectForKey:@"keyString"];
        keyStringDescription = [aDecoder decodeObjectForKey:@"keyStringDescription"];
        timestamp = [aDecoder decodeObjectForKey:@"timestamp"];
        text = [aDecoder decodeObjectForKey:@"text"];
        error = [aDecoder decodeObjectForKey:@"error"];
        
        // post isnt coder compliant, and it doesnt need to be.
        post = [[NAIPSPost alloc] init];
        [post setMyObject:self];
        
    }
    return self;
}

-(id) initWithKeyString:(NSString *)key
{
    self = [super init];
    
    if (self)
    {
        keyString = key;
        timestamp = nil;
        error = nil;

        // Hope this is ok. Both NAIPSObject and NAIPSPost have the request, but NAIPSPost has it weak-ly;
        post = [[NAIPSPost alloc] init];
        
        [post setMyObject:self];
    }
    return self;
}

-(NSURLRequest*) postRequest
{
    NSLog(@"your are getting no request");
    return nil;
}

-(void) NAIPSPostConnectionDidFinishLoading
{
    // Override this and create errors for the NAIPSObject.
    NSLog(@"NAIPSObject - I should be overridden.");
}

-(void) NAIPSPostConnectionDidFailWithError
{
    // Override this method and pass on the connection error...
    NSLog(@"NAIPSObject - I should be overridden.");
}

-(NSError *)error
{
    return error;
}

-(NSString*) text
{
    return text;
}

-(NSString*) keyString
{
    return keyString;
}

-(NSString*) keyStringDescription
{
    return keyStringDescription;
}


-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:text forKey:@"text"];
    [aCoder encodeObject:keyString forKey:@"keyString"];
    [aCoder encodeObject:keyStringDescription forKey:@"keyStringDescription"];
    [aCoder encodeObject:timestamp forKey:@"timestamp"];
    [aCoder encodeObject:error forKey:@"error"];
}

-(NSString*) longTimestampString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"h:mm:ssa dd/MM/yyyy z"];
    
    return [formatter stringFromDate:timestamp];

}

-(NSString*) shortTimestampString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"h:mm:ss a"];
    
    return [formatter stringFromDate:timestamp];
    
}

-(NSString*) dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    return [formatter stringFromDate:timestamp];
    
}


@end
