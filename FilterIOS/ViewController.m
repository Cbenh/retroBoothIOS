//
//  ViewController.m
//  FilterIOS
//
//  Created by camille benhamou on 22/04/2015.
//  Copyright (c) 2015 camille benhamou. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController {
    CGImageRef cgimg;
    UIImageOrientation orientation;
    UIImage *filteredImage;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.save.hidden = YES;
    self.imageView.hidden = YES;

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]]];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)library:(id)sender {
    
    UIImagePickerController *imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}

- (IBAction)takePic:(id)sender {
    
    UIImagePickerController *imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];

}

- (IBAction)save:(id)sender {
   
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgimg
                                 metadata:[self.filteredImageData properties]
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              CGImageRelease(cgimg);
                          }];

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your picture has been saved"
                                                    message:@"You can find your filtred picture in your library"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    self.save.hidden = NO;
    self.imageView.hidden = NO;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"retro-wallpaper 2.jpg"]]];
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    orientation = originalImage.imageOrientation;
    
    CIImage *rawImageData;
    rawImageData = [CIImage imageWithCGImage:originalImage.CGImage];
    
    CIContext *context = [CIContext
                          contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)} ];
    
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey,rawImageData,@"inputIntensity", @0.8, nil];
    
    
    self.filteredImageData = [filter valueForKey:@"outputImage"];
    
    cgimg =[context createCGImage:self.filteredImageData fromRect:[self.filteredImageData extent]];
    
    
    filteredImage = [[UIImage alloc] initWithCGImage:cgimg scale:1.0 orientation:orientation];
    
    UIColor *borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    [self.imageView.layer setBorderColor:borderColor.CGColor];
    [self.imageView.layer setBorderWidth:3.0];
    
    self.imageView.image  = filteredImage;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
  }



@end
