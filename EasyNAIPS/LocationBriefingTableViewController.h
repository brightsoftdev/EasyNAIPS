//
//  NAIPSLocationBriefingController.h
//  EasyNAIPS
//
//  Created by Iain Blair on 28/08/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAIPSObjectStore.h"
#import "PullRefreshTableViewController.h"
#import "MBProgressHUD.h"

@interface LocationBriefingTableViewController : PullRefreshTableViewController <NAIPSObjectQueueDelegate>
{
    BOOL isUpdating;
    MBProgressHUD *hud;
    
}

@end
