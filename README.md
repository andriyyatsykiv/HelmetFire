
<h1 align="center">
  <br>
  <a href="https://github.com/andriyyatsykiv/HelmetFire"><img src="https://github.com/andriyyatsykiv/HelmetFire/blob/33467a45b65a3d65ad5e1c3b2095f7716c01d152/HelmetFire/HelmetFire%202D%20Assets/HelmetFire%20Icon%20SVG.svg" alt="HelmetFire" width="200"></a>
  <br>
  HelmetFire
  <br>
</h1>

<h4 align="center">FOSS Aviation-specific skills training software for aviation enthusiasts.</h4>

<p align="center">
  <a href="#key-features">Key Features</a> •
  <a href="#how-to-use">Installing / Using</a> •
  <a href="#credits">Credits</a>
</p>

<!-- 
![screenshot](https://raw.githubusercontent.com/amitmerchant1990/electron-markdownify/master/app/img/markdownify.gif)
 -->


# Key Features

<p align="center">
<a href="https://github.com/andriyyatsykiv/HelmetFire"><img src="https://github.com/andriyyatsykiv/HelmetFire/blob/76b69a2e011739b50d517f6226b2d6a826aa6752/HelmetFire/HelmetFire%202D%20Assets/HelmetFire%20Screenshots/HelmetFire%20Cockpit%20Playing.png" alt="HelmetFire" width="800"></a>
</p>


While learning fundamentals of BRAA and bullseye callouts for combat flight sims, I saw that there were limited resources available to interactively practice going from hearing a BRAA or BULLSEYE callout to converting that into actual, practical knowledge of where another aircraft (or your own) is located. If you wanted to practice in a dynamic environment, your only option was to load up a full simulator scenario, which is time consuming and takes time away from actually going out and doing the things you enjoy.

HelmetFire is a completely free and open-source BRAA and BULLSEYE call simulator that I designed and coded to overcome this problem and help practice BRAA and BULLSEYE callouts on-demand and in a customizable and controlled environment. The features include :

* A [BRAA](https://wiki.hoggitworld.com/view/Getting_started_with_GCI/AWACS#Understanding_BRAA_calls) call mode (default)
    * You are placed in a simplified 3D cockpit and hear BRAA calls, responding by turning to face the target and clicking once you have figured out where the target is relative to you.


 * A [BULLSEYE](https://www.youtube.com/watch?v=UjLiGRtS_NQ&pp=ygUSYnVsbHNleWUgY2FsbHMgZGNz) call mode
    * Similar to the above, except the calls are given relative to a bullseye.

## Customizations:

<p align="center">
<a href="https://github.com/andriyyatsykiv/HelmetFire"><img src="https://github.com/andriyyatsykiv/HelmetFire/blob/a17192005b3d22f3b426387878d4e2f5920b5998/HelmetFire/HelmetFire%202D%20Assets/HelmetFire%20Screenshots/HelmetFire%20Options.png" alt="HelmetFire" width="400"></a>
</p>

* Toggleable  <a href="###Make-targets-visible">enemy visibility</a>, to simulate BVR conditions.
* Toggleable <a href="###Randomize-own-aircraft-direction">directional randomization</a> for the user aircraft. Beginner users may prefer to always start facing north, with this disabled.
* Toggleable <a href="###Analog Heading Indicator">analog</a> and <a href="### Numerical Heading Indicator">textual</a> heading indicators.
* A toggleable <a href="###Make targets visible">minimap</a> showing your location relative to bullseye
* A toggleable <a href="###Is bullseye location Visible?"> physical bullseye marker</a> present in the simulator space
* A <a href="### Display own bullseye as text">textual indicator</a> showing your own location relative to bullseye, in "DEGREES / NAUTICAL MILES" format

# How To Use - Installing
After downloading the program from the [latest release](TODO RELEASE LINK), launch the HelmetFire.exe included in the download, and configure
your preferred settings in the options menu. When playing, use your mouse to turn towards where you believe the target is, and click. You will hear a positive-sounding tone if you are correct, and a bad-sounding tone if you are not.

## Updating
Your options are stored under \AppData\ (search for helmetfire in that folder). Delete that folder after updaing to re-fresh the settings and shaders for the new version. For browser versions, clear your cache.


## Settings
In addition to the settings presets provided, anyone can change
the settings around to fit their intended goals, whether it be learning the fundamentals of BRAA and Bullseye calls,
or to get used to converting a call to knowledge of where a target actually is in order to do so faster with practice.

* ### Use Bullseye
If enabled, instead of issuing a call in BRAA format relative to your own aircraft, will issue calls relative to a randomly generated bullseye.

* ### Is bullseye location Visible?
Toggles the bullseye marker's visibility _in the 3D world_ (does not affect its visibility on the minimap)

You will see the marker as a blue cone.

* ### Display own bullseye as text
Will display your own aircraft's location relative to bullseye in BBB / MMM (Bearing and Miles) format on
an instrument in the cockpit.

* ### Analog Heading Indicator
Toggles the presence of an analog heading indicator, in the form of a _N E S W_ style heading dial with a red arrow
that points to where your aircraft is facing.

* ### Numerical Heading Indicator
Toggles the presence of a digital heading indicator in the cockpit, that displays your current heading in numerical form as degrees.

* ### Make targets visible
Toggles the visibility of the target aircraft that calls are based off of, to allow for simulation of beyond visual range encounters.

* ### Subtitles
Toggles the display of the BRAA or bullseye call you hear in text form at the bottom of the screen. If disabled, you will only hear the audible call. This makes it easier as it allows you to reference.

* ### Randomize own-aircraft direction
Toggles random heading of the user's simulated cockpit for every challenge scenario. Without this enabled, cockpit will always face north.

* ### Timer Time
Sets the time (in seconds) between targets appearing.

* ### Mouse Sensitivity
How sensitive the in-game mouse is to user mouse movements.

* ### Allowable directional error
Modifies the maximum error in degrees between where the user clicks, and the actual position of a target.

Think of this as a flashlight, this number represents the width of the beam in degrees. When you click, the program checks if the enemy is within X degrees of your click. Bigger numbers allow for greater click error and still getting marked correct.

## Credits

This software used, referenced, or was otherwise helped by the following projects:

[GODOT](https://github.com/godotengine/godot) - Open Source Game Engine that was used for the development of HelmetFire

[Falcon BMS](https://www.falcon-bms.com/) - Incredibly detailed systems simulation of the F-16 viper aircraft and mission briefing/navigation. Now playable in VR!

[VTOL VR](https://store.steampowered.com/app/667970/VTOL_VR/) - Well optimized and accessible VR-based flight sim.

[FreeSVG.org](https://FreeSVG.org) - For a variety of public domain scalable vector graphics, from which I obtained the helmet and flames for the HelmetFire icon.



---
