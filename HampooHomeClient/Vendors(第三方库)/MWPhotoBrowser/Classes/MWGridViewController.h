//
//  MWGridViewController.h
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 08/10/2013.
//
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface MWGridViewController : UICollectionViewController {}

@property (nonatomic, assign) MWPhotoBrowser *browser;
@property (nonatomic) BOOL selectionMode;
@property (nonatomic) CGPoint initialContentOffset;

- (void)adjustOffsetsAsRequired;

// 是否选择了所有
@property (nonatomic) BOOL isSelectAll;
//是否滚动到底部（在选择图片时，因为最新的图片在最低端，所以希望先移动到底部显示老图片）
@property (nonatomic) BOOL isScrollToBottom;
// 是否所有都没有选中
@property (nonatomic) BOOL isUnSelectAll;
- (void)selectAllCell:(BOOL)isSelectAll;

@end
