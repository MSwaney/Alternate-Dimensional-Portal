// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAction_AddLife extends SequenceAction;

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
			rGame.gainLife();
		}
	}
}

defaultproperties
{
	ObjName="Add Life"
	ObjCategory="ADP"

	InputLinks.empty;
	InputLinks(0) = (LinkDesc="In");
}
