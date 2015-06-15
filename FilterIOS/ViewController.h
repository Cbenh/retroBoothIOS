//
//  ViewController.h
//  FilterIOS
//
//  Created by camille benhamou on 22/04/2015.
//  Copyright (c) 2015 camille benhamou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) CIImage *filteredImageData;

- (IBAction)library:(id)sender;
- (IBAction)takePic:(id)sender;
- (IBAction)save:(id)sender;

@end

