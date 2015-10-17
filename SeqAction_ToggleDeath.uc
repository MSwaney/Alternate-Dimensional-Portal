//------------------------------------------------------------------------------------------
// Author:    Team Bravo
// Date:      January 30, 2015
// 
// Purpose: Used for toggling death message "Press SPACE to restart."
//
//------------------------------------------------------------------------------------------

class SeqAction_ToggleDeath extends SequenceAction;

event Activated()
{
	ToggleDeath();
}

function ToggleDeath()
{
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	if( rWorldInfo != none )
	{
		rGame = ADP_GameType( rWorldInfo.Game );

		if( rGame != none && rGame.bDead == false)
		{
			rGame.bDead = true;
		}
		else
		{
			rGame.bDead = false;
		}
	}
}

DefaultProperties
{
	ObjName="Toggle Death"
	ObjCategory="ADP"
}
