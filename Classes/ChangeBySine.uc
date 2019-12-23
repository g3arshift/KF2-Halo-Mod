/*===========================================================================================
ChangeBySine.uc - A class that adds some functionality to figuring out how to fade
between different RGBA values for canvas, including dynamic sinusoidal calculations for
sine wave shaped changes.

email: gearshift@gearshiftgaming.com ; discord: Gear Shift#6360, noodle#0001 ; 2019
===========================================================================================*/

class ChangeBysine extends object;

var int ColorChangeAmount_R;
var int ColorChangeAmount_G;
var int ColorChangeAmount_B;
var int ColorChangeAmount_A;

var float UITime, MinTime, MaxTime;
var bool IsIncrementing, IsMinMaxSet;

/*
* Enabling the override will cause the first "cycle" through the drawing loop to be drawn. The first cycle always starts at 128, so it's typically undesirable to enable this behavior.
*
* The optional variables EnableAlphaDelay, AlphaDelay_AlphaValue, DelayTime, and Worldtime.TimeSeconds all are used for enabling the class to momentarily "pause" the changing of the returned value.
*/
function int SinChange(int ChangeRate, optional bool OverrideDrawing = false) {
	if (!IsMinMaxSet) {
		setMin(ChangeRate);
		setMax(ChangeRate);
	}

	if(IsMinMaxSet == false && OverrideDrawing == false)
	{
		return 0;
	}
	else
	{
		return getSine(ChangeRate);
	}
}

/*
* This function returns the sine calculation. ChangeRate is Frequency, 127.5 is amplitude. You set your upper limit with the amount you multiply sin(UITime * ChangeRate) by, and the
  	number you add to it will be its Y offset. With us multiplying by 127.5, and adding 127.5, the sine graph goes to an upper limit of 255 and starts at 0. If we did not do the addition
  	The lower limit would be -127.5 and the upper would be 127.5.
*/
function int getSine(int ChangeRate) {
	local int sineout;

	doCounter();
	sineout = sin(UITime * ChangeRate) * 127.5 + 127.5;
	return sineout;
	// Once testing is done, you may want to remove the local declaration & var assignment, and instead just `doCounter()` and `return sin(uitime blah blah blah....`
}

function doCounter() {
	if(IsIncrementing) {
		UITime = UITime + 0.001;
	}
	else {
		UITime = UITime - 0.001;
	}
	if(UITime == MinTime || UITime == MaxTime) {
		IsIncrementing = !IsIncrementing;
	}
}

function setMin(int ChangeRate) {
	local int sineout;

	if (MinTime == -1) {
        sineout = getSine(ChangeRate);
        if (sineout == 0) {
            MinTime = UITime;
            IsIncrementing = !IsIncrementing;
        }
    }
    if(Mintime != -1 && Maxtime != -1)
    {
    	IsMinMaxSet = true;
    }
}

function setMax(int ChangeRate )
{
	local int sineout;

	if (MaxTime == -1) {
    	sineout = getSine(ChangeRate);
        if (sineout == 254) {
            MaxTime = UITime;
            IsIncrementing = !IsIncrementing;
        }
    }
    
    if(MinTime != -1 && MaxTime != -1)
    {
    	IsMinMaxSet = true;
    }
}

function ReinitMinMax(int ChangeRate)
{
	setMin(Changerate);
	setMax(ChangeRate);
}


DefaultProperties
{
	ColorChangeAmount_R = 0
	ColorChangeAmount_G = 0
	ColorChangeAmount_B = 0
	ColorChangeAmount_A = 0
	UITime = 0.0;
	IsMinMaxSet = False
	IsIncrementing = true
	MinTime = -1
	MaxTime = -1
}