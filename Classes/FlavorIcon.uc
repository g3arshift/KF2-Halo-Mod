//=============================================================================
// A simple class that contains a CanvasIcon, coordinates, and scaling for its use 
// in the Canvas system using 7 different aspect ratios. Coordinates are the top
// left most edge of the icon.
//=============================================================================
// Gear Shift Gaming 9/8/2020
//=============================================================================

class FlavorIcon extends Canvas;

var CanvasIcon Icon;
var IntPoint AR_4_3, AR_5_4, AR_3_2, AR_16_9, AR_16_10, AR_21_9, AR_32_9;
var float AR_4_3_Scaling, AR_5_4_Scaling, AR_3_2_Scaling, AR_16_9_Scaling, AR_16_10_Scaling, AR_21_9_Scaling, AR_32_9_Scaling;
var LinearColor IconColor;

//Fake constructor for FlavorIcon.
function MakeFlavorIcon(CanvasIcon tempIcon, int X43, int Y43, int X54, int Y54, int X32, int Y32, int X169, int Y169, int X1610, int Y1610, int X219, int Y219, int X329, int Y329, float S43, float S54, float S32, float S169, float S1610, float S219, float S329, optional LinearColor tempIconColor)
{
	Icon = tempIcon;
	SetXY(X43, Y43, X54, Y54, X32, Y32, X169, Y169, X1610, Y1610, X219, Y219, X329, Y329);
	SetScaling(S43, S54, S32, S169, S1610, S219, S329);
	if(tempIconColor.A != 1)
	{
		IconColor = tempIconColor;
	}
}


function SetXY(int X43, int Y43, int X54, int Y54, int X32, int Y32, int X169, int Y169, int X1610, int Y1610, int X219, int Y219, int X329, int Y329)
{
	AR_4_3.X = X43;
	AR_4_3.Y = Y43;

	AR_5_4.X = X54;
	AR_5_4.Y = Y54;

	AR_3_2.X = X32;
	AR_3_2.Y = Y32;

	AR_16_9.X = X169;
	AR_16_9.Y = Y169;

	AR_16_10.X = X1610;
	AR_16_10.Y = Y1610;

	AR_21_9.X = X219;
	AR_21_9.Y = Y219;

	AR_32_9.X = X329;
	AR_32_9.Y = Y329;
}

function SetScaling(float S43, float S54, float S32, float S169, float S1610, float S219, float S329)
{
	AR_4_3_Scaling = S43;
	AR_5_4_Scaling = S54;
	AR_3_2_Scaling = S32;
	AR_16_9_Scaling = S169;
	AR_16_10_Scaling = S1610;
	AR_21_9_Scaling = S219;
	AR_32_9_Scaling = S329;
}

function SetColor(LinearColor tempIconColor)
{
	IconColor = tempIconColor;
}