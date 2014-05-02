//
//  shareViewController.h
//  synapseTask
//
//  Created by Mac Book on 26/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sharingCell.h"
#import "MessageUI/MFMailComposeViewController.h"
#import <Social/Social.h>
@interface shareViewController : UITableViewController<MFMailComposeViewControllerDelegate>
{
    NSMutableArray *arrImages;
}
@property (strong, nonatomic) IBOutlet UITableView *tblImages;
@end
