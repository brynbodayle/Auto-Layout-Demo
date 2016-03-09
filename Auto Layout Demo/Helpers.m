//
//  Helpers.m
//  Auto Layout Demo
//
//  Created by Bryn Bodayle on March/9/2016.
//  Copyright © 2016 Bryn Bodayle. All rights reserved.
//

#import "Helpers.h"

NSString *const LoremIpsum = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ultricies tempus aliquet. Pellentesque cursus tellus eget elit dignissim pharetra. Nam ornare facilisis sollicitudin. Nam efficitur laoreet nisl. Quisque finibus metus consequat, consequat dolor ut, varius sapien. Proin vitae gravida quam, vel facilisis ipsum. Aenean eget porttitor eros, ac viverra diam. Integer varius mi odio, ut interdum ligula rhoncus ut. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam eu turpis sed eros consequat posuere. Duis lacinia purus quis urna cursus, non pulvinar libero scelerisque. Nulla vehicula faucibus tortor nec volutpat. Proin ac nibh non felis malesuada egestas. Proin dictum nibh posuere, dignissim ante non, mollis tellus.Proin et sodales mi, sit amet auctor nisl. Nam mollis faucibus erat ut mollis. Etiam sit amet ipsum posuere, rhoncus nisl eget, bibendum massa. Etiam dignissim rutrum turpis sed scelerisque. Phasellus lobortis pulvinar tincidunt. Nullam id orci volutpat, semper urna eu, ornare dolor. Donec convallis a odio a pharetra.Ut euismod interdum lorem. Ut tristique eget mauris nec ultricies. Maecenas facilisis libero ac nibh auctor, quis dapibus eros congue. Etiam ullamcorper libero tellus, nec accumsan risus convallis in. Praesent at ipsum non nibh pharetra dapibus in non odio. Donec lacus velit, finibus ac nisl nec, convallis ultrices quam. Ut commodo venenatis mattis. Donec a sollicitudin nibh. Vivamus aliquam nisl felis, nec ullamcorper sem pharetra pulvinar. Quisque fringilla, quam id dignissim mollis, lacus urna imperdiet nisi, vel tincidunt arcu ipsum sit amet lectus. Ut blandit euismod elit vel faucibus. Curabitur ultrices ante nisl, nec pellentesque elit ullamcorper non. Integer fringilla tortor ut ullamcorper eleifend. Duis tristique sed tortor quis cursus. Ut quis dictum ante.";

NSString *SampleText(NSUInteger minLength, NSUInteger maxLength) {
    
    NSUInteger textLength = (arc4random() % maxLength) + minLength;
    
    NSUInteger remainingString = LoremIpsum.length - textLength;
    NSUInteger startIndex = arc4random() % remainingString;
    
    NSString *substring = [LoremIpsum substringWithRange:NSMakeRange(startIndex, textLength)];
    NSString *trimmedString = [substring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *capitalizedFirstLetter = [trimmedString substringToIndex:1].uppercaseString;
    trimmedString = [NSString stringWithFormat:@"%@%@", capitalizedFirstLetter, [trimmedString substringFromIndex:1]];
    
    return trimmedString;
}