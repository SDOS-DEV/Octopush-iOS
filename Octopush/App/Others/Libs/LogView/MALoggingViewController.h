//  Octopush
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import <UIKit/UIKit.h>

@interface MALoggingViewController : UIViewController {
    UITextView *_textView;
    CGFloat _currentFontSize;
}

- (void)logToView:(NSString *)format, ...;

@end
