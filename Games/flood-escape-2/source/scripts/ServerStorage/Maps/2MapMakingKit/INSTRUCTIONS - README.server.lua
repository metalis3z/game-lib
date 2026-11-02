--[[

FE2CM MAP KIT INSTRUCTIONS - by Crazyblox (rewritten by dripperoniz & Gam73)
	>> Last Updated: MAY 22nd 2024 <<

------------------------------------------------------------------------------------ 
<TERMS & CONDITIONS>

	By using FE2CM and its services you acknowledge and agree to the following:
	
	- Whitelisting your map to FE2CM grants Crazyblox Games an exclusive license, 
	allowing us to protect your work (Such as map theft).
	- Crazyblox Games holds the right to withhold content for any given reason.
	- Your map may be used as a highlight within Flood Escape 2.

	© Crazyblox Ltd 2024

------------------------------------------------------------------------------------]]


--[[ WHITELISTING
	
	In order to be able to test your map, you need to obtain the 100 Maps Badge in
	Flood Escape 2 and have 2FA enabled on your Roblox account.
	
	After fufilling those requirements, you need to publish a model to Roblox. Select the
	model and press "Save to Roblox". Go to the model's settings and enable "Distribute 
	on Creator Store" so the whitelisting bot can buy the model from your inventory. 
	This process is automatic. Copy the number ID from the model's url.
	
	Join FE2CM Community Maps and paste the ID into the ">Type ID" box and press "Whitelist".
	If you see "Map whitelisted!" in the Output tab, you have successfully whitelisted
	your map! You have to rejoin in order to load the map, and must also go back to the 
	model's page and disable "Distribute on Creator Store".
	
	Reinsert the number ID and press "Load". The output should now give you a string ID to
	properly load the map. Enter this new ID and press "Load" again. Your map should now be
	added to the active list and ready to be played!
	
	NOTE: If you get an error upon rejoining and loading the number ID, the bot may have not
	accepted the model. Rewhitelist the model using the number ID and retry until you
	are finally shown the string ID for the map.
	
]]


--[[ MAP FORMATTING

	In order to load your FE2CM map, you must have the following objects as a direct
	child of the map model or the respective folder names below:
	
	- Map [Model, can be named anything]
		- Settings [Folder]
			- Lighting [Configuration]
		- Timelines [Folder]
		- ExitBlock [Part, multiple allowed]
		- ExitRegion [Part, multiple allowed]
		- Spawn [Part]
	
	It is recommended to use folders in your maps in order to stay organized.
	The map kit provides examples for this (e.g. Geometry, Interactives, Mechanics).
	Things can get messy quick!
	
]]


--[[ MAP SETTINGS

	Map settings are located in the attributes of the Settings folder.
	
	[string] BGM
		The music for the map. It is formatted in one of 2 ways:
		
			AudioID
			AudioID_AudioLink
		
		The Audio IDs for the FE2 OST is in a script called "FE2 OST IDs".
		If you choose to only use a custom soundtrack, AudioID must be set to 0
		
			EXAMPLE: 0_<soundtrack directory>
	
	[string] Collaborators
		Add creators who've contributed to your FE2CM Map via Roblox User ID! You must have 
		them added as a friend on Roblox. User IDs must be separated with ", "
		
			EXAMPLE: 123465126, 50660159
	
	[number] Difficulty
		The set difficulty of the map. The official FE2 difficulties are as follows:
		
			1 = Easy
			2 = Normal
			3 = Hard
			4 = Insane
			5 = Crazy
			6 = Crazy+
		
		You can optionally set a star rating within a difficulty, only spanning the tenths.
		
			EXAMPLES: 3.8, 5, 6.2
	
	[number] MapImage
		The map image that will show up in the map list and during loading.
		
		To create a map image, upload a decal and copy ONLY the number ID from the decal's 
		properties into this attribute. You can find this number ID from the decal in the 
		Creator's tab or via inserting the decal into studio.
	
	[string] MapName
		The name of the map. Note that this will run through Roblox's filter system.
	
	[number] MaxSlopeAngle
		The maximum angle the player can walk on before slipping off. 
		Flood Escape 2's default value is 67.5.
		
			MIN VALUE: 0 [0 degrees]
			MAX VALUE: 90 [90 degrees]
	
	[number] MaxTime
		The max time in seconds allowed before the game kills any 
		players still alive.
		
			MIN VALUE: 10 [10 seconds]
			MAX VALUE: 600 [10 minutes]
	
	[string] Notes
		Map notes that will show up in FE2CM's map list when you hover over them.
		Note that this will also run through Roblox's filter system.
	
	[string] Testers
		Used to add players to closed map testing. Add the Roblox User IDs and 
		separate them with ", "
		
			EXAMPLE: 123465126, 50660159
		
	[boolean] Testing
		Check this box to enforce "Testing Mode". Enabling this will only allow 
		Map Creators/Collaborators/Testers to load the map.
	
]]


--[[ MAP LIGHTING
	
	The Lighting configuration is found under Settings. You will see attributes for 
	all supported lighting properties. You only need to configure the lighting 
	attributes that you want to modify. FE2 will use a preset lighting property if 
	it is not present in the configuration setting.
	
	You can also insert post-processing effects inside of the Lighting configuration.
	Examples include ColorCorrection, Blur, DepthOfField, SunRays, and more.
	Clouds and Atmosphere are also supported and can be placed inside the configuration.
	
]]


--[[ GAME MECHANICS

	More specific info on parts and models that can be used in your map:

	[BasePart] Spawn
		Spawns the player in a random spot on the part. Can be resized.
		
	[BasePart] Water
		The fluids in Flood Escape 2. Each state of water has different 
		effects on the player. Most allow you to swim in them. There are
		presets in the map kit showcasing every available state and attribute.
		
		The main 3 states are water, acid, & lava.
	
	[BasePart] ExitRegion
		The area the player must reach in order to win. All buttons
		must be pressed beforehand. There can be more than 1 ExitRegion.
		
	[BasePart] ExitBlock
		Activates as a solid barrier after the player reaches the ExitRegion.
		There can be more than 1 ExitBlock.
	
	[Model] Buttons
		Must be named "_Button#" and be in numerical order.
		
		You can also add an ObjectValue called "Group" to make a group button, 
		or "Fuse" to make an exploding button.
	
	[TrussPart] Trusses
		Holding space on Trusses allows you to repeatedly jump upwards instead
		of pushing you back.
	
	[BasePart] Walljumps
		Any part that has an ObjectValue named "_Wall" will become a part
		you can stick on to and jump off of.
	
	[BasePart] SlideBeam
		Any part named "SlideBeam" will be compatible with Auto Slide.
	
	[Model] AirTank
		Gives the player 300 air by default. The model is provided in the map kit.
		
		You can add an attribute called "TankCapacity" [number] to customize 
		how much air the tank will give you.
	
	[Model] _Rope
		Ziplines are the main transportation mechanic in FE2. Attempting
		to move the Zipline during gameplay will break its functionality.
		
		The "_Rope" model is used to contain points needed for
		generating Ziplines. You must add BaseParts called
		"Point#" inside of this model.
		
		The game will generate a Zipline path based off these points 
		in numerical order. Note that will be formed as a Bezier curve.
		
		You can also modify the speed (RopeSpeed [number]) 
		and exit velocity (VelocityInheritance [number]) of _Rope using
		the attributes provided in the kit.
		
	[Model] _Variants
		Variants are what can give a map increased replay value and 
		multiple paths if intended by the map creator.
		
		The "_Variants" model contains models intended for multiple 
		paths in a map. FE2 will pick one model and delete the rest.
		Only the parent model must be named _Variants; the models to
		be chosen from can be named anything.
		
	[BasePart] _Rescue
		Used to mark a location for where a potential rescue mission 
		can spawn. You can have multiple _Rescue parts and FE2 will 
		pick from any random one.
		
		You can create a custom escapee which allows you to express 
		your map's theme and personality over a default one.
	
		Under the "Rescue" configuration object, you need the following:
			
			- Body Colors
			- Shirt
			- Pants
			- All Accessories
		
		If you want a custom face, use accessories that allow such case, as
		the face used in escapees are unchangeable. It is important to unanchor 
		all Handles inside the accessories so they don't stay static when you
		collect the escapee.
	
		You can change the escapee's name with the "RescueName" attribute 
		in the Rescue config.
	
]]


--[[ TIMELINES

	As of July 2023, Flood Escape 2 utilizes a scriptless system 
	called "Timelines". It makes use of configuration objects, 
	XFrames via ObjectValues, and attributes.
	
	All timeline objects must be under the "Timelines" folder
	to function, and all XFrames [ObjectValue] must be under
	a Timeline [Configuration] to run.
	
	There are presets in the map kit for most of the functions 
	of Timelines in order to get you started. Mess around and 
	spend time to get used to the system. A lot of creativity is 
	possible despite the limitations!
	
	Here is a brief summary of the supported timeline & XFrame (keyframe) types.
	Not all attributes listed are required for timelines or keyframes to run.
	
	For the full TIMELINES DOCUMENTATION, go to:
	https://devforum.roblox.com/t/fe2cm-timelines-documentation/2982302
	
	
	TIMELINE ATTRIBUTES:
		GLOBAL TRIGGER TYPE - runs for all players
		!!! (Keyframe types supported: SetWaterState, MovePart, SetProperties, SetHumanoid, Teleport, SetCamera, ShakeCamera, Alert, Sound) !!!
			Trigger_Delay [number] - wait time in seconds before the timeline runs
			Trigger_Button [number] - button number to be pressed that runs the timeline
			Trigger_Timeline [string] - runs once the given timeline name finishes
			Trigger_Touch [string] - runs during any player collision with any part with the matching name provided
			Trigger_Dormant [bool] - only runs if connected to a failed conditional keyframe
			
				(NOTE: Multiple triggers that attempt to run the timeline will only be launched by the highest priority)
				(Trigger_Button > Trigger_Timeline > Trigger_Touch)
				
				(Trigger_Delay can be used in addition to any trigger chosen above)
			
		LOCAL TRIGGER TYPE - only runs for a specific player 
		!!! (Keyframe types supported: SetHumanoid, Teleport, SetCamera, ShakeCamera, Alert, Sound) !!!
			LocalTrigger_Touch [string] - same as Trigger_Touch but only applies keyframes to the specific player
			LocalTrigger_Dormant [bool] - same as Trigger_Dormant but only applies keyframes to the specific player
			
		MISC - extra attribute types
			Touch_Debounce [number] - allows for multiple touches using a time delay; supports both Trigger_Touch & LocalTrigger_Touch
			RepeatOnCompletion [bool] - repeats the timeline once finished if set to true; ignored if there is a Touch_Debounce set
	
	XFRAME ATTRIBUTES:
		MAIN ATTRIBUTES - required for the keyframe to run
			XFrame_Timestamp [number] - the time to run the keyframe relative to the timeline beginning
			XFrame_Length [number] - length of the keyframe, can be 0 or larger if supported by chosen function
			XFrame_Priority [number] - order in which to run keyframes if at the same timestamp, highest to lowest
			XFrame_Function [string] - function to be run with the keyframe (see list below)

		FUNCTION CHOICES - function names that can be set for XFrame_Function and their respective attributes
			SetWaterState - function to change state of a water part
				(XFrame.Value -> any _Water part)
				
				State [string] - state to change to (water, acid, lava)
				DontChangeColor [bool] - whether the water will change color when switching states or not
				SpecifiedColor [Color3] - custom color to change the water part to when switching states
				
			MovePart - moving parts/models; models must have PrimaryPart set to allow UseLocalSpace
				(XFrame.Value -> any BasePart or Model)
				
				Translation [Vector3] - xyz position to shift the part/model by
				UseLocalSpace [bool] - whether to move relative to part/model's local orientation or not
				EasingStyle [string] - tweening style of movement (Linear, Sine, Back, Quad, Quart, Quint, Bounce, Elastic, Exponential, Circular, Cubic)
				EasingDirection [string] - start/end tweening style of movement (In, InOut, Out)
			
			SetProperties - modify the properties or attributes of a selected object
				(XFrame.Value -> any object)	
				
				Property_PropertyNameHere [matching data type] - property to change, must match the datatype of the object
				Attribute_AttributeNameHere [matching data type] - attribute to change, must match the datatype of the object's attribute
				Tween_EasingStyle [string] - tweening style of property/attribute (Linear, Sine, Back, Quad, Quart, Quint, Bounce, Elastic, Exponential, Circular, Cubic)
				Tween_EasingDirection [string] - start/end tweening style of property/attribute (In, InOut, Out)
				Tween_RepeatCount [number] - amount of times to repeat the tween
				Tween_Reverses [bool] - whether the tween reverses or not
				Tween_DelayTime [number] - intial delay in seconds before the tween begins
				ApplyToDescendants [bool] - whether to apply changes to all descendants of the selected object or not
				Operator [string] - performs arithmetic operation on the properties/attributes if supported by data type (+, -, *, /)

			Conditional - checks the property/attribute value in the keyframe against the object's property/attribute (IF TRUE, continue timeline; IF FALSE, timeline stops)
				(XFrame.Value -> any object)	
				
				RelationalOperator [string] - comparison type (==, ~=, >, >=, <, <=)
				Property_PropertyNameHere [matching data type] - property to compare against
				Attribute_AttributeNameHere [matching data type] - attribute to compare against
				
				*You can also add "Conditional_Timeline" inside the Conditional keyframe to run if false!
					Conditional_Timeline [ObjectValue] - the timeline to run if the conditional is false; set this as the value
						(No attributes needed for Conditional_Timeline)
					
			SetHumanoid - modifies humanoid properties
				(XFrame.Value -> none)
				
				Property_PropertyNameHere [matching data type] - humanoid property to change, must match the datatype in the humanoid
					(Supported properties: Jump [bool], Health [number], MaxSlopeAngle [number], WalkSpeed [number], JumpPower [number]) 
					
			Teleport - teleports player(s) to a part or by an offset distance
				(XFrame.Value -> any BasePart or none)
				
				TranslateDestination [Vector3] - offset translation to teleport by; offset relative to part selected or the player if no part is selected
						
			SetCamera - modifies the camera position and orientation
				(XFrame.Value -> any BasePart or none)
				
				CamInfo [CFrame] - position & orientation of the camera, orientation is relative to looking at the subject
				RelativeToSubject [bool] - whether camera position is relative to the subject instead of globally
				Enabled [bool] - whether to enable camera modification, or reset the camera to normal
				DisableOnEnd [bool] - whether the camera auto-resets after XFrame_Length has elapsed or not
				
			ShakeCamera - applies camera shake to the screen
				(XFrame.Value -> none)
				
				Intensity [number] - amplitude of the shake, measured in studs away from the camera (1 Intensity = 1 Stud)
				
			Alert - displays a message on the screen, internally filtered (Roblox TOS)
				(XFrame.Value -> none)
				
				Message [string] - message to be displayed
				Color [Color3] - color of the message
				
			Sound - plays sound at a specific location or everywhere
				(XFrame.Value -> any BasePart or none)
				
				SoundId [number] - asset ID of sound to be played
				Volume [number] - how loud the sound is
				Pitch [number] - playback speed of the sound
				
]]