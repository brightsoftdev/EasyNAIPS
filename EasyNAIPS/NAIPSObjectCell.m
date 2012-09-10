//
//  NAIPSObjectCell.m
//  EasyNAIPS
//
//  Created by Iain Blair on 30/08/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import "NAIPSObjectCell.h"

@implementation NAIPSObjectCell
@synthesize dateLabel;
@synthesize keyStringLabel;
@synthesize descriptionLabel;
@synthesize timeLabel;
@synthesize iconImage;
@synthesize errorImage;

-(void) isError:(BOOL) error
{
    if (error)
    {
        [errorImage setHidden:NO];
    }
    else
    {
        [errorImage setHidden:YES];
    }
}

@end
