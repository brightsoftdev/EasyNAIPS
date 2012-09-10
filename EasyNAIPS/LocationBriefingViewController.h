//
//  LocationBriefingViewController.h
//  EasyNAIPS
//
//  Created by Iain Blair on 28/08/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAIPSLocationBriefing.h"

@interface LocationBriefingViewController : UIViewController <NAIPSObjectQueueDelegate>

@property (nonatomic, weak) NAIPSLocationBriefing *brief;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
