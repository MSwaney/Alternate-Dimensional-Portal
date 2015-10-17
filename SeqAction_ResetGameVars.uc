// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAction_ResetGameVars extends SequenceAction;

event Activated()
{
	resetGameVars();
}

//------------------------------------------------------------------------------------------
function resetGameVars()
{
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	if( rWorldInfo != none )
	{
		rGame = ADP_GameType( rWorldInfo.Game );

		if( rGame != none )
		{
			rGame.decayTimer = 25;
			rGame.sDimension = "Original";
			rGame.decayActive = false;
			rGame.bDisplay = true;
			rGame.iLives = 3;
			rGame.cLevel = 1;
		}
	}
}

//------------------------------------------------------------------------------------------
defaultproperties
{
	ObjName="Reset Game Variables"
	ObjCategory="ADP"
}
