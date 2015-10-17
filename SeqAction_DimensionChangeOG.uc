//------------------------------------------------------------------------------------------
// Author:    Team Bravo
// Date:      February 6, 2015
// 
// Purpose: Change the displayed dimension (on HUD) the player is currently in.
//
//------------------------------------------------------------------------------------------
// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAction_DimensionChangeOG extends SequenceAction;

//------------------------------------------------------------------------------------------
event Activated()
{
	changeDimensionOG();
}

//------------------------------------------------------------------------------------------
function changeDimensionOG()
{
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	if( rWorldInfo != none )
	{
		rGame = ADP_GameType( rWorldInfo.Game );

		if( rGame != none && rGame.sDimension != "Original" )
		{
			rGame.sDimension = "Original";
		}
	}
}

//------------------------------------------------------------------------------------------

defaultproperties
{
	ObjName="Change Dimension_Original"
	ObjCategory="ADP"
}
