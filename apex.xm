#import <UIKit/UIKit.h>

%hook UIWindow
- (void)layoutSubviews {
    %orig;
    
    // دڵنیابوونەوە لەوەی تەنها لەناو پبجیدا کار بکات و دووبارە نەبێتەوە
    UIWindow *window = (UIWindow *)self;
    if ([window viewWithTag:333222]) return;
    
    // دڵنیابوونەوە لەوەی کاتێک شاشە دەبێتە لەندەکس یان ستوونی کێشەی نەبێت
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    // قەبارەی سەرەکی سەتری زانیارییەکە
    UIView *stripView = [[UIView alloc] initWithFrame:CGRectMake((screenWidth - 280) / 2, 45, 280, 36)];
    stripView.tag = 333222;
    stripView.backgroundColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:0.88];
    stripView.layer.cornerRadius = 18.0;
    stripView.layer.borderWidth = 1.2;
    stripView.layer.borderColor = [UIColor colorWithRed:0.1 green:0.95 blue:0.4 alpha:0.95].CGColor;
    stripView.clipsToBounds = YES;
    
    // دڵۆپی ڕووناکی زیندوو (Live Dot)
    UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(14, 13, 10, 10)];
    dotView.backgroundColor = [UIColor colorWithRed:0.1 green:0.95 blue:0.4 alpha:1.0];
    dotView.layer.cornerRadius = 5.0;
    [stripView addSubview:dotView];
    
    // فلاش بۆ جووڵەی دڵۆپەکە
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.fromValue = [NSNumber numberWithFloat:1.0];
    flash.toValue = [NSNumber numberWithFloat:0.15];
    flash.duration = 0.7;
    flash.autoreverses = YES;
    flash.repeatCount = HUGE_VALF;
    [dotView.layer addAnimation:flash forKey:@"flashAnimation"];
    
    // دەقەکە (گەورەتر، قەڵەوتر و بە ناوە کۆنەکەی خۆیەوە)
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 238, 36)];
    textLabel.text = @"Your Channel";
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:12.5 weight:UIFontWeightBold];
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    // زیادکردنی سێبەری کاڵ بۆ دەقەکە بۆ جوانی
    textLabel.layer.shadowColor = [UIColor colorWithRed:0.1 green:0.95 blue:0.4 alpha:0.8].CGColor;
    textLabel.layer.shadowOffset = CGSizeMake(0, 0);
    textLabel.layer.shadowRadius = 4.0;
    textLabel.layer.shadowOpacity = 0.8;
    
    [stripView addSubview:textLabel];
    
    // بەستنەوەی بە ویندۆوە سەرەکییەکەی یارییەکە تاوەکو لانەچێت
    [window addSubview:stripView];
    [window bringSubviewToFront:stripView];
}
%end
