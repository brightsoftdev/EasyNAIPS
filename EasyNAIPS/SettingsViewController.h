//
//  SettingsViewController.h
//  EasyNAIPS
//
//  Created by Iain Blair on 3/09/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

@interface SettingsViewController : UITableViewController
{
    KeychainItemWrapper* keyChain;
    __weak UITextField* usernameField;
    __weak UITextField* passwordField;
}

@end
