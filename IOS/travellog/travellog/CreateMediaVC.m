//
//  CreateMediaVC.m
//  travellog
//
//  Created by Cullen on 21/6/15.
//  Copyright (c) 2015 Cullen. All rights reserved.
//

#import "CreateMediaVC.h"
#import "UIImage+RotateAndResize.h"

@interface CreateMediaVC ()
@property (nonatomic, weak) IBOutlet UIButton *deleteBtn;
@property (nonatomic, weak) IBOutlet UIImageView *selectedImgView;
@end

@implementation CreateMediaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deleteBtn.hidden = YES;
    
    UIBarButtonItem *newBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = newBtn;

    self.edgesForExtendedLayout = UIRectEdgeNone;

    // Do any additional setup after loading the view.
}


- (void)save:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pickImageFromAlbum:(id)sender{
    //    AppDelegate* delegate= (AppDelegate*) [[UIApplication sharedApplication] delegate];
    //    [delegate presentImagePickerFromAlbumWithDelegate:self];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
- (IBAction)pickImageFromCam:(id)sender{
    //    AppDelegate* delegate= (AppDelegate*) [[UIApplication sharedApplication] delegate];
    //    [delegate presentImagePickerFromCameraWithDelegate:self];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)apicker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // the picture is saved to the momery only, not disk
    UIImage * imagetaken=[info objectForKey:UIImagePickerControllerOriginalImage];
    self.selectedImgView.image=[imagetaken scaleAndRotateImagewithMaxResolution:1024];
    self.deleteBtn.hidden = NO;
    [apicker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)deleteMedia:(UIButton *)sender {
    self.selectedImgView.image = nil;
    sender.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
