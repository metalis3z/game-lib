local function FuncBeam(pos)
	local Beam = Instance.new("Part")
	Beam.Transparency = 1
	Beam.Anchored = true
	Beam.CanCollide = false
	Beam.CFrame = CFrame.new(pos)
	local BeamAttachment = Instance.new("Attachment", Beam)
	game.Debris:AddItem(Beam, 1)
	Beam.Parent = game.Workspace
	return Beam
end
local TweenService = game:GetService("TweenService")
local tweenInfo1 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
return function(gun, shot)
	local Gunshot = FuncBeam(gun.Position)
	local GunBeam = Instance.new("Beam")
	GunBeam.Attachment0 = Gunshot.Attachment
	GunBeam.Attachment1 = FuncBeam(shot).Attachment
	GunBeam.Width0 = 0.2
	GunBeam.Width1 = 0.2
	GunBeam.LightEmission = 0.5
	GunBeam.LightInfluence = 0
	GunBeam.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.202, 0.95), NumberSequenceKeypoint.new(1, 0.6) })
	GunBeam.FaceCamera = true
	GunBeam.Parent = Gunshot
	local IsHarvester = gun:FindFirstChild("IsHarvester")
	local IsBlueHarvester = gun:FindFirstChild("IsBHarvester")
	local IsBronzeHarvester = gun:FindFirstChild("IsBRHarvester")
	local IsSilverHarvester = gun:FindFirstChild("IsSHarvester")
	local IsGoldHarvester = gun:FindFirstChild("IsGHarvester")
	local IsFirework = gun:FindFirstChild("IsFirework")

	if IsHarvester then
		GunBeam.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
		})
	end
	if IsBlueHarvester then
		GunBeam.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
		})
	end
	
	if IsBronzeHarvester then
		GunBeam.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 150, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 0))
		})
	end
	
	if IsSilverHarvester then
		GunBeam.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
		})
	end
	
	if IsGoldHarvester then
		GunBeam.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
		})
	end
	
	if IsFirework then
		GunBeam.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 65, 145)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 135, 155))
		})
	end
	wait(0.03)
	TweenService:Create(GunBeam, tweenInfo1, {
		Width0 = 0
	}):Play()
	TweenService:Create(GunBeam, tweenInfo2, {
		Width1 = 0
	}):Play()
end
