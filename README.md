# Community-JAS-39-C
Welcome to our GitHub for the JAS-39-C Gripen mod for DCS!

Our team is passionate about aviation and DCS, and we wanted to bring the JAS-39 Gripen to the simulator. We started working on the mod in February 2021, and in a short amount of time, we have achieved a basic FC3 module. We have put a lot of effort into the mod and have added several features to enhance the user experience. Our main focus has been on creating an authentic and immersive cockpit that accurately represents the Gripen's instruments and controls. We have also added unique weapons and made modifications to the SFM to make it as realistic as possible, taking feedback from Gripen SMEs into consideration. We are grateful to the Community A-4E-C team, Grinnelli, Freebird, Gonzalodesanta, Megalax, Isak, 313_Paegas, Krieger, and VSN Team for their support and contributions. Without their help, this project would not have been possible. We are excited to share our mod with the DCS community and welcome anyone who shares our passion to join us on Discord to learn more about the project.

## Contributing Developers

Breadmaker91, Currenthill, FatSpacePanda, FrM|Shaft, kingdevc, Luiz Renault, Gripen Viking, MangoTango, Roughmaster, Whisky Actual, Yatsie

## Past Developers
Double Tap, Glaucus, Kreazle, Vinedog, Wolfthrower

## Liveries

313_Paegas, 59th_Jack, Isak Khysing, Megalax

## Admins

Cortexus, Jack ”Rabbit”, Ulv

## Testers

CJordense, Cortexus, DJTaz1975, Norman, Simba11

## Special Thanks

Bimbac, Fox, Fox2 Productions, Freebird, Generic, Gonzalodesanta, Grinnelli, Growling Sidewinder, Krieger, Neon, PORS, rudel-chw, Jerec, Ulvar40, VSN Team (Cdpkobra and Razor+)

## What's new in version 1.8.5
For a complete list of changes - check out the change log file included in the package.

- Added
  - Cockpit model (added many details, animations, and one easter egg)
  - Cockpit textures (full PBR, normal maps, and proper AO)
  - Cockpit lighting (flood, instruments, and indicators)
  - In-cockpit pilot model with removable kneeboards
  - HMD for all variants, but you can cue weapons only with the new WVR variant
  - Within Visual Ranger (WVR) variant based on the SU33 avionics with HMD
  - More cockpit functionalities such as interior lighting, autopilot, radar controls, etc.
  - Custom RWR for all 3 variants
  - Custom GE F404 engine sounds
  - Training missions by rudel-chw
  - GamePad and keyboard support

- Changed
  - Controls schemes, grouped by systems and unified into 1 profile
  - Removed B* Betty sounds
  
- Fixed
  - APU sounds
  - Ground handeling (discoball bug)
  - Weapons bugs
  - Many bug fixes and improvements

- Known Bugs
  - Works with MT, but some stuff could be broken
  - RWR will work with several clients, but only on 2nd load (e.g. you will need to get out of the cockpit and come back in) -- FC3 limitation
  - Incompatible with some other mods like the Eurofighter and the A4E (will not CTD, but can be buggy)
  - SFM limitations while ground handling and in slow regimes in the air (will not be fixed since we are moving to EFM) 
  - Some weapons can't be fired by the AI (check for the AI versions of these) 

## Complete list of weapons 
- Cannon
   - BK-27 (with PELE/PELE-T and AP/HE/APHE ammo types)
- Air-to-Air WVR
  - AIM-9L
  - AIM-9M
  - AIM-9X
  - A-Darter
  - IRIS-T
  - AIM-132 ASRAAM
  - Python-5
- Air-to-Air BVR 
  - AIM-120B
  - AIM-120C-5
  - AIM-120C-7
  - I-Derby ER
  - Meteor
- Air-to-Ground guided
  - AGM-65H
  - AGM-65K
  - Brimstone
  - GBU-12
  - GBU-16
  - GBU-10
  - GBU-49
  - GBU-31
  - GBU-31 BLU-109
  - GBU-38
  - GBU-32
  - GBU-39 SDB
  - DWS39
  - RBS-15 Gungnir
  - MAR-1
  - SPEAR-3
  - SPEAR-EW
  - KEPD 350
  - Storm Shadow
- Air-to-Ground unguided
  - M70B AP
  - M70B HE
  - M71
  - Mk82
  - Mk83
  - Mk84
- Other
  - LDP Litening III
  - Drop tank 1100 litre

## Known Bugs

Find the full list of bugs and enhancements at https://github.com/whisky-actual/Community-JAS-39-C/issues or in our Discord under #bug-reporting

## Installation

1) Download the latest release at https://github.com/whisky-actual/Community-JAS-39-C/releases select **assets** -> Source code (zip)
2) Open the zip and go inside the first folder that will have the release name
3) Select the **Mods** folder and drop it under `C:\Users\username\Saved Games\DCS` (username will vary on your machine and DCS could be DCS beta)

## Installation Troubleshooting

If your game fails to launch maybe the JAS39 mod is conflicting with another one. We suggest removing all of the mods found in `C:\Users\username\Saved Games\DCS\Mods\`. You can add your mods back one at a time and see which one conflicts.

## Frequently Asked Questions
- **Q: Do you need FC3 to use the module?**
  - Yes for the BVR variant (F15) (not free)
  - Yes for the WVR (SU33) (not free)
  - No for the AG variant since it uses the SU25T avionics (free)
- **Q: Do we plan to make it a standalone?**
  - We are working on it for v2.0, but no promises since we are still exploring the limits of development without the SDK.
- **Q: Do we need test pilots?**
  - Not currently, thank you.
- **Q: Do we plan to have a D model (two seater)?**
  - No, focus will be on the Charlie model.
- **Q: My keybinds don't work (axis, brakes, etc.)**
  - The Gripen has specail keybinds and axis, you will need to bind them before flying.
- **Why can't I fire my tv guided bomb (this includes the GBU-39 SDB)? **
  - There is a conflict with other mods, try disabling them and it should fire as intended.
- **How can I support the mod/team?? **
  - We currently do not have a paypal set up, so here are some ways you can support the development:
    Learn 3D, 2D, coding etc and join the dev team. Help us recruit members to fill gaps in the team. Constructively report bugs and inaccuracies. Contribute to discussions or questions in this Discord. Watch, like and subscribe to content creators who support our mod through trailers as well as tutorial. 
- **Q: Will the JAS39 mod pass IC?**
  - Yes, but a public server will need to have the same version for it to work properly.
- **Q: I can't fire!**
  - There are two safety mechanisms modeled. First, you need to put the master arm switch to "Live". Look for a big knob surrounded by red and white stripes on the right-hand side of the cockpit ([video](https://youtu.be/uRtXBdGcmMY?t=945)). You can also keybind this (<kbd>MASS Live</kbd>, <kbd>MASS Standby</kbd> and <kbd>MASS Safe</kbd>). Second, whenever you shoot, you have to depress (or toggle) the trigger safe (<kbd>Trigger Safe - Hold</kbd> or <kbd>Trigger Safe - Switch</kbd>). If you only press the <kbd>Trigger</kbd> without releasing the trigger safe, nothing will happen.
