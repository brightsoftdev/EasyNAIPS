//
//  SettingsTextInputCell.m
//  EasyNAIPS
//
//  Created by Iain Blair on 5/09/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import "SettingsTextInputCell.h"

@implementation SettingsTextInputCell
@synthesize cellLabel;
@synthesize cellTextField;


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
