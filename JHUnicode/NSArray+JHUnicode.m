//
//  NSArray+JHUnicode.m
//  JHKit
//
//  Created by HaoCold on 2018/5/31.
//  Copyright © 2018年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2018 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "NSArray+JHUnicode.h"
#import <objc/runtime.h>

@implementation NSArray (JHUnicode)

+ (void)load{
    Method old = class_getInstanceMethod(self, @selector(description));
    Method new = class_getInstanceMethod(self, @selector(jh_description));
    method_exchangeImplementations(old, new);
    
    {
        Method old = class_getInstanceMethod(self, @selector(descriptionWithLocale:));
        Method new = class_getInstanceMethod(self, @selector(jh_descriptionWithLocale:));
        method_exchangeImplementations(old, new);
    }
}

- (NSString *)jh_description{
    NSString *description = [self jh_description];
    description = [NSString stringWithCString:[description cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return description;
}

- (NSString *)jh_descriptionWithLocale:(id)local{
    return [self description];
}

@end
