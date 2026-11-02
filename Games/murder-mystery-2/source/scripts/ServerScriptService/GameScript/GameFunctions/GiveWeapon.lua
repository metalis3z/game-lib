local Module = {}

local Gets = script.Parent.Parent.Get

function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end

local Data = require(script.Parent.Parent.DataModule);

Module.Gun = function(Player)
	local Sync = Get("Sync");
	local ItemsDB = Sync.Data["Item"];
	local GunID = ItemsDB[Data.Get(Player,"Weapons").Equipped.Gun];
	
	local NewItem = game.ServerStorage.Default.Gun:Clone();
	pcall(function() NewItem = game.InsertService:LoadAsset(GunID["ItemID"]):GetChildren()[1]; end);
	
	for i,Script in pairs(game.ServerStorage.GunScripts:GetChildren()) do
		local NewScript = Script:Clone()
		if NewScript:IsA("LocalScript") or NewScript:IsA("Script") then
			NewScript.Disabled = false
		end;
		NewScript.Parent = NewItem;
	end
	NewItem.KnifeServer.GameMode.Value = Get("GameMode").Name;
	NewItem.KnifeLocal.GameMode.Value = Get("GameMode").Name;
	NewItem.CanBeDropped = false;
	NewItem.Parent = Player.Backpack;
	return NewItem;
end

Module.Knife = function(Player)
	local Sync = Get("Sync");
	local ItemsDB = Sync.Data["Item"];
	local KnifeID = ItemsDB[Data.Get(Player,"Weapons").Equipped.Knife];
	
	
	local NewItem = game.ServerStorage.Default.Knife:Clone();
	pcall(function() NewItem = game.InsertService:LoadAsset(KnifeID["ItemID"]):GetChildren()[1]; NewItem.TextureId = KnifeID.Image; end);
	
	for i,Script in pairs(game.ServerStorage.KnifeScripts:GetChildren()) do
		local NewScript = Script:Clone()
		if NewScript:IsA("Script") or NewScript:IsA("LocalScript") then
			NewScript.Disabled = false
		end;
		NewScript.Parent = NewItem;
	end
	NewItem.KnifeServer.GameMode.Value = Get("GameMode").Name;
	NewItem.KnifeLocal.GameMode.Value = Get("GameMode").Name;
	NewItem.CanBeDropped = false;
	NewItem.Parent = Player.Backpack;
	return NewItem;
end


return Module;
