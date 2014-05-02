//
//  dragDropViewController.m
//  synapseTask
//
//  Created by Mac Book on 25/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import "dragDropViewController.h"

@interface dragDropViewController ()

@end

@implementation dragDropViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Get documnet directory Path.
- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:name];
}

- (NSMutableArray*)getImageFromDocumentDirectory
{
    NSMutableArray *imageArray  = [[NSMutableArray alloc] init];
    NSError *error;
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *imgs = [NSArray arrayWithArray:[fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]];
    
    for (NSString *str in imgs)
    {
        [imageArray addObject:[UIImage imageNamed:str]];
    }
    
    return imageArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.btnSave.hidden = YES;
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(labelDragged:)];
	
    
    [self.txtText addGestureRecognizer:gesture];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

// Movment of Text.
- (void)labelDragged:(UIPanGestureRecognizer *)gesture
{
    UITextField *label = (UITextField *)gesture.view;
	CGPoint translation = [gesture translationInView:label];
    
	// move label
	label.center = CGPointMake(label.center.x + translation.x,
                               label.center.y + translation.y);
    
	// reset translation
	[gesture setTranslation:CGPointZero inView:label];
}


// get image from gallery.
- (IBAction)getImage:(id)sender
{
    self.txtText.hidden = NO;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    //Deprecated In IOS6[self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    self.btnSave.hidden = NO;
    self.imgContainer.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.txtText becomeFirstResponder];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.txtText.hidden = NO;
   [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.txtText resignFirstResponder];
    return YES;
}

// Get current timestamp for image name.
-(NSString*)getCurrentDateTimeAsNSString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *now = [NSDate date];
    NSString *retStr = [format stringFromDate:now];
    
    return retStr;
}

// Save Image into Document Directory.
- (IBAction)saveImage:(id)sender
{
    CGSize size = [self.baseView bounds].size;
    UIGraphicsBeginImageContext(size);
    [[self.baseView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    self.imgContainer.image = newImage;
    self.txtText.hidden = YES;
    self.txtText.text = @"";
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[self getCurrentDateTimeAsNSString]]];
    UIImage *image = newImage; // imageView is my image from camera
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:NO];
    self.btnSave.hidden = YES;

}

@end
