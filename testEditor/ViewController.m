//
//  ViewController.m
//  testEditor
//
//  Created by Takayuki Kamezawa on 2020/08/23.
//  Copyright © 2020 Takayuki Kamezawa. All rights reserved.
//

#import "ViewController.h"
#import "EditorDelegate.h"

@interface ViewController ()
@property (nonatomic,strong) EditorDelegate* editDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.editDelegate = [[EditorDelegate alloc] init];
  // Do any additional setup after loading the view.
  [self initializeWebView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self loadEditorHtml];
}

- (void)loadEditorHtml {
  NSString* workingDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
  [self loadHTML:[workingDir stringByAppendingPathComponent:@"editor.html"]];
}

- (void)loadHTML:(NSString *)path {
  NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"editor" ofType:@"html"];
  NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
  [self.webview loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:path]];
}

-(void)initializeWebView {
  self.webview = [[WKWebView alloc]initWithFrame:self.view.frame];
  [self.view addSubview:_webview];
  _webview.translatesAutoresizingMaskIntoConstraints = NO;
  // 上
  NSLayoutConstraint* topAnchor = [_webview.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0];
  // 左
  NSLayoutConstraint* leftAnchor = [_webview.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0];
  // 右
  NSLayoutConstraint* rightAnchor = [_webview.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0];
  // 高さ
  NSLayoutConstraint* heightAnchor = [_webview.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0];
  [self.view addConstraint:topAnchor];
  [self.view addConstraint:leftAnchor];
  [self.view addConstraint:rightAnchor];
  [self.view addConstraint:heightAnchor];
}

@end
