-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:53
-- Luau version 6, Types version 3
-- Time taken: 0.001208 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Egg";
})
local var4_upvw
local var5_upvw
function any_new_result1.price(arg1) -- Line 32
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	local Price = arg1.Instance:FindFirstChild("Price")
	if not Price then
	else
		Price:FindFirstChild("SurfaceGui").Label.Text = var4_upvw.suffixes(var5_upvw[arg1.Instance.Name].cost)
	end
end
function any_new_result1.childAdded(arg1) -- Line 42
	arg1.Instance.ChildAdded:Connect(function() -- Line 43
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:price()
	end)
end
function any_new_result1.Start(arg1) -- Line 48
	arg1:childAdded()
	arg1:price()
end
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 53
	--[[ Upvalues[8]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var9_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: var11_upvw (read and write)
		[6]: var4_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var5_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetController("DataController")
	var9_upvw = Knit_upvr.GetController("UIController")
	var10_upvw = Knit_upvr.GetController("SoundController")
	var11_upvw = Knit_upvr.GetController("FFlagController")
	var4_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var5_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Eggs)
end
return any_new_result1