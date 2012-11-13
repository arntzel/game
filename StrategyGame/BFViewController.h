//
//  BFViewController.h
//  StrategyGame
//
//  Created by Eliot Arntz on 10/22/12.
//  Copyright (c) 2012 Eliot Arntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFViewController : UIViewController
<UIGestureRecognizerDelegate>

//iBoulets
@property (strong, nonatomic) NSMutableArray *tiles;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

//ivars
@property (nonatomic) BOOL playerTurnToAddPieces;
@property (nonatomic) BOOL gameStarted;
@property (nonatomic) BOOL whitesTurn;
@property (nonatomic) BOOL middleOfTurn;

@property int numberOfPiecesOnBoard;
@property (strong, nonatomic) NSMutableArray *piecesLocationsOnBoard;
@property (strong, nonatomic) NSArray *possibleMovesArray;
@property (strong, nonatomic) NSMutableArray *blackTiles;
@property (strong, nonatomic) NSMutableArray *whiteTiles;
@property (strong, nonatomic) NSMutableArray *blackSquareImages;
@property (strong, nonatomic) NSMutableArray *whiteSquareImages;
@property (strong, nonatomic) NSMutableArray *blinkingTiles;


//ibaction
- (IBAction)startPressed:(id)sender;
-(void)tapRecognizer:(UITapGestureRecognizer *)tapRecognizer;

//methods
-(void)whitePlayerTurn:(UIView *)image;
-(void)blackPlayerTurn:(UIView *)image;
-(NSMutableArray *)adjacentTiles:(UIView *)image;

@end
