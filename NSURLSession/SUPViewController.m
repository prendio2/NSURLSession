//
//  SUPViewController.m
//  NSURLSession
//
//  Created by Oisin Prendiville on 9/8/13.
//  Copyright (c) 2013 Supertop. All rights reserved.
//

#import "SUPViewController.h"

@interface SUPViewController ()

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSOperationQueue *operationQueue;
@property (nonatomic) NSURLSessionDownloadTask *taskWithCompletionHandler;
@property (nonatomic) NSURLSessionDownloadTask *taskWithoutCompletionHandler;

@end

@implementation SUPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.operationQueue = [[NSOperationQueue alloc]init];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:self.operationQueue];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://resources.usetokens.com/deployed_assets/07092013213943/images/Tokens.iconset/icon_512x512@2x.png"]];
    
    // When I resume this task the delegate methods are never called because it has a completion handler
    self.taskWithoutCompletionHandler = [self.session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"completionHandler");
    }];
    
    // Delegate methods are called as expected on this task without a completion handler
    self.taskWithoutCompletionHandler = [self.session downloadTaskWithRequest:request completionHandler:nil];
    
    [self.taskWithCompletionHandler resume];
    [self.taskWithoutCompletionHandler resume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"didFinishDownloadingToURL %@",location);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (downloadTask == self.taskWithCompletionHandler)
    {
        NSLog(@"didWriteData for task with comletion handler");
    }
    else if (downloadTask == self.taskWithoutCompletionHandler)
    {
        NSLog(@"didWriteDate for task without completion handler");
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{}

@end
