//
//  EditorDelegate.h
//  testEditor
//
//  Created by Takayuki Kamezawa on 2020/08/23.
//  Copyright © 2020 Takayuki Kamezawa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditorDelegate : NSObject

@property(nonatomic) BOOL editorLoaded;
@property(nonatomic) BOOL shouldShowKeyboard;

- (void)focusTextEditor;

@end

NS_ASSUME_NONNULL_END
