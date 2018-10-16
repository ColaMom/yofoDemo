//
//  RHFHomeHeaderCell1.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/19.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFHomeHeaderCell1.h"
#import "RHFCustomButton.h"

static NSInteger const baseTag = 1000;
@interface RHFHomeHeaderCell1 ()
@property (weak, nonatomic) IBOutlet RHFCustomButton *firstBtn;
@property (weak, nonatomic) IBOutlet RHFCustomButton *secondBtn;
@property (weak, nonatomic) IBOutlet RHFCustomButton *thirdBtn;
@property (weak, nonatomic) IBOutlet RHFCustomButton *forthBtn;

@property (nonatomic, strong)NSMutableArray* btnCollections;


@end

@implementation RHFHomeHeaderCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnCollections = [NSMutableArray arrayWithObjects:self.firstBtn,self.secondBtn,self.thirdBtn,self.forthBtn, nil];
    self.firstBtn.buttonStyle = self.secondBtn.buttonStyle = self.thirdBtn.buttonStyle = self.forthBtn.buttonStyle = RHFCustomButtonImageTop;
    self.firstBtn.titleLabel.font = self.secondBtn.titleLabel.font = self.thirdBtn.titleLabel.font = self.forthBtn.titleLabel.font = RRFont(14.0);
    self.firstBtn.imageView.contentMode = self.secondBtn.imageView.contentMode = self.thirdBtn.imageView.contentMode = self.forthBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;

    //placeHolder
    for (int i=0; i<self.btnCollections.count; i++) {
        UIButton *btn = self.btnCollections[i];
        [btn sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:KPlaceHolder_Cover];
        [btn setTitle:@"" forState:UIControlStateNormal];
        btn.tag = i+baseTag;
        [btn addTarget:self action:@selector(moduleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModulesList:(NSMutableArray<RHFHomeModulesModel *> *)modulesList{
    _modulesList = modulesList;
    
    for (int i=0; i<modulesList.count; i++) {
        UIButton *btn = self.btnCollections[i];
        RHFHomeModulesModel *moduleModel = modulesList[i];
        [btn sd_setImageWithURL:[NSURL URLWithString:moduleModel.image] forState:UIControlStateNormal placeholderImage:KPlaceHolder_Cover];
        [btn setTitle:moduleModel.title forState:UIControlStateNormal];
        btn.tag = i+baseTag;
        [btn addTarget:self action:@selector(moduleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)moduleBtnAction:(UIButton*)sender{
    RHFHomeModulesModel *moduleModel = self.modulesList[sender.tag-baseTag];
   
    if ([self.delegate respondsToSelector:@selector(goToModule:)]) {
        [self.delegate goToModule:moduleModel];
    }
}

@end
