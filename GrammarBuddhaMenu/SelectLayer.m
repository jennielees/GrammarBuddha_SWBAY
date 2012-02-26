//
//  HelloWorldLayer.m
//  GrammarBuddhaMenu
//
//  Created by Anita Weil on 2/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "SelectLayer.h"
#import "CustomCCNode.h"

// HelloWorldLayer implementation
@implementation SelectLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SelectLayer *layer = [SelectLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(void)displaySelectMenu {
    
	CGSize screenSize = [CCDirector sharedDirector].winSize;
    
	
	// Main Menu
	CCMenuItemImage *hpButton = [CCMenuItemImage
                                     itemFromNormalImage:@"hp.png"
                                     selectedImage:@"hp.png"
                                     disabledImage:nil
                                     target:self
                                 selector:@selector(chooseCat:)];
    CCMenuItemImage *twilightButton = [CCMenuItemImage
                                        itemFromNormalImage:@"twilight.png"
                                        selectedImage:@"twilight.png"
                                        disabledImage:nil
                                        target:self
                                       selector:@selector(chooseCat:)];
    twilightButton.tag = 2;
    CCMenuItemImage *gleeButton = [CCMenuItemImage
                                       itemFromNormalImage:@"glee.png"
                                       selectedImage:@"glee.png"
                                       disabledImage:nil
                                       target:self
                                   selector:@selector(chooseCat:)];

    gleeButton.tag = 3;
    
    CustomCCNode *hpNode = [CustomCCNode spriteWithFile:@"hp200.png"];
    hpNode.position = ccp(212,screenSize.height * 0.65f);
    hpNode.tag = 1;
    
    CustomCCNode *hpNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    hpNodeShadow.position = ccp(212,screenSize.height*0.65f);
    hpNodeShadow.opacity = 0;
    hpNode.linkedNode = hpNodeShadow;
    
    [self addChild:hpNode z:100];
    [self addChild:hpNodeShadow z:1];
    
    CustomCCNode *twilightNode = [CustomCCNode spriteWithFile:@"twilight200.png"];
    twilightNode.position = ccp(512,screenSize.height * 0.65f);
    twilightNode.tag = 2;
    [self addChild:twilightNode z:100];

    CustomCCNode *twNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    twNodeShadow.position = ccp(512,screenSize.height*0.65f);
    twNodeShadow.opacity = 0;
    twilightNode.linkedNode = twNodeShadow;
    [self addChild:twNodeShadow z:1];
    
    CustomCCNode *gleeNode = [CustomCCNode spriteWithFile:@"glee200locked.png"];
    gleeNode.position = ccp(812,screenSize.height * 0.65f);
    gleeNode.tag = 3;
    [self addChild:gleeNode z:100];    
    
    CustomCCNode *glNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    glNodeShadow.position = ccp(812,screenSize.height*0.65f);
    glNodeShadow.opacity = 0;
//    gleeNode.linkedNode = glNodeShadow;
//    [self addChild:glNodeShadow z:1];
    
    
    // Title
    
    
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"Pick your category" fontName:@"Last Ninja" fontSize:42];
    titleLabel.position = ccp(screenSize.width/2, screenSize.height*0.9f);
    [self addChild:titleLabel];
    
    self.isTouchEnabled = YES;
    
    
    CCLabelTTF *continueLabel = [CCLabelTTF labelWithString:@"Go!" fontName:@"Last Ninja" fontSize:60];
    CCMenuItemLabel *continueButtonLabel = [CCMenuItemLabel itemWithLabel:continueLabel target:self selector:@selector(continueGame)];
    //titleLabel.position = ccp(screenSize.width/2, screenSize.height*0.9f);
    //[self addChild:titleLabel];
    
	mainMenu = [CCMenu menuWithItems:continueButtonLabel,nil];
	[mainMenu setPosition: ccp(screenSize.width/2, screenSize.height*0.35f)];
	[self addChild:mainMenu];
    
    	
}

-(void) continueGame {
    // will dispatch game mode
    [[GameManager sharedGameManager] runSceneWithID:kArcadeScene];

}

-(void) chooseCat:(CCMenuItemImage *)whichImage {
    // not yet implemented
    int cat = whichImage.tag;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        if (self!= nil) {
            CGSize screenSize = [CCDirector sharedDirector].winSize;		
            CCSprite *background = [CCSprite spriteWithFile:@"buddha_muted.png"];
            [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [self addChild:background];
            [self displaySelectMenu];
            
        }
        
	}
	return self;
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
