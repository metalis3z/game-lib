--credit to quartz games studio
local t = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local v1 = LocalPlayer:GetMouse()
local Tooltip = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Tooltip"):WaitForChild("Tooltip")
local v2 = nil
local v3 = false
local SeedData = require(game.ReplicatedStorage.SharedModules.SeedData)
local SellValueData = require(game.ReplicatedStorage.SharedModules.SellValueData)
local NumberUtils = require(game.ReplicatedStorage.SharedModules.NumberUtils)
local WeatherData = require(game.ReplicatedStorage.SharedModules.WeatherData)
local v4 = nil
local HoverSFX = game.SoundService.SFX.HoverSFX

local function isElementVisible(p1) --[[ isElementVisible | Line: 18 ]]
	local v1 = p1

	while v1 do
		if v1:IsA("GuiObject") and not v1.Visible then
			return false
		end

		if v1:IsA("ScreenGui") and not v1.Enabled then
			return false
		end

		v1 = v1.Parent
	end

	return true
end

function Update(p1) --[[ Update | Line: 32 | Upvalues: v4 (ref), HoverSFX (copy), Tooltip (copy), SeedData (copy), SellValueData (copy), NumberUtils (copy) ]]
	if v4 == p1 then
		return
	end

	HoverSFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	HoverSFX.TimePosition = 0
	HoverSFX.Playing = true
	v4 = p1
	Tooltip.AnchorPoint = Vector2.new(0, 0)

	for k, v in pairs(SeedData) do
		if v.SeedName == p1 then
			SeedSpec = v

			break
		end
	end

	if not SeedSpec then
		return
	end

	Tooltip.ItemImage.Vector.Image = SeedSpec.FruitImage.Value
	Tooltip.Rarity.Text = SeedSpec.Rarity
	Tooltip.Rarity.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Tooltip.ItemName.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Tooltip.Price.RichText = false

	for k, v in pairs(Tooltip.Rarity:GetChildren()) do
		if v:IsA("UIGradient") then
			v:Destroy()

			break
		end
	end

	local v1 = game.ReplicatedStorage.SharedModules.RarityData.Gradients:FindFirstChild(SeedSpec.Rarity):Clone()

	if v1 then
		v1.Parent = Tooltip.Rarity
	else
		v1:Destroy()
	end

	Tooltip.Price.Text = "Base: " .. NumberUtils.Abbreviate(SellValueData[p1]) .. "\194\162"
	Tooltip.ItemName.Text = p1
end
function UpdateWeather(p1) --[[ UpdateWeather | Line: 70 | Upvalues: v4 (ref), HoverSFX (copy), Tooltip (copy), WeatherData (copy) ]]
	if v4 ~= p1 then
		HoverSFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		HoverSFX.TimePosition = 0
		HoverSFX.Playing = true
		v4 = p1
		Tooltip.AnchorPoint = Vector2.new(1, 0)
	end

	local Time = p1:FindFirstChild("Time")
	local Weather = p1:FindFirstChild("Weather")
	local Vector = p1:FindFirstChild("Vector")

	if Time and Time:IsA("TextLabel") then
		Tooltip.Rarity.Text = Time.Text
		Tooltip.Rarity.TextColor3 = Time.TextColor3
	end

	for v1, v2 in Tooltip.Rarity:GetChildren() do
		if v2:IsA("UIGradient") then
			v2:Destroy()

			break
		end
	end

	if Weather and Weather:IsA("TextLabel") then
		Tooltip.ItemName.Text = Weather.Text
		Tooltip.ItemName.TextColor3 = Weather.TextColor3
	end

	if Vector and Vector:IsA("ImageLabel") then
		Tooltip.ItemImage.Vector.Image = Vector.Image
	end

	local v3 = if Weather then Weather.Text or "" else ""
	local v42 = ""

	for v5, v6 in WeatherData.Data do
		if v6.Name == v3 then
			v42 = v6.Description

			break
		end
	end

	Tooltip.Price.RichText = true
	Tooltip.Price.Text = v42
	Tooltip.Price.TextColor3 = Color3.new(255/255, 255/255, 255/255)
end
function t.TrackUI(p1, p2) --[[ TrackUI | Line: 121 | Upvalues: v2 (ref), v3 (ref), v4 (ref) ]]
	p2.MouseEnter:Connect(function() --[[ Line: 122 | Upvalues: v2 (ref), p2 (copy), v3 (ref) ]]
		v2 = p2
		v3 = true
	end)
	p2.MouseLeave:Connect(function() --[[ Line: 126 | Upvalues: v2 (ref), p2 (copy), v3 (ref), v4 (ref) ]]
		if v2 ~= p2 then
			return
		end

		v3 = false
		v2 = nil
		v4 = nil
	end)

	local function onAttributeCleared() --[[ onAttributeCleared | Line: 134 | Upvalues: p2 (copy), v2 (ref), v3 (ref) ]]
		if p2:GetAttribute("SeedToolTip") or (p2:GetAttribute("WeatherToolTip") or v2 ~= p2) then
			return
		end

		v3 = false
		v2 = nil
	end

	p2:GetAttributeChangedSignal("SeedToolTip"):Connect(onAttributeCleared)
	p2:GetAttributeChangedSignal("WeatherToolTip"):Connect(onAttributeCleared)
	p2.Destroying:Connect(function() --[[ Line: 145 | Upvalues: v2 (ref), p2 (copy), v3 (ref) ]]
		if v2 ~= p2 then
			return
		end

		v3 = false
		v2 = nil
	end)
end
function t.Start(p1) --[[ Start | Line: 153 | Upvalues: LocalPlayer (copy), Tooltip (copy), RunService (copy), v3 (ref), v2 (ref), isElementVisible (copy), v4 (ref), v1 (copy) ]]
	local PlayerGui = LocalPlayer.PlayerGui

	local function shouldTrack(p1) --[[ shouldTrack | Line: 156 ]]
		return p1:IsA("GuiObject") and (p1:GetAttribute("SeedToolTip") or p1:GetAttribute("WeatherToolTip"))
	end

	for v12, v22 in PlayerGui:GetDescendants() do
		if v22:IsA("GuiObject") and (v22:GetAttribute("SeedToolTip") or v22:GetAttribute("WeatherToolTip")) then
			p1:TrackUI(v22)
		end
	end

	PlayerGui.DescendantAdded:Connect(function(p12) --[[ Line: 166 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("GuiObject") and (p12:GetAttribute("SeedToolTip") or p12:GetAttribute("WeatherToolTip"))) then
			return
		end

		p1:TrackUI(p12)
	end)
	Tooltip.Visible = false
	RunService.Heartbeat:Connect(function() --[[ Line: 173 | Upvalues: v3 (ref), v2 (ref), isElementVisible (ref), Tooltip (ref), v4 (ref), v1 (ref) ]]
		if not (v3 and v2) then
			Tooltip.Visible = false

			return
		end

		if not isElementVisible(v2) then
			Tooltip.Visible = false
			v3 = false
			v2 = nil
			v4 = nil

			return
		end

		if v2:GetAttribute("WeatherToolTip") then
			UpdateWeather(v2)
		else
			Update(v2:GetAttribute("SeedToolTip") or "")
		end

		Tooltip.Position = UDim2.new(0, v1.X, 0, v1.Y - Tooltip.AbsoluteSize.Y - 8)
		Tooltip.Visible = true
	end)
end
function t.Init(p1) --[[ Init | Line: 198 ]] end

return t