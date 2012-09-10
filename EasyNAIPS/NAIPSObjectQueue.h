//
//  NAIPSObjectQueue.h
//  taf
//
//  Created by Iain Blair on 26/08/12.
//
//

#import <Foundation/Foundation.h>
#import "NAIPSObject.h"

@class NAIPSObject;

@protocol NAIPSObjectQueueDelegate <NSObject>

-(void) queueDidFinish;
-(void) queueFailedAt: (NSInteger) index;
-(void) queueJustFinished: (NSInteger) index;
@end




@interface NAIPSObjectQueue : NSObject
{
    NSMutableArray* theQ;
    NSInteger lastStarted;
    BOOL isBusy;
}

@property (nonatomic, weak) id<NAIPSObjectQueueDelegate> delegate;

-(void) addNAIPSObject: (NAIPSObject*) object;

-(void) cancel;
-(void) go;

-(void) objectDone;
-(NSArray*) objects;

-(BOOL) isBusy;

@end
