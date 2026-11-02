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
local GuiController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)

LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GearShop")

local Humanoid = script.Parent.Parent.Parent:WaitForChild("Humanoid")
local Animations = script.Parent.Parent.Parent.Animations
local v7 = Humanoid.Animator:LoadAnimation(Animations.Idle)
local v8 = Humanoid.Animator:LoadAnimation(Animations.Interact)

v7:Play(0.01, 25, 1)

local v9 = nil

function cancelYes() --[[ cancelYes | Line: 28 | Upvalues: v6 (ref), v4 (ref), TopText (copy), v2 (copy), LocalPlayer (copy), v1 (ref), TweenService (copy), v3 (copy), NPC (copy), v9 (ref), v5 (ref) ]]
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
	v9 = nil
	v5 = false
	task.wait(0.5)
	script.Parent.Enabled = true
end

local function Color3ToHex(p1) --[[ Color3ToHex | Line: 44 ]]
	return string.format("#%02X%02X%02X", math.floor(p1.R * 255), math.floor(p1.G * 255), (math.floor(p1.B * 255)))
end

function yes() --[[ yes | Line: 56 | Upvalues: v4 (ref), v5 (ref), v9 (ref), NPC (copy), v1 (ref), TweenService (copy), v3 (copy), v6 (ref), v8 (copy), TopText (copy), v2 (copy), GuiController (copy) ]]
	for k, v in pairs(script.Parent.Parent.Parent.Head:GetChildren()) do
		if v:IsA("BillboardGui") then
			v.Enabled = false
		end
	end

	if v4 ~= true then
		return
	end

	v4 = false
	v5 = true
	v9 = game.Players.LocalPlayer
	NPC.StartSpeaking(game.Players.LocalPlayer)

	if v1 and v1 ~= nil then
		TweenService:Create(v1, v3, {
			OutlineTransparency = 1
		}):Play()
		game.Debris:AddItem(v1, v3.Time)
	end

	v6 = false
	script.Parent.Enabled = false

	if v1 then
		TweenService:Create(v1, v3, {
			OutlineTransparency = 1
		}):Play()
		game.Debris:AddItem(v1, v3.Time)
	end

	v8:Play(0.1, 100, 1)
	TopText.NpcText(v2, "Here are the gears that are in stock", true)

	local v12 = time()
	local v22 = 0

	while v22 < 0.8374507866387546 and v6 == false do
		task.wait()
		v22 = time() - v12
	end

	if not GuiController:IsOpen("GearShop") then
		GuiController:Open("GearShop", nil, { "HUD" })
	end

	if v6 then
		return cancelYes()
	end

	local v32 = time()
	local v42 = 0

	while v42 < 0.5874507866387546 and v6 == false do
		task.wait()
		v42 = time() - v32
	end

	if v6 then
		return cancelYes()
	end

	TopText.TakeAwayResponses(script.Parent.Parent.Parent, game.Players.LocalPlayer)
	v4 = true
	v5 = false
	script.Parent.Enabled = true
	NPC.EndSpeaking(game.Players.LocalPlayer)
end
script.Parent.Triggered:Connect(function() --[[ Line: 115 | Upvalues: NPC (copy), LocalPlayer (copy) ]]
	if NPC.CanSpeak(LocalPlayer) ~= true then
		return
	end

	yes(LocalPlayer)
end)

local Click = game.SoundService.SFX.Click

script.Parent.PromptButtonHoldBegan:Connect(function() --[[ Line: 122 | Upvalues: Click (copy) ]]
	Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Click.Playing = true
	Click.TimePosition = 0
end)

local Position = script.Parent.Parent.Position

task.spawn(function() --[[ Line: 128 | Upvalues: v9 (ref), Position (copy), v4 (ref), v5 (ref), TopText (copy), LocalPlayer (copy), v2 (copy), NPC (copy) ]]
	while true do
		local v1

		repeat
			repeat
				task.wait(1)
			until v9 and v9.Character

			v1 = v9.Character.PrimaryPart
		until v1 and ((v1.Position - Position).Magnitude > 10 and (v4 == false and v5 == true))

		TopText.RemovePlayerSideFrame(LocalPlayer)
		TopText.NpcText(v2, "...", true)
		NPC.EndSpeaking(game.Players.LocalPlayer)
		cancelYes()
	end
end)
script.Parent.PromptShown:Connect(function() --[[ Line: 149 | Upvalues: v1 (ref), v2 (copy), TweenService (copy), v3 (copy) ]]
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
script.Parent.PromptHidden:Connect(function() --[[ Line: 160 | Upvalues: v1 (ref), TweenService (copy), v3 (copy) ]]
	if not v1 then
		return
	end

	TweenService:Create(v1, v3, {
		OutlineTransparency = 1
	}):Play()
	game.Debris:AddItem(v1, v3.Time)
end)