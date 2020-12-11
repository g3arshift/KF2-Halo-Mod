//=============================================================================
// A class that uses a basic template of materials to update two and three digit
// ammo counter displays.
//=============================================================================
// To use the class, first initialize the class with AmmoDisplayVar = New class'Standard_Ammo_Display';
// Then call InitializeDisplay and pass it the correct variables
//
// And example for a two digit display is M392_Display.InitializeDisplay(KFPC, 4, 3, 0.67, 0.334);
//
// Next call RunDisplay and pass it a mesh component. If the Standard_Ammo_Display
// Object was created inside a weapon class as it will be in most cases, use
// Standard_Ammo_DisplayVariable.RunDisplay(Mesh);
//
// The MeshComponent here is PASS BY REFERENCE.
//=============================================================================
// Gear Shift Gaming 3/15/2020
//=============================================================================

class Standard_Ammo_Display extends Object;

var array<MaterialInstanceConstant> AmmoNumbers_High;
var array<MaterialInstanceConstant> AmmoNumbers_Medium;
var array<MaterialInstanceConstant> AmmoNumbers_Low;

var bool TwoDigits, ThreeDigits;
var int LeftDigit_MaterialSlotNum, RightDigit_MaterialSlotNum, MiddleDigit_MaterialSlotNum;
var KFPlayerController KFPC;
var int AmmoCount_LeftDigit, AmmoCount_RightDigit, AmmoCount_CenterDigit, Current_Ammo, Current_MagazineCapacity;
var float AmmoYellow_Perc, AmmoRed_Perc;

function InitializeDisplay(KFPlayerController KFPC_Ref, int LeftDigit_MatNum, int RightDigit_MatNum, float AmmoYellow_Val, float AmmoRed_Val, optional int MiddleDigit_MatNum = -1)
{
	if(MiddleDigit_MatNum == -1)
	{
		TwoDigits = true;
		LeftDigit_MaterialSlotNum = LeftDigit_MatNum;
		RightDigit_MaterialSlotNum = RightDigit_MatNum;
	}
	else
	{
		ThreeDigits = true;
		LeftDigit_MaterialSlotNum = LeftDigit_MatNum;
		RightDigit_MaterialSlotNum = RightDigit_MatNum;
		MiddleDigit_MaterialSlotNum = MiddleDigit_MatNum;
	}

	AmmoYellow_Perc = AmmoYellow_Val;
	AmmoRed_Perc = AmmoRed_Val;

	if(KFPC_Ref == none)
	{
		`log("Ammo Display has no KFPC Reference!");
	}
	else
	{
		KFPC = KFPC_Ref;
	}

	//Ammo Counter Display Materials
	//For some reason this doesn't work when set in default properties
	//Maybe in the future just use 1 array for each color, and change the glow parameter? Definitely better than 30 fucking MICs. This needs to be
	// replaced anyways with the Ammo Display class, which itself needs to have all that shit changed to using glow params.
	AmmoNumbers_High[0] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_0';
	AmmoNumbers_High[1] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_1';
	AmmoNumbers_High[2] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_2';
	AmmoNumbers_High[3] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_3';
	AmmoNumbers_High[4] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_4';
	AmmoNumbers_High[5] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_5';
	AmmoNumbers_High[6] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_6';
	AmmoNumbers_High[7] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_7';
	AmmoNumbers_High[8] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_8';
	AmmoNumbers_High[9] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_9';

	AmmoNumbers_Medium[0] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_0';
	AmmoNumbers_Medium[1] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_1';
	AmmoNumbers_Medium[2] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_2';
	AmmoNumbers_Medium[3] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_3';
	AmmoNumbers_Medium[4] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_4';
	AmmoNumbers_Medium[5] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_5';
	AmmoNumbers_Medium[6] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_6';
	AmmoNumbers_Medium[7] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_7';
	AmmoNumbers_Medium[8] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_8';
	AmmoNumbers_Medium[9] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_9';

	AmmoNumbers_Low[0] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_0';
	AmmoNumbers_Low[1] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_1';
	AmmoNumbers_Low[2] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_2';
	AmmoNumbers_Low[3] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_3';
	AmmoNumbers_Low[4] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_4';
	AmmoNumbers_Low[5] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_5';
	AmmoNumbers_Low[6] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_6';
	AmmoNumbers_Low[7] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_7';
	AmmoNumbers_Low[8] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_8';
	AmmoNumbers_Low[9] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_9';
}

function RunDisplay(out MeshComponent AmmoDisplay_Ref)
{
	Current_Ammo = KFWeapon(KFPC.Pawn.Weapon).AmmoCount[0];
	Current_MagazineCapacity = KFWeapon(KFPC.Pawn.Weapon).MagazineCapacity[0];

	if(TwoDigits)
	{
		AmmoCount_LeftDigit = int(left(Current_Ammo, 1));
		AmmoCount_RightDigit = int(Right(Current_Ammo, 1));
		UpdateAmmoDisplay_Standard(AmmoDisplay_Ref);
	}
	else if(ThreeDigits)
	{
		AmmoCount_LeftDigit = int(left(Current_Ammo, 1));
		AmmoCount_CenterDigit = int(Right(Current_Ammo, 1));
		AmmoCount_RightDigit = int(Right(Current_Ammo, 2));
		UpdateAmmoDisplay_Triple(AmmoDisplay_Ref);
	}
	else
	{
		`log("Display is neither two or three digits. How you do dat?");
	}
}

function UpdateAmmoDisplay_Standard(out MeshComponent AmmoDisplay_Ref)
{
	if ( Current_Ammo >= 99 )
	{
		AmmoDisplay_Ref.SetMaterial( LeftDigit_MaterialSlotNum, AmmoNumbers_High[9]); //Left Display
		AmmoDisplay_Ref.SetMaterial( RightDigit_MaterialSlotNum, AmmoNumbers_High[9]); //Right Display
	}
	else if ( Current_Ammo > Current_MagazineCapacity * AmmoYellow_Perc ) //If below 99 bullets, but above yellow magazine percentage
	{
		AmmoDisplay_Ref.SetMaterial( LeftDigit_MaterialSlotNum, AmmoNumbers_High[AmmoCount_LeftDigit]); //Left Display
		AmmoDisplay_Ref.SetMaterial( RightDigit_MaterialSlotNum, AmmoNumbers_High[AmmoCount_RightDigit]); //Right Display
	}
	else if ( Current_Ammo <= Current_MagazineCapacity * AmmoYellow_Perc && Current_Ammo > Current_MagazineCapacity * AmmoRed_Perc ) //If Below Yellow Magazine Percentage and above Red Magazine Percentage
	{
		if( Current_Ammo == 10 )
		{
			AmmoCount_LeftDigit = 1;
		}
		else if(Current_Ammo < 10)
		{
			AmmoCount_LeftDigit = 0;	
		}

		AmmoDisplay_Ref.SetMaterial( LeftDigit_MaterialSlotNum, AmmoNumbers_Medium[AmmoCount_LeftDigit]); //Left Display
		AmmoDisplay_Ref.SetMaterial( RightDigit_MaterialSlotNum, AmmoNumbers_Medium[AmmoCount_RightDigit]); //Right Display
	}
	else 
	{
		if( Current_Ammo == 10 )
		{
			AmmoCount_LeftDigit = 1;
		}
		else if(Current_Ammo < 10)
		{
			AmmoCount_LeftDigit = 0;	
		}

		AmmoDisplay_Ref.SetMaterial( LeftDigit_MaterialSlotNum, AmmoNumbers_Low[AmmoCount_LeftDigit]); //Left Display
		AmmoDisplay_Ref.SetMaterial( RightDigit_MaterialSlotNum, AmmoNumbers_Low[AmmoCount_RightDigit]); //Right Display
	}
	//`log("Current Ammo Is :"$Current_Ammo);
	//`log("Left Digit Is :"$AmmoCount_LeftDigit);
	//`log("Right Digit Is :"$AmmoCount_RightDigit);
}

function UpdateAmmoDisplay_Triple(out MeshComponent AmmoDisplay_Ref)
{
	if( Current_Ammo > Current_MagazineCapacity * AmmoYellow_Perc && Current_Ammo >= 100)
	{
		AmmoDisplay_Ref.SetMaterial( LeftDigit_MaterialSlotNum, AmmoNumbers_High[AmmoCount_LeftDigit]); //Left Display
		AmmoDisplay_Ref.SetMaterial( MiddleDigit_MaterialSlotNum, AmmoNumbers_High[AmmoCount_CenterDigit]); //Center Display
		AmmoDisplay_Ref.SetMaterial( RightDigit_MaterialSlotNum, AmmoNumbers_High[AmmoCount_RightDigit]); //Right Display
	}
	else if( Current_Ammo > Current_MagazineCapacity * AmmoYellow_Perc ) //If below 99 bullets, but above yellow magazine percentage
	{
		AmmoDisplay_Ref.SetMaterial( LeftDigit_MaterialSlotNum, AmmoNumbers_High[0]); //Left Display
		AmmoDisplay_Ref.SetMaterial( MiddleDigit_MaterialSlotNum, AmmoNumbers_High[AmmoCount_LeftDigit]); //Center Display
		AmmoDisplay_Ref.SetMaterial( RightDigit_MaterialSlotNum, AmmoNumbers_High[AmmoCount_CenterDigit]); //Right Display
	}
	else if ( Current_Ammo <= Current_MagazineCapacity * AmmoYellow_Perc && Current_Ammo > Current_MagazineCapacity * AmmoRed_Perc ) //If Below Yellow Magazine Percentage and above Red Magazine Percentage
	{
		if( Current_Ammo == 10 )
		{
			AmmoCount_LeftDigit = 1;
		}
		else
		{
			AmmoCount_CenterDigit = 0;	
		}

		AmmoDisplay_Ref.SetMaterial( LeftDigit_MaterialSlotNum, AmmoNumbers_Medium[0]); //Left Display
		AmmoDisplay_Ref.SetMaterial( MiddleDigit_MaterialSlotNum, AmmoNumbers_Medium[AmmoCount_LeftDigit]); //Center Display
		AmmoDisplay_Ref.SetMaterial( RightDigit_MaterialSlotNum, AmmoNumbers_Medium[AmmoCount_CenterDigit]); //Right Display
	}
	else
	{
		if( Current_Ammo == 10 )
		{
			AmmoCount_LeftDigit = 1;
		}
		else
		{
			AmmoCount_CenterDigit = 0;	
		}

		AmmoDisplay_Ref.SetMaterial( LeftDigit_MaterialSlotNum, AmmoNumbers_Medium[0]); //Left Display
		AmmoDisplay_Ref.SetMaterial( MiddleDigit_MaterialSlotNum, AmmoNumbers_Medium[AmmoCount_LeftDigit]); //Center Display
		AmmoDisplay_Ref.SetMaterial( RightDigit_MaterialSlotNum, AmmoNumbers_Medium[AmmoCount_CenterDigit]); //Right Display
	}
}

DefaultProperties{
	TwoDigits = false;
	ThreeDigits = false;
}