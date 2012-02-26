//
//  ArcadeScene.m
//  SpaceViking
//
//  Created by Jennie Lees on 2/23/12.
//  Copyright 2012 Affect Labs Ltd. All rights reserved.
//

#import "ArcadeScene.h"

@implementation ArcadeScene

-(id)init {
	self = [super init];
	if (self != nil) {
		arcadeLayer = [ArcadeLayer node];
		[self addChild:arcadeLayer];
	}
	return self;
}

@end
