-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:56
-- Luau version 6, Types version 3
-- Time taken: 0.002800 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "LightSwitch";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
function any_new_result1.createProximity(arg1) -- Line 31
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: var8_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var7_upvw (read and write)
	]]
	if not arg1.Instance.PrimaryPart then
	else
		local ProximityPrompt_upvr = Instance.new("ProximityPrompt", arg1.Instance.PrimaryPart)
		ProximityPrompt_upvr.RequiresLineOfSight = false
		ProximityPrompt_upvr.ActionText = "Pull!"
		ProximityPrompt_upvr.ObjectText = "Light Switch"
		ProximityPrompt_upvr.Name = "_leverProximity"
		arg1:toggleProximityIfBuilt()
		ProximityPrompt_upvr.Triggered:Connect(function() -- Line 46
			--[[ Upvalues[7]:
				[1]: var4_upvw (copied, read and write)
				[2]: ProximityPrompt_upvr (readonly)
				[3]: var6_upvw (copied, read and write)
				[4]: var8_upvw (copied, read and write)
				[5]: arg1 (readonly)
				[6]: var5_upvw (copied, read and write)
				[7]: var7_upvw (copied, read and write)
			]]
			ProximityPrompt_upvr:Destroy()
			var6_upvw:play("Lever", {
				timePosition = 0.6;
			})
			var8_upvw.activateLightSwitch:Fire(arg1.Instance:GetAttribute("lightSwitchId"))
			arg1:pullLeverAnimation()
			local var13_upvr = #var4_upvw:getData().lightSwitches + 1
			task.delay(0.35, function() -- Line 60
				--[[ Upvalues[2]:
					[1]: var5_upvw (copied, read and write)
					[2]: var13_upvr (readonly)
				]]
				var5_upvw:createNotification("Custom", `<font color="#ffffff"><stroke color="#000000" thickness="3">You activated a light switch! ({var13_upvr}/6)</stroke></font>`, 3)
			end)
			task.delay(2.9, function() -- Line 64
				--[[ Upvalues[2]:
					[1]: var4_upvw (copied, read and write)
					[2]: var7_upvw (copied, read and write)
				]]
				if #var4_upvw:getData().lightSwitches == 6 then
					var7_upvw:unlockedAnimation()
				end
			end)
		end)
	end
end
function any_new_result1.toggleProximityIfBuilt(arg1) -- Line 73
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	local _leverProximity = arg1.Instance.PrimaryPart:FindFirstChild("_leverProximity")
	if not _leverProximity then
	else
		_leverProximity.Enabled = var4_upvw:getData().buildings[arg1.Instance:GetAttribute("buildingId")]
	end
end
local TweenService_upvr = game:GetService("TweenService")
function any_new_result1.pullLeverAnimation(arg1) -- Line 84
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local CFrameValue_upvr = Instance.new("CFrameValue")
	TweenService_upvr:Create(CFrameValue_upvr, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
		Value = CFrame.Angles(-20, 0, 0);
	}):Play()
	local any_GetPivot_result1_upvr = arg1.Instance.Lever:GetPivot()
	CFrameValue_upvr.Changed:Connect(function() -- Line 90
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: any_GetPivot_result1_upvr (readonly)
			[3]: CFrameValue_upvr (readonly)
		]]
		arg1.Instance.Lever:PivotTo(any_GetPivot_result1_upvr * CFrameValue_upvr.Value)
	end)
	task.delay(0.35, function() -- Line 94
		--[[ Upvalues[1]:
			[1]: CFrameValue_upvr (readonly)
		]]
		CFrameValue_upvr:Destroy()
	end)
end
function any_new_result1.onSpawned(arg1) -- Line 99
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	if not table.find(var4_upvw:getData().lightSwitches, arg1.Instance:GetAttribute("lightSwitchId")) then
		arg1:createProximity()
	else
		arg1:pullLeverAnimation()
	end
end
function any_new_result1.childAdded(arg1) -- Line 109
	arg1.Instance.ChildAdded:Connect(function(arg1_2) -- Line 110
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_2 ~= arg1.Instance.PrimaryPart then
		else
			if arg1_2:FindFirstChild("_leverProximity") then return end
			arg1:onSpawned()
		end
	end)
end
function any_new_result1.onSet(arg1) -- Line 123
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"buildings"}, function() -- Line 124
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:toggleProximityIfBuilt()
	end)
end
function any_new_result1.Start(arg1) -- Line 129
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	task.spawn(function() -- Line 130
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		arg1:childAdded()
		arg1:onSpawned()
		arg1:onSet()
	end)
end
local var26_upvw
function any_new_result1.Construct(arg1) -- Line 138
	--[[ Upvalues[7]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var26_upvw (read and write)
		[7]: var7_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("RewardService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var26_upvw = Knit_upvr.GetController("FFlagController")
	var7_upvw = Knit_upvr.GetController("CityController")
end
return any_new_result1