-- SERVICES --

local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local CollectionService = game:GetService('CollectionService')

-- INSTANCES --

local Tool = script.Parent
local Handle = Tool:WaitForChild('Handle', 5)
local Character = Players:WaitForChild(Tool.Parent.Parent.Name, 10).Character

local Humanoid = Character:WaitForChild('Humanoid', 5)

-- DATA --

local IsAnimating = false

-- MAIN SCRIPT --

CollectionService:AddTag(script.Parent, 'Hammer')

spawn(function()
	

	while true do

		for i = 1, 360 do

			script.Parent.Handle.Color = Color3.fromHSV(i/360, 1, 1)
			script.Parent.Handle.Diamonds.Color = Color3.fromHSV(i/360, 1, 1)
			
			script.Parent.Handle.ImpactAttachment.Impact_Spark1.Color =  ColorSequence.new(Color3.fromHSV(i/360, 1, 1))
			script.Parent.Handle.ImpactAttachment.Impact_Spark2.Color = ColorSequence.new(Color3.fromHSV(i/360, 1, 1))
			script.Parent.Handle.ImpactAttachment.Impact_Spark3.Color = ColorSequence.new(Color3.fromHSV(i/360, 1, 1))
			script.Parent.Handle.ImpactAttachment.Impact_RaysBig.Color = ColorSequence.new(Color3.fromHSV(i/360, 1, 1))
			script.Parent.Handle.ImpactAttachment.Impact_Shockwave.Color = ColorSequence.new(Color3.fromHSV(i/360, 1, 1))
			script.Parent.Handle.ImpactAttachment.Impact_FractalBurst.Color = ColorSequence.new(Color3.fromHSV(i/360, 1, 1))
			script.Parent.Handle.ImpactAttachment.Impact_SparkleExplosion.Color = ColorSequence.new(Color3.fromHSV(i/360, 1, 1))

			script.Parent.Handle.InnerTrail.Color = ColorSequence.new(Color3.fromHSV(i/360, 1, 1))
			script.Parent.Handle.OuterTrail.Color = ColorSequence.new(Color3.fromHSV(i/360, 1, 1))

			for _, ParticleEmitter in pairs(script.Parent.Handle.Diamonds:GetDescendants()) do

				if ParticleEmitter:IsA('ParticleEmitter') then

					ParticleEmitter.Color = ColorSequence.new(Color3.fromHSV(i/360, 1, 1))

				end

			end
			
			wait()

		end

	end
	
end)

wait(0.5)

local IdleAnimation = Humanoid:LoadAnimation(script.Animations.Idle)
local SwingAnimation = Humanoid:LoadAnimation(script.Animations.Swing)

script.Parent.Equipped:Connect(function()

	IdleAnimation:Play()

end)

script.Parent.Unequipped:Connect(function()

	IdleAnimation:Stop()

end)

for _, Object in pairs(Handle.Diamonds:GetChildren()) do

	if Object:IsA("Attachment") and string.find(Object.Name, "DiamondAttachment") ~= nil then

		Object.Flare.Rate = 0
		Object.Flare.Enabled = true

	end

end

script.Parent.Activated:Connect(function()

	if IsAnimating then

		return

	end
	
	Character.Humanoid.WalkSpeed = 0

	IsAnimating = true

	SwingAnimation:Play()

	--IdleAnimation:Pause()

	spawn(function()

		for _, Object in pairs(Handle.Diamonds:GetChildren()) do

			if Object:IsA("Attachment") and string.find(Object.Name, "DiamondAttachment") ~= nil then

				TweenService:Create(Object.Flare, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
					Rate = 13
				}):Play()

			end

		end

	end)

	Handle.Charge_1:Play()
	Handle.Charge_2:Play()
	Handle.MainChargeSound:Play()

	Handle.Diamonds.DiamondAttachment_Main.Shockwave:Emit(2)

	Handle.Diamonds.DiamondAttachment_Main.ChargeGlow.Enabled = true
	Handle.Diamonds.DiamondAttachment_Main.ChargeRays.Enabled = true

	local Swinged = false

	SwingAnimation:GetMarkerReachedSignal('Swinging'):Connect(function()

		if Swinged then

			return

		end

		Swinged = true

		Handle.ChargeEndSound:Play()

		Handle.Diamonds.DiamondAttachment_Main.Shockwave:Emit(5)

		Handle.InnerTrail.Enabled = true
		Handle.OuterTrail.Enabled = true

		Handle.Diamonds.DiamondAttachment_Main.ChargeGlow.Enabled = false
		Handle.Diamonds.DiamondAttachment_Main.ChargeRays.Enabled = false

	end)

	SwingAnimation:GetMarkerReachedSignal('Impact'):Connect(function()
		
		Handle.MainChargeSound:Stop()
		
		Handle.Impact_Ring:Play()
		Handle.Impact_Impact:Play()
		Handle.Impact_Ambiance:Play()

		Handle.InnerTrail.Enabled = false
		Handle.OuterTrail.Enabled = false

		for _, Effect in pairs(Handle.ImpactAttachment:GetChildren()) do

			if Effect:IsA('ParticleEmitter') then

				Effect:Emit(8)

			end

		end

		for _, Object in pairs(Handle.Diamonds:GetChildren()) do

			if Object:IsA("Attachment") and string.find(Object.Name, "DiamondAttachment") ~= nil then

				Object.Flare.Rate = 0

			end

		end

	end)

	SwingAnimation.Stopped:Connect(function()
		
		Character.Humanoid.WalkSpeed = 16
		
		wait(1.5)

		IsAnimating = false

	end)

end)