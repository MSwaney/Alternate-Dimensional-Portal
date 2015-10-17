// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAction_LevelUpdate extends SequenceAction;

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
			if (InputLinks[0].bHasImpulse)
			{
				rGame.cLevel = 1;
			}
			else if (InputLinks[1].bHasImpulse)
			{
				rGame.cLevel = 2;
			}
			else if (InputLinks[2].bHasImpulse)
			{
				rGame.cLevel = 3;
			}
			else if (InputLinks[3].bHasImpulse)
			{
				rGame.cLevel = 4;
			}
			else if (InputLinks[4].bHasImpulse)
			{
				rGame.cLevel = 5;
			}
			else if (InputLinks[5].bHasImpulse)
			{
				rGame.cLevel = 6;
			}
			else if (InputLinks[6].bHasImpulse)
			{
				rGame.cLevel = 7;
			}
			else if (InputLinks[7].bHasImpulse)
			{
				rGame.cLevel = 8;
			}
			else if (InputLinks[8].bHasImpulse)
			{
				rGame.cLevel = 9;
			}
			else if (InputLinks[9].bHasImpulse)
			{
				rGame.cLevel = 10;
			}
		}
	}
}

defaultproperties
{
	ObjName="Current Level Update"
	ObjCategory="ADP"

	InputLinks.empty;
	InputLinks(0) = (LinkDesc="Level 1");
	InputLinks(1) = (LinkDesc="Level 2");
	InputLinks(2) = (LinkDesc="Level 3");
	InputLinks(3) = (LinkDesc="Level 4");
	InputLinks(4) = (LinkDesc="Level 5");
	InputLinks(5) = (LinkDesc="Level 6");
	InputLinks(6) = (LinkDesc="Level 7");
	InputLinks(7) = (LinkDesc="Level 8");
	InputLinks(8) = (LinkDesc="Level 9");
	InputLinks(9) = (LinkDesc="Level 10");
}
