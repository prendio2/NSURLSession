//
//  SUPViewController.m
//  NSURLSession
//
//  Created by Oisin Prendiville on 9/8/13.
//  Copyright (c) 2013 Supertop. All rights reserved.
//

#import "SUPViewController.h"
#import "AFNetworking.h"

@interface SUPViewController ()

@property (nonatomic) AFURLSessionManager *sessionManager;

@end

@implementation SUPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *medium_request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://resources.usetokens.com/deployed_assets/07092013213943/images/Tokens.iconset/icon_512x512@2x.png"]];
    NSURLRequest *small_request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://resources.usetokens.com/deployed_assets/07092013213943/images/Tokens.iconset/icon_16x16@2x.png"]];
    
    self.sessionManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.sessionManager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [[self.sessionManager downloadTaskWithRequest:medium_request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSLog(@"destination %@",targetPath);
        return nil;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"completionHandler %@ %@ %@",response, filePath, error);
    }] resume];
    
    [[self.sessionManager downloadTaskWithRequest:small_request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSLog(@"destination %@",targetPath);
        return nil;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"completionHandler %@ %@ %@",response, filePath, error);
    }] resume];
    
    [self.sessionManager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        CGFloat progress = (CGFloat)totalBytesWritten/totalBytesExpectedToWrite;
        NSLog(@"downloadTaskDidWrite %f <%@>",progress,downloadTask);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
