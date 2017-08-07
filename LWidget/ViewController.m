//
//  ViewController.m
//  LWidget
//
//  Created by 李明明 on 2017/8/7.
//  Copyright © 2017年 李明明. All rights reserved.
//

#import "ViewController.h"
#import "LImageCacheCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *resueStr = @"imagecachereuse";
    LImageCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:resueStr];
    [cell loadInfo:self.dataArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

#pragma mark - setter and getter

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"http://pic.nipic.com/2007-12-17/20071217131733113_2.jpg",
                       @"http://pic25.photophoto.cn/20121216/0010023956779853_b.jpg",
                       @"http://pic22.nipic.com/20120701/10315940_111456383183_2.jpg",
                       @"http://pic2.16pic.com/00/07/80/16pic_780640_b.jpg",
                       @"http://pic40.nipic.com/20140411/11083261_154516373000_2.jpg",
                       @"http://pic31.nipic.com/20130702/11884402_125218001387_2.jpg",
                       @"http://pic26.photophoto.cn/20130310/0021033885191753_b.jpg",
                       @"http://pic.58pic.com/58pic/11/39/22/38c58PICtuS.jpg",
                       @"http://imgsrc.baidu.com/imgad/pic/item/908fa0ec08fa513d4e3de6fb376d55fbb2fbd904.jpg",
                       @"http://imgsrc.baidu.com/imgad/pic/item/c995d143ad4bd113780c5a1750afa40f4afb05d5.jpg",
                       @"http://imgsrc.baidu.com/imgad/pic/item/2cf5e0fe9925bc312f6929bb54df8db1cb1370d8.jpg",
                       @"http://pic14.photophoto.cn/20100325/0010023565924970_b.jpg",
                       @"http://pic.35pic.com/normal/09/19/05/14151964_201027677000_2.jpg",
                       @"http://pic13.nipic.com/20110419/5077493_180019386311_2.jpg",
                       @"http://pic.58pic.com/58pic/13/19/35/72h58PICxR9_1024.jpg",
                       @"http://img3.redocn.com/tupian/20151014/katongbeijingtupian_5086318.jpg",
                       @"http://pic15.nipic.com/20110708/7843095_103004548386_2.jpg",
                       @"http://pic.58pic.com/58pic/14/03/69/93658PICJMN_1024.jpg",
                       @"http://pic32.photophoto.cn/20140815/0017029190714317_b.jpg",
                       @"http://pic33.photophoto.cn/20141030/0005018378281009_b.jpg",
                       @"http://pic.58pic.com/58pic/16/59/96/66K58PICFnM_1024.jpg",
                       @"http://img4.duitang.com/uploads/blog/201512/12/20151212120309_BduTC.thumb.700_0.jpeg"
                       ];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
