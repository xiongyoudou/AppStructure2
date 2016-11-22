//
//  UILabel+SuggestSize.m
//  WordPress
//
//  Created by Eric J on 6/18/13.
//  Copyright (c) 2013 WordPress. All rights reserved.
//

#import "UILabel+XYDSuggestSize.h"

@implementation UILabel (XYDSuggestSize)

- (CGSize)xyd_suggestedSizeForWidth:(CGFloat)width {
    if (self.attributedText)
        return [self xyd_suggestSizeForAttributedString:self.attributedText width:width];
    
	return [self xyd_suggestSizeForString:self.text width:width];
}

- (CGSize)xyd_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

- (CGSize)xyd_suggestSizeForString:(NSString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [self xyd_suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] width:width];
}

@end
