//
//  UIImageView+LJImageView.m
//  LJYYG
//
//  Created by 李明明 on 2017/8/4.
//  Copyright © 2017年 youwillcatch. All rights reserved.
//

#import "UIImageView+LJImageView.h"
#import <objc/runtime.h>

#define kCacheImagePath @"ljcacheimage"

@implementation UIImageView (LJImageView)

- (void)ljSetImageWithUrlStr:(NSString *)urlStr
{
    [self ljSetImageWithUrlStr:urlStr holderImage:nil];
}

- (void)ljSetImageWithUrlStr:(NSString *)urlStr holderImage:(NSString *)holderImage
{
    if (!self.tasks)
    {
        self.tasks = [NSMutableArray array];
    }
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.tasks];
    for (int i = 0; i < self.tasks.count; i++)
    {
        if (i != self.tasks.count) {
            NSURLSessionTask *task = self.tasks[i];
            [task cancel];
            [arr removeObject:task];
        }
    }
    self.tasks = arr;
    
    self.image = [UIImage imageNamed:holderImage];
    if (!urlStr || urlStr.length == 0)
    {
        [self loadHolderImage:holderImage];
    }else
    {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *path = [UIImageView ljCachePathWithCreate:NO];
        NSString *fileName = [self dealWithUrl:urlStr];
        path = [path stringByAppendingPathComponent:fileName];
        if ([manager fileExistsAtPath:path])
        {
            self.image = [UIImage imageWithContentsOfFile:path];
        }else
        {
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15];
            dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
                NSURLSessionTask *task = nil;
                task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error)
                        {
                            [self loadHolderImage:holderImage];
                        }else {
                            self.image = [UIImage imageWithData:data];
                            [self saveImg:data withName:urlStr];
                        }
                        [self.tasks removeObject:task];
                    });
                }];
                [task resume];
                [self.tasks addObject:task];
            });
        }
    }
}

- (void)saveImg:(NSData *)data withName:(NSString *)name
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [UIImageView ljCachePathWithCreate:YES];
    NSString *fileName = [self dealWithUrl:name];
    path = [path stringByAppendingPathComponent:fileName];
    if (![manager fileExistsAtPath:path])
    {
        [manager createFileAtPath:path contents:nil attributes:nil];
    }
    [data writeToFile:path atomically:YES];
}

- (NSString *)dealWithUrl:(NSString *)url
{
    NSString *tmpStr = [[url componentsSeparatedByString:@"://"] lastObject];
    return [tmpStr stringByReplacingOccurrencesOfString:@"/" withString:@"."];
}

- (void)loadHolderImage:(NSString *)holderImage
{
    self.image = [UIImage imageNamed:holderImage];
}

+ (NSInteger)ljCacheSize 
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [self ljCachePathWithCreate:YES];
    NSArray *files = [manager contentsOfDirectoryAtPath:path error:nil];
    BOOL cd = [manager changeCurrentDirectoryPath:path];
    NSInteger size = 0;
    if (files.count > 0) {
        if (cd) {
            for (NSString *file in files)
            {
                NSDictionary<NSString *, id> *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:file error:nil];
                size += [dic fileSize];
            }
        }else
        {
            for (NSString *file in files)
            {
                NSString *tmpPath = [path stringByAppendingPathComponent:file];
                NSDictionary<NSString *, id> *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:tmpPath error:nil];
                size += [dic fileSize];
            }
        }
    }
    return size;
}

+ (NSString *)ljCachePathWithCreate:(BOOL)isCreate
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:kCacheImagePath];
    BOOL isDir;
    [manager fileExistsAtPath:path isDirectory:&isDir];
    if (isCreate && !isDir)
    {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (void)ljClearCache
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [self ljCachePathWithCreate:NO];
    BOOL isDir;
    [manager fileExistsAtPath:path isDirectory:&isDir];
    if (isDir)
    {
        NSArray *files = [manager contentsOfDirectoryAtPath:path error:nil];
        BOOL cd = [manager changeCurrentDirectoryPath:path];
        if (cd)
        {
            for (NSString *file in files)
            {
                [manager removeItemAtPath:file error:nil];
            }
        }else
        {
            for (NSString *file in files)
            {
                NSString *tmpPath = [path stringByAppendingPathComponent:file];
                [manager removeItemAtPath:tmpPath error:nil];
            }
        }
    }else
    {
    }
}

- (void)setTasks:(NSMutableArray *)tasks
{
    objc_setAssociatedObject(self, @selector(tasks), tasks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)tasks
{
    return objc_getAssociatedObject(self, @selector(tasks));
}

@end

