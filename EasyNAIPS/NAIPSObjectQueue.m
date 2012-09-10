//
//  NAIPSObjectQueue.m
//  taf
//
//  Created by Iain Blair on 26/08/12.
//
//

#import "NAIPSObjectQueue.h"

@implementation NAIPSObjectQueue

@synthesize delegate;

-(NSArray*) objects
{
    return theQ;
}


-(id) init
{
    self = [super init];
    
    if (self)
    {
        theQ = [[NSMutableArray alloc] init];
        lastStarted = 0;
        isBusy = false;
    }
    return self;
}

-(void) addNAIPSObject:(NAIPSObject *)object
{
    [object setQueue:self];
    [theQ addObject:object];
}

-(void) cancel
{
    // commented out dont know what it does!
    /*if (lastStarted == [theQ count])
    {
        return;
    }*/
    
    NSLog(@"Cancelling...");
    [[[theQ objectAtIndex:lastStarted] post] cancel];
    isBusy = FALSE;
}

-(void) go
{
    NSLog(@"Go!");
    isBusy = TRUE;
    [[[theQ objectAtIndex:lastStarted] post] go];
}

-(void) objectDone
{
    [delegate queueJustFinished:lastStarted];
    NAIPSObject *o = [theQ objectAtIndex:lastStarted];
    
    if ([o error] != nil)
    {
        // lets say that error codes over 10 should stop the Q.
        if ([[o error] code] >= 10)
        {
            isBusy = FALSE;
            [delegate queueFailedAt:lastStarted];
            return;
        }
    }
    
    
    lastStarted++;
    
    if (lastStarted == [theQ count])
    {
        isBusy = FALSE;
        [delegate queueDidFinish];
        return;
    }
    
    [self go];
}

-(BOOL) isBusy
{
    return isBusy;
}


@end
