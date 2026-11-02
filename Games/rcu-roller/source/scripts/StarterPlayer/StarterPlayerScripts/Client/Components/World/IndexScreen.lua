-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:45
-- Luau version 6, Types version 3
-- Time taken: 0.001806 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "IndexScreen";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
function any_new_result1.getNumberPetsLabel(arg1) -- Line 36
	local NumberPets = arg1.Instance:FindFirstChild("NumberPets")
	if not NumberPets then return end
	return NumberPets:WaitForChild("SurfaceGui"):WaitForChild("Amount")
end
function any_new_result1.getPetImageLabel(arg1) -- Line 48
	local SurfaceGui = arg1.Instance:FindFirstChild("SurfaceGui")
	if not SurfaceGui then return end
	return SurfaceGui:WaitForChild("ImageLabel")
end
local var12_upvw = 1
function any_new_result1.run(arg1) -- Line 59
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: var6_upvw (read and write)
		[4]: var7_upvw (read and write)
		[5]: var8_upvw (read and write)
		[6]: var9_upvw (read and write)
		[7]: var12_upvw (read and write)
	]]
	task.spawn(function() -- Line 60
		--[[ Upvalues[8]:
			[1]: arg1 (readonly)
			[2]: var4_upvw (copied, read and write)
			[3]: var5_upvw (copied, read and write)
			[4]: var6_upvw (copied, read and write)
			[5]: var7_upvw (copied, read and write)
			[6]: var8_upvw (copied, read and write)
			[7]: var9_upvw (copied, read and write)
			[8]: var12_upvw (copied, read and write)
		]]
		while true do
			local any_getNumberPetsLabel_result1 = arg1:getNumberPetsLabel()
			local any_getPetImageLabel_result1 = arg1:getPetImageLabel()
			if not any_getNumberPetsLabel_result1 or not any_getPetImageLabel_result1 then
				task.wait(1)
			else
				local data = var4_upvw.data
				if not data then
					task.wait(1)
				else
					any_getNumberPetsLabel_result1.Text = `{var5_upvw.floatingPoint(var5_upvw.suffixes(var6_upvw.indexUtils.countIndex(data, true)) / var5_upvw.suffixes(var5_upvw.getAmountInTable(var7_upvw) * #var8_upvw) * 100, 1)}%`
					any_getPetImageLabel_result1.Image = var9_upvw[var12_upvw]
					var12_upvw += 1
					if #var9_upvw <= var12_upvw then
						var12_upvw = 1
					end
					task.wait(10)
				end
			end
		end
	end)
end
function any_new_result1.Start(arg1) -- Line 95
	arg1:run()
end
local var17_upvw
local var18_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 99
	--[[ Upvalues[10]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var17_upvw (read and write)
		[4]: var18_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: ReplicatedStorage_upvr (readonly)
		[7]: var6_upvw (read and write)
		[8]: var7_upvw (read and write)
		[9]: var8_upvw (read and write)
		[10]: var9_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var17_upvw = Knit_upvr.GetController("UIController")
	var18_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var6_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var7_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Pets)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Tiers)
	var9_upvw = require(script.Images)
end
return any_new_result1