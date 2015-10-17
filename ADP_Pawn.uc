//------------------------------------------------------------------------------------------------ 
// Author:  Team Bravo
// Date:    February 8, 2015
//
// Purpose: Pawn class for ADP.
//
//------------------------------------------------------------------------------------------------

class ADP_Pawn extends UTPawn;

//var() PointLightComponent MyLight;

simulated function PostBeginPlay()
{
    //Mesh.AttachComponentToSocket(MyLight, 'b_Neck');
}

simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
	local vector ApplyImpulse, ShotDir;
	local TraceHitInfo HitInfo;
	local PlayerController PC;
	local bool bPlayersRagdoll, bUseHipSpring;
	local class<UTDamageType> UTDamageType;
	local RB_BodyInstance HipBodyInst;
	local int HipBoneIndex;
	local matrix HipMatrix;
	local class<UDKEmitCameraEffect> CameraEffect;
	local name HeadShotSocketName;
	local SkeletalMeshSocket SMS;

	local ADP_GameType rGame;

	rGame = ADP_GameType(WorldInfo.Game);

		if (rGame != none)
		{
			rGame.loseLife();
		}

	bCanTeleport = false;
	bReplicateMovement = false;
	bTearOff = true;
	bPlayedDeath = true;
	bForcedFeignDeath = false;
	bPlayingFeignDeathRecovery = false;

	HitDamageType = DamageType; // these are replicated to other clients
	TakeHitLocation = HitLoc;

	// make sure I don't have an active weaponattachment
	CurrentWeaponAttachmentClass = None;
	WeaponAttachmentChanged();

	if ( WorldInfo.NetMode == NM_DedicatedServer )
	{
 		UTDamageType = class<UTDamageType>(DamageType);
		// tell clients whether to gib
		bTearOffGibs = (UTDamageType != None && ShouldGib(UTDamageType));
		bGibbed = bGibbed || bTearOffGibs;
		GotoState('Dying');
		return;
	}

	// Is this the local player's ragdoll?
	ForEach LocalPlayerControllers(class'PlayerController', PC)
	{
		if( pc.ViewTarget == self )
		{
			if ( UTHud(pc.MyHud)!=none )
				UTHud(pc.MyHud).DisplayHit(HitLoc, 100, DamageType);
			bPlayersRagdoll = true;
			break;
		}
	}
	if ( (WorldInfo.TimeSeconds - LastRenderTime > 3) && !bPlayersRagdoll )
	{
		if (WorldInfo.NetMode == NM_ListenServer || WorldInfo.IsRecordingDemo())
		{
			if (WorldInfo.Game.NumPlayers + WorldInfo.Game.NumSpectators < 2 && !WorldInfo.IsRecordingDemo())
			{
				Destroy();
				return;
			}
			bHideOnListenServer = true;

			// check if should gib (for clients)
			UTDamageType = class<UTDamageType>(DamageType);
			if (UTDamageType != None && ShouldGib(UTDamageType))
			{
				bTearOffGibs = true;
				bGibbed = true;
			}
			TurnOffPawn();
			return;
		}
		else
		{
			// if we were not just controlling this pawn,
			// and it has not been rendered in 3 seconds, just destroy it.
			Destroy();
			return;
		}
	}

	UTDamageType = class<UTDamageType>(DamageType);
	if (UTDamageType != None && !class'UTGame'.static.UseLowGore(WorldInfo) && ShouldGib(UTDamageType))
	{
		SpawnGibs(UTDamageType, HitLoc);
	}
	else
	{
		CheckHitInfo( HitInfo, Mesh, Normal(TearOffMomentum), TakeHitLocation );

		// check to see if we should do a CustomDamage Effect
		if( UTDamageType != None )
		{
			if( UTDamageType.default.bUseDamageBasedDeathEffects )
			{
				UTDamageType.static.DoCustomDamageEffects(self, UTDamageType, HitInfo, TakeHitLocation);
			}

			if( UTPlayerController(PC) != none )
			{
				CameraEffect = UTDamageType.static.GetDeathCameraEffectVictim(self);
				if (CameraEffect != None)
				{
					UTPlayerController(PC).ClientSpawnCameraEffect(CameraEffect);
				}
			}
		}

		bBlendOutTakeHitPhysics = false;

		// Turn off hand IK when dead.
		SetHandIKEnabled(false);

		// if we had some other rigid body thing going on, cancel it
		if (Physics == PHYS_RigidBody)
		{
			//@note: Falling instead of None so Velocity/Acceleration don't get cleared
			setPhysics(PHYS_Falling);
		}

		PreRagdollCollisionComponent = CollisionComponent;
		CollisionComponent = Mesh;

		Mesh.MinDistFactorForKinematicUpdate = 0.f;

		// If we had stopped updating kinematic bodies on this character due to distance from camera, force an update of bones now.
		if( Mesh.bNotUpdatingKinematicDueToDistance )
		{
			Mesh.ForceSkelUpdate();
			Mesh.UpdateRBBonesFromSpaceBases(TRUE, TRUE);
		}

		Mesh.PhysicsWeight = 1.0;

		if(UTDamageType != None && UTDamageType.default.DeathAnim != '' && (FRand() > 0.5) )
		{
			// Don't want to use stop player and use hip-spring if in the air (eg PHYS_Falling)
			if(Physics == PHYS_Walking && UTDamageType.default.bAnimateHipsForDeathAnim)
			{
				SetPhysics(PHYS_None);
				bUseHipSpring=true;
			}
			else
			{
				SetPhysics(PHYS_RigidBody);
				// We only want to turn on 'ragdoll' collision when we are not using a hip spring, otherwise we could push stuff around.
				SetPawnRBChannels(TRUE);
			}

			Mesh.PhysicsAssetInstance.SetAllBodiesFixed(FALSE);

			// Turn on angular motors on skeleton.
			Mesh.bUpdateJointsFromAnimation = TRUE;
			Mesh.PhysicsAssetInstance.SetNamedMotorsAngularPositionDrive(false, false, NoDriveBodies, Mesh, true);
			Mesh.PhysicsAssetInstance.SetAngularDriveScale(1.0f, 1.0f, 0.0f);

			// If desired, turn on hip spring to keep physics character upright
			if(bUseHipSpring)
			{
				HipBodyInst = Mesh.PhysicsAssetInstance.FindBodyInstance('b_Hips', Mesh.PhysicsAsset);
				HipBoneIndex = Mesh.MatchRefBone('b_Hips');
				HipMatrix = Mesh.GetBoneMatrix(HipBoneIndex);
				HipBodyInst.SetBoneSpringParams(DeathHipLinSpring, DeathHipLinDamp, DeathHipAngSpring, DeathHipAngDamp);
				HipBodyInst.bMakeSpringToBaseCollisionComponent = FALSE;
				HipBodyInst.EnableBoneSpring(TRUE, TRUE, HipMatrix);
				HipBodyInst.bDisableOnOverextension = TRUE;
				HipBodyInst.OverextensionThreshold = 100.f;
			}

			FullBodyAnimSlot.PlayCustomAnim(UTDamageType.default.DeathAnim, UTDamageType.default.DeathAnimRate, 0.05, -1.0, false, false);
			SetTimer(0.1, true, 'DoingDeathAnim');
			StartDeathAnimTime = WorldInfo.TimeSeconds;
			TimeLastTookDeathAnimDamage = WorldInfo.TimeSeconds;
			DeathAnimDamageType = UTDamageType;
		}
		else
		{
			SetPhysics(PHYS_RigidBody);
			Mesh.PhysicsAssetInstance.SetAllBodiesFixed(FALSE);
			SetPawnRBChannels(TRUE);

			if( TearOffMomentum != vect(0,0,0) )
			{
				ShotDir = normal(TearOffMomentum);
				ApplyImpulse = ShotDir * DamageType.default.KDamageImpulse;

				// If not moving downwards - give extra upward kick
				if ( Velocity.Z > -10 )
				{
					ApplyImpulse += Vect(0,0,1)*DamageType.default.KDeathUpKick;
				}
				Mesh.AddImpulse(ApplyImpulse, TakeHitLocation, HitInfo.BoneName, true);
			}
		}
		GotoState('Dying');

		if (WorldInfo.NetMode != NM_DedicatedServer && UTDamageType != None && UTDamageType.default.bSeversHead && !bDeleteMe)
		{
			SpawnHeadGib(UTDamageType, HitLoc);

			if ( !class'UTGame'.Static.UseLowGore(WorldInfo) )
			{
				HeadShotSocketName = GetFamilyInfo().default.HeadShotGoreSocketName;
				SMS = Mesh.GetSocketByName( HeadShotSocketName );
				if( SMS != none )
				{
					HeadshotNeckAttachment = new(self) class'StaticMeshComponent';
					HeadshotNeckAttachment.SetActorCollision( FALSE, FALSE );
					HeadshotNeckAttachment.SetBlockRigidBody( FALSE );

					Mesh.AttachComponentToSocket( HeadshotNeckAttachment, HeadShotSocketName );
					HeadshotNeckAttachment.SetStaticMesh( GetFamilyInfo().default.HeadShotNeckGoreAttachment );
					HeadshotNeckAttachment.SetLightEnvironment( LightEnvironment );
				}
			}
		}
	}
}

DefaultProperties
{
	/*Begin Object Class=PointLightComponent name=LComp
        LightColor=(R=255,G=255,B=255)
        CastShadows=false
        bEnabled=true
        Radius=7500.000000
        FalloffExponent=3.000000
        Brightness=1.900000
        CastStaticShadows=False
        CastDynamicShadows=False
        bCastCompositeShadow=False
        bAffectCompositeShadowDirection=False
    End Object
	Components.Add(LComp)
	bForceDynamicLight=true
    MyLight=LComp*/

	// Disable Double Jump
	MaxMultiJump = 0

	// Jump Height (322)
	JumpZ = 635

	// Disable spawn sound
	SpawnSound = none
}
