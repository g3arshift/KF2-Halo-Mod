# KF2-Halo-Mod

## EXTREMELY IMPORTANT INFO, DO NOT SKIP!!!

In order to get the sound for this weapon you need to go to
>Documents\my games\KillingFloor2\KFGame\Cache\2135416557\BrewedPC

and copy the 'WwiseAudio' folder into
>Steam\steamapps\common\killingfloor2\KFGame\BrewedPC

Additionally, if you were previously subscribed to my 'M6C Pistol' you **need** to unsubscribe from it, or delete folder number 1753171331 from your cache folder.

## Halo Mod - Weapons
This is the first phase of a multi-part mod for the game. It contains 15 new weapons, with extensive effort being put into making the weapons both feel as they did in the Halo games they come from, and also to fit well into the balance of Killing Floor 2.

The mod currently contains the following weapons:

- Halo 1 Magnum - M6D
- Halo 1 Anniversary Shotgun - M90 CAWS
- Halo 2 Anniversary Battle Rifle - BR55
- Halo 2 Anniversary SMG - M7
- Halo 3 Magnum - M6C/ M6C Dual
- Halo 3: ODST Magnum - M6C/SOCOM
- Halo 3: ODST SMG - M7S
- Halo: Reach Rocket Launcher - M41
- Halo: Reach Shotgun - M45
- Halo: Reach Grenade Launcher - M319 IGL
- Halo: Reach DMR - M392
- Halo: Reach Assault Rifle - MA37
- Halo: Reach Sniper Rifle - SRS99-AM
- Expanded Concept from Halo: Contact Harvest - XBR55/SOCOM

There are all new mechanics included in these weapons, mimicking their functionality in the games they come from, as well as some all new animations made from scratch, completely custom audio, and they are completely free and open source.

Make sure to join our [discord server here!](https://discord.gg/9AXPjaQ) Sneak peeks at content updates are regularly posted there as well as development progress on new weapons, characters, and more!


## SERVERS
Come join us on the official Halo Mod servers! We have a Zedternal server, two endless servers, two survival servers, and two servers with friendly fire on. Use one of the links below!

- GSG - Zedternal Reborn Hardcore - steam://rungameid/232090/connect/73.180.142.115:7783/
- GSG - Official Halo Server 1 - steam://rungameid/232090/connect/73.180.142.115:7789/
- GSG - Official Halo Server 2 - steam://rungameid/232090/connect/73.180.142.115:7791/
- GSG - Official Halo Server 3 - steam://rungameid/232090/connect/73.180.142.115:7793/
- GSG - Official Halo Server 4 - steam://rungameid/232090/connect/73.180.142.115:7795/
- GSG - Official Halo Server 5 - steam://rungameid/232090/connect/73.180.142.115:7797/
- GSG - Official Halo Server 6 - steam://rungameid/232090/connect/73.180.142.115:7799/


## USAGE

**Initialization**

Go to the [steam page](https://steamcommunity.com/sharedfiles/filedetails/?id=2135416557) and subscribe to the item first.

**Single Player Quick Start**
1. Click the Subscribe button above
2. Wait for Steam to finish downloading
3. Make sure you have copied the audio files as listed in the step at the top of the page
3. Start Killing Floor 2
4. On the game console (press ` key) enter (or copy/paste):
>open KF-BurningParis?Game=KFGameContent.KFGameInfo_Survival?difficulty=3?Gamelength=1?Mutator=HaloMod_Weapons.WeaponsActive

For server usage add

>mutator=HaloMod_Weapons.WeaponsActive

to launch arguments. However, as this mod replaces the trader archetype in order to use it in conjunction with other weapon mods you will either need to run the [Zedternal Reborn](https://steamcommunity.com/sharedfiles/filedetails/?id=2058869377) game mode or use the [Trader Inventory Mutator.](https://steamcommunity.com/sharedfiles/filedetails/?id=1131663339)

To use this on a Zedternal Reborn server **DON'T** add it as a mutator, instead go into the ZedternalReborn.ini and navigate to the section containing 'Weapon_CustomWeaponDef=Class.Weapon_Definition_Example'
then add the following lines below it

>Weapon_CustomWeaponDef=KFWeapDef_BR55
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_BR55
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M319
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M392
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M41
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M45
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M6C
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M6C_SOCOM
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M6CDual
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M6D
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M7
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M7S
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_M90
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_MA37
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_SRS99_AM
>Weapon_CustomWeaponDef=HaloMod_Weapons.KFWeapDef_XBR55_SOCOM


## ISSUE TRACKING
Please submit any issues you may have to the bug tracking on this page.


## CREDITS

- M7S Model/ Textures - Mattisafish, [Ishi](https://steamcommunity.com/id/mendicat)
- M7 Models/ Textures - [Ishi](https://steamcommunity.com/id/mendicat)
- BR55 Model/ Textures - [Tillice](https://steamcommunity.com/id/Tillice)
- M90 Model/ Textures - [DangerWasp](https://steamcommunity.com/id/dangerwasp)
- M6D Model/ Textures - [DangerWasp](https://steamcommunity.com/id/dangerwasp)
- Audio - Bungie
- Models/ Textures - Bungie
- Custom Animations/ Programming/ Rigging/ Texture Alterations/ UI Textures/ Everything Else - [Gear Shift](https://steamcommunity.com/id/g3arshift/)

Special Thanks to:

- [Magonus](https://steamcommunity.com/id/magonus)
- [Dragontear](https://steamcommunity.com/profiles/76561198057043296)
- [Kill Master](https://steamcommunity.com/id/KlLLMaster)
- [TheJP](https://steamcommunity.com/id/Altrentorae/)
- [Forrest Mark X](https://steamcommunity.com/id/ForrestMarkX)
- [Pissjar](https://steamcommunity.com/id/PissJar69)
- [Noodle](https://steamcommunity.com/id/jwshields)
- [Peelz](https://steamcommunity.com/id/LouisTakePILLz)

And all the others in the KF2 Modding Community

And a HUGE thanks to [Jafet Meza](https://www.youtube.com/channel/UCio5EkaSBFXlX4dRy-RzLXA) for his permission to use his arrangement of One Final Effort in the trailer.
