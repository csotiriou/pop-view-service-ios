//
//  SFPopViewService.h
//
//  Created by Christos Sotiriou on 9/28/11.
//  Copyright 2011 Oramind.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "CMPopTipView.h"

@interface CSPopViewService : NSObject <CMPopTipViewDelegate>{
	NSMutableArray *popViews;
	UIColor *currentBackgroundColor;
	UIColor *currentTextColor;
	
	BOOL autoDismiss;
	NSTimeInterval autoDismissTime;
}
@property (nonatomic, strong) NSMutableArray *popViews;
@property (nonatomic, strong) UIColor *currentBackgroundColor;
@property (nonatomic, strong) UIColor *currentTextColor;
@property (nonatomic) BOOL autoDismiss;
@property (nonatomic) NSTimeInterval autoDismissTime;

- (void)presentPopViewWithMessage:(NSString *)message pointingAtView:(UIView *)targetView inView:(UIView *)containerView animated:(BOOL)animated dismissAllOtherViews:(BOOL)soloPresent withDelay:(NSTimeInterval)delay;
- (void)presentPopViewWithMessage:(NSString *)message pointingAtBarButtonItem:(UIBarButtonItem *)barButtonItem animated:(BOOL)animated dismissAllOtherViews:(BOOL)soloPresent withDelay:(NSTimeInterval)delay;

- (void)dismissAllViewsAnimated:(BOOL)animated;
- (void)dismissPopView:(CMPopTipView *)popTipView animated:(BOOL)animated;

- (void)enableAutoDismissAfterTime:(NSTimeInterval)dismissAfterTime;
- (void)disableAutoDismiss;
@end
