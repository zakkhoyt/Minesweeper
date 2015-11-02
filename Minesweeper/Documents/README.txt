

The user starts on ZHOptionsTableViewController where they can set a few game options.
* The number of cells that the board has. Height calculated using the aspect ratio of the screen
* Number of mines. The user can enter a number manually or tap the "Level" button for suggested mine counts
* Use SpriteKit or use UIKit (UICollectionView). I first wrote this to use UIKit, but performance gets pretty terrible when a high density is used. See UICollectionView_heirarchy.png.
* Start. When start is pressed an instance of ZHBoard is created using the options and then passed to the Game view controller.

The game's logic consists of ZHBoard and ZHCell.
* ZHBoard (see ZHBoard.h)
    * Contains a dictionary of ZHCells. I chose to use a dictionary with lookup keys to find neighboring cells. The key looks like "x<x>:y<y>". This could be done using an array just as easily.
    * Processes the playing of a cell on background queues
    * Methods to return a cell from either the key string, or NSIndexPath.
    * Method to retrieve all neighboring cells for a cell.
    * Callback blocks which are called on certain events. The ViewController should implement these to be notified. Perhaps a delegate/protocol should be used here since some callbacks are required.
    * Keeps tally of moves, mine count, cheat count, etc...
* ZHCell is a model for a board cell.
    * isBomb: Contains a mine
    * isCheat: The user pressed the cheat button to reveal a free cell
    * adjacentBombCount
    * isPlayed

I've provided two implementations of rendering view controllers.
* One for UIKit using a UICollectionView. A mentioned above UICollectionView gets pretty bogged down when a cell count of 20xH or more is used. I could have created a UIView subclass and used CoreGraphics to render the cells. I used this approach for one of my personal published apps YAGOLA:
    * https://github.com/zakkhoyt/YAGOLA
    * https://itunes.apple.com/us/app/yet-another-game-of-life-app/id663581165?mt=8
* Another using SpriteKit, a scene, and some nodes.
Each view controller is passed an instance of ZHBoard and implments ZHBoard's callback blocks to know when to render visual feedback. This decouples the game from the rendering.



What have I done to profile the app?
    * Using Instruments I ran both an Allocatoins analysis and a Time Profile analysis. This is how I determined that UICollectionView was the bottle neck.
    * I found that all large allocations and most processor time was spent on system calls and very little in my game locic.
    * The game engine code seems to be efficient.
    * My spritekit code could be improved by add the nodes only once at load time and then update only the cells that have changed. It currently redraws the entire board each time renderBoard is called (only on touch events and load).

What could be improved about this code?
    * When a cell is played I use recursion to find the neighboring cells. If you set the board to something high like 30xH with a low mine count, the stack limit is reached and the app will crash. A good solution would be to use an iterative approach instead of recursion.
    * ZHSpriteKitGameViewController and ZHUIKitGameViewController contain duplicate code which manages the buttons and labels. These code should be abstracted to a base ZHViewController subclass.
    * ZHBoard could execute the setup code on background queues. It is currently called during init. Using an init with a completion block would be strange, so we would need to create another public method with a callback block which would need to be called after init by the caller.

What could be added to fill the app out a bit?
    * Keeping a history of your game play (games played, games won, leaderboards). Perhaps using gamecenter and/or CloudKit/CoreData.
    * Various other cheats that the "free cell" cheat that I've provided.
    * First move to be a freebie (guaranteed not to be a mine). We could either reassign that mine to another spot, or layout the mines after the first cell is played.
    * Some particle emitters and sound effects would add a lot. This is easy to do with spritekit and a bit more involved with UIKit.

Source code is available on github: https://github.com/zakkhoyt/Minesweeper

