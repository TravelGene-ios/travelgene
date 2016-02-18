//
//  Friend.m
//  LYCFriendList
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 TravelGene. All rights reserved.
//

#import "Friend.h"

@implementation Friend

@synthesize friendId, friendName, friendEmail, friendGender, friendAge, friendImg;

- (id)initWithFriendName: (NSString *)fName andFriendId: (NSString *)fId andFriendEmail: (NSString *)fEmail andFriendGender: (NSString *)fGender andFriendAge: (NSString *)fAge andFriendImg: (NSString *)fImg {
    self = [super init];
    if (self) {
        friendId = fId;
        friendName = fName;
        friendEmail = fEmail;
        friendAge = fAge;
        friendGender = fGender;
        friendImg = fImg;
    }
    return self;
}

@end
