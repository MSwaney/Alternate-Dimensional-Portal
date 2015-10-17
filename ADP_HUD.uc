//------------------------------------------------------------------------------------------
// Author:    Team Bravo
// Date:      February 8, 2015
// 
// Purpose: A custom HUD designed for ADP_GameType.
//
//------------------------------------------------------------------------------------------
class ADP_HUD extends HUD;

//------------------------------------------------------------------------------------------
var Font m_font;
var Texture2D m_texture;
var Texture2D m_textureHUD;
var Texture2D m_textureHUD2;
var Texture2D m_textureBar;
var Font tut_font;
var Font hud_font;

//------------------------------------------------------------------------------------------
// Calls the functions to draw all aspects of the HUD
function DrawHUD()
{
	super.DrawHUD();

	backgroundHUD();
	drawDecayTimer();
	drawDimension();
	drawCurrentLevel();
	drawTutorial();
	drawDeath();
	drawLives();
}

//------------------------------------------------------------------------------------------
// Function responsible for placing background texture (call first)
function backgroundHUD()
{
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	rGame =  ADP_GameType( rWorldInfo.Game );

	if( rGame.sDimension == "Original" )
	{
		//Left
		Canvas.SetPos( 520 / 1440.0f * Canvas.SizeX , 840 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD2 , 
			200 / 1440.0f * Canvas.SizeX , 60 / 900.0f * Canvas.SizeY ,     // Size of the texture drawn
			1378 , 724,                                                     // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length

		//Right
		Canvas.SetPos( 720 / 1440.0f * Canvas.SizeX , 840 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD , 
			200 / 1440.0f * Canvas.SizeX, 60 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
			0 , 724,                                                        // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length

		//Top-left
		Canvas.SetPos( 520 / 1440.0f * Canvas.SizeX , -25 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD2 , 
			200 / 1440.0f * Canvas.SizeX , 60 / 900.0f * Canvas.SizeY ,     // Size of the texture drawn
			1378 , 724,                                                     // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length

		//Top-right
		Canvas.SetPos( 720 / 1440.0f * Canvas.SizeX , -25 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD , 
			200 / 1440.0f * Canvas.SizeX, 60 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
			0 , 724,                                                        // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length
	}

	else if( rGame.sDimension == "Alternate" )
	{
		//Left
		Canvas.SetPos( 520 / 1440.0f * Canvas.SizeX , 840 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD2 , 
			200 / 1440.0f * Canvas.SizeX , 60 / 900.0f * Canvas.SizeY ,     // Size of the texture drawn
			1378 , 364,                                                     // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length

		//Right
		Canvas.SetPos( 720 / 1440.0f * Canvas.SizeX , 840 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD , 
			200 / 1440.0f * Canvas.SizeX, 60 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
			0 , 364,                                                        // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length

		//Top-left
		Canvas.SetPos( 520 / 1440.0f * Canvas.SizeX , -25 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD2 , 
			200 / 1440.0f * Canvas.SizeX , 60 / 900.0f * Canvas.SizeY ,     // Size of the texture drawn
			1378 , 364,                                                     // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length

		//Top-right
		Canvas.SetPos( 720 / 1440.0f * Canvas.SizeX , -25 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD , 
			200 / 1440.0f * Canvas.SizeX, 60 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
			0 , 364,                                                        // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length
	}

	else if( rGame.sDimension == "Inception" )
	{
		//Left
		Canvas.SetPos( 520 / 1440.0f * Canvas.SizeX , 840 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD2 , 
			200 / 1440.0f * Canvas.SizeX , 60 / 900.0f * Canvas.SizeY ,     // Size of the texture drawn
			1378 , 8,                                                     // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length

		//Right
		Canvas.SetPos( 720 / 1440.0f * Canvas.SizeX , 840 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD , 
			200 / 1440.0f * Canvas.SizeX, 60 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
			0 , 8,                                                        // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length

		//Top-left
		Canvas.SetPos( 520 / 1440.0f * Canvas.SizeX , -25 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD2 , 
			200 / 1440.0f * Canvas.SizeX , 60 / 900.0f * Canvas.SizeY ,     // Size of the texture drawn
			1378 , 8,                                                       // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length

		//Top-right
		Canvas.SetPos( 720 / 1440.0f * Canvas.SizeX , -25 / 900.0f * Canvas.SizeY );
		Canvas.SetDrawColor( 255 , 255 , 255 );
		Canvas.DrawTile( m_textureHUD , 
			200 / 1440.0f * Canvas.SizeX, 60 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
			0 , 8,                                                          // U, V (or X, Y) of where to start inside the texture
			670 , 300 );                                                    // UL, VL (of XL, YL) L == length
	}

	//Top bar
	Canvas.SetPos( 515 / 1440.0f * Canvas.SizeX , 25 / 900.0f * Canvas.SizeY );
	Canvas.SetDrawColor( 0 , 0 , 0 );
	Canvas.DrawTile( m_textureBar , 
		410 / 1440.0f * Canvas.SizeX , 35 / 900.0f * Canvas.SizeY ,         // Size of the texture drawn
		0 , 0,                                                              // U, V (or X, Y) of where to start inside the texture
		256 , 16 );                                                         // UL, VL (of XL, YL) L == length
	
	//Reset bar
	/*Canvas.SetPos( 135 / 1440.0f * Canvas.SizeX , 865 / 900.0f * Canvas.SizeY );
	Canvas.SetDrawColor( 0 , 0 , 0 );
	Canvas.DrawTile( m_textureBar , 
		120 / 1440.0f * Canvas.SizeX, 40 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
		0 , 0,         // U, V (or X, Y) of where to start inside the texture
		256 , 16 );*/      // UL, VL (of XL, YL) L == length

	//Bottom bar
	Canvas.SetPos( 600 / 1440.0f * Canvas.SizeX , 865 / 900.0f * Canvas.SizeY );
	Canvas.SetDrawColor( 0 , 0 , 0 );
	Canvas.DrawTile( m_textureBar , 
		240 / 1440.0f * Canvas.SizeX, 40 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
		0 , 0,         // U, V (or X, Y) of where to start inside the texture
		256 , 16 );      // UL, VL (of XL, YL) L == length

	//Lives bar
	/*Canvas.SetPos( 740 / 1440.0f * Canvas.SizeX , 865 / 900.0f * Canvas.SizeY );
	Canvas.SetDrawColor( 0 , 0 , 0 );
	Canvas.DrawTile( m_textureBar , 
		110 / 1440.0f * Canvas.SizeX, 40 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
		0 , 0,         // U, V (or X, Y) of where to start inside the texture
		256 , 16 );*/      // UL, VL (of XL, YL) L == length

	//Display hide/show bar
	Canvas.SetPos( 1320 / 1440.0f * Canvas.SizeX , 865 / 900.0f * Canvas.SizeY );
	Canvas.SetDrawColor( 0 , 0 , 0 );
	Canvas.DrawTile( m_textureBar , 
		110 / 1440.0f * Canvas.SizeX, 40 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
		0 , 0,         // U, V (or X, Y) of where to start inside the texture
		256 , 16 );      // UL, VL (of XL, YL) L == length
}

//------------------------------------------------------------------------------------------
//Draw text for Current Level
function drawCurrentLevel()
{
	local ADP_GameType rGame;

	rGame = ADP_GameType( WorldInfo.Game );

	if( rGame != none )
	{
		// Level #
		Canvas.SetPos( 610 / 1440.0f * Canvas.SizeX, 878 / 900.0f * Canvas.SizeY );
		Canvas.Font = hud_font;
		Canvas.SetDrawColor(255, 255, 255);
		Canvas.DrawText("Level: " @ rGame.cLevel, , 0.8 / 1440.0f * Canvas.SizeX , 0.8 / 900.0f * Canvas.SizeY);
	}
}

//------------------------------------------------------------------------------------------
// Draws the decay timer
function drawDecayTimer()
{
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;
	//local Vector2D TextSize;
	local string rTime;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	if(rWorldInfo != none)
	{
		rGame =  ADP_GameType( rWorldInfo.Game );
		rTime = " " @ rGame.decayTimer;
		rTime = Left(rTime, InStr(rTime, ".") + 0);

		if(rGame != none && rGame.decayActive == true)
		{
			//Display health decay background bar
			Canvas.SetPos( 620 / 1440.0f * Canvas.SizeX , 45 / 900.0f * Canvas.SizeY );
			Canvas.SetDrawColor( 0 , 0 , 0 );
			Canvas.DrawTile( m_textureBar , 
				200 / 1440.0f * Canvas.SizeX, 50 / 900.0f * Canvas.SizeY ,      // Size of the texture drawn
				0 , 0,         // U, V (or X, Y) of where to start inside the texture
				256 , 16 );      // UL, VL (of XL, YL) L == length
		}

		if(rGame != none && rGame.decayActive == true && rGame.decayTimer > 20)
		{
			//Decay timer
			Canvas.SetPos( 670 / 1440.0f * Canvas.SizeX , 55 / 900.0f * Canvas.SizeY );
			Canvas.Font = m_font;
			Canvas.SetDrawColor( 255 , 255 , 100 );
			Canvas.DrawText( rTime , , 1.5 / 1440.0f * Canvas.SizeX , 1.5 / 900.0f * Canvas.SizeY );
		}
		else if(rGame != none && rGame.decayActive == true && rGame.decayTimer > 10)
		{
			Canvas.SetPos( 675 / 1440.0f * Canvas.SizeX , 55 / 900.0f * Canvas.SizeY );
			Canvas.Font = m_font;
			Canvas.SetDrawColor( 255 , 149 , 0 );
			Canvas.DrawText( rTime , , 1.5 / 1440.0f * Canvas.SizeX , 1.5 / 900.0f * Canvas.SizeY );
		}
		else if(rGame != none && rGame.decayActive == true && rGame.decayTimer >= 0)
		{
			Canvas.SetPos( 680 / 1440.0f * Canvas.SizeX , 55 / 900.0f * Canvas.SizeY );
			Canvas.Font = m_font;
			Canvas.SetDrawColor( 212 , 0 , 0 );
			Canvas.DrawText( rTime , , 1.5 / 1440.0f * Canvas.SizeX , 1.5 / 900.0f * Canvas.SizeY );
		}
	}
}

//------------------------------------------------------------------------------------------
//Draw what dimension the player currently is in
function drawDimension()
{
	local ADP_GameType rGame;
	//local Vector2D TextSize;

	rGame = ADP_GameType( WorldInfo.Game );

	if( rGame != none )
	{
		if( rGame.sDimension == "Original" )
		{
			Canvas.SetPos( 580 / 1440.0f * Canvas.SizeX , 30 / 900.0f * Canvas.SizeY );
			Canvas.Font = hud_font;
			Canvas.SetDrawColor( 255 , 255 , 255 );
			Canvas.DrawText( rGame.sDimension @ " Dimension" , , 1.1 / 1440.0f * Canvas.SizeX , 1.1 / 900.0f * Canvas.SizeY );
		}
		else if( rGame.sDimension == "Alternate" )
		{
			Canvas.SetPos( 560 / 1440.0f * Canvas.SizeX , 30 / 900.0f * Canvas.SizeY );
			Canvas.Font = hud_font;
			Canvas.SetDrawColor( 255 , 255 , 255 );
			Canvas.DrawText( rGame.sDimension @ " Dimension" , , 1.1 / 1440.0f * Canvas.SizeX , 1.1 / 900.0f * Canvas.SizeY );
		}
		else if( rGame.sDimension == "Inception" )
		{
			Canvas.SetPos( 570 / 1440.0f * Canvas.SizeX , 30 / 900.0f * Canvas.SizeY );
			Canvas.Font = hud_font;
			Canvas.SetDrawColor( 255 , 255 , 255 );
			Canvas.DrawText( rGame.sDimension @ " Dimension" , , 1.1 / 1440.0f * Canvas.SizeX , 1.1 / 900.0f * Canvas.SizeY );
		}
	}
}

//------------------------------------------------------------------------------------------
//Draw text for Reset and Hide/Show display
function drawTutorial()
{
	local ADP_GameType rGame;

	rGame = ADP_GameType( WorldInfo.Game );

	if( rGame != none )
	{
		// Reset 'R'
		/*Canvas.SetPos( 140 / 1440.0f * Canvas.SizeX, 878 / 900.0f * Canvas.SizeY );
		Canvas.Font = hud_font;
		Canvas.SetDrawColor(255, 255, 255);
		Canvas.DrawText( "[R] Reset", , 0.8 / 1440.0f * Canvas.SizeX , 0.8 / 900.0f * Canvas.SizeY );*/

		// Display ON
		if (rGame.bDisplay == true)
		{
			Canvas.SetPos( 1325 / 1440.0f * Canvas.SizeX, 878 / 900.0f * Canvas.SizeY );
			Canvas.Font = hud_font;
			Canvas.SetDrawColor(255, 255, 255);
			Canvas.DrawText( "[H] Hide", , 0.8 / 1440.0f * Canvas.SizeX , 0.8 / 900.0f * Canvas.SizeY );
		}
		// Display OFF
		else
		{
			Canvas.SetPos( 1325 / 1440.0f * Canvas.SizeX, 878 / 900.0f * Canvas.SizeY );
			Canvas.Font = hud_font;
			Canvas.SetDrawColor(255, 255, 255);
			Canvas.DrawText( "[H] Show", , 0.8 / 1440.0f * Canvas.SizeX , 0.8 / 900.0f * Canvas.SizeY );
		}
	}
}

//------------------------------------------------------------------------------------------
//Draw Death message
function drawDeath()
{
	local ADP_GameType rGame;

	rGame = ADP_GameType( WorldInfo.Game );

	if( rGame != none )
	{
		// Death
		if (rGame.bDead == true)
		{
			Canvas.SetPos( Canvas.ClipX / 2 - 150, Canvas.ClipY / 2);
			Canvas.Font = tut_font;
			Canvas.SetDrawColor(255, 255, 255);
			Canvas.DrawText("Press SPACE to restart.", , 1.75, 1.75);
		}
		// Alive
		else
		{
			
		}
	}
}

//------------------------------------------------------------------------------------------
//Draw Lives on screen
function drawLives()
{
	//local Vector2D TextSize;
	local WorldInfo rWorldInfo;
	local ADP_GameType rGame;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
		if (rWorldInfo != none)
		{
			rGame = ADP_GameType(rWorldInfo.Game);

			if (rGame != none)
			{
				Canvas.SetPos( 740 / 1440.0f * Canvas.SizeX, 878 / 900.0f * Canvas.SizeY);
				Canvas.Font = hud_font;
				Canvas.SetDrawColor(255, 255, 255);
				Canvas.DrawText( "Lives: " @ rGame.iLives , , 0.8 / 1440.0f * Canvas.SizeX , 0.8 / 900.0f * Canvas.SizeY);
			}
		}
}

//------------------------------------------------------------------------------------------
DefaultProperties
{
	m_texture = Texture2D'UI_HUD.HUD.UI_HUD_BaseB';
	m_textureHUD = Texture2D'ADP_Prototype.Textures.ADP_HUD';
	m_textureHUD2 = Texture2D'ADP_Prototype.Textures.ADP_HUD2';
	m_textureBar = Texture2D'UDKHUD.team_blue';
	
	m_font = Font'UI_Fonts.Fonts.UI_Fonts_AmbexHeavyOblique18';
	
	hud_font = Font'UI_Fonts.Fonts.UI_Fonts_AmbexThin18';
	tut_font = Font'ADP_Assets.Menu_ShowcardGothic';
}
