--credit to quartz games studio
local v1 = nil
local v2 = script.Parent.Parent.Parent
local TweenService = game:GetService("TweenService")
local v3 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local v4 = true
local TopText = require(game.ReplicatedStorage.ClientModules.TopText)
local Exit_Detection = script.Parent.Parent.Exit_Detection
local LocalPlayer = game.Players.LocalPlayer
local v5 = false
local v6 = false
local NPC = require(game.ReplicatedStorage.ClientModules.NPC)

require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)

local v7 = nil

function cancelYes() --[[ cancelYes | Line: 20 | Upvalues: v6 (ref), v4 (ref), TopText (copy), v2 (copy), LocalPlayer (copy), v1 (ref), TweenService (copy), v3 (copy), NPC (copy), v7 (ref), v5 (ref) ]]
	v6 = true
	v4 = true
	TopText.TakeAwayResponses(v2, LocalPlayer)

	if v1 then
		TweenService:Create(v1, v3, {
			OutlineTransparency = 1
		}):Play()
		game.Debris:AddItem(v1, v3.Time)
	end

	NPC.EndSpeaking(game.Players.LocalPlayer)
	v7 = nil
	v5 = false
	task.wait(0.5)
	script.Parent.Enabled = true
end

local function Color3ToHex(p1) --[[ Color3ToHex | Line: 36 ]]
	return string.format("#%02X%02X%02X", math.floor(p1.R * 255), math.floor(p1.G * 255), (math.floor(p1.B * 255)))
end

local Click = game.SoundService.SFX.Click

script.Parent.PromptButtonHoldBegan:Connect(function() --[[ Line: 108 | Upvalues: Click (copy) ]]
	Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Click.Playing = true
	Click.TimePosition = 0
end)

local Position = script.Parent.Parent.Position

task.spawn(function() --[[ Line: 114 | Upvalues: v7 (ref), Position (copy), v4 (ref), v5 (ref), TopText (copy), LocalPlayer (copy), v2 (copy), NPC (copy) ]]
	while true do
		local v1

		repeat
			repeat
				task.wait(1)
			until v7 and v7.Character

			v1 = v7.Character.PrimaryPart
		until v1 and ((v1.Position - Position).Magnitude > 10 and (v4 == false and v5 == true))

		TopText.RemovePlayerSideFrame(LocalPlayer)
		TopText.NpcText(v2, "...", true)
		NPC.EndSpeaking(game.Players.LocalPlayer)
		cancelYes()
	end
end)
script.Parent.PromptShown:Connect(function() --[[ Line: 135 | Upvalues: v1 (ref), v2 (copy), TweenService (copy), v3 (copy) ]]
	v1 = Instance.new("Highlight")
	v1.DepthMode = Enum.HighlightDepthMode.Occluded
	v1.FillTransparency = 1
	v1.OutlineTransparency = 1
	v1.Adornee = v2
	v1.Parent = v2
	TweenService:Create(v1, v3, {
		OutlineTransparency = 0
	}):Play()
end)
script.Parent.PromptHidden:Connect(function() --[[ Line: 146 | Upvalues: v1 (ref), TweenService (copy), v3 (copy) ]]
	if not v1 then
		return
	end

	TweenService:Create(v1, v3, {
		OutlineTransparency = 1
	}):Play()
	game.Debris:AddItem(v1, v3.Time)
end)