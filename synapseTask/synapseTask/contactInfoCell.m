//
//  contactInfoCell.m
//  synapseTask
//
//  Created by Mac Book on 25/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import "contactInfoCell.h"

@implementation contactInfoCell
@synthesize lblName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Delegate:(id)del tag:(int)tagValue
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        lblName = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 170, 20)];
        lblName.textColor = [UIColor blackColor];
        lblName.textAlignment = NSTextAlignmentLeft;
        lblName.backgroundColor = [UIColor clearColor];
        [self addSubview:lblName];
        
        btnSMS = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblName.frame)+7, 2, 35, 35)];
        btnSMS.backgroundColor = [UIColor clearColor];
        btnSMS.tag = tagValue;
        [btnSMS setImage:[UIImage imageNamed:@"icon_sms"] forState:UIControlStateNormal];
        [btnSMS addTarget:del action:@selector(sendSMS:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnSMS];
        
        btnCall = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btnSMS.frame)+7, 2, 35, 35)];
        btnCall.backgroundColor = [UIColor clearColor];
        btnCall.tag = tagValue;
        [btnCall setImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateNormal];
        [btnCall addTarget:del action:@selector(makeCall:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCall];
        
        btnEmail = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btnCall.frame)+7, 2, 35, 35)];
        btnEmail.backgroundColor = [UIColor clearColor];
        btnEmail.tag = tagValue;
        [btnEmail setImage:[UIImage imageNamed:@"icon_mail"] forState:UIControlStateNormal];
        [btnEmail addTarget:del action:@selector(sendeMail:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnEmail];
    }
    return self;
}

-(void)sendeMail:(id)sender{
    
}
-(void)makeCall:(id)sender{
    
}
-(void)sendSMS:(id)sender{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
