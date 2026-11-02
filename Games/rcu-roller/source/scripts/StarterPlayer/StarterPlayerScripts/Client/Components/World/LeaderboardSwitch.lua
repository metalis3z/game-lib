-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:50
-- Luau version 6, Types version 3
-- Time taken: 0.001424 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "LeaderboardSwitch";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw = 1
function any_new_result1.switch(arg1) -- Line 32
	--[[ Upvalues[3]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: var7_upvw (read and write)
	]]
	local ClickDetector = arg1.Instance:WaitForChild("ClickDetector", math.huge)
	ClickDetector.CursorIcon = "rbxassetid://15950785490"
	ClickDetector.MouseClick:Connect(function() -- Line 36
		--[[ Upvalues[4]:
			[1]: var5_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var6_upvw (copied, read and write)
			[4]: var7_upvw (copied, read and write)
		]]
		local var12 = var6_upvw[var5_upvw.toCamel(arg1.Instance.Parent.Name)]
		var7_upvw += 1
		if #var12.values < var7_upvw then
			var7_upvw = 1
		end
		local SurfaceGui = arg1.Instance.Parent.Show.Show.SurfaceGui
		arg1.Instance.Parent.Title.SurfaceGui.Label.Text = var12.values[var7_upvw].title
		for _, v in SurfaceGui:GetChildren() do
			v.Visible = false
		end
		SurfaceGui[var7_upvw].Visible = true
	end)
end
function any_new_result1.start(arg1) -- Line 66
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	task.spawn(function() -- Line 67
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		repeat
			task.wait()
		until var4_upvw.data
		arg1:switch()
	end)
end
function any_new_result1.Start(arg1) -- Line 73
	arg1:start()
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 77
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: ReplicatedStorage_upvr (readonly)
		[5]: var6_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var6_upvw = require(ReplicatedStorage_upvr.Shared.List.Leaderboards)
end
return any_new_result1