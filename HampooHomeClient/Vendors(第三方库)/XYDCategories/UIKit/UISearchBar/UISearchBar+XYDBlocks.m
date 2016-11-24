//
//  UISearchBar+XYDBlocks.m
//  UISearchBarBlocks
//
//  Created by Håkon Bogen on 20.10.13.
//  Copyright (c) 2013 Håkon Bogen. All rights reserved.
//

#import "UISearchBar+XYDBlocks.h"
#import <objc/runtime.h>

/* Only for convenience and readabilty in delegate methods */
typedef BOOL (^xyd_UISearchBarReturnBlock) (UISearchBar *searchBar);
typedef void (^xyd_UISearchBarVoidBlock) (UISearchBar *searchBar);
typedef void (^xyd_UISearchBarSearchTextBlock) (UISearchBar *searchBar,NSString *searchText);
typedef BOOL (^xyd_UISearchBarInRangeReplacementTextBlock) (UISearchBar *searchBar,NSRange range,NSString *text);
typedef void (^xyd_UISearchBarScopeIndexBlock)(UISearchBar *searchBar, NSInteger selectedScope);

@implementation UISearchBar (XYDBlocks)


static const void *xyd_UISearchBarDelegateKey                                = &xyd_UISearchBarDelegateKey;
static const void *xyd_UISearchBarShouldBeginEditingKey                      = &xyd_UISearchBarShouldBeginEditingKey;
static const void *xyd_UISearchBarTextDidBeginEditingKey                     = &xyd_UISearchBarTextDidBeginEditingKey;
static const void *xyd_UISearchBarShouldEndEditingKey                        = &xyd_UISearchBarShouldEndEditingKey;
static const void *xyd_UISearchBarTextDidEndEditingKey                       = &xyd_UISearchBarTextDidEndEditingKey;
static const void *xyd_UISearchBarTextDidChangeKey                           = &xyd_UISearchBarTextDidChangeKey;
static const void *xyd_UISearchBarShouldChangeTextInRangeKey                 = &xyd_UISearchBarShouldChangeTextInRangeKey;
static const void *xyd_UISearchBarSearchButtonClickedKey                                = &xyd_UISearchBarSearchButtonClickedKey;
static const void *xyd_UISearchBarBookmarkButtonClickedKey                                = &xyd_UISearchBarBookmarkButtonClickedKey;
static const void *xyd_UISearchBarCancelButtonClickedKey                                = &xyd_UISearchBarCancelButtonClickedKey;
static const void *xyd_UISearchBarResultsListButtonClickedKey                                = &xyd_UISearchBarResultsListButtonClickedKey;
static const void *xyd_UISearchBarSelectedScopeButtonIndexDidChangeKey                                = &xyd_UISearchBarSelectedScopeButtonIndexDidChangeKey;




#pragma mark UISearchBar delegate Methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    xyd_UISearchBarReturnBlock block = searchBar.xyd_completionShouldBeginEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]){
        return [delegate searchBarShouldBeginEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    xyd_UISearchBarVoidBlock block = searchBar.xyd_completionTextDidBeginEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]){
        [delegate searchBarTextDidBeginEditing:searchBar];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    xyd_UISearchBarReturnBlock block = searchBar.xyd_completionShouldEndEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]){
        return [delegate searchBarShouldEndEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
   xyd_UISearchBarVoidBlock block = searchBar.xyd_completionTextDidEndEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]){
        [delegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    xyd_UISearchBarSearchTextBlock block = searchBar.xyd_completionTextDidChangeBlock;
    if (block) {
        block(searchBar,searchText);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:textDidChange:)]){
        [delegate searchBar:searchBar textDidChange:searchText];
    }
}
// called when text changes (including clear)
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    xyd_UISearchBarInRangeReplacementTextBlock block = searchBar.xyd_completionShouldChangeTextInRangeBlock;
    if (block) {
        return block(searchBar,range,text);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]){
        return [delegate searchBar:searchBar shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    xyd_UISearchBarVoidBlock block = searchBar.xyd_completionSearchButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
        [delegate searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    xyd_UISearchBarVoidBlock block = searchBar.xyd_completionBookmarkButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarBookmarkButtonClicked:)]){
        [delegate searchBarBookmarkButtonClicked:searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    xyd_UISearchBarVoidBlock block = searchBar.xyd_completionCancelButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]){
        [delegate searchBarCancelButtonClicked:searchBar];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    xyd_UISearchBarVoidBlock block = searchBar.xyd_completionResultsListButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarResultsListButtonClicked:)]){
        [delegate searchBarResultsListButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    xyd_UISearchBarScopeIndexBlock block = searchBar.xyd_completionSelectedScopeButtonIndexDidChangeBlock;
    if (block) {
        block(searchBar,selectedScope);
    }
    id delegate = objc_getAssociatedObject(self, xyd_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]){
        [delegate searchBar:searchBar selectedScopeButtonIndexDidChange:selectedScope];
    }
}


#pragma mark Block setting/getting methods
- (BOOL (^)(UISearchBar *))xyd_completionShouldBeginEditingBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarShouldBeginEditingKey);
}

- (void)setXyd_completionShouldBeginEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldBeginEditingBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarShouldBeginEditingKey, searchBarShouldBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))xyd_completionTextDidBeginEditingBlock
{
    return objc_getAssociatedObject(self,xyd_UISearchBarTextDidBeginEditingKey);
}

- (void)setXyd_completionTextDidBeginEditingBlock:(void (^)(UISearchBar *))searchBarTextDidBeginEditingBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarTextDidBeginEditingKey, searchBarTextDidBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *))xyd_completionShouldEndEditingBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarShouldEndEditingKey);
}

- (void)setXyd_completionShouldEndEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldEndEditingBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarShouldEndEditingKey, searchBarShouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))xyd_completionTextDidEndEditingBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarTextDidEndEditingKey);
}

- (void)setXyd_completionTextDidEndEditingBlock:(void (^)(UISearchBar *))searchBarTextDidEndEditingBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarTextDidEndEditingKey, searchBarTextDidEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSString *))xyd_completionTextDidChangeBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarTextDidChangeKey);
}

- (void)setXyd_completionTextDidChangeBlock:(void (^)(UISearchBar *, NSString *))searchBarTextDidChangeBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarTextDidChangeKey, searchBarTextDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *, NSRange, NSString *))xyd_completionShouldChangeTextInRangeBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarShouldChangeTextInRangeKey);
}

- (void)setXyd_completionShouldChangeTextInRangeBlock:(BOOL (^)(UISearchBar *, NSRange, NSString *))searchBarShouldChangeTextInRangeBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarShouldChangeTextInRangeKey, searchBarShouldChangeTextInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))xyd_completionSearchButtonClickedBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarSearchButtonClickedKey);
}

- (void)setXyd_completionSearchButtonClickedBlock:(void (^)(UISearchBar *))searchBarSearchButtonClickedBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarSearchButtonClickedKey, searchBarSearchButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))xyd_completionBookmarkButtonClickedBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarBookmarkButtonClickedKey);
}

- (void)setXyd_completionBookmarkButtonClickedBlock:(void (^)(UISearchBar *))searchBarBookmarkButtonClickedBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarBookmarkButtonClickedKey, searchBarBookmarkButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))xyd_completionCancelButtonClickedBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarCancelButtonClickedKey);
}

- (void)setXyd_completionCancelButtonClickedBlock:(void (^)(UISearchBar *))searchBarCancelButtonClickedBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarCancelButtonClickedKey, searchBarCancelButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))xyd_completionResultsListButtonClickedBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarResultsListButtonClickedKey);
}

- (void)setXyd_completionResultsListButtonClickedBlock:(void (^)(UISearchBar *))searchBarResultsListButtonClickedBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarResultsListButtonClickedKey, searchBarResultsListButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSInteger))xyd_completionSelectedScopeButtonIndexDidChangeBlock
{
    return objc_getAssociatedObject(self, xyd_UISearchBarSelectedScopeButtonIndexDidChangeKey);
}

- (void)setXyd_completionSelectedScopeButtonIndexDidChangeBlock:(void (^)(UISearchBar *, NSInteger))searchBarSelectedScopeButtonIndexDidChangeBlock
{
    [self xyd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, xyd_UISearchBarSelectedScopeButtonIndexDidChangeKey, searchBarSelectedScopeButtonIndexDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void)xyd_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UISearchBarDelegate>)self) {
        objc_setAssociatedObject(self, xyd_UISearchBarDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UISearchBarDelegate>)self;
    }
}

@end
