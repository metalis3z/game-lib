-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Library.Audio)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Player = require(ReplicatedStorage.Library.Player)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local v1 = TweenInfo.new(0.28, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local v4 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v5 = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local v6 = TweenInfo.new(0.3)
local LocalPlayer = Players.LocalPlayer
local t = {}
local t2 = {}
local v7 = Random.new()
local t3 = {}

local function getTemplate() --[[ getTemplate | Line: 68 | Upvalues: GUI (copy) ]]
	local v1 = GUI.SpeedGainAnimation()

	assert(v1:IsA("ScreenGui"), "Speed gain animation owner must be a ScreenGui")

	local Frame = v1.Frame

	assert(Frame:IsA("Frame"), "Speed gain template Frame must be a Frame")

	return v1, Frame
end

local function setPopupTransparency(p1, p2) --[[ setPopupTransparency | Line: 77 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("TextLabel") then
			v.TextTransparency = p2

			continue
		end

		if v:IsA("ImageLabel") then
			v.ImageTransparency = p2

			continue
		end

		if v:IsA("UIStroke") then
			v.Transparency = p2
		end
	end
end

local function getOrCreateScale(p1) --[[ getOrCreateScale | Line: 89 ]]
	local UIScale = p1:FindFirstChildOfClass("UIScale")

	if UIScale then
		return UIScale
	end

	local UIScale2 = Instance.new("UIScale")

	UIScale2.Parent = p1

	return UIScale2
end

local function getDefaultStartPosition(p1) --[[ getDefaultStartPosition | Line: 100 ]]
	return Vector2.new(p1.X * 0.25, p1.Y)
end

local function getTargetPosition(p1) --[[ getTargetPosition | Line: 104 ]]
	return p1.AbsolutePosition + p1.AbsoluteSize * 0.5
end

local function getControlPoint(p1, p2) --[[ getControlPoint | Line: 108 | Upvalues: UserInputService (copy), v7 (copy) ]]
	local v2 = if p2.X >= p1.X then -1 else 1
	local v3 = if UserInputService.TouchEnabled then 0.4 else 1
	local v4 = v7:NextNumber(v3 * 90, v3 * 120)

	return (p1 + p2) * 0.5 + Vector2.new(v2 * v4, -v7:NextNumber(v3 * 100, v3 * 150))
end

local function quadBezier(p1, p2, p3, p4) --[[ quadBezier | Line: 120 ]]
	local v1 = 1 - p4

	return p1 * (v1 * v1) + p2 * (v1 * 2 * p4) + p3 * (p4 * p4)
end

local function pulseTargetLabel(p1) --[[ pulseTargetLabel | Line: 125 | Upvalues: TweenService (copy), v1 (copy) ]]
	local v12 = p1.Parent

	if v12 == nil or not v12:IsA("GuiObject") then
		return
	end

	local UIScale = v12:FindFirstChildOfClass("UIScale")
	local v2

	if UIScale then
		v2 = UIScale
	else
		local UIScale2 = Instance.new("UIScale")

		UIScale2.Parent = v12
		v2 = UIScale2
	end

	v2.Scale = 0.7
	TweenService:Create(v2, v1, {
		Scale = 1
	}):Play()
end

local function setTargetLabelPulseActive(p1, p2) --[[ setTargetLabelPulseActive | Line: 138 | Upvalues: t (copy), t2 (copy), TweenService (copy), v3 (copy), v2 (copy) ]]
	local v1 = p1.Parent

	if v1 == nil or not v1:IsA("GuiObject") then
		return
	end

	local UIScale = v1:FindFirstChildOfClass("UIScale")
	local v22

	if UIScale then
		v22 = UIScale
	else
		local UIScale2 = Instance.new("UIScale")

		UIScale2.Parent = v1
		v22 = UIScale2
	end

	if t[v22] == p2 then
		return
	end

	local v32 = (t2[v22] or 0) + 1

	t2[v22] = v32
	t[v22] = p2

	if p2 then
		task.spawn(function() --[[ Line: 160 | Upvalues: t2 (ref), v22 (copy), v32 (copy), TweenService (ref), v2 (ref), v3 (ref) ]]
			while t2[v22] == v32 and v22:IsDescendantOf(game) do
				TweenService:Create(v22, v2, {
					Scale = 1.06
				}):Play()
				task.wait(0.25)

				if t2[v22] ~= v32 or not v22:IsDescendantOf(game) then
					break
				end

				TweenService:Create(v22, v3, {
					Scale = 1
				}):Play()
				task.wait(0.25)
			end
		end)
	else
		TweenService:Create(v22, v3, {
			Scale = 1
		}):Play()
	end
end

local function completeAnimation(p1) --[[ completeAnimation | Line: 179 ]]
	if p1 == nil then
		return
	end

	p1()
end

local function showWalkPlusOne(p1, p2, p3, p4, p5) --[[ showWalkPlusOne | Line: 185 | Upvalues: Player (copy), LocalPlayer (copy), GUI (copy), v7 (copy), TweenService (copy), v4 (copy), v5 (copy), v6 (copy), pulseTargetLabel (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)

	if v1 == nil then
		return
	end

	local v2 = p3 or 1
	local v3 = Color3.fromRGB(178, 233, 255)

	if v2 >= 100 then
		v3 = Color3.fromRGB(255, 0, 0)
	elseif v2 >= 25 then
		v3 = Color3.fromRGB(255, 67, 199)
	elseif v2 >= 9 then
		v3 = Color3.fromRGB(0, 255, 255)
	elseif v2 > 1 then
		v3 = Color3.fromRGB(255, 238, 0)
	end

	if p4 ~= nil then
		v3 = p4
	end

	local PlusOne = Instance.new("BillboardGui")

	PlusOne.Name = "PlusOne"
	PlusOne.Size = UDim2.fromScale(4.5, 1.5)
	PlusOne.StudsOffset = Vector3.new(0, 1, 0)
	PlusOne.AlwaysOnTop = true
	PlusOne.Adornee = v1
	PlusOne.Parent = GUI.PlayerGui()

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(0, 0, 0, 0)
	Frame.Position = UDim2.fromScale(0.5, 0.5)
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundTransparency = 1
	Frame.Parent = PlusOne

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0.05, 0)
	UIListLayout.Parent = Frame

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Size = UDim2.fromScale(0.3, 0.8)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Image = "rbxassetid://99458650446228"
	ImageLabel.Parent = Frame

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

	UIAspectRatioConstraint.AspectRatio = 1
	UIAspectRatioConstraint.Parent = ImageLabel

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromScale(0.6, 0.9)
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextColor3 = v3
	TextLabel.Text = p2
	TextLabel.TextScaled = true
	TextLabel.Font = Enum.Font.GothamBlack
	TextLabel.Parent = Frame

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Thickness = 2
	UIStroke.Parent = TextLabel

	local v11 = Vector3.new(v7:NextInteger(-4, 4), v7:NextInteger(3, 5), v7:NextInteger(-2, 2))

	TweenService:Create(Frame, v4, {
		Size = UDim2.fromScale(1, 1)
	}):Play()
	TweenService:Create(PlusOne, v5, {
		StudsOffset = v11
	}):Play()

	if p5 == nil then
		task.delay(0.5, function() --[[ Line: 272 | Upvalues: TweenService (ref), TextLabel (copy), v6 (ref), ImageLabel (copy), UIStroke (copy), PlusOne (copy), v11 (copy), pulseTargetLabel (ref), p1 (copy) ]]
			TweenService:Create(TextLabel, v6, {
				TextTransparency = 1
			}):Play()
			TweenService:Create(ImageLabel, v6, {
				ImageTransparency = 1
			}):Play()
			TweenService:Create(UIStroke, v6, {
				Transparency = 1
			}):Play()
			TweenService:Create(PlusOne, v6, {
				StudsOffset = v11 + Vector3.new(0, -1, 0)
			}):Play()
			task.delay(0.35, function() --[[ Line: 285 | Upvalues: pulseTargetLabel (ref), p1 (ref), PlusOne (ref) ]]
				pulseTargetLabel(p1)
				PlusOne:Destroy()
			end)
		end)

		return
	end

	p5()
	task.delay(0.5, function() --[[ Line: 272 | Upvalues: TweenService (ref), TextLabel (copy), v6 (ref), ImageLabel (copy), UIStroke (copy), PlusOne (copy), v11 (copy), pulseTargetLabel (ref), p1 (copy) ]]
		TweenService:Create(TextLabel, v6, {
			TextTransparency = 1
		}):Play()
		TweenService:Create(ImageLabel, v6, {
			ImageTransparency = 1
		}):Play()
		TweenService:Create(UIStroke, v6, {
			Transparency = 1
		}):Play()
		TweenService:Create(PlusOne, v6, {
			StudsOffset = v11 + Vector3.new(0, -1, 0)
		}):Play()
		task.delay(0.35, function() --[[ Line: 285 | Upvalues: pulseTargetLabel (ref), p1 (ref), PlusOne (ref) ]]
			pulseTargetLabel(p1)
			PlusOne:Destroy()
		end)
	end)
end

local function playSpeedGainTemplate(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ playSpeedGainTemplate | Line: 292 | Upvalues: Workspace (copy), GUI (copy), getControlPoint (copy), setPopupTransparency (copy), Audio (copy), RunService (copy), pulseTargetLabel (copy) ]]
	if not (p2 <= 0) then
		local CurrentCamera = Workspace.CurrentCamera

		if CurrentCamera ~= nil then
			local v1 = GUI.SpeedGainAnimation()

			assert(v1:IsA("ScreenGui"), "Speed gain animation owner must be a ScreenGui")

			local Frame = v1.Frame

			assert(Frame:IsA("Frame"), "Speed gain template Frame must be a Frame")

			local v4 = Frame:Clone()

			v4.Name = p3
			v4.Visible = true
			v4.AnchorPoint = Vector2.new(0.5, 0.5)

			local CurrentBoost = v4.CurrentBoost

			assert(CurrentBoost:IsA("TextLabel"), "Speed gain popup CurrentBoost must be a TextLabel")

			local UIScale = CurrentBoost:FindFirstChildOfClass("UIScale")
			local v6

			if UIScale then
				v6 = UIScale
			else
				local UIScale2 = Instance.new("UIScale")

				UIScale2.Parent = CurrentBoost
				v6 = UIScale2
			end

			CurrentBoost.Text = p4
			v6.Scale = 0.72

			local v7 = p7 or 1
			local ViewportSize = CurrentCamera.ViewportSize
			local v8, v9

			if p8 and p8.StartPosition ~= nil then
				v8 = p8.StartPosition
				v9 = v1
			else
				v9 = v1
				v8 = Vector2.new(ViewportSize.X * 0.25, ViewportSize.Y)
			end

			local v10 = p1.AbsolutePosition + p1.AbsoluteSize * 0.5
			local v11 = getControlPoint(v8, v10)

			v4.Position = UDim2.fromOffset(v8.X, v8.Y)
			v4.Parent = v9
			setPopupTransparency(v4, 0)

			if p5 then
				Audio.Play(p5, script, v7)
			end

			local v12 = os.clock()
			local v13 = 0

			while v13 < 1 and v4.Parent ~= nil do
				local v15 = math.min((os.clock() - v12) / 0.85, 1)
				local v16 = 1 - v15
				local v17 = v8 * (v16 * v16) + v11 * (v16 * 2 * v15) + v10 * (v15 * v15)
				local v18 = math.clamp((v15 - 0.72) / 0.28, 0, 1)

				v4.Position = UDim2.fromOffset(v17.X, v17.Y)
				v6.Scale = math.sin(v15 * math.pi) * 0.18 + 0.72
				setPopupTransparency(v4, v18)
				RunService.RenderStepped:Wait()
				v13 = v15
			end

			if v4.Parent ~= nil then
				if p6 then
					Audio.Play(p6, script)
				end

				pulseTargetLabel(p1)
				v4:Destroy()
			end
		end
	end

	if p9 == nil then
		return
	end

	p9()
end

function t3.HideTemplate() --[[ HideTemplate | Line: 373 | Upvalues: GUI (copy) ]]
	local v1 = GUI.SpeedGainAnimation()

	assert(v1:IsA("ScreenGui"), "Speed gain animation owner must be a ScreenGui")

	local Frame = v1.Frame

	assert(Frame:IsA("Frame"), "Speed gain template Frame must be a Frame")
	Frame.Visible = false
end
function t3.Play(p1, p2, p3, p4) --[[ Play | Line: 378 | Upvalues: playSpeedGainTemplate (copy), TreadmillUtil (copy) ]]
	playSpeedGainTemplate(p1, p2, "SpeedGainPopup", "+" .. TreadmillUtil.FormatSpeedPower(p2) .. " Speed", nil, nil, 1, {
		StartPosition = p3
	}, p4)
end
function t3.ShowPlusOne(p1, p2, p3, p4) --[[ ShowPlusOne | Line: 399 | Upvalues: showWalkPlusOne (copy), TreadmillUtil (copy) ]]
	if not (p2 <= 0) then
		showWalkPlusOne(p1, "+" .. TreadmillUtil.FormatSpeedPower((math.round(p2))), p2, p3, p4)

		return
	end

	if p4 == nil then
		return
	end

	p4()
end
function t3.SetTargetLabelPulseActive(p1, p2) --[[ SetTargetLabelPulseActive | Line: 419 | Upvalues: setTargetLabelPulseActive (copy) ]]
	setTargetLabelPulseActive(p1, p2)
end
function t3.PlayWalk(p1, p2, p3, p4) --[[ PlayWalk | Line: 423 | Upvalues: t3 (copy) ]]
	t3.ShowPlusOne(p1, p2, p3, p4)
end

return t3