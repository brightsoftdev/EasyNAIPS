//
//  SettingsViewController.m
//  EasyNAIPS
//
//  Created by Iain Blair on 3/09/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsTextInputCell.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Settings"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"settings.png"]];
        
        keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:@"NAIPS" accessGroup:nil];
        
        [keyChain setObject:@"NAIPS" forKey:(__bridge_transfer id)kSecAttrService];
    }
    return self;
}

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
            return 2;
            break;
    }
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case (0):
            return @"NAIPS Login";
            break;
    }
    return nil;
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    switch (section) {
        case (0):
            return @"Enter your NAIPS username and password above.";
            break;
    }
    return nil;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingsTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsTextInputCell"];

    [[cell cellTextField] setDelegate:cell];
    
    
    switch ([indexPath row]) {
        case 0:
            
            [[cell cellLabel] setText:@"Username"];

           
            [[cell cellTextField] setSecureTextEntry:NO];
             [[cell cellTextField] setText:[keyChain objectForKey:(__bridge_transfer id)kSecAttrAccount]];
            
            [[cell cellTextField] setPlaceholder:@"Username"];
            usernameField = [cell cellTextField];
            
            break;
        case 1:
            [[cell cellLabel] setText:@"Password"];
            
           
            [[cell cellTextField] setSecureTextEntry:YES];
            [[cell cellTextField] setText:[keyChain objectForKey:(__bridge_transfer id)kSecValueData]];
            
            [[cell cellTextField] setPlaceholder:@"Password"];
            
            passwordField = [cell cellTextField];
        default:
            break;
    }
    return cell;
}

-(void) viewWillDisappear:(BOOL)animated
{

    [keyChain setObject:usernameField.text forKey:(__bridge_transfer id)kSecAttrAccount];
    [keyChain setObject:passwordField.text forKey:(__bridge_transfer id)kSecValueData];
    
    [super viewWillDisappear:animated];
}


@end
