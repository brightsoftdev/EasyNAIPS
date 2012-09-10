//
//  NAIPSObjectCell.h
//  EasyNAIPS
//
//  Created by Iain Blair on 30/08/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAIPSObjectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *keyStringLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView* iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *errorImage;
-(void) isError:(BOOL) error;

@end
