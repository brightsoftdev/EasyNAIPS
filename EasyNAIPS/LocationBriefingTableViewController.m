//
//  NAIPSLocationBriefingController.m
//  EasyNAIPS
//
//  Created by Iain Blair on 28/08/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import "LocationBriefingTableViewController.h"

#import "NAIPSObjectStore.h"
#import "NAIPSLocationBriefing.h"

#import "AddLocationBriefingViewController.h"
#import "AddLocationViewController.h"

#import "LocationBriefingViewController.h"

#import "NAIPSObjectCell.h"

@implementation LocationBriefingTableViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self)
    {
        [self setTitle: @"Location Briefs"];
        
        [[self tabBarItem] setImage:[UIImage imageNamed:@"push_pin.png"]];
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addLocationBriefing:)];
        
        [[self navigationItem] setRightBarButtonItem:bbi];
        
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
        
        isUpdating = NO;
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"NAIPSObjectCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"NAIPSObjectCell"];
    
    
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationBriefingViewController *vc = [[LocationBriefingViewController alloc] init];
    
    NAIPSLocationBriefing *brief = [[[NAIPSObjectStore sharedStore] locationBriefs] objectAtIndex:[indexPath row]];
    
    
    [vc setBrief:brief];
    
    [[self navigationController] pushViewController:vc animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
    
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59.0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[NAIPSObjectStore sharedStore] locationBriefs] count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NAIPSObjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NAIPSObjectCell"];
    
    
    NSArray* a = [[NAIPSObjectStore sharedStore] locationBriefs];

    
    NAIPSObject* o = [a objectAtIndex:[indexPath row]];
    
    
    [[cell keyStringLabel] setText:[o keyString]];
    [[cell descriptionLabel] setText:[o keyStringDescription]];
    
    [[cell timeLabel] setText:[o shortTimestampString]];
    [[cell dateLabel] setText:[o dateString]];
    
    if ([o error] != nil)
    {
        [cell isError:YES];
    }
    else
    {
        [cell isError:NO];
    }
    
    return cell;
}

-(void) addLocationBriefing:(id)sender
{
    AddLocationViewController *vc = [[AddLocationViewController alloc] init];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        
    [self  presentViewController:nc animated:YES completion:nil];
}

-(void) queueDidFinish
{
    isUpdating = NO;
    [super stopLoading];
    
    NSLog(@"Q fin!");
    
}

-(void) queueFailedAt:(NSInteger)index
{
    
    isUpdating = NO;
    [super stopLoading];
    
    NSLog(@"%i",index);
    
    
    if (index == -1)
    {
        // this is a login error so we should look at the store login object
         [[[UIAlertView alloc] initWithTitle:@"Login Error" message: [[[[NAIPSObjectStore sharedStore] loginObject] error] localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else
    {
    
    [[[UIAlertView alloc] initWithTitle:@"Briefing Error" message: [[[[[NAIPSObjectStore sharedStore] locationBriefs] objectAtIndex:index] error] localizedDescription]delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    
    }

    //NSLog(@"Q failed at: %i\nReason: %@", index, [[[[q objects] objectAtIndex:index] error] localizedDescription]);
  
}

-(void) queueJustFinished:(NSInteger)index
{
    [[self tableView] reloadData];

}

-(void) cancelRefresh
{
    
    isUpdating = NO;
    [[NAIPSObjectStore sharedStore] cancelQueue];
    [super stopLoading];
}


-(void)refresh
{
    
    isUpdating = YES;
    [[NAIPSObjectStore sharedStore] updateObjectsForKey:@"locationBriefing" queueDelegate:self];
}



- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((editingStyle == UITableViewCellEditingStyleDelete) && (!isUpdating))
    {
        NAIPSObjectStore* store = [NAIPSObjectStore sharedStore];
        
        [store removeLocationBrief:[[store locationBriefs] objectAtIndex:[indexPath row]] ];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
     
    }
}


@end
