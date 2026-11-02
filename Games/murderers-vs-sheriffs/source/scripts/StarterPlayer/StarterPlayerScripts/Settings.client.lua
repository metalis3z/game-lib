local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Settings")
local Camera = workspace.CurrentCamera
local NightTimeRemote = Remotes:WaitForChild("NightTime")
local DisableShadowsRemote = Remotes:WaitForChild("DisableShadows")
local LowGraphicsRemote = Remotes:WaitForChild("LowGraphics")
local LowFogRemote = Remotes:WaitForChild("LowFog")
local GunAnimations = Remotes:WaitForChild("GunAnimations")

local OriginalMaterials = {}
local LowGraphicsEnabled = false
local DescendantAddedConnection

NightTimeRemote.OnClientEvent:Connect(function(IsEnabled)
	if IsEnabled then
		TweenService:Create(
			Lighting,
			TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ ClockTime = 0 }
		):Play()
	else
		TweenService:Create(
			Lighting,
			TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ ClockTime = 14 }
		):Play()
	end
end)

DisableShadowsRemote.OnClientEvent:Connect(function(IsEnabled)
	Lighting.GlobalShadows = not IsEnabled
end)

LowGraphicsRemote.OnClientEvent:Connect(function(IsEnabled)
	if IsEnabled and not LowGraphicsEnabled then
		LowGraphicsEnabled = true

		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				if not OriginalMaterials[obj] then
					OriginalMaterials[obj] = obj.Material
				end
				obj.Material = Enum.Material.SmoothPlastic
			elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
				obj.Enabled = false
			end
		end

		DescendantAddedConnection = workspace.DescendantAdded:Connect(function(obj)
			if not LowGraphicsEnabled then return end
			if obj:IsA("BasePart") then
				if not OriginalMaterials[obj] then
					OriginalMaterials[obj] = obj.Material
				end
				obj.Material = Enum.Material.SmoothPlastic
			elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
				obj.Enabled = false
			end
		end)

	else
		if LowGraphicsEnabled then
			LowGraphicsEnabled = false

			if DescendantAddedConnection then
				DescendantAddedConnection:Disconnect()
				DescendantAddedConnection = nil
			end

			for obj, mat in pairs(OriginalMaterials) do
				if obj and obj:IsA("BasePart") then
					pcall(function()
						obj.Material = mat
					end)
				end
			end

			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
					obj.Enabled = true
				end
			end
		end
	end
end)


local ac
local cc
GunAnimations.OnClientEvent:Connect(function(IsEnabled)
	if not IsEnabled then
		if ac then ac:Disconnect(); ac = nil end
		if cc then cc:Disconnect(); cc = nil end
		return
	end
	
	local locels = Players.LocalPlayer
	-- government hooker GAGA QUEEN FOR LIKE LAST WORD
	local function hulK(cherubs)
		local um = cherubs:WaitForChild("Humanoid")
		local alsocanuaddaoptionwhere = um:WaitForChild("Animator")

		if ac then ac:Disconnect() end

		ac = alsocanuaddaoptionwhere.AnimationPlayed:Connect(function(trackten)
			local overrated = trackten.Animation.AnimationId
			if overrated == "rbxassetid://125115297534427"
				or overrated == "rbxassetid://134821825721377" then
				trackten:Stop()
			end
		end)
	end

	if locels.Character then
		hulK(locels.Character)
	end

	if cc then cc:Disconnect() end
	cc = locels.CharacterAdded:Connect(hulK)
end)