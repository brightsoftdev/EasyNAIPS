//
//  AirportViewController.m
//  taf
//
//  Created by Iain Blair on 4/08/12.
//
//

#import "AddLocationBriefingViewController.h"
#import "NAIPSObjectStore.h"
#import "NAIPSLocationBriefing.h"

@implementation AddLocationBriefingViewController
@synthesize airportLabel;

-(void) cancel:(id)sender
{
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

-(void) done:(id)sender
{
    
   
    // more checks here
    NAIPSLocationBriefing *loc = [[NAIPSLocationBriefing alloc] initWithKeyString:airportLabel.text];
    
    [[[[NAIPSObjectStore sharedStore] allObjects] objectForKey:@"locationBriefing"] addObject:loc];
    
    [[NAIPSObjectStore sharedStore] saveChanges];
    
     [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    [airportLabel becomeFirstResponder];
}

-(id) init
{
    self = [super init];
    
    if (self)
    {
        
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
            
            [[self navigationItem] setRightBarButtonItem:doneItem];
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
            
        [self setTitle:@"Add Location"];
    }
    
    return self;

}

- (void)viewDidUnload {
    [self setAirportLabel:nil];
    [super viewDidUnload];
}
@end
