//
//  dragDropViewController.h
//  synapseTask
//
//  Created by Mac Book on 25/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dragDropViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *imgArray;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgContainer;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)getImage:(id)sender;
- (IBAction)saveImage:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtText;
@property (strong, nonatomic) IBOutlet UIView *baseView;

@end
