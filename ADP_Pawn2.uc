// if you find this useful, feel free to credit me: http://www.youtube.com/user/lickstab
// or not, i don't really care i guess.
//
// and of course, the dude whose code i based this on:
// http://www.youtube.com/watch?v=6NXJ9UWXNkM

class ADP_Pawn2 extends UTPawn;

// variables
var int lookDir; 		// Direction the player is looking at (0 - left, 32768 - right)
var int camSpeed; 		// The speed at which the camera pans left and right
var int camZSpeed; 		// The speed at which the camera pans up and down
var int zOffset; 		// Max up/down offset
var int currZOffset; 	// Current up/down offset
//var bool IsFront;		// is player in the front of back part of the scene?
var bool MoveCam;		// should camera move to follow player?

// Code for rotating the player when turning left and right
exec function turnRight()
{
	lookDir = 0;
}

exec function turnLeft()
{
	lookDir = 32768;
}

// calculate camera position/direction
simulated function bool CalcCamera(float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV)
{
	local vector CamStart;
	local float distance;
	
	CamStart = Location;
	
	out_CamRot.Yaw = -16384; // -90 degrees
	CamStart.Y += 1200; // camera distance (depthwise)
	CamStart.Z += 64 - currZOffset; // camera height

	//if(IsFront)
	//	CamStart.Y += 400; // camera distance (depthwise)
	//else
	//	CamStart.Y -= 400; // "back"-side: put camera on opposite side

	// offset between camera's X position and pawn's X position
	distance = out_CamLoc.X - CamStart.X;
	// start moving when the player is near the screen's edge
	if(Abs(distance) > 138)
		MoveCam = true;
	// scroll a bit more so the player is never at the very edge unless moving
	else if(Abs(distance) < 96)
		MoveCam = false;

	// okay, reset camera's X position
	CamStart.X = out_CamLoc.X;

	// and then move it slowly if needed
	if(MoveCam)
	{
		CamStart.X += distance / -45;
	}	
	
	// now, set the final position
	out_CamLoc = CamStart;
	
	// rotate camera if necessary
	//if(IsFront)
	//	out_CamRot.Yaw = -16384; // -90 degrees
	//else
	//	out_CamRot.Yaw = 16384; // 90 degrees if player is "in the back"
		
	out_CamRot.Pitch = 0; // lock camera pitch
	return true;
}

// loop
simulated function Tick(float DeltaTime)
{
	local vector temp;
	local rotator tempRot;

	super.Tick(DeltaTime);

	temp = Location;

	//if(IsFront)
	//	temp.Y = 0;
	//else
	//	temp.Y = -256;
		
	SetLocation(temp);
	
	// lock direction
	//if(IsFront)
	//	tempRot.Yaw = lookDir;
	//else
	//	tempRot.Yaw = 32768 - lookDir; // if player is in the "back" part, reverse direction
		
	tempRot.Pitch = 0;
	SetRotation(tempRot);
	
	// move the camera up
	if (Velocity.Z<-280)
	{
		if(currZOffset<zOffset)
			currZOffset += camZSpeed;
	}
	else if(currZOffset>0)
		currZOffset += -camZSpeed;
}

defaultproperties
{
  /*Begin Object Name=WPawnSkeletalMeshComponent
       //Your Mesh Properties
      SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
      AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
      PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
      AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
      Translation=(Z=8.0)
      Scale=1.075
      //General Mesh Properties
      bCacheAnimSequenceNodes=FALSE
      AlwaysLoadOnClient=true
      AlwaysLoadOnServer=true
      bOwnerNoSee=false
      CastShadow=true
      BlockRigidBody=TRUE
      bUpdateSkelWhenNotRendered=false
      bIgnoreControllersWhenNotRendered=TRUE
      bUpdateKinematicBonesFromAnimation=true
      bCastDynamicShadow=true
      RBChannel=RBCC_Untitled3
      RBCollideWithChannels=(Untitled3=true)
      LightEnvironment=MyLightEnvironment
      bOverrideAttachmentOwnerVisibility=true
      bAcceptsDynamicDecals=FALSE
      bHasPhysicsAssetInstance=true
      TickGroup=TG_PreAsyncWork
      MinDistFactorForKinematicUpdate=0.2
      bChartDistanceFactor=true
      RBDominanceGroup=20
      MotionBlurScale=0.0
      bUseOnePassLightingOnTranslucency=TRUE
      bPerBoneMotionBlur=true
   End Object
   Mesh=WPawnSkeletalMeshComponent
   Components.Add(WPawnSkeletalMeshComponent)*/

	zOffset = 60;
	camSpeed = 10;
	camZSpeed = 2;
	
	//IsFront = true;
	MoveCam = false;
	
	Name="Default__ADP_Pawn2"

	// Disable Double Jump
	MaxMultiJump = 0

	// Jump Height (322)
	JumpZ = 635
}