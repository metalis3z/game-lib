-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

require(ReplicatedStorage.Library.Client.Eggs.Types)

local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = Color3.fromRGB(166, 255, 111)
local v2 = TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local t = {}

local function stopPulse(p1) --[[ stopPulse | Line: 28 ]]
	local PulseTween = p1.PulseTween

	p1.PulseTween = nil

	if PulseTween ~= nil then
		PulseTween:Cancel()
		PulseTween:Destroy()
	end

	p1.HatchButton.BackgroundColor3 = p1.OriginalHatchColor
end

local function startPulse(p1) --[[ startPulse | Line: 39 | Upvalues: TweenService (copy), v2 (copy), v1 (copy) ]]
	if p1.PulseTween == nil then
		local v12 = TweenService:Create(p1.HatchButton, v2, {
			BackgroundColor3 = v1
		})

		p1.PulseTween = v12
		v12:Play()
	end
end

local function updateButtonState(p1, p2, p3) --[[ updateButtonState | Line: 51 | Upvalues: TweenService (copy), v2 (copy), v1 (copy) ]]
	p1.GrowButton.Visible = not p2 and p3
	p1.GrowButton.Active = not p2 and p3
	p1.HatchButton.Visible = p2
	p1.HatchButton.Active = p2

	if p2 then
		if p1.PulseTween == nil then
			local v12 = TweenService:Create(p1.HatchButton, v2, {
				BackgroundColor3 = v1
			})

			p1.PulseTween = v12
			v12:Play()
		end
	else
		local PulseTween = p1.PulseTween

		p1.PulseTween = nil

		if PulseTween ~= nil then
			PulseTween:Cancel()
			PulseTween:Destroy()
		end

		p1.HatchButton.BackgroundColor3 = p1.OriginalHatchColor
	end
end

function t.Mount(p1, p2, p3, p4, p5) --[[ Mount | Line: 68 | Upvalues: Trove (copy) ]]
	local v1 = p1:Clone()

	v1.Name = p3
	v1.Visible = true
	v1.Parent = p2

	local GrowButton = v1.Main_Frame.BevelEffect.GrowButton
	local HatchButton = v1.Main_Frame.HatchButton

	HatchButton.Visible = false

	local v2 = Trove.new()
	local t = {
		PulseTween = nil,
		Uid = p3,
		Root = v1,
		GrowButton = GrowButton,
		HatchButton = HatchButton,
		OriginalHatchColor = HatchButton.BackgroundColor3,
		Trove = v2
	}

	v2:Add(v1)
	v2:Add(function() --[[ Line: 96 | Upvalues: t (copy) ]]
		local v1 = t
		local PulseTween = v1.PulseTween

		v1.PulseTween = nil

		if PulseTween == nil then
			v1.HatchButton.BackgroundColor3 = v1.OriginalHatchColor

			return
		end

		PulseTween:Cancel()
		PulseTween:Destroy()
		v1.HatchButton.BackgroundColor3 = v1.OriginalHatchColor
	end)
	v2:Connect(GrowButton.Activated, function() --[[ Line: 99 | Upvalues: p4 (copy), p3 (copy) ]]
		p4(p3)
	end)
	v2:Connect(HatchButton.Activated, function() --[[ Line: 102 | Upvalues: p5 (copy), p3 (copy) ]]
		p5(p3)
	end)

	return t
end
function t.Update(p1, p2, p3, p4, p5, p6) --[[ Update | Line: 109 | Upvalues: TweenService (copy), v2 (copy), v1 (copy) ]]
	local Main_Frame = p1.Root.Main_Frame

	Main_Frame.Image.Image = p2
	Main_Frame.ProgressBar.Frame.Size = UDim2.fromScale(p3, 1)
	Main_Frame.ProgressBar.TextLabel.Text = p4
	Main_Frame.ProgressBar.Visible = not p5
	p1.GrowButton.Visible = not p5 and p6
	p1.GrowButton.Active = not p5 and p6
	p1.HatchButton.Visible = p5
	p1.HatchButton.Active = p5

	if p5 then
		if p1.PulseTween == nil then
			local v12 = TweenService:Create(p1.HatchButton, v2, {
				BackgroundColor3 = v1
			})

			p1.PulseTween = v12
			v12:Play()
		end
	else
		local PulseTween = p1.PulseTween

		p1.PulseTween = nil

		if PulseTween ~= nil then
			PulseTween:Cancel()
			PulseTween:Destroy()
		end

		p1.HatchButton.BackgroundColor3 = p1.OriginalHatchColor
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 126 ]]
	p1.Trove:Destroy()
end

return t