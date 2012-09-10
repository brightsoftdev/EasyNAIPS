//
//  SettingsTextInputCell.h
//  EasyNAIPS
//
//  Created by Iain Blair on 5/09/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsTextInputCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;


@property (weak, nonatomic) IBOutlet UITextField *cellTextField;


@end
