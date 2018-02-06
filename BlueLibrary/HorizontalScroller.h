//
//  HorizontalScroller.h
//  BlueLibrary
//
//  Created by Olya Tilichenko on 06.02.18.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorizontalScrollerDelegate;


@interface HorizontalScroller : UIView

@property (weak) id<HorizontalScrollerDelegate> delegate; //Это необходимо, чтобы предотвратить «retain-зацикливание»
- (void)reload;

@end

@protocol HorizontalScrollerDelegate <NSObject>

@required

// Спросить делегата, сколько представлений мы покажем внутри горизонтального скроллера
- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller;

// Попросить делегата получить представление по индексу <index>
- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(int)index;

// Сообщить делегату о нажатии на представлении по индексу <index>
- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(int)index;

@optional

// Спросить делегата, какое из представлений отобразить при открытии
// (метод необязательный, по умолчанию 0, если делегат не реализует метод)
- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller *)scroller;
@end
