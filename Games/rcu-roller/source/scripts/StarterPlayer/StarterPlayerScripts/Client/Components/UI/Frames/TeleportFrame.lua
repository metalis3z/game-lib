-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:45
-- Luau version 6, Types version 3
-- Time taken: 0.002506 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "TeleportFrame";
})
local var4_upvw
local var5_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var7_upvw
local var8_upvw
local var9_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Holder_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("TeleportFrame"):WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder")
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.setupFrames(arg1) -- Line 39
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: Assets_upvr (readonly)
		[4]: var5_upvw (read and write)
		[5]: Holder_upvr (readonly)
		[6]: var7_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: LocalPlayer_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	for i, v_upvr in var9_upvw do
		if table.find(var4_upvw.data.maps, i) then
			local clone = Assets_upvr.UI.Teleport:Clone()
			for _, v_2 in v_upvr.machines do
				local clone_2 = clone.Tools.Template:Clone()
				clone_2.ImageLabel.Image = v_2.icon
				clone_2.Visible = true
				clone_2.Parent = clone.Tools
				var5_upvw:createTooltipOnHover(clone_2, v_2.name)
			end
			local var31 = clone
			var31.Title.Text = v_upvr.name
			var31.WorldIcon.Image = v_upvr.icon
			var31.BG.Image = v_upvr.background
			var31.Visible = true
			var31.Parent = Holder_upvr
			var7_upvw.new(var31.Teleport):buttonUp(function() -- Line 65
				--[[ Upvalues[4]:
					[1]: var8_upvw (copied, read and write)
					[2]: LocalPlayer_upvr (copied, readonly)
					[3]: var5_upvw (copied, read and write)
					[4]: v_upvr (readonly)
				]]
				local any_getHRP_result1 = var8_upvw.getHRP(LocalPlayer_upvr)
				if not any_getHRP_result1 then
				else
					var5_upvw:closeAllFrames()
					var5_upvw:transitionIn()
					LocalPlayer_upvr:RequestStreamAroundAsync(v_upvr.cframe.p)
					task.wait(0.5)
					any_getHRP_result1:PivotTo(v_upvr.cframe)
					task.wait(0.5)
					var5_upvw:transitionOut()
				end
			end)
		end
	end
end
function any_new_result1.removeFrames(arg1) -- Line 85
	--[[ Upvalues[1]:
		[1]: Holder_upvr (readonly)
	]]
	for _, v_3 in Holder_upvr:GetChildren() do
		if v_3:IsA("Frame") then
			v_3:Destroy()
		end
	end
end
function any_new_result1.opened(arg1) -- Line 93
	arg1:setupFrames()
end
function any_new_result1.closed(arg1) -- Line 97
	arg1:removeFrames()
end
function any_new_result1.Start(arg1) -- Line 101
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:opened()
	var5_upvw:listenToOpen("TeleportFrame"):Connect(function() -- Line 103
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClose("TeleportFrame"):Connect(function() -- Line 106
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
end
local var41_upvw
function any_new_result1.Construct(arg1) -- Line 111
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var41_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var9_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var41_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = require(Knit_upvr.Modules.Button)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.List.Maps)
end
return any_new_result1