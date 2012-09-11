//
//  NAIPSObjectStore.m
//  taf
//
//  Created by Iain Blair on 26/08/12.
//
//

#import "NAIPSObjectStore.h"
#import "NAIPSObjectQueue.h"
#import "NAIPSLogin.h"
#import "NAIPSLocationBriefing.h"

#import "KeychainItemWrapper.h"

@implementation NAIPSObjectStore
@synthesize loginObject;

+ (NAIPSObjectStore*) sharedStore
{
    static NAIPSObjectStore *sharedStore = nil;
    
    if (!sharedStore)
    {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+(id) allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

-(NSString*) itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"easynaips.archive"];
    
}

-(NSMutableDictionary*) allObjects
{
    return allObjects;
}

-(NSArray*) locationBriefs
{
    return  [allObjects objectForKey:@"locationBriefing"];
}

-(BOOL) saveChanges
{
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:allObjects toFile:path];
}

-(void) updateObjectsForKey:(NSString *)theKey queueDelegate: (id<NAIPSObjectQueueDelegate>) delegate
{
   
    NSMutableArray *a = [allObjects objectForKey:theKey];
    
    if ([a count] == 0)
    {
        return;
    }
    
    q = [[NAIPSObjectQueue alloc] init];
    [q setDelegate:delegate];
    
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:@"NAIPS" accessGroup:nil];
    
    
    
     loginObject = [[NAIPSLogin alloc] initWithUsername:[keyChain objectForKey:(__bridge_transfer id)kSecAttrAccount] AndPassword:[keyChain objectForKey:(__bridge_transfer id)kSecValueData]];
    
    [q addNAIPSObject:loginObject];
    
    for (NAIPSLocationBriefing *l in a)
     {
     [q addNAIPSObject:  l ];
     }


    [q go];
}

-(id) init
{
    self = [super init];
    
    if (self)
    {
        NSString* path = [self itemArchivePath];
        
        allObjects = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!allObjects)
        {
            allObjects = [[NSMutableDictionary alloc] init];
            
            // We must add entries here if we subclass from NAIPSObject.
            NSMutableArray *locationBriefingArray = [[NSMutableArray alloc] init];
            NSMutableArray *areaBriefingArray = [[NSMutableArray alloc] init];
            
            [allObjects setValue:locationBriefingArray forKey:@"locationBriefing"];
            
             [allObjects setValue:areaBriefingArray forKey:@"areaBriefing"];

        }
    }
    return self;
}

-(BOOL) updateLocationBrief: (NAIPSLocationBriefing*) brief queueDelegate: (id<NAIPSObjectQueueDelegate>) delegate
{
    
    if (![q isBusy])
    {
        q = [[NAIPSObjectQueue alloc] init];
    
        [q setDelegate:delegate];
    
    NAIPSLogin *login = [[NAIPSLogin alloc] initWithUsername:@"makeliftnotwar" AndPassword:@"3184"];
    
        [q addNAIPSObject:login];
    
        [q addNAIPSObject:brief];
        
        [q go];
        
        return YES;
    
    }
    else
    {
        // come back later...
        return NO;
    }
}

-(void) cancelQueue
{
    [q cancel];
}

-(void) removeLocationBrief: (NAIPSLocationBriefing*) brief
{
    [[[self allObjects] objectForKey:@"locationBriefing"] removeObjectIdenticalTo:brief];
}

@end
