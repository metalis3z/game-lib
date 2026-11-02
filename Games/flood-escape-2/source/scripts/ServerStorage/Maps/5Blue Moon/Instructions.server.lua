--Last edited 03/26/2021 by Crazyblox

--[[ BEFORE CONTINUING [[--
	By creating and submitting a map to FE2CM you are acknowledging that Crazyblox Games
	holds the right to allow / remove community created content. You also acknowledge
	that the functionality of FE2 and FE2CM changes and evolves with it overtime.
	With each update to the game we check thoroughly for any game breaking bugs.
	If your map becomes incompatible as part of an update that was made to FE2,
	Crazyblox Games is not responsible for the functionality of your map breaking.
	It is best to refer to the community and see if others are sharing the same problem,
	and work towards making your map compatible. Most map breakages come from not
	complying with the policy set in place for FE2CM designed to make the game run smoothly.

	In order to be able to test your map, you need to publish it as a model and
	submit the ID found in the Model's URL on the website for whitelisting at the
	FE2 Map Testing Grounds: https://www.roblox.com/games/2198503790/FE2-Map-Test
	
	Whitelisting maps is a manual process and is run through every couple days.
	Once your map has been approved you can test the map with FE2CM.
	
	If your map is chosen to be added to FE2's main game, you will be reached out to
	where you are most prominent online, whether that be the CG forums, the discord server
	or twitter, and permission will be requested to add the map to the game, allowing
	Crazyblox Games to not only use the map but also hold the right to change anything in the
	map. Once permission is granted from yourself we will negotiate an agreed amount of pay via Robux
	and if applicable, split between other mentioned contributing members who have
	worked on developing the map. (Payment made through Crazyblox Games Group).
	Your map will then be officially added to FE2 and your name will show
	alongside the Map Name during gameplay.
	
	Good luck!
---------------------------]]


---Important:
--All major game objects must exist as the direct child of the map model.
--Major game objects include: Settings, Spawn, ExitBlock, ExitRegion, EventScript
--Intro model is used to simulate the lift moving, only use if you plan to add extra polish
--Geometry is just a Folder to help organise parts that aren't involved with any other feature in the map
--Walls for walljumping must have the texture and _Wall tag as included in the map kit
-----

------------------------------GAMEPLAY
--(If aiming for FE2 main game compatibility)
--Time to complete the map as a player should take between 1:10 - 1:45  minutes on a solo run,
--try not to build past 1:45 as the game kills off players after 2:00 minutes
--ExitRegion must be sealed by ExitBlock, duplicate ExitBlock if you need to
--
--
--Spawn can be modified but must remain the same size, add 30 stud height clearance if you're using Intro
--Don't modify AirTanks, they can however be duplicated or removed entirely
-----

------------------------------INTERACTIVES
--These objects don't require to be in this folder but it helps with organisation
--_Button#'s affect objects with tags in them or in the same model as them
--To link a button with a tag, just use the same number, the game goes through the buttons in order from 1 onwards.
--To make a button a group button, insert an objectvalue into the button and name it Group.

--Tags:
--[ObjectValue] _Fall# : Parts that become unanchored and fade when triggered
--[ObjectValue] _Fade# : Parts that get deleted when triggered
--[ObjectValue] _Appear# : Part that appears when triggered
--[Sound] _Sound# : Sound that plays when triggered
--[NumberValue] _Delay : Place inside any tag, delays action of the tag by your chosen number in seconds

--Variants:
--Variants are what can give a map increased replay value and multiple paths if intended by the map creator.
--[Model] _Variants : Contains models intended for multiple paths in a map. FE2 will pick one model and delete the rest.

--Ziplines:
--Ziplines are static and are not compatible with any tag. Attempting to move the Zipline during gameplay will break its functionality.
--[Model] _Rope : Model used to contain points needed for generating Zipline
--	--> [BasePart] Point# : The game will generate a Zipline based of these points in numerical order.

--Rescue:
--[BasePart] _Rescue : Used to mark a location for where a potential rescue mission can spawn. FE2 will pick from any random _Rescue part.
--			 Make sure part is upright, as the Rescue spawn will make use of this parts exact CFrame.
-----

------------------------------SETTINGS
--FE2 reads these values to set up for the map
--DON'T DELETE ANY SETTINGS except for Lightings children, FE2 uses a lighting preset if properties aren't present
--To add a new property to the Lighting Folder, add a value with the exact same name as the property, and the relevant type of value.

--Settings Properties:
--	[StringValue] BGM: ID used from selected audio's URL
--	[StringValue] Creator
--	[NumberValue] Difficulty : 1 = Easy, 2 = Normal, 3 = Hard, 4 = Insane
--	[StringValue] MapImage : Can be left blank
--	[StringValue] MapName
--	[NumberValue] MaxTime : Number is clamped from 10 to 180
--	[Folder] Rescue : Contains details for rescue character
--		--> [Folder] Cosmetics : Anything you want your rescue character to wear you put in here. Characters are R6.
--			--> [StringValue] RescueName

--Lighting Properties:
--	[Color3Value] Ambient
--	[NumberValue] Brightness
--	[Color3Value] ColorShift_Bottom
--	[Color3Value] ColorShift_Top
--	[Color3Value] OutdoorAmbient
--	[StringValue] TimeOfDay : Value is formatted by ' HH:MM:SS ' 
--	[Color3Value] FogColor
--	[NumberValue] FogEnd
--	[NumberValue] FogStart
--	[Folder] Effects : Used for any Lighting Effect (Color Correction may be incompatible when in _Water)
--		If you want to address these with LocalEventScript, FE2 will clone these effects into Lighting and prefix their name with "Map_"
-----

--------------------------------EVENTSCRIPT
--Controls water for the map, any other script included in the map is deleted
--Water is made only visible on the part's top surface
--Use these functions to manipulate the water:

--Lib.Script.setWaterState(water, state, noChangeColor, specifiedColor)
--	[BasePart] water : Selected water that will have its toxic state altered
--	[String] state : Changes state based on string ("water" = standard, "acid" = increased air drain, "lava" = instakill)
--  [Bool] noChangeColor : If true the game will not adjust the water's color that you are changing the state of. Use nil if you want to skip this.
--	[Color3] specifiedColor : Color that the game will transition the waters color to instead of the standard blue, green & red. 

--Lib.Script.moveWater(water, move, dur, isLocalSpace)
--	[BasePart] water: Water that will be moved
--	[Vector3] move : How far the water will be moved
--	[Number] dur : Duration in seconds for movement to happen
--	[Bool] isLocalSpace : false/nil translates in world space,
--						  true translates in local space
			
--I have added support for buttons executing functions within the EventScript
--I recommend only people with previous scripting experience to use this.

--EventString has since been deprecated and is no longer recommended for map functionality.
--Please make use of the EventScript provided.
-----

--Crazyblox