//
//  shareViewController.m
//  synapseTask
//
//  Created by Mac Book on 26/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import "shareViewController.h"

@interface shareViewController ()

@end

@implementation shareViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Get saved image from document Directory.
- (void)getImage
{
    if (!arrImages)
    {
        arrImages = [[NSMutableArray alloc]init];
    }else
    {
        [arrImages removeAllObjects];
    }
    
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDir error:nil];
    NSArray *onlyPics = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.png'"]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    for (int i=0; i<[onlyPics count]; i++)
    {
        NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[onlyPics objectAtIndex:i]]];
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        [arrImages addObject:image];
    }
    
    if ([arrImages count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"There is no Saved image."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    [self.tblImages reloadData];
}

- (void)viewDidLoad
{
    [self getImage];
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrImages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
    sharingCell *cell = (sharingCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
    {
        cell = [[sharingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier Delegate:self tag:indexPath.row];
    }
    
    cell.imgPreview.image = [arrImages objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// Share image by e_mail.
-(void)shareOnMail:(id)sender{
    UIButton *btnTemp = (UIButton *)sender;
    
    UIImage *img = [arrImages objectAtIndex:btnTemp.tag];
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        UIImage *savedImage = img;
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(savedImage)];
        [picker addAttachmentData:imageData mimeType:@"image/png" fileName:@"photo"];
        
        NSString *subject = @"Share";
        [picker setSubject:subject];
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

// Share image on FaceBook.
-(void)shareOnSocialFB:(id)sender
{
    UIButton *btnTemp = (UIButton *)sender;
    
    UIImage *img = [arrImages objectAtIndex:btnTemp.tag];
    SLComposeViewController *socialVc=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    [socialVc addImage:[UIImage imageWithData:data]];
    [socialVc setInitialText:@"Testing"];
    [self.navigationController presentViewController:socialVc animated:YES completion:nil];
}

// Share image on Twitter.
-(void)shareOnSocialTW:(id)sender
{
    UIButton *btnTemp = (UIButton *)sender;
    
    UIImage *img = [arrImages objectAtIndex:btnTemp.tag];
    SLComposeViewController *socialVc=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    [socialVc addImage:[UIImage imageWithData:data]];
    [socialVc setInitialText:@"Testing"];
    [self.navigationController presentViewController:socialVc animated:YES completion:nil];
}

@end
