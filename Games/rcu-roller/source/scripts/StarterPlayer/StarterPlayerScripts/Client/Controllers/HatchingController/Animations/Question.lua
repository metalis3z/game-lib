-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:49
-- Luau version 6, Types version 3
-- Time taken: 0.001844 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local CurrentCamera_upvr = workspace.CurrentCamera
local function _(arg1, arg2) -- Line 20, Named "tweenFOV"
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local tbl = {}
	tbl.FieldOfView = arg1
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(arg2, Enum.EasingStyle.Linear), tbl):Play()
end
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
local Debris_upvr = game:GetService("Debris")
local Assets_upvr = ReplicatedStorage.Assets
local RunService_upvr = game:GetService("RunService")
local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
return function(arg1) -- Line 26
	--[[ Upvalues[7]:
		[1]: Functions_upvr (readonly)
		[2]: Debris_upvr (readonly)
		[3]: Assets_upvr (readonly)
		[4]: TweenService_upvr (readonly)
		[5]: RunService_upvr (readonly)
		[6]: CurrentCamera_upvr (readonly)
		[7]: Knit_upvr (readonly)
	]]
	for _, v in arg1.eggData.eggs do
		Functions_upvr.tweens.scale(v.instance, {
			time = 0.3;
			initialValue = v.instance:GetScale();
			finalValue = 0.01;
		})
		Debris_upvr:AddItem(v.instance, 0.3)
	end
	local clone_upvr = Assets_upvr.Other.Question:Clone()
	clone_upvr.Parent = workspace
	local NumberValue_upvr = Instance.new("NumberValue")
	TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Value = 4776;
	}):Play()
	Functions_upvr.tweens.scale(clone_upvr, {
		time = 1;
		initialValue = 0.05;
		finalValue = 1;
	})
	task.delay(4.5, function() -- Line 49
		--[[ Upvalues[2]:
			[1]: Functions_upvr (copied, readonly)
			[2]: clone_upvr (readonly)
		]]
		Functions_upvr.tweens.scale(clone_upvr, {
			time = 0.5;
			initialValue = 1;
			finalValue = 0.01;
		})
	end)
	RunService_upvr:BindToRenderStep("questionPosition", Enum.RenderPriority.Camera.Value + 1, function() -- Line 57
		--[[ Upvalues[3]:
			[1]: clone_upvr (readonly)
			[2]: CurrentCamera_upvr (copied, readonly)
			[3]: NumberValue_upvr (readonly)
		]]
		clone_upvr:PivotTo(CurrentCamera_upvr.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, math.rad(NumberValue_upvr.Value), 0))
	end)
	task.delay(0.915, function() -- Line 61
		--[[ Upvalues[1]:
			[1]: Knit_upvr (copied, readonly)
		]]
		Knit_upvr.GetController("SoundController"):play("Aura Riser", {
			volume = 1;
		})
	end)
	task.delay(5, function() -- Line 67
		--[[ Upvalues[3]:
			[1]: RunService_upvr (copied, readonly)
			[2]: clone_upvr (readonly)
			[3]: NumberValue_upvr (readonly)
		]]
		RunService_upvr:UnbindFromRenderStep("questionPosition")
		clone_upvr:Destroy()
		NumberValue_upvr:Destroy()
	end)
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		FieldOfView = 120;
	}):Play()
	task.wait(5)
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(0.05), {
		FieldOfView = 70;
	}):Play()
end