//
//  BFViewController.m
//  StrategyGame
//
//  Created by Eliot Arntz on 10/22/12.
//  Copyright (c) 2012 Eliot Arntz. All rights reserved.
//

#import "BFViewController.h"
#define IMAGE_COUNT 9

@interface BFViewController ()
@end

@implementation BFViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _tiles = [[NSMutableArray alloc]init];
    _piecesLocationsOnBoard = [[NSMutableArray alloc]init];
    _blackTiles = [[NSMutableArray alloc]init];
    _whiteTiles = [[NSMutableArray alloc]init];
    _blinkingTiles = [[NSMutableArray alloc]init];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"macBackGround.png"]];
    self.view.backgroundColor = background;
    
    _numberOfPiecesOnBoard = 0;
    
    _possibleMovesArray = @[
                          // horizontal grouping
                          @[@0,@1,@2],@[@3,@4,@5],@[@6,@7,@8],@[@9,@10,@11],
                          @[@12,@13,@14],@[@15,@16,@17],@[@18,@19,@20],@[@21,@22,@23],
                          // vertical grouping
                          @[@0,@9,@21],@[@3,@10,@18],@[@6,@11,@15],@[@1,@4,@7],
                          @[@16,@19,@22],@[@8,@12,@17],@[@5,@13,@20],@[@2,@14,@23]];
                          // diagnol grouping
                          //@[@0,@3,@6],@[@2,@5,@8],@[@21,@18,@15],@[@23,@20,@17]];
    
    
    _blackSquareImages = [[NSMutableArray alloc] initWithCapacity:9];
    for(int a = 1; a < IMAGE_COUNT; a ++){
        NSString *blackSquare = [[NSString alloc] initWithFormat:@"blackSquare%i.png",a];                
        [_blackSquareImages addObject:[UIImage imageNamed:blackSquare]];
    }
    _whiteSquareImages = [[NSMutableArray alloc] initWithCapacity:9];
    for(int a = 1; a < IMAGE_COUNT; a ++){
        NSString *whiteSquare = [[NSString alloc] initWithFormat:@"whiteSquare%i.png",a];
        [_whiteSquareImages addObject:[UIImage imageNamed:whiteSquare]];
    }
}



-(void)blackPlayerTurn:(UIImageView *)blackTile{
    
}

-(void)whitePlayerTurn:(UIView *)whiteTile{
    
    //to end turn set _whitesTurn = NO;
    
    NSMutableArray *adjacentTiles = [self createAdjacentTiles:whiteTile];
    
    if((_blinkingTiles.count > 0) && ([_blinkingTiles containsObject:whiteTile])) {
        
        NSLog(@"true");
        [(UIImageView *)whiteTile setImage:nil];
        
        
    //change the selected tile to UIWhiteColor
     //to do list.. stop animation of current tiles.   
    //Chane the old tile to WoodenBlock
        
    }
//        if([_blinkingTiles containsObject:tapRecognizer.view]){
//                //access the images array find the touched blinking image and set the background to nil.
//                for(UIImageView *image in _tiles){
//                    if(image.tag == tapRecognizer.view.tag ){
//                        [image setImage:nil];
//                    }
//                }
//                //you need to remove the image from the UIView
//            tapRecognizer.view.backgroundColor = [UIColor whiteColor];
//            }
//            else{
//            }
//    }
//    else{
//
else{
    //fast enumeration
    if(_middleOfTurn != YES){
        for(UIImageView *imageInTiles in _tiles){
            //if adjacentTiles array has image from tiles arrays.
            if([adjacentTiles containsObject:[NSNumber numberWithInt:imageInTiles.tag]]){
                if(imageInTiles.backgroundColor != [UIColor blackColor] && imageInTiles.backgroundColor != [UIColor whiteColor]){
                    //_whiteSquareImages is an array of current white animation images
                    imageInTiles.animationImages = _whiteSquareImages;
                    imageInTiles.animationDuration = 2;
                    [imageInTiles startAnimating];
                    //NSLog(@"imageInTiles %@",imageInTiles);
                    [_blinkingTiles addObject:imageInTiles];
                    NSLog(@"blinkingTilesArray %@",_blinkingTiles);
                    _middleOfTurn = YES;
                }
            }
        }
    }
    else{
        for(UIImageView *blinkingImages in _blinkingTiles){
            [blinkingImages stopAnimating];
            NSLog(@" secondBlindTiles %@",_blinkingTiles);
            _middleOfTurn = NO;
        }
        //when you set an array to nil you must then reallocate and initialize it
        _blinkingTiles = nil;
        _blinkingTiles = [[NSMutableArray alloc] init];
    }
}
}
-(NSMutableArray *)createAdjacentTiles:(UIView *)image{
    //NSNumber repersents the tag of the currently selected tile
    NSNumber *tileSelected = [[NSNumber alloc]initWithInt:image.tag];
    //holds an array of the current adjacent tiles
    NSMutableArray *adjacentTiles = [[NSMutableArray alloc] init];
    //for loop that appends adjacent tiles to hold an array of all adjacent tiles to the current tileSelected
    if(_whitesTurn == YES){
    for (int i = 0; i < _possibleMovesArray.count; i ++){
        if ([[_possibleMovesArray objectAtIndex:i] containsObject:tileSelected] &&    
            [image.backgroundColor isEqual:[UIColor whiteColor]]){
            int x = [[_possibleMovesArray objectAtIndex:i]indexOfObject:tileSelected];
            NSArray *secondArray = [_possibleMovesArray objectAtIndex:i];
            if(x+1 < secondArray.count){
                [adjacentTiles addObject:[secondArray objectAtIndex:x+1]];
            }
            if(x > 0){
                [adjacentTiles addObject:[secondArray objectAtIndex:x-1]];
            }
        }
        else{
        }
    }
    return adjacentTiles;
    }
    else{
        for (int i = 0; i < _possibleMovesArray.count; i ++){
            if ([[_possibleMovesArray objectAtIndex:i] containsObject:tileSelected] &&
                [image.backgroundColor isEqual:[UIColor blackColor]]){
                int x = [[_possibleMovesArray objectAtIndex:i]indexOfObject:tileSelected];
                NSArray *secondArray = [_possibleMovesArray objectAtIndex:i];
                if(x+1 < secondArray.count){
                    [adjacentTiles addObject:[secondArray objectAtIndex:x+1]];
                }
                if(x > 0){
                    [adjacentTiles addObject:[secondArray objectAtIndex:x-1]];
                }
            }
            else{
            }
        }
        return adjacentTiles;
    }
}

-(void)tapRecognizer:(UITapGestureRecognizer *)tapRecognizer{
    //NSLog(@"%i",tapRecognizer.view.tag);        
    if(_gameStarted != YES){
        
    //add pieces to board logic
        //BOOL _playerTurnToAddPieces switches between white and black for initial setup, player turns are later managed by white by white player vs black player turn methods
        if(_playerTurnToAddPieces != YES){
            //if the tile is already white/black do nothing so the user cannot overwrite previously set tiles, otherwise set the tile to the appropriate color
            if([tapRecognizer.view.backgroundColor isEqual:[UIColor whiteColor]] || [tapRecognizer.view.backgroundColor isEqual:[UIColor blackColor]]) {
            }
            else{
            [(UIImageView *)tapRecognizer.view setImage:nil];

            [(UIImageView *)tapRecognizer.view setBackgroundColor:[UIColor whiteColor]];
            
            //create a whilte tiles array to keep track of tag #'s of all white tiles currently on the board.
            NSNumber *whiteTile = [[NSNumber alloc] initWithInt:tapRecognizer.view.tag];
            [_whiteTiles addObject:whiteTile];
            NSNumber *viewTagInt = [[NSNumber alloc]initWithInt:tapRecognizer.view.tag];
            [_piecesLocationsOnBoard addObject:viewTagInt];
            _numberOfPiecesOnBoard ++;
            _playerTurnToAddPieces = YES;
            }
        }
        else{
            //if the tile is already white/black do nothing so the user cannot overwrite previously set tiles, otherwise set the tile to the appropriate color
            
            if([tapRecognizer.view.backgroundColor isEqual:[UIColor whiteColor]] || [tapRecognizer.view.backgroundColor isEqual:[UIColor blackColor]]){
            }
            else{
            [(UIImageView *)tapRecognizer.view setImage:nil];
            [(UIImageView *)tapRecognizer.view setImage:nil];
            [(UIImageView *)tapRecognizer.view setBackgroundColor:[UIColor blackColor]];
                
            NSNumber *blackTile = [[NSNumber alloc] initWithInt:tapRecognizer.view.tag];
            [_blackTiles addObject:blackTile];
            _playerTurnToAddPieces = NO;
            _numberOfPiecesOnBoard ++;
            //start game off with white's turn
            _whitesTurn = YES;
            }
        }
    }
    if(_numberOfPiecesOnBoard >= 8){
        _gameStarted = YES;
    }
    
    //Game Started _numberOfPiecesOnBoard >= 8;
    if(_gameStarted == YES){
        
        //if there are blinking tiles and user picks a blinking tile change that to the current player's turn otherwise do the old whitePlayerTurnLogic//
        //if (tapRecognizer.view.tag)
            
        //no if statement for white vs black turn
        
        if(_whitesTurn == YES){
        [self whitePlayerTurn:tapRecognizer.view];
        }
        else{
        [self blackPlayerTurn:tapRecognizer.view];
        }
    }
}

- (IBAction)startPressed:(id)sender {
    UIImage *woodenBlock = [UIImage imageNamed:@"woodSquare.png"];

    NSArray *xNumbers = @[@20,@145,@270,@60,@145,@230,@105,@145,
                        @185,@20,@60,@105,@185,@230,@270,@105,@145,
                        @185,@60,@145,@230,@20,@145,@270];
    NSArray *yNumbers = @[@10, @10, @10, @80, @80, @80, @150, @150,
                        @150, @220, @220, @220, @220, @220, @220, @290,
                        @290, @290, @360, @360, @360, @430, @430, @430];
    
    float height = 30;
    float width = 30;
    for (int x = 0; x < [xNumbers count]; x++) {

        UIImageView *blockImageView = [[UIImageView alloc] initWithFrame:CGRectMake([xNumbers[x]intValue], [yNumbers[x]intValue], height, width)];
        //add user interaction
        blockImageView.userInteractionEnabled = YES;
        
        blockImageView.tag = x;
        [blockImageView setImage:woodenBlock];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
        [tapRecognizer setNumberOfTapsRequired:1];
        //[tapRecognizer setDelegate:self];
        tapRecognizer.delegate = self;
        [blockImageView addGestureRecognizer:tapRecognizer];
        [self.view addSubview:blockImageView];
        
        [_tiles addObject:blockImageView];
    }
    //reset the counter for the owner of blocks.
    _numberOfPiecesOnBoard = 0;
    [_startButton setHidden:YES];
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end