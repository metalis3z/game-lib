-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:12
-- Luau version 6, Types version 3
-- Time taken: 0.005788 seconds

-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
local InsertService_upvr = game:GetService("InsertService")
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local Weapons = game:GetService("ReplicatedStorage").Weapons
local tbl = {}
for _, v in pairs(Weapons:GetChildren()) do
	local var43
	for _, v_2 in pairs(tbl) do
		if tostring(v_2) == v.Name then
			var43 = true
		end
	end
	if not var43 then
		print("id not found: ", v.Name)
	end
end
for _, v_3_upvr in pairs(tbl) do
	var43 = spawn
	var43(function() -- Line 107
		--[[ Upvalues[3]:
			[1]: v_3_upvr (readonly)
			[2]: InsertService_upvr (readonly)
			[3]: MarketplaceService_upvr (readonly)
		]]
		print("id: ", v_3_upvr)
		local any_LoadAsset_result1 = InsertService_upvr:LoadAsset(v_3_upvr)
		local var49_upvw
		repeat
			local pcall_result1, _ = pcall(function() -- Line 113
				--[[ Upvalues[3]:
					[1]: var49_upvw (read and write)
					[2]: MarketplaceService_upvr (copied, readonly)
					[3]: v_3_upvr (copied, readonly)
				]]
				var49_upvw = MarketplaceService_upvr:GetProductInfo(v_3_upvr)
			end)
			local var53 = pcall_result1
			if not var53 then
				print("fail")
				wait(1)
			end
		until var53
		print("id: success")
		local PriceInRobux = var49_upvw.PriceInRobux
		local IntValue = Instance.new("IntValue")
		IntValue.Name = "Price"
		IntValue.Value = PriceInRobux
		if PriceInRobux then
		end
		local _1 = any_LoadAsset_result1:GetChildren()[1]
		IntValue.Parent = _1
		_1.Name = v_3_upvr
		_1.ToolTip = var49_upvw.Name
		_1.Parent = workspace
		any_LoadAsset_result1:destroy()
	end)
end
print("success: ", #Weapons:GetChildren())
local children = game.ReplicatedStorage.WEAPONS_BACKUP:GetChildren()
table.sort(children, function(arg1, arg2) -- Line 145
	local var59
	if tonumber(arg1.Price.Value) >= tonumber(arg2.Price.Value) then
		var59 = false
	else
		var59 = true
	end
	return var59
end)
for _, v_4 in pairs(children) do
	v_4.Parent = game.ReplicatedStorage.Weapons
	wait()
	local _
end