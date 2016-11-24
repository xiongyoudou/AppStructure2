//
//  UILabel+AutomaticWriting.m
//  UILabel-AutomaticWriting
//
//  Created by alexruperez on 10/3/15.
//  Copyright (c) 2015 alexruperez. All rights reserved.
//

#import "UILabel+XYDAutomaticWriting.h"
#import <objc/runtime.h>


NSTimeInterval const UILabelAWDefaultDuration = 0.4f;

unichar const UILabelAWDefaultCharacter = 124;

static inline void xyd_AutomaticWritingSwizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static char kAutomaticWritingOperationQueueKey;
static char kAutomaticWritingEdgeInsetsKey;


@implementation UILabel (XYDAutomaticWriting)

@dynamic xyd_automaticWritingOperationQueue, xyd_edgeInsets;

#pragma mark - Public Methods

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xyd_AutomaticWritingSwizzleSelector([self class], @selector(textRectForBounds:limitedToNumberOfLines:), @selector(xyd_automaticWritingTextRectForBounds:limitedToNumberOfLines:));
        xyd_AutomaticWritingSwizzleSelector([self class], @selector(drawTextInRect:), @selector(xyd_drawAutomaticWritingTextInRect:));
    });
}

-(void)xyd_drawAutomaticWritingTextInRect:(CGRect)rect
{
    [self xyd_drawAutomaticWritingTextInRect:UIEdgeInsetsInsetRect(rect, self.xyd_edgeInsets)];
}

- (CGRect)xyd_automaticWritingTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [self xyd_automaticWritingTextRectForBounds:UIEdgeInsetsInsetRect(bounds, self.xyd_edgeInsets) limitedToNumberOfLines:numberOfLines];
    return textRect;
}

- (void)setXyd_edgeInsets:(UIEdgeInsets)edgeInsets
{
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, [NSValue valueWithUIEdgeInsets:edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)xyd_edgeInsets
{
    NSValue *edgeInsetsValue = objc_getAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey);
    
    if (edgeInsetsValue)
    {
        return edgeInsetsValue.UIEdgeInsetsValue;
    }
    
    edgeInsetsValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
    
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, edgeInsetsValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return edgeInsetsValue.UIEdgeInsetsValue;
}

- (void)setXyd_automaticWritingOperationQueue:(NSOperationQueue *)automaticWritingOperationQueue
{
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, automaticWritingOperationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)xyd_automaticWritingOperationQueue
{
    NSOperationQueue *operationQueue = objc_getAssociatedObject(self, &kAutomaticWritingOperationQueueKey);
    
    if (operationQueue)
    {
        return operationQueue;
    }
    
    operationQueue = NSOperationQueue.new;
    operationQueue.name = @"Automatic Writing Operation Queue";
    operationQueue.maxConcurrentOperationCount = 1;
    
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, operationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return operationQueue;
}

- (void)xyd_setTextWithAutomaticWritingAnimation:(NSString *)text
{
    [self xyd_setText:text automaticWritingAnimationWithBlinkingMode:UILabelJKlinkingModeNone];
}

- (void)xyd_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelJKlinkingMode)blinkingMode
{
    [self xyd_setText:text automaticWritingAnimationWithDuration:UILabelAWDefaultDuration blinkingMode:blinkingMode];
}

- (void)xyd_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration
{
    [self xyd_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:UILabelJKlinkingModeNone];
}

- (void)xyd_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelJKlinkingMode)blinkingMode
{
    [self xyd_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:UILabelAWDefaultCharacter];
}

- (void)xyd_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelJKlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter
{
    [self xyd_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:blinkingCharacter completion:nil];
}

- (void)xyd_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelJKlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion
{
    self.xyd_automaticWritingOperationQueue.suspended = YES;
    self.xyd_automaticWritingOperationQueue = nil;
    
    self.text = @"";
    
    NSMutableString *automaticWritingText = NSMutableString.new;
    
    if (text)
    {
        [automaticWritingText appendString:text];
    }
    
    [self.xyd_automaticWritingOperationQueue addOperationWithBlock:^{
        [self xyd_automaticWriting:automaticWritingText duration:duration mode:blinkingMode character:blinkingCharacter completion:completion];
    }];
}

#pragma mark - Private Methods

- (void)xyd_automaticWriting:(NSMutableString *)text duration:(NSTimeInterval)duration mode:(UILabelJKlinkingMode)mode character:(unichar)character completion:(void (^)(void))completion
{
    NSOperationQueue *currentQueue = NSOperationQueue.currentQueue;
    if ((text.length || mode >= UILabelJKlinkingModeWhenFinish) && !currentQueue.isSuspended)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (mode != UILabelJKlinkingModeNone)
            {
                if ([self xyd_isLastCharacter:character])
                {
                    [self xyd_deleteLastCharacter];
                }
                else if (mode != UILabelJKlinkingModeWhenFinish || !text.length)
                {
                    [text insertString:[self xyd_stringWithCharacter:character] atIndex:0];
                }
            }
            
            if (text.length)
            {
                [self xyd_appendCharacter:[text characterAtIndex:0]];
                [text deleteCharactersInRange:NSMakeRange(0, 1)];
                if ((![self xyd_isLastCharacter:character] && mode == UILabelJKlinkingModeWhenFinishShowing) || (!text.length && mode == UILabelJKlinkingModeUntilFinishKeeping))
                {
                    [self xyd_appendCharacter:character];
                }
            }
            
            if (!currentQueue.isSuspended)
            {
                [currentQueue addOperationWithBlock:^{
                    [self xyd_automaticWriting:text duration:duration mode:mode character:character completion:completion];
                }];
            }
            else if (completion)
            {
                completion();
            }
        });
    }
    else if (completion)
    {
        completion();
    }
}

- (NSString *)xyd_stringWithCharacter:(unichar)character
{
    return [self xyd_stringWithCharacters:@[@(character)]];
}

- (NSString *)xyd_stringWithCharacters:(NSArray *)characters
{
    NSMutableString *string = NSMutableString.new;
    
    for (NSNumber *character in characters)
    {
        [string appendFormat:@"%C", character.unsignedShortValue];
    }
    
    return string.copy;
}

- (void)xyd_appendCharacter:(unichar)character
{
    [self xyd_appendCharacters:@[@(character)]];
}

- (void)xyd_appendCharacters:(NSArray *)characters
{
    self.text = [self.text stringByAppendingString:[self xyd_stringWithCharacters:characters]];
}

- (BOOL)xyd_isLastCharacters:(NSArray *)characters
{
    if (self.text.length >= characters.count)
    {
        return [self.text hasSuffix:[self xyd_stringWithCharacters:characters]];
    }
    return NO;
}

- (BOOL)xyd_isLastCharacter:(unichar)character
{
    return [self xyd_isLastCharacters:@[@(character)]];
}

- (BOOL)xyd_deleteLastCharacters:(NSUInteger)characters
{
    if (self.text.length >= characters)
    {
        self.text = [self.text substringToIndex:self.text.length-characters];
        return YES;
    }
    return NO;
}

- (BOOL)xyd_deleteLastCharacter
{
    return [self xyd_deleteLastCharacters:1];
}

@end
