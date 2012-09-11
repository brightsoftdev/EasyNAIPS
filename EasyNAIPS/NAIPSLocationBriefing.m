//
//  NAIPSTaf.m
//  taf
//
//  Created by Iain Blair on 26/08/12.
//
//

#import "NAIPSLocationBriefing.h"
#import "NAIPS.h"

@implementation NAIPSLocationBriefing

-(NSURLRequest*) postRequest
{
    return [NAIPS requestFromArray: [[NSArray alloc] initWithObjects:
                                    @"msg", @"0092",
                                    @"aid", @"0",
                                    @"dom", @"1",
                                    @"loc", keyString,
                                    @"loc", @"",
                                    @"loc", @"",
                                    @"loc", @"",
                                    @"loc", @"",
                                    @"loc", @"",
                                    @"loc", @"",
                                    @"loc", @"",
                                    @"loc", @"",
                                    @"loc", @"",
                                    @"met", @"1",
                                    @"ntm", @"1",
                                    @"val", @"",
                                    nil]];
}


-(void) NAIPSPostConnectionDidFinishLoading
{
    NSLog(@"NAIPSLocation Finished: %@", keyString);
    text = [NAIPS stringBetweenTagString:@"pre" textWithTags:[self.post receivedString] returnWithTags:YES];

    
    if ([NAIPS string:@"LOCATION BRIEFING" existsIn:[self.post receivedString]] == YES)
    {
        error = nil;
        keyStringDescription = [self findLocationName];
    }
    else
    {

        // Lets find out specifically what is wrong
        NSMutableDictionary *details = [NSMutableDictionary dictionary];
        int errorCode;
        
        if ([NAIPS string:@"is unknown" existsIn:[self.post receivedString]] == YES)
        {
            
            // for some reason this error is in between 2 pre tags...
            text = [NAIPS stringBetweenTagString:@"pre" textWithTags:text returnWithTags:NO];
   
            text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            
            
            
            [details setValue:@"The location entered is unknown." forKey:NSLocalizedDescriptionKey];
            errorCode = 0;
        }
        else if ([NAIPS string:@"is not a FIR NOTAM restriction area" existsIn:[self.post receivedString]] == YES)
        {
            
            // for some reason this error is in between 2 pre tags...
            text = [NAIPS stringBetweenTagString:@"pre" textWithTags:text returnWithTags:NO];
            
         
            text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];

            
            [details setValue:@"The location is not a FIR NOTAM restriction area." forKey:NSLocalizedDescriptionKey];
            errorCode = 1;
        }
        else if ([NAIPS string:@"No locations entered" existsIn:[self.post receivedString]] == YES)
        {
            
            [details setValue:@"No locations entered." forKey:NSLocalizedDescriptionKey];
            errorCode = 2;
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


-(NSString*) findLocationName
{
    NSString* pattern = [[NSString alloc] initWithFormat: @"(.*) \\(%@\\)",keyString.uppercaseString];
    
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    
    NSArray *matches = [reg matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    NSString *locationName = @"";
            
    if ([matches count] > 0)
    {
        NSTextCheckingResult *result = [matches objectAtIndex:0];
        

        NSRange r = [result rangeAtIndex:1];
            
        locationName = [text substringWithRange:r];
    }
    
    return locationName;
}


-(void) NAIPSPostConnectionDidFailWithError
{
    NSLog(@"NAIPSObjectConnection Error: %@", [[self.post connectionError] localizedDescription]);
    
    // Since this should fail the Q, we have to repackage the error with my own custom error code of 10.
    error = [[NSError alloc] initWithDomain:@"NAIPS" code:10 userInfo:[[self.post connectionError] userInfo]];
    
    // notify queue we are done, the queue can check my error.
    [self.queue objectDone];
}

@end
