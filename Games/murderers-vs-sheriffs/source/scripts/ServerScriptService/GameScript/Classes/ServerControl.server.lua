_G.ServerSettings = {
	DisguisesMode = false;
	AssassinMode = false;
	ClassicMode = false;
	LobbyMode = false;
	DuelMode = false;
	Timer = 180;
};
_G.CustomMurderer = nil
_G.CustomSheriff = nil
_G.Gamemode = "Classic";

local GameModes = require(game.ReplicatedStorage.Database.Sync).GameModes
local TeleportService    = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

local function SafeTeleportAsync(...)
	if RunService:IsStudio() then
		warn("[ServerControl] TeleportAsync blocked during Studio playtest.")
		return nil
	end
	return TeleportService:TeleportAsync(...)
end

local function SafeTeleportToPlaceInstance(...)
	if RunService:IsStudio() then
		warn("[ServerControl] TeleportToPlaceInstance blocked during Studio playtest.")
		return nil
	end
	return TeleportService:TeleportToPlaceInstance(...)
end
game.ReplicatedStorage.Remotes.Extras.RequestTeleport.OnServerInvoke = function(player : Player, modeName : string)
	local modeData = GameModes[modeName]
	if not modeData then
		warn(`[GameMode: Teleport] {player.Name} request unknown gamemode {modeName}`)
		return false, "invalid_mode"
	end
	if modeData.LimitedTime and (not modeData:IsOpen()) then
		return false, "mode_closed"
	end
	local placeId = modeData.PlaceID
	local options = Instance.new("TeleportOptions")
	options:SetTeleportData({ requestedMode = modeName })
	local ok, err = pcall(function()
		SafeTeleportAsync(placeId, { player }, options)
	end)
	if not ok then
		warn(`[GameMode: Teleport] Error teleport {player.Name}: {err}`)
		return false, tostring(err)
	end
	return true
end
function game.ReplicatedStorage.Remotes.Extras.CanChangeServerSettings.OnServerInvoke(Player)
	return Player.UserId == game.VIPServerOwnerId;
end
game.ReplicatedStorage.Remotes.Extras.ChangeServerSetting.OnServerEvent:Connect(function(Player, SettingName, SettingValue)
	if Player.UserId ~= game.VIPServerOwnerId then
		warn(Player.Name .. " attempted to change server settings but is not authorized.")
		Player:Kick("Nice try, but no. This isn't your server, chief. Did you really think that would work? Try again in your dreams XD")
		return
	end
	if SettingName == "RoundTimerOverride" then
		local timerPresets = {SixMin = 360, ThirtySec = 30, ThreeMin  = 180, TwelveMin = 720}
		local newTime = timerPresets[SettingValue]
		if newTime then
			_G.ServerSettings.Timer = newTime
		end
	else
		for _, mode in ipairs({"DisguisesMode", "AssassinMode", "ClassicMode", "LobbyMode", "DuelMode"}) do
			_G.ServerSettings[mode] = false
		end
		_G.ServerSettings[SettingName] = SettingValue
	end
end)



local TeleportService = game:GetService("TeleportService");

game.ReplicatedStorage.Remotes.Extras.Follow.OnServerEvent:connect(function(Player)
	local success,errorMsg,placeId,instanceId = TeleportService:GetPlayerPlaceInstanceAsync(Player.FollowUserId)
    if success then
        SafeTeleportToPlaceInstance(placeId, instanceId, Player,nil,{Joined=true});
    else
        print("Teleport error:", errorMsg)
    end
end)

function game.ReplicatedStorage.Remotes.Extras.IsVIPServer.OnServerInvoke()
	return not(game.VIPServerId == "");
end


local Searches = {};

function unescape(str)
	str = string.gsub( str, '&lt;', '<' )
	str = string.gsub( str, '&gt;', '>' )
	str = string.gsub( str, '&quot;', '"' )
	str = string.gsub( str, '&apos;', "'" )
	
	str = string.gsub( str, '&#(%d+);',function(n)
		if tonumber(n) and tonumber(n)<126 then
			return string.char( tonumber(n) )
		else
			return "";
		end;
	end)
	
	str = string.gsub( str, '&#x(%d+);', function(n)
		if tonumber(n) and tonumber(n)<126 then
			return string.char( tonumber(n) )
		else
			return "";
		end;
	end)
	
	str = string.gsub( str, '&amp;', '&' ) -- Be sure to do this after all others
	return str
end


local Http = game:GetService("HttpService");

--//Audio Fix//--
game.ReplicatedStorage.Remotes.Extras.SearchSongs.OnServerInvoke = function(Player, String)
	return require(game.ReplicatedStorage.Modules.AudioSearcher).searchAudio(String)
end



local LastMap = os.time();
local ShuttingDown = false;

game.Workspace.ChildAdded:connect(function(Map)
	if game.ServerStorage.Database.Maps:FindFirstChild(Map.Name) and (not game.Players:GetPlayerFromCharacter(Map)) then
		LastMap = os.time();
	end
end)

if game.VIPServerId == "" then
	game:GetService("RunService").Heartbeat:connect(function()
		if os.time()-LastMap >= (60*5) and not ShuttingDown then
			ShuttingDown = true;
			error("No Map Detected in 1 Minute");
		end
	end)
end;



                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               