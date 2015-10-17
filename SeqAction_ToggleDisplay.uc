//------------------------------------------------------------------------------------------
// Author:    Team Bravo
// Date:      January 23, 2015
// 
// Purpose: Toggle the camera display HUD text (Hide vs Show) when activated.
//
//------------------------------------------------------------------------------------------

class SeqAction_ToggleDisplay extends SequenceAction;

event Activated()
{
	ToggleDisplay();
}

function ToggleDisplay()
{
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	if( rWorldInfo != none )
	{
		rGame = ADP_GameType( rWorldInfo.Game );

		if( rGame != none && rGame.bDisplay == false)
		{
			rGame.bDisplay = true;
		}
		else
		{
			rGame.bDisplay = false;
		}
	}
}

DefaultProperties
{
	ObjName="Toggle Display"
	ObjCategory="ADP"
}
