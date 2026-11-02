--[[ << PERMISSION TYPES >>																																							
<PermissionNumber>		<PermissionName>																																																	]]local Owner local HeadAdmin local Admin local Mod local VIP--[[
auto					Owner			-- Type ;cmds to view all Owner commands
4						HeadAdmin		-- Type ;cmds to view all HeadAdmin commands
3						Admin			-- Type ;cmds to view all Admin commands
2						Mod				-- Type ;cmds to view all Mod commands
1						VIP				-- Can only use commands on theirself. Type ;cmds to view all VIP commands																		
0						Everyone		-- Setting a command to this permission type will allow anyone to use it																															]]


--[[ << INDIVIDUAL PERMISSIONS >>
Format:  "PlayerName", or UserId,																																																		]]return{Individual_Permissions = {
HeadAdmins	= {"PlayerName1",156,}																																																;
Admins		= {}																																																							;
Mods		= {}																																																							;
VIPs		= {}																																																							;			};


--[[ << GROUP PERMISSIONS >>																																						
Format:  [GroupId] = { [GroupRoleNumber] = "PermissionName", OR PermissionNumber, };																																							]]
Group_Permissions={
	[0] = { [254]="HeadAdmin", [1]="VIP", };
}																																																											;


--[[ << ASSET PERMISSIONS >> (e.g. Gamepasses, Shirts, Models etc)
Format:  [AssetId] = "PermissionName" OR PermissionNumber ;																																													]]
Asset_Permissions={
	[0] = "Mod";
}																																																											;


--[[ << BANLAND >>																																																							]]
Banned = {"PlayerName1","PlayerName2",};


-- << SETTINGS >>
Settings={
	-- <Prefix>
	Prefix			=";" ;			-- The character used to begin each command
	
	-- <Owner chat colour>
	OwnerChatColour = "y" ;			--w/r/g/b/p/y    OR    white/red/green/blue/purple/yellow

	-- <Donor Perks>   **Please keep enabled to help support the development of HD Admin Commands**
	DonorItem 		= true ;
	DonorItemId 	= 10472779 ;
	DonorCommands 	= true ;
	
	-- <Other>
	CmdBar			= true ;		-- Enabled/disales the cmdbar - press @ to open the cmdbar
	HDIcon			= true ;		-- The HD Icon in the corner of screen (helps support the development HD Admin Commands)
	AutoPrompt		= true ;		-- This prompts all players to take a free copy of the model. Set to 'false' to disable.
	FreeAdmin		= "HeadAdmin" ;		-- Allows everyone in server to have the chosen admin. e.g.' FreeAdmin = "VIP" '. Set to False if not. You can not set to 'Owner'.
	NoticeSound		= 261082034 ;	-- Notification sound ID
	NoticeSoundVol	= 0.5 ;			-- How loud the notification sound is. Must be between 0 and 1.
	ErrorSound		= 138090596 ;	-- Error sound ID
	ErrorSoundVol	= 0.5 ;			-- How loud the error sound is. Must be between 0 and 1.
}																																																											;


--[[ << MODIFY COMMANDS >>
This allows you to change the permission type required to use a command
Format:  ["CommandName"] = "PermissionName" ;																																																]]
ModifiedCommands={
	["fly"] = "Mod" ; -- This changes the command so that Mods (or above) can use it
}																																																											;Version = 1.3;--[[Don't edit this, otherwise the commands may break]]}