//
//  NAIPSPost.m
//  taf
//
//  Created by Iain Blair on 25/08/12.
//
//

// This seems to work OK. At least it gets the text no problem. Error hasn't been tested.


#import "NAIPSPost.h"

@implementation NAIPSPost
@synthesize connectionError;
@synthesize receivedString;
@synthesize myObject;

-(void) go
{
    receivedData = [[NSMutableData alloc] init];
    connection = [[NSURLConnection alloc] initWithRequest:[myObject postRequest] delegate:self startImmediately:YES];
}

-(void) cancel
{
    [connection cancel];
}

-(void) connection: (NSURLConnection*) conn didReceiveData:(NSData *)data
{
    
    [receivedData appendData:data];
}

-(void) connection: (NSURLConnection*) conn didFailWithError:(NSError *)error
{
   
    connection = nil;
    receivedData = nil;
    connectionError = error;
    
    [myObject NAIPSPostConnectionDidFailWithError];
}

-(void) connectionDidFinishLoading:(NSURLConnection*) conn
{
    NSString* dataString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    receivedString = dataString;
    [myObject setTimestamp:[[NSDate alloc]init]];
    [myObject NAIPSPostConnectionDidFinishLoading];
    
}


@end
