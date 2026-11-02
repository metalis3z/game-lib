-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_Shop_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Shop");
local v2 = require(game.ReplicatedStorage.Modules.BoxModule);
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_MysteryBoxService_0 = require(l_ReplicatedStorage_0:WaitForChild("ClientServices"):WaitForChild("MysteryBoxService"));
game.ReplicatedStorage.Remotes.Shop.BoxController.Event:connect(function(v5) --[[ Line: 9 ]]
	-- upvalues: l_MysteryBoxService_0 (copy), l_Shop_0 (copy)
	l_MysteryBoxService_0:PlayOpeningAnimation(v5);
	for _, v7 in v5 do
		l_Shop_0.NewItemReceived:Fire(v7.RewardedItemId, "Weapons");
		game.ReplicatedStorage.Remotes.Inventory.UpdateSalvageClient:Fire();
		game.ReplicatedStorage.Remotes.Shop.CrateComplete:FireServer(v7.RewardedItemId);
	end;
end);
game.ReplicatedStorage.Remotes.Shop.EggController.Event:connect(function(v8, v9) --[[ Line: 19 ]]
	-- upvalues: v2 (copy), l_Shop_0 (copy)
	v2.HatchEgg(v8, v9);
	l_Shop_0.NewItemReceived:Fire(v9, "Pets");
	game.ReplicatedStorage.Remotes.Shop.CrateComplete:FireServer(v9);
end);