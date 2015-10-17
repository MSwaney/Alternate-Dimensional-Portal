//------------------------------------------------------------------------------------------------ 
// Author:  Team Bravo
// Date:    December 21, 2014
// Credit:  http://udn.epicgames.com/Three/GametypeTechnicalGuide.html
//
// Purpose: Game Type for Team Bravo's Alternate Dimension Portal
//
//------------------------------------------------------------------------------------------------
class ADP_GameType extends UTGame;

//------------------------------------------------------------------------------------------------
var float decayTimer;
var string sDimension;
var bool decayActive;
var bool bDisplay;
var bool bDead;
var int iLives;
var int cLevel;

//------------------------------------------------------------------------------------------
// Tick function for health decay in alternate dimension
function tick( float deltaTime )
{
	if( decayActive == true )
	{
		decayTimer -= deltaTime;
	}
	else
	{
		decayTimer = 25;
	}
}

//------------------------------------------------------------------------------------------
// Lives function, game end at 0 lives
function loseLife()
{
    if(iLives == 0)
	{
		iLives = 0;
	}
	else 
	{
		iLives--;
	}
}
//------------------------------------------------------------------------------------------
// Lives function, if player has less than 5, reward him with a new life
function gainLife()
{
	if(iLives < 5)
	{
		iLives++;
	}
}

//------------------------------------------------------------------------------------------------
DefaultProperties
{
	bDelayedStart=false     //We want to jump straight into the game

	HUDType=class'ADP.ADP_HUD';
	bUseClassicHUD = true;  //Disable the flash HUD

	//Variables
	decayTimer = 25;
	sDimension = "Original";
	decayActive = false;
	bDisplay = true;
	bDead = false;
	iLives = 3;
	cLevel = 1;

	DefaultInventory(0)=none;
    DefaultPawnClass = class'ADP_Pawn'
	PlayerControllerClass = class'ADP_PlayerController'

	MapPrefixes[1]="ADP"
}
