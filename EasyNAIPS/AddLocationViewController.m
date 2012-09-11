//
//  AddLocationViewController.m
//  EasyNAIPS
//
//  Created by Iain Blair on 5/09/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import "AddLocationViewController.h"
#import "SettingsTextInputCell.h"
#import "NAIPSObjectStore.h"
#import "NAIPSLocationBriefing.h"
@implementation AddLocationViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"SettingsTextInputCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"SettingsTextInputCell"];
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    return self;
}


-(id) init
{
    self = [super init];
    
    if (self)
    {
    
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        [[self navigationItem] setLeftBarButtonItem:cancelItem];
        
        [self setTitle:@"Add Location"];
    }
    
    return self;
    
}

-(void) cancel:(id)sender
{
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case (0):
            return 1;
            break;
    }
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case (0):
            return @"Location";
            break;
    }
    return nil;
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    switch (section) {
        case (0):
            return @"Enter the location?blah ICAO?";
            break;
    }
    return nil;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingsTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsTextInputCell"];
    
    [[cell cellTextField] setDelegate:self];
    
    
            [[cell cellLabel] setText:@"Identifier"];
            [[cell cellTextField] setSecureTextEntry:NO];
    [[cell cellTextField] setAutocapitalizationType: UITextAutocapitalizationTypeAllCharacters];
    
            [[cell cellTextField] setPlaceholder:@"Identifier"];
    if (startingField == nil)
    {
        startingField = [cell cellTextField];
        [startingField becomeFirstResponder];
    }


    return cell;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    // more checks here
    NAIPSLocationBriefing *loc = [[NAIPSLocationBriefing alloc] initWithKeyString:textField.text];
    
    [[[[NAIPSObjectStore sharedStore] allObjects] objectForKey:@"locationBriefing"] addObject:loc];
    
    [[NAIPSObjectStore sharedStore] saveChanges];
    
    [textField resignFirstResponder];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    return YES;

}

@end
