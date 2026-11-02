-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved soon!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-12-08 12:49:49
-- Luau version 6, Types version 3
-- Time taken: 0.000818 seconds

local TweenService = game:GetService("TweenService")
local Speed = script.Parent:GetAttribute("Speed")
local any_LoadAnimation_result1 = script.Parent.Yuuki.Humanoid:LoadAnimation(script.Animation)
any_LoadAnimation_result1:Play(0, nil, Speed)
if script.Parent:GetAttribute("Jackpot") == false then
	any_LoadAnimation_result1.TimePosition = 7
	task.wait(3 / Speed)
	TweenService:Create(script.Parent.Door1, TweenInfo.new(1), {
		Orientation = script.Parent.Door1.Orientation + Vector3.new(0, -90, 0);
	}):Play()
	TweenService:Create(script.Parent.Door2, TweenInfo.new(1), {
		Orientation = script.Parent.Door1.Orientation + Vector3.new(0, 90, 0);
	}):Play()
	task.wait(1 / Speed)
	local Highlight = Instance.new("Highlight")
	Highlight.FillColor = Color3.new(0, 0, 0)
	Highlight.FillTransparency = 1
	Highlight.OutlineTransparency = 1
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	Highlight.Parent = script.Parent
	TweenService:Create(Highlight, TweenInfo.new(1 / Speed), {
		FillTransparency = 0.5;
	}):Play()
end