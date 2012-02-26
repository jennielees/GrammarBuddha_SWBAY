//
//  HelloWorldLayer.m
//  GrammarBuddhaMenu
//
//  Created by Anita Weil on 2/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "ArcadeLayer.h"

// HelloWorldLayer implementation
@implementation ArcadeLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ArcadeLayer *layer = [ArcadeLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        CGSize screenSize = [CCDirector sharedDirector].winSize;
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"ARCADE GOES HERE" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        
        CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"BACK" fontName:@"Last Ninja" fontSize:60];
        CCMenuItemLabel *backButtonLabel = [CCMenuItemLabel itemWithLabel:backLabel target:self selector:@selector(goBack)];
        //titleLabel.position = ccp(screenSize.width/2, screenSize.height*0.9f);
        //[self addChild:titleLabel];
        
        CCMenu *mainMenu = [CCMenu menuWithItems:backButtonLabel,nil];
        [mainMenu setPosition: ccp(screenSize.width/2, screenSize.height*0.35f)];
        [self addChild:mainMenu];
        
        
	}
	return self;
}

-(void) goBack {
    [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
