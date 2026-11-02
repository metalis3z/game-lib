
local WeldHat = require(script.WeldHat);
local PassFaces = require(game.ServerStorage.Faces)
local Data = require(game.ServerScriptService.GameScript.DataModule);

local Module = function(Player,Color,RoleName,Map,CodeName)
	
	local OwnsAsset = false;
	if not (string.sub(Player.Name,1,6) == "Guest " or string.sub(Player.Name,1,6) == "Player" ) then
		OwnsAsset = (game:GetService("MarketplaceService"):PlayerOwnsAsset(Player,143544775) or game:GetService("MarketplaceService"):PlayerOwnsAsset(Player,237848679))
	end;
	game.ReplicatedStorage.RoleSelect:FireClient(Player,RoleName,Color,CodeName,_G.ServerSettings.LockFirstPerson,"ElfInvasion");
	
	if _G.ServerSettings.Disguises == true then end;
end

return Module;
