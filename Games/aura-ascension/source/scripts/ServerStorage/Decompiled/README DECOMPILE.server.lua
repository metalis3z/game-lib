--[[
		Thank you for using UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw.

		If you didn't save in Binary (rbxl) - it's recommended to save the game right away to take advantage of the binary format & to preserve values of certain properties if you used IgnoreDefaultProperties setting (as they might change in the future).
		You can do that by going to FILE -> Save to File As -> Make sure File Name ends with .rbxl -> Save

		ServerStorage, ServerScriptService and Server Scripts are IMPOSSIBLE to save because of FilteringEnabled.

		If your player cannot spawn into the game, please move the scripts in StarterPlayer somewhere else or delete them. Then run `game:GetService("Players").CharacterAutoLoads = true`.
		And use "Play Here" to start game instead of "Play" to spawn your Character where your Camera currently is.

		If the chat system does not work, please use the explorer and delete everything inside the TextChatService/Chat service(s). 
		Or run `game:GetService("Chat"):ClearAllChildren() game:GetService("TextChatService"):ClearAllChildren()`
				
		If Union and MeshPart collisions don't work, run the script below in the Studio Command Bar:
				
				
		local C = game:GetService("CoreGui")
		local D = Enum.CollisionFidelity.Default
				
		for _, v in game:GetDescendants() do
			if v:IsA("TriangleMeshPart") and not v:IsDescendantOf(C) then
				v.CollisionFidelity = D
			end
		end
		print("Done")
				
		If you can't move the Camera, run this script in the Studio Command Bar:
			
		workspace.CurrentCamera.CameraType = Enum.CameraType.Fixed
		
		Or Destroy the Camera.

		This file was generated with the following settings:
		{"SaveBytecode":false,"Callback":false,"ShowStatus":true,"IgnoreDefaultPlayerScripts":false,"NilInstancesFixes":{"BaseWrap":null,"Animator":null,"Attachment":null,"PackageLink":null,"AdPortal":null},"IgnoreList":["CoreGui","CorePackages"],"__DEBUG_MODE":false,"KillAllScripts":false,"DecompileJobless":false,"IgnoreNotArchivable":true,"RemovePlayerCharacters":false,"Object":false,"DecompileIgnore":["TextChatService"],"IgnoreSpecialProperties":false,"TreatUnionsAsParts":false,"IsModel":false,"NilInstances":false,"ExtraInstances":[],"noscripts":false,"ReadMe":true,"OptionsAliases":{"SavePlayers":"IsolatePlayers","IgnoreArchivable":"IgnoreNotArchivable","DecompileTimeout":"timeout","SaveNonCreatable":"SaveNotCreatable","InstancesBlacklist":"IgnoreList","IsolatePlayerGui":"IsolateLocalPlayer","FileName":"FilePath","IgnoreDefaultProps":"IgnoreDefaultProperties"},"scriptcache":true,"SharedStringOverwrite":false,"AlternativeWritefile":true,"mode":"optimized","SaveCacheInterval":56320,"IgnoreSharedStrings":true,"IsolatePlayers":false,"NotCreatableFixes":["","AdvancedDragger","AnimationTrack","Dragger","Player","PlayerGui","PlayerMouse","PlayerMouse","PlayerScripts","ScreenshotHud","StudioData","TextChatMessage","TextSource","TouchTransmitter","Translator"],"timeout":10,"IgnoreDefaultProperties":true,"Anonymous":false,"IsolateStarterPlayer":false,"IsolateLocalPlayerCharacter":true,"IgnorePropertiesOfNotScriptsOnScriptsMode":false,"AvoidFileOverwrite":true,"SaveNotCreatable":false,"IsolateLocalPlayer":true,"FilePath":false,"AntiIdle":true,"ShutdownWhenDone":false,"SafeMode":false,"IgnoreProperties":[]}

		Elapsed time: 52.724047300000166 Date (UTC): 7 April 2026 06:57:49 PlaceId: 77393318863643 PlaceVersion: 2004 Client Version: 0.715.0.7151110 Platform: Windows Executor: Velocity 0.9.1
]]