//
//  contactListViewController.h
//  synapseTask
//
//  Created by Mac Book on 25/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "contactData.h"
#import "contactInfoCell.h"
#import "MessageUI/MFMailComposeViewController.h"
#import <MessageUI/MessageUI.h>

@interface contactListViewController : UITableViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
{
     NSMutableArray *arrayContactList;
}
@property (strong, nonatomic) IBOutlet UITableView *tblContactList;
@end
