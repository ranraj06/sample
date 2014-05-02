//
//  sharingCell.m
//  synapseTask
//
//  Created by Mac Book on 26/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import "sharingCell.h"

@implementation sharingCell
@synthesize imgPreview;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Delegate:(id)del tag:(int)tagValue
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        imgPreview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 150, 150)];
        imgPreview.backgroundColor = [UIColor clearColor];
        [self addSubview:imgPreview];
        
        btnMail = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgPreview.frame)+10, 55, 40, 40)];
        btnMail.backgroundColor = [UIColor clearColor];
        btnMail.tag = tagValue;
        [btnMail setImage:[UIImage imageNamed:@"mail_black"] forState:UIControlStateNormal];
        [btnMail addTarget:del action:@selector(shareOnMail:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnMail];
        
        btnSocialFB = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btnMail.frame)+10, 55, 40, 40)];
        btnSocialFB.backgroundColor = [UIColor clearColor];
        btnSocialFB.tag = tagValue;
        [btnSocialFB setImage:[UIImage imageNamed:@"icon_FB"] forState:UIControlStateNormal];
        [btnSocialFB addTarget:del action:@selector(shareOnSocialFB:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnSocialFB];
        
        btnSocialTW = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btnSocialFB.frame)+10, 55, 40, 40)];
        btnSocialTW.backgroundColor = [UIColor clearColor];
        btnSocialTW.tag = tagValue;
        [btnSocialTW setImage:[UIImage imageNamed:@"icon_Twitter"] forState:UIControlStateNormal];
        [btnSocialTW addTarget:del action:@selector(shareOnSocialTW:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnSocialTW];
        
    }
    return self;
}

-(void)shareOnMail:(id)sender{
    
}
-(void)shareOnSocialFB:(id)sender{
    
}
-(void)shareOnSocialTW:(id)sender{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
