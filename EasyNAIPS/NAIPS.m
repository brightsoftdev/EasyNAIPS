//
//  NAIPS.m
//  naips_testing
//
//  Created by Iain Blair on 14/08/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import "NAIPS.h"

@implementation NAIPS

+(NSDictionary*) NAIPSErrorDict
{
    //NSNumber *no = [[NSNumber alloc] initWithBool:NO];
    NSNumber *yes = [[NSNumber alloc] initWithBool:YES];
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            
    yes,@"You are not logged on to NAIPS",
    yes,@"Invalid User ID or Password",
    yes,@"Your access to NAIPS is temporarily denied",
    nil];
}

+(NSDictionary*) NAIPSStatusDict
{
    NSNumber *no = [[NSNumber alloc] initWithBool:NO];
    //NSNumber *yes = [[NSNumber alloc] initWithBool:YES];
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            
            no,@"Welcome to NAIPS",
            no,@"LOCATION BRIEFING",
            nil];
}


+(NSString*) NAIPS_URL
{
    return @"https://www.airservicesaustralia.com/brief/html.asp?/cgi-bin/naips";
}

+(NSString*) stringBetweenTagString: (NSString*) tag textWithTags: (NSString*) text returnWithTags: (BOOL) withTags
{
    NSString* pattern = [[NSString alloc] initWithFormat:@"<%@>(.*)</%@>",tag,tag];
   
    NSRegularExpression* reg = [[NSRegularExpression alloc]
                                       initWithPattern: pattern
                                       options: NSRegularExpressionDotMatchesLineSeparators
                                       error: nil];

    NSArray *matches = [reg matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    if([matches count] > 0)
    {
        NSTextCheckingResult *result = [matches objectAtIndex:0];
        
        if ([result numberOfRanges] == 2)
        {
            NSRange r;

            if (withTags)
            {
                r = [result rangeAtIndex:0];
            }
            else
            {
                r = [result rangeAtIndex:1];
            }
            
            return [text substringWithRange:r];
        }
    }
    
    return nil;
}

+(NSString*) POSTStringFromArray: (NSArray *) parameters
{
    
    NSMutableString *formPostParams = [[NSMutableString alloc] init];
    
    for (int i = 0; i < [parameters count]; i += 2)
    {
        [formPostParams appendString: [parameters objectAtIndex:i]];
        [formPostParams appendString: @"="];
 
        [formPostParams appendString: [parameters objectAtIndex:i + 1]];
        
    
        if (i != [parameters count] - 2)
        {
                [formPostParams appendString: @"&"];
        }
    }
    return formPostParams;
}


+(NSURLRequest*) requestFromUsername: (NSString*) username andPassword: (NSString*) password
{
    return [self requestFromArray: [[NSArray alloc] initWithObjects:
                                                        @"msg", @"0048",
                                                        @"usr", username,
                                                        @"pwd", password,
                                                        nil]];
}

+(NSURLRequest*) locationBriefingRequestFromLocation: (NSString*) location
{
    return [self requestFromArray: [[NSArray alloc] initWithObjects:
                                    @"msg", @"0092",
                                    @"aid", @"0",
                                    @"dom", @"1",
                                    @"loc", location,
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
                                    @"ntm", @"0",
                                    @"val", @"",
                                    nil]];
}

+(NSURLRequest*) areaBriefingRequestFromArea: (NSString*) area
{
    return [self requestFromArray: [[NSArray alloc] initWithObjects:
                                    @"msg", @"008e",
                                    @"aid", @"0",
                                    @"area", area,
                                    @"area", @"",
                                    @"area", @"",
                                    @"area", @"",
                                    @"met", @"1",
                                    @"ntm", @"0",
                                    @"hon",@"0"
                                    @"val", @"",
                                    nil]];
}


+(NSURLRequest*) requestFromArray: (NSArray*) theArray
{
    
    NSString *postString = [NAIPS POSTStringFromArray:theArray];
    
    //NSLog(@"POST data: %@",postString);
    
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString: [self NAIPS_URL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    return request;

}



+(BOOL) string: (NSString*) aString existsIn: (NSString*) text
{
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:aString options:0 error:nil];
    
     NSArray *matches = [reg matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    if ([matches count] > 0)
    {
        return YES;
    }
    
    return NO;
}

+(NSInteger) NAIPSErrFromString: (NSString*) text
{
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:@"NAIPS err=(\\d)" options:0 error:nil];
    
    NSArray *matches = [reg matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    if ([matches count] > 0)
    {
        NSTextCheckingResult *result = [matches objectAtIndex:0];
        
        if ([result numberOfRanges] == 2)
        {
            NSRange r = [result rangeAtIndex:1];
            
            NSInteger naipsError = [[text substringWithRange:r] integerValue];
            
            return naipsError;
        }
    }
    return -12345;
}

@end
