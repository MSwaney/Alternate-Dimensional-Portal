//------------------------------------------------------------------------------------------
// Author:    Team Bravo
// Date:      February 6, 2015
// 
// Purpose: Change the displayed dimension (on HUD) the player is currently in.
//
//------------------------------------------------------------------------------------------
// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAction_DimensionChangeALT extends SequenceAction;

//------------------------------------------------------------------------------------------
event Activated()
{
	changeDimension();
}

//------------------------------------------------------------------------------------------
function changeDimension()
{
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	if( rWorldInfo != none )
	{
		rGame = ADP_GameType( rWorldInfo.Game );

		if( rGame != none && rGame.sDimension != "Alternate")
		{
			rGame.sDimension = "Alternate";
		}
		else
		{
			rGame.sDimension = "Original";
		}
	}
}

//------------------------------------------------------------------------------------------

defaultproperties
{
	ObjName="Change Dimension_Alternate"
	ObjCategory="ADP"
}
