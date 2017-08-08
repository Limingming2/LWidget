//
//  UIImageView+LJImageView.h
//  LJYYG
//
//  Created by 李明明 on 2017/8/4.
//  Copyright © 2017年 youwillcatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LJImageView)

- (void)ljSetImageWithUrlStr:(NSString *)urlStr;

- (void)ljSetImageWithUrlStr:(NSString *)urlStr holderImage:(NSString *)holderImage;

+ (void)ljClearCache;

+ (NSInteger)ljCacheSize;


@property (nonatomic, strong) NSMutableArray *tasks;

@end
