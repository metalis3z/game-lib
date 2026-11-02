local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local rp = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local ModuleFolder = rp.Modules
local RemotesFolder = rp:WaitForChild("Remotes")

local ShakeCamera = require(game.ReplicatedFirst.ShakeCamera)

local CameraShaker = require(ModuleFolder.CameraShaker)
local CameraShakeInstance = require(ModuleFolder.CameraShaker.CameraShakeInstance)

local FrameHolder = script.Parent.Holder
local Button = script.Parent.DomainClickButton

local IsClashing = false

local function UpdateSize()
	for i, v in pairs(FrameHolder:GetChildren()) do
		if v:IsA("Frame") then
			TS:Create(v,
				TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
				{Size = UDim2.new(1, 0, FrameHolder:GetAttribute("MaxYSize"), 0)}
			):Play()
		end
	end
end

FrameHolder.ChildAdded:Connect(function(frame)
	FrameHolder.Size = UDim2.new(1.2, 0, 1.024, 0)
	FrameHolder.Rotation = -10

	if frame:IsA("Frame") then
		local numberOfFrames = #FrameHolder:GetChildren() - 1
		FrameHolder:SetAttribute("MaxYSize", numberOfFrames > 2 and 1 / numberOfFrames or .45)

		UpdateSize()
	end
end)

FrameHolder.AttributeChanged:Connect(function(AttributeChanged)
	if FrameHolder:GetAttribute("Clashing") then
		IsClashing = true

		Button.Visible = true

		local numberOfFrames = #FrameHolder:GetChildren() - 1
		FrameHolder:SetAttribute("MaxYSize", numberOfFrames > 2 and 1 / numberOfFrames or .45)

		UpdateSize()

		local HolderTween = TS:Create(FrameHolder, 
			TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
			{Rotation = -80, Size = UDim2.new(1.2, 0, 1.8, 0)}
		)

		HolderTween:Play()
		HolderTween.Completed:Once(function()
			UpdateSize()
		end)

		local c = CameraShakeInstance.new(3, 7, .5, 1)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(1, 1, 4)

		ShakeCamera.SustainShake(c)

		local max = #FrameHolder:GetChildren()
		for index, template in pairs(FrameHolder:GetChildren()) do
			if template:IsA("Frame") then
				if index == 2 then
					script.BlurryBackground:Clone().Parent = template
				end

				local TemplateCamera = template.ViewportFrame.Camera
				template.ViewportFrame.CurrentCamera = TemplateCamera

				local SetCameraCFrame = function(ShakeCFrame)
					TemplateCamera.CFrame = TemplateCamera.CFrame * ShakeCFrame
					TemplateCamera:SetAttribute("ShakeCFrame", ShakeCFrame)
				end

				local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, SetCameraCFrame)
				camShake:Start()

				local D = CameraShakeInstance.new(1.5, 15, .5, 1)
				D.PositionInfluence = Vector3.new(0, 0, 0)
				D.RotationInfluence = Vector3.new(1, 1, 0)

				local shakeInstance = camShake:ShakeSustain(D)

				local connection
				connection = RS.Heartbeat:Connect(function()
					if not IsClashing then
						shakeInstance:StartFadeOut(.5)

						connection:Disconnect()
						connection = nil
					end
				end)

				local speed = (math.random(30, 60) / 100) / 2
				for _, border in pairs(template:GetChildren()) do
					if string.find(border.Name, "Border") then
						--local line1, line2 = border.LINE, border.LINE2
						--local background1, background2 = border.BACKGROUND, border.BACKGROUND2

						local originalPositions = {}

						spawn(function()
							while IsClashing do
								for _, value : ImageLabel in pairs(border:GetChildren()) do
									if string.find(value.Name, "LINE") or string.find(value.Name, "BACKGROUND") then
										originalPositions[value.Name] = value.Position
										if not value.Visible then value.Visible = true end

										TS:Create(value,
											TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
											{Position = UDim2.new(value.Position.X.Scale - 1, 0, .5, 0)}
										):Play()
									end
								end

								task.wait(speed)

								for _, value in pairs(border:GetChildren()) do
									if string.find(value.Name, "LINE") or string.find(value.Name, "BACKGROUND") then
										if originalPositions[value.Name] then
											value.Position = originalPositions[value.Name]
										end
									end
								end
							end
						end)
					end
				end

				TS:Create(TemplateCamera,
					TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
					{CFrame = TemplateCamera.CFrame * CFrame.Angles(0, 0, math.rad(70))}
				):Play()
			end
		end
	end

	if not FrameHolder:GetAttribute("Clashing") and IsClashing then
		IsClashing = false

		Button.Visible = false

		ShakeCamera.StopSustainShake()

		local Winner = FrameHolder:GetAttribute("ClashingWinner")
		for _, template in pairs(FrameHolder:GetChildren()) do
			if template:IsA("Frame") then
				if template.Name ~= Winner then
					local Tween = TS:Create(template,
						TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 0, 0, 0)}
					)

					Tween:Play()
					Tween.Completed:Once(function()
						template:Destroy()
					end)
				else
					TS:Create(template,
						TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
						{Size = UDim2.new(1, 0, .4, 0)}
					):Play()

					task.delay(1.5, function()
						local tween = TS:Create(template,
							TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
							{Size = UDim2.new(1, 0, 0, 0)}
						)

						tween:Play()
						tween.Completed:Once(function()
							template:Destroy()
						end)
					end)
				end
			end
		end
	end

	if FrameHolder:GetAttribute("End") then
		for _, template in pairs(FrameHolder:GetChildren()) do
			if template:IsA("Frame") then
				local Tween = TS:Create(template,
					TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
					{Size = UDim2.new(1, 0, 0, 0)}
				)

				local DomainText = template.BorderTop:FindFirstChild("DOMAIN")
				local ExpansionText = template.BorderBottom:FindFirstChild("EXPANSION")

				if DomainText then
					TS:Create(DomainText,
						TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Position = UDim2.new(0, 0, .5, 0)}
					):Play()
				end

				if ExpansionText then
					TS:Create(ExpansionText,
						TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Position = UDim2.new(1, 0, .5, 0)}
					):Play()
				end

				Tween:Play()
				Tween.Completed:Once(function()
					template:Destroy()
				end)
			end
		end
	end
end)

local function Expand()
	RemotesFolder.DomainClashing:FireServer()
	Button.Size = UDim2.new(0.078 * .8, 0, 0.139 * .8, 0)

	TS:Create(Button,
		TweenInfo.new(.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{Size = UDim2.new(0.078, 0, 0.139, 0)}
	):Play()

	local ImpactEffect = Button.ClickImpact:Clone()
	ImpactEffect.Parent = Button
	ImpactEffect.ImageTransparency = 0
	ImpactEffect.Rotation = math.random(-180, 180)
	ImpactEffect.Size = UDim2.new(0, 0, 0, 0)
	Debris:AddItem(ImpactEffect, .15)

	local randomSize = math.random(30, 40) / 10
	TS:Create(ImpactEffect,
		TweenInfo.new(.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
		{Size = UDim2.new(randomSize, 0, randomSize, 0), ImageTransparency = .5}
	):Play()
end

Button.Button.MouseButton1Up:Connect(Expand)

UIS.InputBegan:Connect(function(input, chatting)
	if not chatting then
		if input.KeyCode == Enum.KeyCode.Space then
			Expand()
		end
	end
end)