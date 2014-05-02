//
//  sharingCell.h
//  synapseTask
//
//  Created by Mac Book on 26/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sharingCell : UITableViewCell
{
    UIImageView *imgPreview;
    UIButton *btnSocialFB,*btnMail,*btnSocialTW;
}
@property(nonatomic,retain) UIImageView *imgPreview;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Delegate:(id)del tag:(int)tagValue;
-(void)shareOnMail:(id)sender;
-(void)shareOnSocialFB:(id)sender;
-(void)shareOnSocialTW:(id)sender;
@end
