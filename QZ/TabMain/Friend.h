//
//  Friend.h
//  LYCFriendList
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 TravelGene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (strong, nonatomic) NSString *friendName;
@property (strong, nonatomic) NSString *friendId;
@property (strong, nonatomic) NSString *friendEmail;
@property (strong, nonatomic) NSString *friendGender;
@property (strong, nonatomic) NSString *friendAge;
@property (strong, nonatomic) NSString *friendImg;

- (id)initWithFriendName: (NSString *)fName andFriendId: (NSString *)fId andFriendEmail: (NSString *)fEmail andFriendGender: (NSString *)fGender andFriendAge: (NSString *)fAge andFriendImg: (NSString *)fImg;

@end
