//------------------------------------------------------------------------------------------
// Author:    Team Bravo
// Date:      February 15, 2014
// 
// Purpose: Check to determine if player has any lives remaining. 
//
//------------------------------------------------------------------------------------------
class SeqCond_GameOverCheck extends SequenceCondition;

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
			if ( rGame.iLives == 0 )
			{
   				OutputLinks[0].bHasImpulse = true;
			}
			else
			{
				OutputLinks[1].bHasImpulse = true;
			}
		}
	}
}

defaultproperties
{
	ObjName="Game Over Check"
	ObjCategory="ADP"

	InputLinks.empty;
	InputLinks(0) = (LinkDesc="In");

	OutputLinks.empty;
	OutputLinks(0) = (LinkDesc="True");
	OutputLinks(1) = (LinkDesc="False");

	bAutoActivateOutputLinks = false;
}
