//
//  NAIPSAreaBriefing.m
//  taf
//
//  Created by Iain Blair on 26/08/12.
//
//

#import "NAIPSAreaBriefing.h"
#import "NAIPS.h"

@implementation NAIPSAreaBriefing

-(NSURLRequest*) postRequest
{
    return [NAIPS requestFromArray: [[NSArray alloc] initWithObjects:
                                    @"msg", @"008e",
                                    @"aid", @"0",
                                    @"area", keyString,
                                    @"area", @"",
                                    @"area", @"",
                                    @"area", @"",
                                    @"met", @"1",
                                    @"ntm", @"0",
                                    @"hon", @"0",
                                    @"val", @"",
                                    nil]];
}

-(void) NAIPSPostConnectionDidFinishLoading
{
    //NSLog(@"NAIPSLogin Finished: %@", [self.post receivedString]);
    text = [NAIPS stringBetweenTagString:@"pre" textWithTags:[self.post receivedString] returnWithTags:YES];
    
    
    if ([NAIPS string:@"AREA BRIEFING" existsIn:[self.post receivedString]] == YES)
    {
        error = nil;

    }
    else
    {
        // Lets find out specifically what is wrong
        NSMutableDictionary *details = [NSMutableDictionary dictionary];
        int errorCode;
        
        if ([NAIPS string:@"is unknown" existsIn:[self.post receivedString]] == YES)
        {
            [details setValue:@"The area entered is unknown." forKey:NSLocalizedDescriptionKey];
            errorCode = 0;
        }
        else if ([NAIPS string:@"Invalid area" existsIn:[self.post receivedString]] == YES)
        {
            [details setValue:@"The area entered is invalid." forKey:NSLocalizedDescriptionKey];
            errorCode = 1;
        }
        else
        {
            [details setValue:@"Unknown NAIPS response." forKey:NSLocalizedDescriptionKey];
            errorCode = 99;
        }
        
        error = [NSError errorWithDomain:@"NAIPS" code:errorCode userInfo:details];
        
    }
    [self.queue objectDone];
    
}

-(void) NAIPSPostConnectionDidFailWithError
{
    NSLog(@"NAIPSObjectConnection Error: %@", [[self.post connectionError] localizedDescription]);
    
    // pass on the connection error, this way NAIPSObjects error is the connectionError if a connection error occurs.
    error = [self.post connectionError];
    
    // notify queue we are done, the queue can check my error.
    [self.queue objectDone];
}


@end
