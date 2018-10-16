//
//  RHFHomeController.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/19.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFHomeController.h"


#import "RHFPopOptionView.h"

#import "RHFSearchField.h"
#import "RHFHomeCollectionHeaderView.h"
#import "RHFUserSkinNoteStyleCell.h"

#import "RHFArticleModel.h"
#import "RHFProductModel.h"
 #import "RHFHomeModulesModel.h"
#import "RHFArticleTagSectionModel.h"
#import "FJWaterfallFlowLayout.h"

static NSString *const skinNoteCellID = @"RHFUserSkinNoteStyleCell";

@interface RHFHomeController ()<FJWaterfallFlowLayoutDelegate,RHFHomeCollectionHeaderViewDelegate,RHFPopOptionViewDelegate>

@property (weak, nonatomic) RHFSearchField* searchBar;
@property (strong, nonatomic) NSMutableArray* hotkeyWordList;
@property (weak, nonatomic) NSTimer* timer;
@property (assign, nonatomic) NSInteger currentHotKeyIndex;
@property (strong, nonatomic) NSMutableArray* bannerList;

@property (strong, nonatomic)NSMutableArray<RHFArticleModel*>* articleList;
@property (strong, nonatomic)NSMutableArray<RHFProductModel*>* productList;
@property (strong, nonatomic)NSMutableArray<RHFHomeModulesModel*>* modulesList;

@property (assign, nonatomic) CGPoint lastOffset ;
@property (assign, nonatomic) BOOL isVaild ;

@property (nonatomic, strong) NSMutableArray<RHFArticleTagModel*> *selectedTags;
@property (nonatomic, strong) NSMutableArray<RHFArticleTagSectionModel *> *allTagsArr;
@property (nonatomic,strong) RHFHomeCollectionHeaderView * headerView;
//网络请求任务组
@property (retain, nonatomic) dispatch_group_t group;
@property (retain, nonatomic) dispatch_queue_t globalQueue;
//排序选项:热度/最新
@property (copy, nonatomic) NSString *sortType ;
@end

@implementation RHFHomeController

- (NSMutableArray *)hotkeyWordList{
    if (!_hotkeyWordList) {
        _hotkeyWordList = [NSMutableArray array];
    }
    return _hotkeyWordList;
}
- (NSMutableArray<RHFProductModel *> *)productList{
    if (!_productList) {
        _productList = [NSMutableArray array];
    }
    return _productList;
}

- (NSMutableArray<RHFArticleModel *> *)articleList{
    if (!_articleList) {
        _articleList = [NSMutableArray array];
    }
    return _articleList;
}

- (NSMutableArray<RHFHomeModulesModel *> *)modulesList{
    if (!_modulesList) {
        _modulesList = [NSMutableArray array];
    }
    return _modulesList;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.lastOffset.y>0) {
        [self.collectionView setContentOffset:self.lastOffset animated:NO];
    }
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self setTimerStart];
  
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setTimerStop];
    self.lastOffset = self.collectionView.contentOffset;
    self.isVaild = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.collectionView setContentOffset:self.lastOffset animated:NO];
    [super viewDidDisappear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.isVaild = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.backgroundColor = [UIColor colorWithHex:@"FAFAFA"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAfterLogin) name:RHFLoginCompleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAfterLogout) name:RHFLogOutCompleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skinTestCompleteAction) name:RHFSkinTestCompleteNotification object:nil];

    self.sortType = kArticleSortTypePraise;
    self.lastOffset = CGPointMake(0, 0);
    [self setupNavigationBar];
    [self configDefault];
    [self requestHotKeywordList];
    //创建全局并行
    self.group = dispatch_group_create();
    self.globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    [self requestData];
  
}
//获取数据
- (void)requestData{
    self.currentPage = 0;
    [self requesetBannerList];
    [self requestFourModules];
    [self requestProductList];
    //第一次先获取所有标签
    if (!self.selectedTags) {
        [self requestAllTags];
        dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
            [self requestArticleListIsSort:NO];
        });
    }
    else{
        [self requestArticleListIsSort:NO];
        dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }
  
}

#pragma mark - setUp

- (void)setupNavigationBar{
    
    //搜索输入框的父视图按钮,使用输入框的UI并输入框禁用,以免点击激活键盘
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRM(0, 0, KScreenWidth - 100, 30);
//    [searchBtn addTarget:self action:@selector(searchBarButtonDidClickAction) forControlEvents:UIControlEventTouchUpInside];
    RHFSearchField *searchField = [[RHFSearchField alloc]initWithFrame:CGRM(0, 0, searchBtn.width, searchBtn.height)];
    [searchBtn addSubview:searchField];
    searchField.placeholder = @"搜索你感兴趣的";
    searchField.font = RRFont(13.0);
    searchField.enabled = NO;
    self.searchBar = searchField;
    self.navigationItem.titleView = searchBtn;

}

- (void)configDefault{
    FJWaterfallFlowLayout *waterFlowLayout = [[FJWaterfallFlowLayout alloc] init];
    waterFlowLayout.delegate = self;
    waterFlowLayout.colCount = 2;
    waterFlowLayout.itemSpacing = 11;
    waterFlowLayout.lineSpacing = 11;
    waterFlowLayout.sectionInset = UIEdgeInsetsMake(11, 15, 11, 15);
    self.collectionView.collectionViewLayout = waterFlowLayout;
    self.collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.collectionView registerNib:[UINib nibWithNibName:skinNoteCellID bundle:nil] forCellWithReuseIdentifier:skinNoteCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"RHFHomeCollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RHFHomeCollectionHeaderView"];
    
    self.currentPage = 0;
    self.pageSize = 24;
    self.firstLoad = YES;
    weakify(self);
    self.refreshCompleteHandler = ^{
        if (weakSelf.isFooterRefresh) {
            [weakSelf requestArticleListIsSort:NO];
//            [weakSelf endRefresh];
        }
        else{
            [weakSelf requestData];
        }
    };
}

- (void)setTimerStart{
    NSUInteger count = self.hotkeyWordList.count;
    if (count>0) {
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hotkeyTimerFunction) userInfo:nil repeats:YES];
        self.timer = timer;
        [self.timer fire];
        
    }
    
    
}

- (void)setTimerStop{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        DLog(@"社区轮播定时器停止");
    }
}

- (void)hotkeyTimerFunction{
    NSUInteger count = self.hotkeyWordList.count;
    self.searchBar.placeholder = self.hotkeyWordList[self.currentHotKeyIndex%count];
    self.currentHotKeyIndex ++;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - request

- (void)requestAllTags{
    dispatch_group_enter(self.group);
    dispatch_async(self.globalQueue, ^{
      
//        [RHFNetInterface articleGetTags:nil success:^(id dataObject) {
//            if (kSuccess) {
//                NSMutableArray *dataList = dataObject[@"data"];
        NSMutableArray *dataList = [NSMutableArray array];

                self.allTagsArr = [RHFArticleTagSectionModel mj_objectArrayWithKeyValuesArray:dataList];
                self.selectedTags = [NSMutableArray array];
                
                //有肤质,默认选中肤质做标签
                if ([RHFUserModel currentUser].status && !IsEmptyValue([RHFUserModel currentUser].skinType) && self.selectedTags.count == 0) {
                    if (self.allTagsArr.count>0) {
                        //循环出当前选中标签
                        for (RHFArticleTagSectionModel *sectionModel in self.allTagsArr) {
                            NSArray *tagArr = sectionModel.data;
                            NSPredicate *pre = [NSPredicate predicateWithFormat:@"val == %@",[RHFUserModel currentUser].skinType];
                            NSArray *fetch = [tagArr filteredArrayUsingPredicate:pre];
                            if (fetch.count>0) {
                                //是选中的
                                [self.selectedTags addObject:fetch[0]];
                            }
                        }
                    }
                }
               
//            }
            dispatch_group_leave(self.group);
            
//        } failure:^(NSError *error) {
//            dispatch_group_leave(self.group);
//
//        }];
    });
}

/**
 * 四个模块接口
 */
- (void)requestFourModules{
    dispatch_group_enter(self.group);
    dispatch_async(self.globalQueue, ^{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:[RHFUserModel currentUser].userId forKey:@"user_id"];
//        [RHFNetInterface getModular:params success:^(id dataObject) {
//            if (kSuccess) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=0; i<4; i++) {
            RHFHomeModulesModel *model= [[RHFHomeModulesModel alloc] init];
            model.type = @"trial";
            model.title = @"大牌试用";
            model.image = @"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg";
            [arr addObject:model];
        }
                self.modulesList  = [RHFHomeModulesModel mj_objectArrayWithKeyValuesArray:arr];
//            }
            dispatch_group_leave(self.group);
//
//        } failure:^(NSError *error) {
//            dispatch_group_leave(self.group);
//
//        }];
    });
}

/**
 *获取搜索热词
 */
- (void)requestHotKeywordList{
    self.currentHotKeyIndex = 0;

//    [RHFNetInterface hotKeywordSuccess:^(id dataObject) {
        for (NSDictionary *dic in [NSMutableArray array]) {
            [self.hotkeyWordList addObject:dic[@"name"]];
        }
        
        [self setTimerStart];
//    } failure:^(NSError *error) {
//
//    }];
}

/**
 *请求文章
 */
- (void)requestArticleListIsSort:(BOOL)isSort{
   
    
    dispatch_group_enter(self.group);
    dispatch_async(self.globalQueue, ^{
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:RRStr(@"%d",self.currentPage+1) forKey:@"page"];
        [params setValue:RRStr(@"%d",self.pageSize) forKey:@"page_size"];
        [params setValue:[RHFUserModel currentUser].userId forKey:@"userId"];
        [params setValue:self.sortType forKey:@"order"];
        NSMutableString *tagStr = [NSMutableString string];
        
        for (RHFArticleTagModel *tagModel in self.selectedTags) {
            [tagStr appendString:tagModel.key];
            [tagStr appendString:@","];
        }
        if (tagStr.length>0) {
            [params setValue:[tagStr substringToIndex:tagStr.length-1] forKey:@"tag_str"];
        }
//        [RHFNetInterface getDiscoverArticleList:params Success:^(id dataObject) {
//            if (kSuccess) {
                if (isSort) {
                    [self.articleList removeAllObjects];
                    NSMutableArray *arr = [NSMutableArray array];
                    for (int i=0; i<4; i++) {
                        RHFArticleModel *model= [[RHFArticleModel alloc] init];
                        model.title = @"文章标题";
                        model.image = @"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg";
                        [arr addObject:model];
                    }
                    self.articleList  = [RHFArticleModel mj_objectArrayWithKeyValuesArray:arr];
                    [self.collectionView reloadData];
                    self.currentPage++;
                    [self endRefresh];
                    
                }
                else{
                    NSMutableArray *dataList = [NSMutableArray array];
                    for (int i=0; i<13; i++) {
                        RHFArticleModel *model= [[RHFArticleModel alloc] init];
                        model.title = @"文章标题";
                        model.image = @"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg";
                        [dataList addObject:model];
                    }
                     [self refreshCompleteHandlerWhenRequestListEnd:dataList HeaderHandler:^{
                        [self.articleList removeAllObjects];
                        self.articleList  = [RHFArticleModel mj_objectArrayWithKeyValuesArray:dataList];
                    } footerHandler:^{
                        [self.articleList addObjectsFromArray:[RHFArticleModel mj_objectArrayWithKeyValuesArray:[NSMutableArray array]]];
                        
                    }];
                    
                    if (self.firstLoad) {
                        self.firstLoad = NO;
                    }
                }
              
                
//            }
//            else{
//                [self showTextHUDWithTitle:KMessage];
//                [self endRefresh];
//            }
            //任务执行完毕后离开调度组
            dispatch_group_leave(self.group);
            
//        } failure:^(NSError *error) {
//            [hud hideAnimated:YES];
//            [self endRefresh];
//            [self showTextHUDWithTitle:@"出错了,请稍后重试.."];
//            //任务执行完毕后离开调度组
//            dispatch_group_leave(self.group);
//
//        }];
    });

}

/**
 * 获取banner列表
 */
- (void)requesetBannerList{
    dispatch_group_enter(self.group);
    dispatch_async(self.globalQueue, ^{
        //获取轮播图
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (IsEmptyValue([RHFUserModel currentUser].userId)) {
            [params setValue:@"0" forKey:@"user_id"];
        }
        else{
            [params setValue:[RHFUserModel currentUser].userId forKey:@"user_id"];
        }
        
//        [RHFNetInterface homeBannerList:params success:^(id dataObject) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=0; i<4; i++) {
            RHFHomeModulesModel *model= [[RHFHomeModulesModel alloc] init];
            model.is_click = NO;
            model.image = @"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg";            [arr addObject:model];
        }
            self.bannerList = [RHFHomeModulesModel mj_objectArrayWithKeyValuesArray:arr];
            //任务执行完毕后离开调度组
            dispatch_group_leave(self.group);
//        } failure:^(NSError *error) {
//            DLog(@"%@",error);
//            //任务执行完毕后离开调度组
//            dispatch_group_leave(self.group);
//        }];
    });
}

/**
 *获取产品
 */
- (void)requestProductList{
    dispatch_group_enter(self.group);
    dispatch_async(self.globalQueue, ^{
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:[RHFUserModel currentUser].userId forKey:@"user_id"];
        
//        [RHFNetInterface getRecommendProduct:params success:^(id dataObject) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=0; i<4; i++) {
            RHFProductModel *model= [[RHFProductModel alloc] init];
            model.china_name = @"兰蔻大粉水";
            model.image = @"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg";            [arr addObject:model];
        }
            self.productList = [RHFProductModel mj_objectArrayWithKeyValuesArray:arr];
            dispatch_group_leave(self.group);
            
//        } failure:^(NSError *error) {
//            dispatch_group_leave(self.group);
//
//        }];
    });

    
}

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
//每组有多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.articleList.count;
}


//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RHFArticleModel *articleModel = self.articleList[indexPath.row];
    RHFUserSkinNoteStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:skinNoteCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHex:@"FAFAFA"];
    cell.articleModel = articleModel;
    cell.praiseArticleBlock = ^(RHFArticleModel *articleModel) {
        if ([articleModel.list_type isEqualToString:kListTypeArticle]) {
            [self tapPraiseHandlerWithArticleModel:articleModel];
        }
        else if ([articleModel.list_type isEqualToString:kListTypeHeart]){
            [self tapPraiseHandlerWithFeel:articleModel];
        }
    };
    return cell;
}
/**
 * 头视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    RHFHomeCollectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RHFHomeCollectionHeaderView" forIndexPath:indexPath];
    if (!header) {
        header = [[[NSBundle mainBundle] loadNibNamed:@"RHFHomeCollectionHeaderView" owner:self options:nil] lastObject];
    }
    header.delegate = self;
    header.bannerList = self.bannerList;
    header.productList = self.productList;
    header.modulesList = self.modulesList;
    header.selectedTags = self.selectedTags;
    [header refreshView];
    self.headerView = header;
    return header;
    
}

/**
 *点击事件
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
 
}

#pragma mark FJWaterfallFlowLayoutDelegate
//行高
- (CGFloat)FJWaterFlowlayout:(FJWaterfallFlowLayout *)collectionViewLayout collectionView:(UICollectionView *)collectionView heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    RHFArticleModel *articleModel = self.articleList[indexPath.row];
    articleModel.collectionWidth = width;
    return  105+articleModel.coverImageHeight;
}
//头视图高度
- (CGSize)FJWaterFlowlayout:(FJWaterfallFlowLayout *)collectionViewLayout collectionView:(UICollectionView *)collectionView referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.width, 600+90*(KScreenWidth/375)+55);
}

#pragma mark - <RHFHomeCollectionHeaderViewDelegate>
//选中banner
- (void)selectBannerAtIndex:(NSInteger)indexPath{

}

#pragma mark 四个模块
- (void)goToModule:(RHFHomeModulesModel *)modulesModel{
    //测肤
    if ([modulesModel.type isEqualToString:@"skin_test"]){
        [self goToTestSkinWithLastTestId:modulesModel.sub_id];
    }
    //试用
    else if ([modulesModel.type isEqualToString:@"trial"]){
        [self goToTrail];
    }
    //话题
    else if ([modulesModel.type isEqualToString:@"topic"]){
        [self goToTopicDetailWithModulesModel:modulesModel];
    }
    //主题
    else if ([modulesModel.type isEqualToString:@"theme"]){
        [self goToThemeDetailWithModulesModel:modulesModel];
    }
    //测评
    else if ([modulesModel.type isEqualToString:@"yofo_evaluation"]){
        [self goToYofoArticleListWithModule:modulesModel];
    }
    //达人笔记
    else if ([modulesModel.type isEqualToString:@"note"]){
        [self goToYofoArticleListWithModule:modulesModel];
    }
    //话题列表
    else if ([modulesModel.type isEqualToString:@"topic_list"]){
        [self goToTopicList];
    }
    //主题列表
    else if ([modulesModel.type isEqualToString:@"theme_list"]){
        [self goToQualityThemeList];
    }
    //帮你买
    else if ([modulesModel.type isEqualToString:@"help_buy"]){
        [self goToWishListVC];
    }
}

//帮你买,去长草清单
- (void)goToWishListVC{
    
//    if (![RHFUserModel currentUser].userId) {
//
//        RHFLoginController *loginVC = [[RHFLoginController alloc]init];
//        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
//        nav.navigationBarHidden = YES;
//        [self.navigationController presentViewController:nav animated:YES completion:nil];
//        return;
//    }
//
//    RHFMyGrassGrowUpVC *grassListVC =  [[RHFMyGrassGrowUpVC alloc] init];
//    grassListVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:grassListVC animated:YES];
}

//优质主题列表
- (void)goToQualityThemeList{
//    RHFThemeListVC *themeVC = [[RHFThemeListVC alloc] init];
//    themeVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:themeVC animated:YES];
}

//话题列表
- (void)goToTopicList{
//    RHFHotTopicListVC *topicVC = [[RHFHotTopicListVC alloc]init];
//    topicVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:topicVC animated:YES];
}

//YOFO测评和 达人笔记
- (void)goToYofoArticleListWithModule:(RHFHomeModulesModel*)module{
//    RHFNBNoteVC *yofoTestVC = [[RHFNBNoteVC alloc] init];
//    yofoTestVC.modulesModel = module;
//    yofoTestVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:yofoTestVC animated:YES];
}
//测肤
- (void)goToTestSkinWithLastTestId:(NSString*)lastTestId{

}
//大牌试用
- (void)goToTrail{
//    RHFProBationalVC *probationVC = [[RHFProBationalVC alloc]init];
//    probationVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:probationVC animated:YES];
}
//话题详情
- (void)goToTopicDetailWithModulesModel:(RHFHomeModulesModel *)modulesModel{
  
  
}

//主题详情
- (void)goToThemeDetailWithModulesModel:(RHFHomeModulesModel *)modulesModel{
   
}

#pragma mark 产品
//产品详情
-(void)goToProductDetail:(RHFProductModel *)product{

}
//解锁产品礼包
- (void)unLockSkinPackage{
    if (![RHFUserModel currentUser].status) {
        //没有登录
        [self login];
    }
    else if(IsEmptyValue([RHFUserModel currentUser].skinType)){
        //没有肤质
        [self goToTestSkinWithLastTestId:@""];
    }
}
#pragma mark 排行榜

 - (void)goToKoreaRank{
  
}
 - (void)goToJapanRank{
  
}





#pragma mark - login
- (void)login{
}

//登录成功之后，刷新页面,刷新肤质产品列表
- (void)refreshAfterLogin{
    //第一次reload,是显示肤质
    [self.collectionView reloadData];
    [self requestProductList];
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        //此时reload,是刷新产品
        [self.collectionView reloadData];
    });
}

- (void)refreshAfterLogout{
    [self.collectionView reloadData];
}

- (void)skinTestCompleteAction{
    [self.collectionView reloadData];
    [self requestProductList];
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.lastOffset.y>0 && self.isVaild) {
        [self.collectionView setContentOffset:self.lastOffset animated:NO];
        self.lastOffset = CGPointMake(0, 0);
    }
    
}

#pragma mark - 点赞

- (void)tapPraiseHandlerWithFeel:(RHFArticleModel*)feelModel{

}


- (void)tapPraiseHandlerWithArticleModel:(RHFArticleModel*)articleModel{
   
}

#pragma mark - 标签和排序
#pragma mark  <RHFHomeCollectionHeaderViewDelegate>
/**
 点击标签进入选择标签页面
 */
- (void)tagHeadrViewDidSelectTagAtIndex:(NSInteger)index{
  
}

- (void)tagHeadrViewSortBtnPress{
    //转换坐标,得到点击的视图的位置
    CGRect rect1 = [self.headerView convertRect:self.headerView.frame fromView:self.headerView.superview];     //获取button在contentView的位置
    CGRect rect2 = [self.headerView convertRect:rect1 toView:KKeyWindow];         //获取button在window的位置

    CGFloat popViewHeight = 40*2;
    //按照这个位置,弹出option
    RHFPopOptionView* popView = [[RHFPopOptionView alloc]initWithFrame:CGRM(self.view.width - 40, CGRectGetMaxY(rect2), 85, popViewHeight) Style:RHFPopOptionStyleNoIcon itemNum:2];
    popView.delegate = self;
    popView.atRow = 0;
    [popView addOption:@"热度" image:nil style:RHFPopOptionCellStyleDefault];
    [popView addOption:@"最新" image:nil style:RHFPopOptionCellStyleDefault];
    [popView show];
}


#pragma mark  <RHFPopOptionViewDelegate>
- (void)RHFPopOptionViewDidSelectedOptionAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        self.sortType = kArticleSortTypePraise;
//        [self requestArticleListIsSort:YES];
//    }
//    else{
//        self.sortType = kArticleSortTypeNewest;
//    }
//    self.currentPage = 0;
//    [self requestArticleListIsSort:YES];

}


#pragma mark  <RHFUserSkinNoteTagVCDelegate>
/**
 选择完标签的回调
 
 @param selectedTags 已选择的标签集合
 */
- (void)RHFUserSkinNoteTagVCSelectDone:(NSMutableArray *)selectedTags{
    
    self.selectedTags = selectedTags;
    self.currentPage = 0;
    [self requestArticleListIsSort:YES];
}
@end
