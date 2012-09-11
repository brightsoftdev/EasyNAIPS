//
//  NAIPSLogin.m
//  taf
//
//  Created by Iain Blair on 26/08/12.
//
//

#import "NAIPSLogin.h"
#import "NAIPS.h"

@implementation NAIPSLogin
@synthesize username;
@synthesize password;

-(id) initWithUsername: (NSString*) usernameString AndPassword: (NSString*) passwordString;
{
    // anything is ok for a login.
    self = [super initWithKeyString:@"login"];
    
    if (self)
    {
        username = usernameString;
        password = passwordString;
    }
    
    return self;
}

-(NSURLRequest*) postRequest
{
    return [NAIPS requestFromArray: [[NSArray alloc] initWithObjects:
                                    @"msg", @"0048",
                                    @"usr", username,
                                    @"pwd", password,
                                    nil]];
}


-(void) NAIPSPostConnectionDidFinishLoading
{
   // NSLog(@"NAIPSLogin Finished: %@", [self.post receivedString]);
    text = [NAIPS stringBetweenTagString:@"pre" textWithTags:[self.post receivedString] returnWithTags:YES];

    
     if ([NAIPS string:@"Welcome to NAIPS" existsIn:[self.post receivedString]] == YES)
     {
         error = nil;
     }
     else
     {
         // Lets find out specifically what is wrong
         NSMutableDictionary *details = [NSMutableDictionary dictionary];
         int errorCode;
         
         if ([NAIPS string:@"User Id not entered" existsIn:[self.post receivedString]] == YES)
         {
             [details setValue:@"NAIPS User ID not entered." forKey:NSLocalizedDescriptionKey];
             errorCode = 10;
         }
         else if ([NAIPS string:@"Password not entered" existsIn:[self.post receivedString]] == YES)
         {
             [details setValue:@"NAIPS Password not entered." forKey:NSLocalizedDescriptionKey];
             errorCode = 11;

         }
         else if ([NAIPS string:@"Invalid User ID or Password" existsIn:[self.post receivedString]] == YES)
         {
             [details setValue:@"Invalid User ID or Password." forKey:NSLocalizedDescriptionKey];
             errorCode = 12;

         }
         else if ([NAIPS string:@"Your access to NAIPS is temporarily denied" existsIn:[self.post receivedString]] == YES)
         {
             [details setValue:@"Your NAIPS account has been temporarily suspended." forKey:NSLocalizedDescriptionKey];
             errorCode = 13;
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
 
    // Since this should fail the Q, we have to repackage the error with my own custom error code of 10.
    error = [[NSError alloc] initWithDomain:@"NAIPS" code:10 userInfo:[[self.post connectionError] userInfo]];
    
    // notify queue we are done, the queue can check my error.
    [self.queue objectDone];
}


@end
