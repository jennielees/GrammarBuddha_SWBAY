//
//  Quiz.m
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import "Quiz.h"
#import "QuizQuestion.h"
#import "GrammarQuestion.h"

@implementation Quiz

@dynamic startedAt;
@dynamic finishedAt;
@dynamic secondsRemaining;
@dynamic quizQuestions;

- (QuizQuestion*) appendNewQuizQuestionWithError:(NSError**)error {
    // Grab a list of questions currently not within this quiz
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"QuizQuestion"];
    
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:error];
    NSMutableArray *listOfIDs = [NSMutableArray array];
    [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [listOfIDs addObject:[[((QuizQuestion*)obj) grammarQuestion] grammarQuestionID]];
    }];
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"GrammarQuestion"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (grammarQuestionID in %@) AND usable = %@", listOfIDs, [NSNumber numberWithBool:YES]];
    [request setPredicate:predicate];
    
    NSUInteger remainingQuestions = [self.managedObjectContext countForFetchRequest:request error:error];
    
    if (remainingQuestions == 0) {
        *error = [NSError errorWithDomain:@"NotEnoughQuestions" code:1 userInfo:nil];
        return nil;;
    }
    
    request.fetchLimit = 1;
    request.fetchOffset = arc4random() % remainingQuestions;
    
    results = [self.managedObjectContext executeFetchRequest:request error:error];
    GrammarQuestion *grammarQuestion = [results objectAtIndex:0];
    QuizQuestion *quizQuestion = [[QuizQuestion alloc] initWithEntity:
                                  [NSEntityDescription entityForName:@"QuizQuestion" inManagedObjectContext:self.managedObjectContext] 
                                       insertIntoManagedObjectContext:self.managedObjectContext];
    
    quizQuestion.grammarQuestion = grammarQuestion;
    quizQuestion.createdAt = [NSDate date];
    [self addQuizQuestionsObject:quizQuestion];

    return quizQuestion;
}

// REMOVE THIS AFTER APPLE FIXES BUG
- (void)addQuizQuestionsObject:(QuizQuestion *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.quizQuestions];
    [tempSet addObject:value];
    self.quizQuestions = tempSet;
}

@end
