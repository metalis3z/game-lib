--credit to prince games studio
local Bar = script.Parent:WaitForChild("Bar")
local Notch = script.Parent:WaitForChild("Notch")
local Scroll = game.SoundService.SFX.Scroll
local UserInputService = game:GetService("UserInputService")

game:GetService("RunService")

local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = game.Players.LocalPlayer
local v1 = LocalPlayer:GetMouse()
local v2 = false
local v3 = -1
local v4 = 0

local function snap(p1) --[[ snap | Line: 24 ]]
	return math.round(p1 / 0.1) * 0.1
end

local v5 = script.Parent
local SFX_Volume = LocalPlayer:WaitForChild("Settings"):WaitForChild("SFX_Volume")

local function applySavedPercent(p1) --[[ applySavedPercent | Line: 34 | Upvalues: Bar (copy), v3 (ref) ]]
	local v2 = math.clamp(math.round(p1 / 0.1) * 0.1, 0, 1)

	Bar.Size = UDim2.new(v2, 0, 1, 0)
	Bar.BackgroundColor3 = Color3.fromHSV(0.3 * v2, 1, 1)
	v3 = v2
end

local v8 = math.clamp(math.round(SFX_Volume.Value / 0.1) * 0.1, 0, 1)

Bar.Size = UDim2.new(v8, 0, 1, 0)
Bar.BackgroundColor3 = Color3.fromHSV(0.3 * v8, 1, 1)
v3 = v8

local function getPercent() --[[ getPercent | Line: 43 | Upvalues: v1 (copy), v5 (copy) ]]
	return math.round(math.clamp((v1.X - v5.AbsolutePosition.X) / v5.AbsoluteSize.X, 0, 1) / 0.1) * 0.1
end

local function playTick(p1) --[[ playTick | Line: 50 | Upvalues: Scroll (copy) ]]
	Scroll.TimePosition = 0
	Scroll.PlaybackSpeed = 1 + 0.5 * p1
	Scroll:Play()
end

local function updateSlider() --[[ updateSlider | Line: 57 | Upvalues: v1 (copy), v5 (copy), Bar (copy), v3 (ref), Scroll (copy), v4 (ref), Networking (copy) ]]
	local v32 = math.round(math.clamp((v1.X - v5.AbsolutePosition.X) / v5.AbsoluteSize.X, 0, 1) / 0.1) * 0.1

	Bar.Size = UDim2.new(v32, 0, 1, 0)
	Bar.BackgroundColor3 = Color3.fromHSV(0.3 * v32, 1, 1)

	if v32 == v3 then
		return
	end

	Scroll.TimePosition = 0
	Scroll.PlaybackSpeed = 1 + 0.5 * v32
	Scroll:Play()
	v4 = v4 - (v32 - v3) * 30
	v3 = v32
	Networking.Settings.UpdateSFX:Fire(v32)
end

local function startDragLoop() --[[ startDragLoop | Line: 72 | Upvalues: v2 (ref), updateSlider (copy) ]]
	while v2 do
		updateSlider()
		task.wait(0.01)
	end
end

Notch.InputBegan:Connect(function(p1) --[[ Line: 81 | Upvalues: v2 (ref), updateSlider (copy) ]]
	if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	if v2 then
		return
	end

	v2 = true

	while v2 do
		updateSlider()
		task.wait(0.01)
	end
end)
Notch.InputEnded:Connect(function(p1) --[[ Line: 90 | Upvalues: v2 (ref) ]]
	if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	v2 = false
end)
UserInputService.InputEnded:Connect(function(p1) --[[ Line: 98 | Upvalues: v2 (ref) ]]
	if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	v2 = false
end)