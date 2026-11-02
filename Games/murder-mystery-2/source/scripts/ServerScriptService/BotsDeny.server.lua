local allowedAnyDisplay = {
	[3582027804] = true; -- ChampulseV0
	[488129495] = true; -- LegoBrickMissing
	[1624517569] = true; -- TheNamesShadows
	[2743744514] = true; -- MyGameTester45
	[702952403] = true; -- RhavizinNxtrixz
	[4664957679] = true; --Rhavi's Alt
}
local bannedDisplayNames = { -- keep lower cases
	["champulsev"] = true;
	["champulsev0"] = true;
	["legomm2dev"] = true;
	["lego"] = true;
	["legobrickdev"] = true;
	["legobrickmissing"] = true;
	["legobrickmissingdev"] = true;
	["legobrickmissingdev1"] = true;
	["legobr1ckm1ssingdev1"] = true;
	["legobr1ckmissingdev1"] = true;
	["legobr1ckm1ssingdev2"] = true;
	["legobrickmissingdeveloper"] = true;
	["legobrickmissingowner"] = true;
	["legobrickmissingowner1"] = true;
	["legogameowner"] = true;
	["legobrickgameowner"] = true;
	["Skaynioo"] = true;
	["RhavizinNxtrixz"] = true;

}

local function ReturnKickMessage(DisplayName)
	return "Your Current Display Username Has been Blacklisted From Jay's Murder Mystery 2 . Please Change it and feel free to Rejoin!"
end

game.Players.PlayerAdded:Connect(function(player)
	local display = player.DisplayName
	local lowerDisplay = display:lower()
	
	if bannedDisplayNames[lowerDisplay] then
		if not allowedAnyDisplay[player.userId] then
			player:Kick(ReturnKickMessage(display))
		end
	end
end)