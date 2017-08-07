//
//  LImageCacheCell.m
//  LWidget
//
//  Created by 李明明 on 2017/8/7.
//  Copyright © 2017年 李明明. All rights reserved.
//

#import "LImageCacheCell.h"
#import "UIImageView+LJImageView.h"

@interface LImageCacheCell ()
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@end

@implementation LImageCacheCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)loadInfo:(id)info 
{
    [self.imgView ljSetImageWithUrlStr:info];
}

@end
