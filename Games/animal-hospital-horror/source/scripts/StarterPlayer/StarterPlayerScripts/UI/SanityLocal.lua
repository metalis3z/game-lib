local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local Frame = Lib.UI.Get("Sanity"):WaitForChild("Frame")
local LocalPlayer = game.Players.LocalPlayer
local staticframe = Lib.UI.Get("static"):WaitForChild("staticframe")
local Vignette = Lib.UI.Get("Vignette").Vignette

local function shakeImage(p1, p2, p3) --[[ shakeImage | Line: 8 | Upvalues: Frame (copy) ]]
	local v1 = if p1 then p1 else Frame:WaitForChild("Images")
	local v2 = v1:GetAttribute("OriginalPosition") or v1.Position

	v1:SetAttribute("OriginalPosition", v2)

	local v3 = p2 or 1
	local v4 = math.round(7 * v3)
	local v5 = p3 or 0.01
	local v6 = 0.25 * v3

	for i = 1, v4 do
		local v7 = (math.random() - 0.5) * v5 * 2

		v1.Position = UDim2.new(v2.X.Scale + v7, 0, v2.Y.Scale + (math.random() - 0.5) * v5 * 2, 0)
		task.wait(v6 / v4)
	end

	v1.Position = v2
end

Lib.Inject("ShakeImage", shakeImage)

local function imageEffect(p1, p2) --[[ imageEffect | Line: 28 | Upvalues: Frame (copy), Lib (copy) ]]
	local v1 = Frame.Images.brain:GetAttribute("OriginalSize") or Frame.Images.brain.Size

	Frame.Images.brain:SetAttribute("OriginalSize", v1)
	Frame.Images.brain.Size = UDim2.new(v1.X.Scale * 1.2, 0, v1.Y.Scale * 1.2, 0)
	Frame.Images.brain.ImageColor3 = p1 and Color3.new(0/255, 255/255, 0/255) or (p2 and Color3.new(255/255, 0/255, 0/255) or Color3.new(255/255, 255/255, 255/255))
	Lib.TS:Create(Frame.Images.brain, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
		Size = v1,
		ImageColor3 = Color3.new(255/255, 255/255, 255/255)
	}):Play()

	local v3 = Frame.Images.back:GetAttribute("OriginalSize") or Frame.Images.back.Size

	Frame.Images.back:SetAttribute("OriginalSize", v3)
	Frame.Images.back.Size = UDim2.new(v3.X.Scale * 1.2, 0, v3.Y.Scale * 1.2, 0)
	Lib.TS:Create(Frame.Images.back, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
		Size = v3
	}):Play()
end

local function displayModEffect(p1) --[[ displayModEffect | Line: 42 | Upvalues: Lib (copy) ]]
	p1.Visible = true

	local v1 = UDim2.new(0.5, 0, -1, 0)

	Lib.TS:Create(p1, TweenInfo.new(3, Enum.EasingStyle.Linear), {
		Position = v1
	}):Play()
	task.delay(2.5, function() --[[ Line: 48 | Upvalues: Lib (ref), p1 (copy) ]]
		Lib.TS:Create(p1, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
			TextTransparency = 0.9
		}):Play()
		Lib.TS:Create(p1.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
			Transparency = 0.9
		}):Play()
	end)
end

local v1 = nil
local v2 = nil
local amount = Frame:WaitForChild("Frame"):WaitForChild("textbox"):WaitForChild("amount")

local function updateSanity() --[[ updateSanity | Line: 57 | Upvalues: LocalPlayer (copy), v2 (ref), amount (copy), Frame (copy), v1 (ref), Lib (copy), imageEffect (copy), staticframe (copy), Vignette (copy), shakeImage (copy), displayModEffect (copy) ]]
	local v12 = LocalPlayer:GetAttribute("Sanity")

	if not v12 then
		return
	end

	local v22 = v2 and (if v12 < v2 then v2 - v12 else false)
	local v3 = v2 and (if v2 < v12 then v12 - v2 else false)
	local v4 = 1 - (1 - v12 / 100) * 0.02
	local v5 = 0.8 - (1 - v12 / 100) * 0.2

	v2 = v12
	amount.Text = v12 .. "%"
	Frame:WaitForChild("Images"):WaitForChild("brain"):WaitForChild("UIGradient").Offset = Vector2.new(0, -v12 / 100)

	if not v1 then
		local v6 = Color3.fromHSV(120 * (1 - (1 - v12 / 100)) / 360, 1, 1)

		Lib.TS:Create(amount, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
			TextColor3 = v6
		}):Play()
		imageEffect(v3, v22)
	end

	local ColorCorrection = game.Lighting:WaitForChild("ColorCorrection")

	if v12 < 35 then
		ColorCorrection.Saturation = -0.4 + 1.4 * (v12 / 35)
		Lib.TS:Create(Lib.MusicService.Get("HouseSlow").Sound, TweenInfo.new(10, Enum.EasingStyle.Linear), {
			PlaybackSpeed = v5
		}):Play()
	else
		ColorCorrection.Saturation = 1

		local v8 = Lib.MusicService.Get("HouseSlow")
		local v9 = v8.Sound:GetAttribute("OriginalPlaybackSpeed") or v8.Sound.PlaybackSpeed

		Lib.TS:Create(v8.Sound, TweenInfo.new(2, Enum.EasingStyle.Linear), {
			PlaybackSpeed = v9
		}):Play()
	end

	if v22 then
		local v122 = amount.Parent.Parent:WaitForChild(if v1 then "difDrain" else "dif"):Clone()

		v122.Parent = amount.Parent.Parent
		v122.Text = "-" .. v22 .. " " .. (LocalPlayer:GetAttribute("SanityLossReason") or "")
		v122.TextColor3 = v1 and Color3.new(0.8, 0.75, 0.75) or Color3.new(1, 0.35, 0.35)

		if not v1 then
			staticframe.ImageTransparency = 0.75
			Lib.TS:Create(staticframe, TweenInfo.new(1.5, Enum.EasingStyle.Exponential), {
				ImageTransparency = v4
			}):Play()
			Vignette.ImageTransparency = 0
			Lib.TS:Create(Vignette, TweenInfo.new(1.5, Enum.EasingStyle.Exponential), {
				ImageTransparency = 1
			}):Play()
			Lib.MusicService.Get("Ominous Bell2", "sfx"):Play()
			shakeImage()
		end

		displayModEffect(v122)
		task.wait(3)
		v122:Destroy()
	elseif v3 then
		Lib.MusicService.Get("Sparkle", "sfx"):Play()

		local v14 = amount.Parent.Parent:WaitForChild("dif"):Clone()

		v14.Parent = amount.Parent.Parent
		v14.Text = "+" .. v3 .. " " .. (LocalPlayer:GetAttribute("SanityGainReason") or "")
		v14.TextColor3 = Color3.new(0/255, 255/255, 0/255)
		displayModEffect(v14)
		task.wait(3)
		v14:Destroy()
	end

	v1 = false
	staticframe.ImageTransparency = v4

	local fade = Frame.Images:WaitForChild("fade")

	fade.Visible = v12 <= 0
end

local function LocalLoseSanity(p1, p2, p3) --[[ LocalLoseSanity | Line: 134 | Upvalues: v2 (ref), LocalPlayer (copy), Lib (copy) ]]
	if v2 and not (v2 <= 0) then
		local v1 = LocalPlayer:GetAttribute("SanityImpactMultiplier") or 1

		LocalPlayer:SetAttribute("SanityLossReason", p2 or "")
		LocalPlayer:SetAttribute("Sanity", (math.clamp((LocalPlayer:GetAttribute("Sanity") or 100) - p1 * v1, 0, 100)))
		Lib.Network:FireServer("PlayerLostSanity", p1, p2, p3)
	end
end

Lib.Inject("PlayerLostSanity", LocalLoseSanity)
updateSanity()
LocalPlayer:GetAttributeChangedSignal("Sanity"):Connect(updateSanity)
task.spawn(function() --[[ Line: 147 | Upvalues: Frame (copy), Lib (copy) ]]
	local Position = Frame.Images.Position

	Frame.Images:SetAttribute("OriginalPosition", Position)

	local v1 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true)
	local v2 = Random.new()
	local v3 = 1

	while task.wait(4) do
		v3 = -v3
		Lib.TS:Create(Frame.Images, v1, {
			Rotation = v3 * 4,
			Position = UDim2.new(Position.X.Scale + v2:NextNumber(-0.004, 0.004), 0, Position.Y.Scale + v2:NextNumber(-0.003, 0.003), 0)
		}):Play()
	end
end)
task.spawn(function() --[[ Line: 164 | Upvalues: v1 (ref), LocalLoseSanity (copy) ]]
	while task.wait(50) do
		v1 = true
		LocalLoseSanity(1, "Job Stress", true)
	end
end)

return {}