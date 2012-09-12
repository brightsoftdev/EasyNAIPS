//
//  LocationBriefingViewController.m
//  EasyNAIPS
//
//  Created by Iain Blair on 28/08/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import "LocationBriefingViewController.h"
#import "NAIPSObjectStore.h"
#import "MBProgressHUD.h"
@interface LocationBriefingViewController ()

@end

@implementation LocationBriefingViewController
@synthesize brief;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
        
        [[self navigationItem] setRightBarButtonItem:bbi];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:[brief keyString]];
    [webView loadHTMLString:[brief text] baseURL:nil];
    
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NAIPSObjectStore sharedStore] cancelQueue];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud hide:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
   
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (YES);
}

-(void) refresh
{
    
    if ([[NAIPSObjectStore sharedStore] updateLocationBrief:brief queueDelegate:self])
    {
        // q started.. look to delegates now...
        NSLog(@"**** Q started ****");
        
        hud = [[MBProgressHUD alloc] initWithView:webView];
        [self.webView addSubview:hud];

        
        hud.labelText = @"Updating...";
        [hud show:YES];
        
    }
    else
    {
        // the queue is busy...
        NSLog(@"********Busy*********");

    }
}

-(void) queueDidFinish
{
    NSLog(@"Q fin!");
    [webView loadHTMLString:[brief text] baseURL:nil];
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
	// Set custom view mode
	hud.mode = MBProgressHUDModeCustomView;
    
	hud.labelText = @"Completed";
    
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud hide:YES afterDelay:0.6];
 
}

-(void) queueFailedAt:(NSInteger)index
{

    NSLog(@"q fail");
}

-(void) queueJustFinished:(NSInteger)index
{
    
}

-(void) queueJustStarted:(NSInteger)index
{
    
}


@end
