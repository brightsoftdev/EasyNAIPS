//
//  NAIPSObjectStore.h
//  taf
//
//  Created by Iain Blair on 26/08/12.
//
//

#import "NAIPSObject.h"
#import "NAIPSObjectQueue.h"
#import "NAIPSLocationBriefing.h"

@interface NAIPSObjectStore : NAIPSObject
{
    // this works for now, but we need to have 3 arrays or something.
    NSMutableDictionary *allObjects;
    NAIPSObjectQueue *q;
    
}

+(NAIPSObjectStore*) sharedStore;

-(NSString*) itemArchivePath;

-(NSMutableDictionary*) allObjects;

-(BOOL) saveChanges;

-(void) cancelQueue;

-(void) updateObjectsForKey: (NSString*) theKey queueDelegate: (id<NAIPSObjectQueueDelegate>) delegate;
-(NSArray*) locationBriefs;
-(BOOL) updateLocationBrief: (NAIPSLocationBriefing*) brief queueDelegate: (id<NAIPSObjectQueueDelegate>) delegate;

-(void) removeLocationBrief: (NAIPSLocationBriefing*) brief;

@property (nonatomic, strong) NAIPSObject *loginObject;

@end
