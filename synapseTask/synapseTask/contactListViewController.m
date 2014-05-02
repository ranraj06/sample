//
//  contactListViewController.m
//  synapseTask
//
//  Created by Mac Book on 25/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import "contactListViewController.h"

@interface contactListViewController ()

@end

@implementation contactListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self getContactList];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self performSelector:@selector(reloadTable) withObject:nil afterDelay:1.0];
    [super viewWillAppear:animated];
    
}

-(void)reloadTable
{
    [self.tblContactList reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Get contact list from Device.
-(void)getContactList
{
    CFErrorRef  error;
    __block BOOL accessGranted;
    ABAddressBookRef myAddressBook = ABAddressBookCreateWithOptions(NULL,&error);
    ABAddressBookRequestAccessWithCompletion(myAddressBook, ^(bool granted, CFErrorRef error)
                                             {
                                                 if (!accessGranted && !granted)
                                                 {
                                                     UIAlertView  *alertViewDeny = [[UIAlertView alloc]initWithTitle:@"Deny Access" message:@"Deny" delegate:self cancelButtonTitle:nil otherButtonTitles:@"cancel", nil];
                                                     [alertViewDeny show];
                                                 }
                                                 else
                                                 {
                                                     ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
                                                     ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
                                                     CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByFirstName);
                                                     CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
                                                     
                                                     if (!arrayContactList) {
                                                         arrayContactList = [[NSMutableArray alloc]init];
                                                     }else
                                                     {
                                                         [arrayContactList removeAllObjects];
                                                     }
                                                     
                                                     for (int i = 0; i < nPeople; i++)
                                                     {
                                                         
                                                         ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
                                                         
                                                         contactData *contactObj = [[contactData alloc]init];
                                                         
                                                         if (ABRecordCopyValue(person, kABPersonFirstNameProperty)) {
                                                             contactObj.strFirstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
                                                         }
                                                         
                                                         if (ABRecordCopyValue(person, kABPersonLastNameProperty)) {
                                                            contactObj.strLastName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
                                                         }
                                                         
                                                         
                                                         if (!contactObj.strFirstName) {
                                                             contactObj.strFirstName = @"";
                                                         }
                                                         if (!contactObj.strLastName) {
                                                             contactObj.strLastName = @"";
                                                         }
                                                         
                                                         //get Contact number
                                                         
                                                         ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
                                                         for(CFIndex i=0;i<ABMultiValueGetCount(multiPhones);i++)
                                                         {
                                                             if (ABMultiValueCopyValueAtIndex(multiPhones, i)!=nil)
                                                             {
                                                             CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
                                                             contactObj.strPhone = (__bridge NSString *) phoneNumberRef;
                                                                 break;
                                                             }
                                                         }
                                                         
                                                         
                                                         //get Contact email
                                                         
                                                         ABMultiValueRef multiEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
                                                         
                                                         for (CFIndex i=0; i<ABMultiValueGetCount(multiEmails); i++)
                                                         {
                                                             if (ABMultiValueCopyValueAtIndex(multiEmails, i)!=nil)
                                                             {
                                                             CFStringRef contactEmailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
                                                             contactObj.streMail = (__bridge NSString *)contactEmailRef;
                                                             break;
                                                             }
                                                         }
                                                         
                                                         [arrayContactList addObject:contactObj];
                                                     }
                                                 }
                                                  [self.tblContactList reloadData];
                                             });
}


// Performing Calling Action.
-(void)makeCall:(id)sender
{
    UIButton *btnTemp = (UIButton *)sender;
    
    contactData *dataOBJ = [arrayContactList objectAtIndex:btnTemp.tag];

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:+11111"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",dataOBJ.strPhone]]];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Device have no facility of making call or Phone number is not valid" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

// Send SMS to given Number.
-(void)sendSMS :(id)sender
{
    UIButton *btnTemp = (UIButton *)sender;
    
    contactData *dataOBJ = [arrayContactList objectAtIndex:btnTemp.tag];
    
    if([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setRecipients:[NSArray arrayWithObjects:dataOBJ.strPhone, nil]];
        [self presentViewController:messageController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support message facility"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

// Send Mail.
-(void)sendeMail:(id)sender
{
    UIButton *btnTemp = (UIButton *)sender;
    
    contactData *dataOBJ = [arrayContactList objectAtIndex:btnTemp.tag];
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        NSString *subject = @"Feedback";
        [picker setSubject:subject];
        [picker setToRecipients:[NSArray arrayWithObject:dataOBJ.streMail]];
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}



- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
  
    NSString *strMessage;
    
    switch (result) {
        case MessageComposeResultCancelled:
            strMessage = @"Message has been Cancelled.";
            break;
        case MessageComposeResultSent:
            strMessage = @"Message Sent Successfully";
            break;
        case MessageComposeResultFailed:
            strMessage = @"Message has been Failed.";
            break;
            
        default:
            break;
    }
      [self dismissViewControllerAnimated:YES completion:nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:strMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{


    NSString *strMessage;
    
    switch (result) {
        case MFMailComposeResultCancelled:
            strMessage = @"Mail has been Cancelled.";
            break;
        case MFMailComposeResultSent:
            strMessage = @"Mail Sent Successfully";
            break;
        case MFMailComposeResultFailed:
            strMessage = @"Mail has been Failed.";
            break;
        case MFMailComposeResultSaved:
            strMessage = @"Mail has been Saved.";
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:strMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


#pragma mark - UITableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayContactList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
    contactInfoCell *cell = (contactInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[contactInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier Delegate:self tag:indexPath.row];
    }
    
    contactData *dataOBJ = [arrayContactList objectAtIndex:indexPath.row];
    
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@",dataOBJ.strFirstName,dataOBJ.strLastName];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
