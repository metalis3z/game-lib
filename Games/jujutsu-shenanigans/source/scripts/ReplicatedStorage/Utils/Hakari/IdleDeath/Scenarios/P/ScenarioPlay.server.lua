-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved soon!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-12-08 12:49:48
-- Luau version 6, Types version 3
-- Time taken: 0.000626 seconds

local Speed = script.Parent:GetAttribute("Speed")
local any_LoadAnimation_result1 = script.Parent.Yuuki.Humanoid:LoadAnimation(script.Animation)
any_LoadAnimation_result1:Play(0, nil, Speed)
if script.Parent:GetAttribute("Jackpot") == false then
	any_LoadAnimation_result1.TimePosition = 7
	task.wait(4 / Speed)
	local Highlight = Instance.new("Highlight")
	Highlight.FillColor = Color3.new(0, 0, 0)
	Highlight.FillTransparency = 1
	Highlight.OutlineTransparency = 1
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	Highlight.Parent = script.Parent
	game:GetService("TweenService"):Create(Highlight, TweenInfo.new(1 / Speed), {
		FillTransparency = 0.5;
	}):Play()
end