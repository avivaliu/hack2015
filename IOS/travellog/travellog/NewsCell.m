//
//  NewsCell.m
//  travellog
//
//  Created by Cullen on 20/6/15.
//  Copyright (c) 2015 Cullen. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"

@interface NewsCell ()

@property (nonatomic, weak) IBOutlet UIImageView *coverImg;

@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UIImageView *authorProfileImg;
@property (nonatomic, weak) IBOutlet UILabel *briefLbl;

@property (nonatomic, weak) IBOutlet UIButton *durationBtn;
@property (nonatomic, weak) IBOutlet UIButton *locationBtn;


@end


@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
    //[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.durationBtn.userInteractionEnabled = NO;
    self.locationBtn.userInteractionEnabled = NO;

    self.authorProfileImg.layer.cornerRadius = CGRectGetHeight(self.authorProfileImg.bounds)/2.0;
    self.authorProfileImg.layer.masksToBounds = YES;
    self.authorProfileImg.layer.backgroundColor = [UIColor whiteColor].CGColor;

}

- (void)setItem:(NewsItem *)item {
    _item = item;
    [self configCellWithItem:item];
}

- (void)configCellWithItem:(NewsItem *)item
{
    
    [self.coverImg sd_setImageWithURL:[NSURL URLWithString:item.coverImageUrl]];
    
    [self.titleLbl setText:item.title];
    [self.authorProfileImg sd_setImageWithURL:[NSURL URLWithString:item.authorProfileUrl]];
    [self.briefLbl setText:item.brief];
    
    [self.durationBtn setTitle:item.duration forState:UIControlStateNormal];
    [self.locationBtn setTitle:item.location forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
