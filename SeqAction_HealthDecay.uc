//------------------------------------------------------------------------------------------
// Author:    Team Bravo
// Date:      December 21, 2014
// 
// Purpose: Begins a timer countdown when activated. If it hits zero, kill player pawn.
//
//------------------------------------------------------------------------------------------
// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAction_HealthDecay extends SequenceAction;

//------------------------------------------------------------------------------------------
event Activated()
{
	startDecay();
}

//------------------------------------------------------------------------------------------
function startDecay()
{
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	if( rWorldInfo != none )
	{
		rGame = ADP_GameType( rWorldInfo.Game );

		if( rGame != none && rGame.decayActive == false)
		{
			rGame.decayActive = true;
		}
		else
		{
			rGame.decayActive = false;
		}
	}
}

//------------------------------------------------------------------------------------------
defaultproperties
{
	ObjName="Health Decay"
	ObjCategory="ADP"
}
