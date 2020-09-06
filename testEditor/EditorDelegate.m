//
//  EditorDelegate.m
//  testEditor
//
//  Created by Takayuki Kamezawa on 2020/08/23.
//  Copyright © 2020 Takayuki Kamezawa. All rights reserved.
//

#import "EditorDelegate.h"
#import <WebKit/WebKit.h>
#import <objc/runtime.h>
#import "WebViewInjection.h"

@implementation EditorDelegate

@end


@interface EditorDelegate(webDelegate) <UIWebViewDelegate,WKUIDelegate>


@end

@implementation EditorDelegate(webDelegate)

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.editorLoaded = YES;
  self.shouldShowKeyboard = YES;
    if (self.shouldShowKeyboard) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self focusTextEditor];
            [self focusEditor:webView];
        });
    }

    /*

     Create listeners for when text is changed, solution by @madebydouglas derived from richardortiz84 https://github.com/nnhubbard/ZSSRichTextEditor/issues/5

     */

    NSString *inputListener = @"document.getElementById('editor').addEventListener('input', function() {window.webkit.messageHandlers.jsm.postMessage('input');});";
    NSString *pasteListener = @"document.getElementById('editor').addEventListener('paste', function() {window.webkit.messageHandlers.jsm.postMessage('paste');});";

    [webView evaluateJavaScript:inputListener completionHandler:^(NSString *result, NSError *error) {
        if (error != NULL) {
            NSLog(@"%@", error);
        }
    }];

    [webView evaluateJavaScript:pasteListener completionHandler:^(NSString *result, NSError *error) {
        if (error != NULL) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)focusEditor:(WKWebView*)editorView {
  NSLog(@"focus Editor");
  NSString* js = @"var editor = $('#editor');var range = document.createRange();range.selectNodeContents(editor.get(0));range.collapse(false);var selection = window.getSelection();selection.removeAllRanges();selection.addRange(range);editor.focus();";
  [editorView evaluateJavaScript:js completionHandler:^(NSString *result, NSError *error) {

  }];
}

- (void)focusTextEditor:(WKWebView*)editorView {

    //TODO: Is this behavior correct? Is it the right replacement?
//    self.editorView.keyboardDisplayRequiresUserAction = NO;
    [WebViewInjection allowDisplayingKeyboardWithoutUserAction];

    NSString *js = [NSString stringWithFormat:@"editor.focusEditor();"];
    [editorView evaluateJavaScript:js completionHandler:^(NSString *result, NSError *error) {

    }];

}

@end
