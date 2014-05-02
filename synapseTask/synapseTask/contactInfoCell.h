//
//  contactInfoCell.h
//  synapseTask
//
//  Created by Mac Book on 25/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contactInfoCell : UITableViewCell
{
    UILabel *lblName;
    UIButton *btnSMS,*btnCall,*btnEmail;
}
@property(nonatomic,retain) UILabel *lblName;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Delegate:(id)del tag:(int)tagValue;
-(void)sendeMail:(id)sender;
-(void)makeCall:(id)sender;
-(void)sendSMS:(id)sender;
@end
