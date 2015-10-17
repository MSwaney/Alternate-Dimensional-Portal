//------------------------------------------------------------------------------------------
// Author:    Team Bravo
// Date:      December 21, 2014
// 
// Purpose: Change the displayed dimension (on HUD) the player is currently in.
//
//------------------------------------------------------------------------------------------
class SeqCond_DecayCheck extends SequenceCondition;

event Activated()
{
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	if( rWorldInfo != none )
	{
		rGame = ADP_GameType( rWorldInfo.Game );

		if( rGame != none )
		{
			if ( rGame.decayTimer <= 0 )
			{
				OutputLinks[0].bHasImpulse = true;
			}
			else
			{
				OutputLinks[0].bHasImpulse = false;
			}
		}
	}
}

defaultproperties
{
	ObjName="Decay Death Check"
	ObjCategory="ADP"

	InputLinks.empty;
	InputLinks(0) = (LinkDesc="In");

	OutputLinks.empty;
	OutputLinks(0) = (LinkDesc="Timer = 0");
	//OutputLinks(1) = (LinkDesc="Timer Reset");

	bAutoActivateOutputLinks = false;
}
