-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:57
-- Luau version 6, Types version 3
-- Time taken: 0.001651 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "HighlightInZone";
})
local var4_upvw
function any_new_result1.create(arg1) -- Line 32
	if arg1._highlight then
	else
		local Highlight = Instance.new("Highlight", arg1.Instance)
		Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
		Highlight.FillTransparency = 1
		Highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
		Highlight.OutlineTransparency = 0.7
		Highlight.Name = "_spawnedHighlight"
		arg1._highlight = Highlight
	end
end
function any_new_result1.remove(arg1) -- Line 48
	if not arg1._highlight then
	else
		arg1._highlight:Destroy()
		arg1._highlight = nil
	end
end
function any_new_result1.getMapIds(arg1) -- Line 57
	local string_split_result1 = string.split(arg1._mapIds, ',')
	for i, v in ipairs(string_split_result1) do
		string_split_result1[i] = tonumber(v)
	end
	return string_split_result1
end
function any_new_result1.Start(arg1) -- Line 67
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1._mapIds = arg1.Instance:GetAttribute("highlightMapIds")
	arg1._connection = var4_upvw.onMapChange:Connect(function(arg1_2) -- Line 69
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if table.find(arg1:getMapIds(), arg1_2) then
			arg1:create()
		else
			arg1:remove()
		end
	end)
end
function any_new_result1.Stop(arg1) -- Line 80
	arg1._connection:Disconnect()
end
local var15_upvw
local var16_upvw
local var17_upvw
local var18_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var20_upvw
function any_new_result1.Construct(arg1) -- Line 84
	--[[ Upvalues[8]:
		[1]: var15_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var16_upvw (read and write)
		[4]: var17_upvw (read and write)
		[5]: var4_upvw (read and write)
		[6]: var18_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var20_upvw (read and write)
	]]
	var15_upvw = Knit_upvr.GetController("DataController")
	var16_upvw = Knit_upvr.GetController("UIController")
	var17_upvw = Knit_upvr.GetController("SoundController")
	var4_upvw = Knit_upvr.GetController("MapController")
	var18_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var20_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Eggs)
end
return any_new_result1