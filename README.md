# Community JAS-39C
Welcome to our GitHub for the JAS-39C Gripen mod for DCS!

Our team is passionate about aviation and DCS, and we wanted to bring the JAS-39 Gripen to the simulator. We started working on the mod in February 2021, and in a short amount of time, we have achieved a basic FC3 module. We have put a lot of effort into the mod and have added several features to enhance the user experience. Our main focus has been on creating an authentic and immersive cockpit that accurately represents the Gripen's instruments and controls. We have also added unique weapons and made modifications to the SFM to make it as realistic as possible, taking feedback from Gripen SMEs into consideration. We are grateful to the Community A-4E-C team, Grinnelli, Freebird, Gonzalodesanta, Megalax, Isak, 313_Paegas, Krieger, and VSN Team for their support and contributions. Without their help, this project would not have been possible. We are excited to share our mod with the DCS community and welcome anyone who shares our passion to join us on Discord to learn more about the project.

## Contributing Developers

Breadmaker91, Currenthill, FatSpacePanda, FrM|Shaft, kingdevc, Luiz Renault, Gripen Viking, MangoTango, Roughmaster, Whisky Actual, Yatsie, mrbenevolentcanard, neon_cat_

## Past Developers
Double Tap, Glaucus, Kreazle, Vinedog, Wolfthrower

## Liveries

313_Paegas, 59th_Jack, Isak Khysing, Megalax

## Admins

Cortexus, Jack ”Rabbit”, Ulv, mrbenevolentcanard

## Testers

CJordense, Cortexus, DJTaz1975, Norman, Simba11, kenoneuer, bothhoon, bitar_a

## Special Thanks

Bimbac, Fox, Fox2 Productions, Freebird, Generic, Gonzalodesanta, Grinnelli, Growling Sidewinder, Krieger, Neon, PORS, rudel-chw, Jerec, Ulvar40, VSN Team (Cdpkobra and Razor+)

## What's new in version 1.8.6
For a complete list of changes - check out the 1.8.6 release notes.

- Added
  - Simple navigation system (waypoints from ME).
  - New RWR symbolgy + RWR on HUD.
  - Shading on MFD (LD) instruments.
  - New HMD symbolgy and brightness control via UCP.
  - Keybinds for zooming in/out on CD (for navigation).

- Changed
  - RB-15 uses ELINT for targeting again.
  - Pylons now have SAAB names (3R/L 2R/L etc).
  - RB-15 is now only available on 3R/L pylons.
  - More realistic AAM performance.
  - Moved cockpit camera to better align with HUD.
  
- Fixed
  - HMD not always working.
  - TVC missiles spinning out of control.
  - Ground units not spawning.
  - Airbrake not deploying.
  - Unable to get LA.
  - "Trigger safe (hold)" not working.
  - HMD causing CTD (although it is a performance issue, but should be more forgiving).
  - JAS-39 RWR not working (garuanteed to work with surface contacts, air contacts can still be buggy). 
  - Other minor bug fixes.

- Known Bugs
  - Can't fly A/A BVR & A/A WVR. **Fix:** Load the cooresponding FC3 (F-15C and Su-33 respectively) module's cockpit once that game session (bug by ED for all FC3 mods since FC2024).
  - RWR air contacts can be buggy at times. **Fix (not 100%):** If in SP, click right alt + j two times in a row. If in MP, hop in and out of the aircraft.

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

If your game fails to launch maybe the JAS-39 mod is conflicting with another one. We suggest removing all of the mods found in `C:\Users\username\Saved Games\DCS\Mods\`. You can add your mods back one at a time and see which one conflicts.

## Frequently Asked Questions
- **Q: Do you need FC3 to use the module?**
  - Yes for the A/A BVR variant (F-15C) (not free)
  - Yes for the A/A WVR (Su-33) (not free)
  - No for the AG variant since it uses the Su-25T avionics (free)
- **Q: Do we plan to make it a standalone?**
  - We are working on it for v2.0, but no promises since we are still exploring the limits of development without the SDK.
- **Q: Do we need test pilots?**
  - Not currently, thank you.
- **Q: Do we plan to have a D model (two seater)?**
  - No, focus will be on the Charlie model.
- **Q: My keybinds don't work (axis, brakes, etc.)**
  - The Gripen has special keybinds and axis, you will need to bind them before flying.
- **Why can't I fire my tv guided bomb (this includes the GBU-39 SDB)? **
  - There is a conflict with other mods, try disabling them and it should fire as intended.
- **How can I support the mod/team?? **
  - We currently do not have a paypal set up, so here are some ways you can support the development:
    Learn 3D, 2D, coding etc and join the dev team. Help us recruit members to fill gaps in the team. Constructively report bugs and inaccuracies. Contribute to discussions or questions in this Discord. Watch, like and subscribe to content creators who support our mod through trailers as well as tutorial. 
- **Q: Will the JAS-39 mod pass IC?**
  - Yes, but a public server will need to have the same version for it to work properly.
- **Q: I can't fire!**
  - There are two safety mechanisms modeled. First, you need to put the master arm switch to "Live". Look for a big knob surrounded by red and white stripes on the right-hand side of the cockpit ([video](https://youtu.be/uRtXBdGcmMY?t=945)). You can also keybind this (<kbd>MASS Live</kbd>, <kbd>MASS Standby</kbd> and <kbd>MASS Safe</kbd>). Second, whenever you shoot, you have to depress (or toggle) the trigger safe (<kbd>Trigger Safe - Hold</kbd> or <kbd>Trigger Safe - Switch</kbd>). If you only press the <kbd>Trigger</kbd> without releasing the trigger safe, nothing will happen.
