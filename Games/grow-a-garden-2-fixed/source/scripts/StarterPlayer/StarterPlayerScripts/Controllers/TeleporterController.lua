--credit to leon games studio
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local TeleporterData = require(ReplicatedStorage.SharedModules.TeleporterData)
local LocalPlayer = Players.LocalPlayer
local Temporary = workspace:WaitForChild("Temporary")
local t = {}
local v1 = false
local t2 = { 0.9, 0.8, 0.7, 0.6, 0.5 }
local v2 = nil
local v3 = nil
local v4 = 0
local t3 = {
	StartOrder = 1
}
local v5 = 10
local v6 = nil
local v7 = nil

for v8, v9 in TeleporterData.Data do
	t[v9.Name] = v9.TeleportDistance
end

local function getCharacter() --[[ getCharacter | Line: 58 | Upvalues: LocalPlayer (copy) ]]
	return LocalPlayer.Character
end

local function getHumanoidRootPart() --[[ getHumanoidRootPart | Line: 62 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	return if Character then Character:FindFirstChild("Head") else Character
end

local function getForwardCFrame(p1) --[[ getForwardCFrame | Line: 67 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = Character and Character:FindFirstChild("Head")

	if not v1 then
		return nil
	end

	local LookVector = v1.CFrame.LookVector
	local v2 = Vector3.new(LookVector.X, 0, LookVector.Z)

	if v2.Magnitude < 0.01 then
		return nil
	end

	return v1.CFrame + v2.Unit * p1
end

local function applyTransparencyToClone(p1, p2) --[[ applyTransparencyToClone | Line: 83 ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.Transparency = math.max(v2.Transparency, p2)
			v2.CanCollide = false
			v2.CanQuery = false
			v2.CanTouch = false
			v2.Anchored = true

			continue
		end

		if v2:IsA("Decal") or v2:IsA("Texture") then
			v2.Transparency = math.max(v2.Transparency, p2)

			continue
		end

		if v2:IsA("ParticleEmitter") or (v2:IsA("Trail") or v2:IsA("Beam")) then
			v2.Enabled = false

			continue
		end

		if v2:IsA("Fire") or (v2:IsA("Smoke") or v2:IsA("Sparkles")) then
			v2.Enabled = false

			continue
		end

		if v2:IsA("Light") then
			v2.Enabled = false
		end
	end

	for v3, v4 in p1:GetChildren() do
		if v4:IsA("Accessory") then
			local Handle = v4:FindFirstChild("Handle")

			if Handle and Handle:IsA("BasePart") then
				Handle.Transparency = math.max(Handle.Transparency, p2)
				Handle.Anchored = true
				Handle.CanCollide = false
				Handle.CanQuery = false
				Handle.CanTouch = false
			end
		end
	end
end

local function fadeOutClone(p1, p2) --[[ fadeOutClone | Line: 116 | Upvalues: TweenService (copy), Debris (copy) ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			local v3 = TweenService:Create(v2, TweenInfo.new(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Transparency = 1
			})

			v3:Play()
			table.insert(t, v3)

			continue
		end

		if v2:IsA("Decal") or v2:IsA("Texture") then
			TweenService:Create(v2, TweenInfo.new(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Transparency = 1
			}):Play()
		end
	end

	if #t > 0 then
		t[1].Completed:Once(function() --[[ Line: 135 | Upvalues: p1 (copy) ]]
			p1:Destroy()
		end)
	else
		Debris:AddItem(p1, p2)
	end

	Debris:AddItem(p1, p2 + 1)
end

local function clearPreview() --[[ clearPreview | Line: 149 | Upvalues: v2 (ref), v7 (ref), v1 (ref) ]]
	if v2 then
		v2:Destroy()
		v2 = nil
	end

	if not v7 then
		v1 = false

		return
	end

	v7:Disconnect()
	v7 = nil
	v1 = false
end

local function createPreview() --[[ createPreview | Line: 161 | Upvalues: v3 (ref), v2 (ref), v7 (ref), v1 (ref), LocalPlayer (copy), applyTransparencyToClone (copy), Temporary (copy) ]]
	if v3 == nil then
		return
	end

	if v2 then
		v2:Destroy()
		v2 = nil
	end

	if v7 then
		v7:Disconnect()
		v7 = nil
	end

	v1 = false

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	if not Character:FindFirstChildOfClass("Humanoid") then
		return
	end

	Character.Archivable = true

	local TeleportPreview = v3:Clone()

	TeleportPreview.Name = "TeleportPreview"
	Character.Archivable = false

	if Character.PrimaryPart then
		local v12 = TeleportPreview:FindFirstChild(Character.PrimaryPart.Name)

		if v12 and v12:IsA("BasePart") then
			TeleportPreview.PrimaryPart = v12
		end
	end

	applyTransparencyToClone(TeleportPreview, 0.5)
	TeleportPreview.Parent = Temporary
	v2 = TeleportPreview
end

local function updatePreview() --[[ updatePreview | Line: 190 | Upvalues: v2 (ref), v5 (ref), LocalPlayer (copy), v1 (ref), Temporary (copy) ]]
	if not v2 then
		return
	end

	if not v2.PrimaryPart then
		return
	end

	local v12 = v5
	local Character = LocalPlayer.Character
	local v22 = Character and Character:FindFirstChild("Head")
	local v3

	if v22 then
		local LookVector = v22.CFrame.LookVector
		local v4 = Vector3.new(LookVector.X, 0, LookVector.Z)

		v3 = if v4.Magnitude < 0.01 then nil else v22.CFrame + v4.Unit * v12
	else
		v3 = nil
	end

	if v3 then
		if v1 then
			v2:SetPrimaryPartCFrame(v3)

			return
		end

		v2.Parent = Temporary
		v1 = true
		v2:SetPrimaryPartCFrame(v3)
	else
		if not v1 then
			return
		end

		v2.Parent = nil
		v1 = false
	end
end

local function spawnTeleportTrail(p1, p2) --[[ spawnTeleportTrail | Line: 215 | Upvalues: LocalPlayer (copy), applyTransparencyToClone (copy), t2 (copy), Temporary (copy), fadeOutClone (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	Character.Archivable = true

	local v1 = Character:Clone()

	Character.Archivable = false

	for v2, v3 in v1:GetDescendants() do
		if v3:IsA("BasePart") then
			v3.CollisionGroup = "NoPlayers"
		end
	end

	for i = 1, 5 do
		local v4 = p1:Lerp(p2, i / 5)
		local v5 = v1:Clone()

		v5.Name = "TeleportTrail_" .. tostring(i)

		if Character.PrimaryPart then
			local v6 = v5:FindFirstChild(Character.PrimaryPart.Name)

			if v6 and v6:IsA("BasePart") then
				v5.PrimaryPart = v6
			end
		end

		applyTransparencyToClone(v5, t2[i])
		v5.Parent = Temporary

		if v5.PrimaryPart then
			v5:SetPrimaryPartCFrame(v4)
		end

		task.delay((i - 1) * 0.03, function() --[[ Line: 256 | Upvalues: v5 (copy), fadeOutClone (ref) ]]
			if not (v5 and v5.Parent) then
				return
			end

			fadeOutClone(v5, 0.6)
		end)
	end

	v1:Destroy()
end

local function doTeleport() --[[ doTeleport | Line: 271 | Upvalues: LocalPlayer (copy), v5 (ref), Networking (copy), spawnTeleportTrail (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = Character and Character:FindFirstChild("Head")

	if not v1 then
		return
	end

	local Character2 = LocalPlayer.Character

	if not Character2 then
		return
	end

	local Humanoid = Character2:FindFirstChildOfClass("Humanoid")

	if not Humanoid or Humanoid.Health <= 0 then
		return
	end

	local v2 = v5
	local Character3 = LocalPlayer.Character
	local v3 = Character3 and Character3:FindFirstChild("Head")
	local v4

	if v3 then
		local LookVector = v3.CFrame.LookVector
		local v52 = Vector3.new(LookVector.X, 0, LookVector.Z)

		v4 = if v52.Magnitude < 0.01 then nil else v3.CFrame + v52.Unit * v2
	else
		v4 = nil
	end

	if v4 then
		local v6 = v1.CFrame

		v1.CFrame = v4
		Networking.Place.UseTeleporter:Fire(v4.Position)
		spawnTeleportTrail(v6, v4)
	end
end

local function onToolEquipped(p1) --[[ onToolEquipped | Line: 299 | Upvalues: v6 (ref), v5 (ref), t (copy), createPreview (copy), v7 (ref), RunService (copy), v2 (ref), LocalPlayer (copy), v1 (ref), Temporary (copy) ]]
	if p1:GetAttribute("Teleporter") then
		v6 = p1
		v5 = t[p1:GetAttribute("Teleporter")] or 10
		createPreview()
		v7 = RunService.RenderStepped:Connect(function() --[[ Line: 308 | Upvalues: v2 (ref), v5 (ref), LocalPlayer (ref), v1 (ref), Temporary (ref) ]]
			debug.profilebegin("Controllers/TeleporterController/PreviewUpdate")

			if not (v2 and v2.PrimaryPart) then
				debug.profileend()

				return
			end

			local v12 = v5
			local Character = LocalPlayer.Character
			local v22 = Character and Character:FindFirstChild("Head")
			local v3

			if v22 then
				local LookVector = v22.CFrame.LookVector
				local v4 = Vector3.new(LookVector.X, 0, LookVector.Z)

				v3 = if v4.Magnitude < 0.01 then nil else v22.CFrame + v4.Unit * v12
			else
				v3 = nil
			end

			if v3 then
				if not v1 then
					v2.Parent = Temporary
					v1 = true
				end

				v2:SetPrimaryPartCFrame(v3)
			else
				if not v1 then
					debug.profileend()

					return
				end

				v2.Parent = nil
				v1 = false
			end

			debug.profileend()
		end)
	end
end

local function onToolUnequipped(p1) --[[ onToolUnequipped | Line: 315 | Upvalues: v6 (ref), v2 (ref), v7 (ref), v1 (ref) ]]
	if v6 ~= p1 then
		return
	end

	v6 = nil

	if v2 then
		v2:Destroy()
		v2 = nil
	end

	if not v7 then
		v1 = false

		return
	end

	v7:Disconnect()
	v7 = nil
	v1 = false
end

local function tryTeleport() --[[ tryTeleport | Line: 325 | Upvalues: v6 (ref), v4 (ref), doTeleport (copy), createPreview (copy), v7 (ref), RunService (copy), v2 (ref), v5 (ref), LocalPlayer (copy), v1 (ref), Temporary (copy) ]]
	if not v6 then
		return
	end

	local v12 = os.clock()

	if not (v12 - v4 < 1) then
		v4 = v12
		doTeleport()
		task.defer(function() --[[ Line: 335 | Upvalues: v6 (ref), createPreview (ref), v7 (ref), RunService (ref), v2 (ref), v5 (ref), LocalPlayer (ref), v1 (ref), Temporary (ref) ]]
			if not v6 then
				return
			end

			createPreview()

			if v7 then
				return
			end

			v7 = RunService.RenderStepped:Connect(function() --[[ Line: 339 | Upvalues: v2 (ref), v5 (ref), LocalPlayer (ref), v1 (ref), Temporary (ref) ]]
				debug.profilebegin("Controllers/TeleporterController/PreviewUpdate")

				if not (v2 and v2.PrimaryPart) then
					debug.profileend()

					return
				end

				local v12 = v5
				local Character = LocalPlayer.Character
				local v22 = Character and Character:FindFirstChild("Head")
				local v3

				if v22 then
					local LookVector = v22.CFrame.LookVector
					local v4 = Vector3.new(LookVector.X, 0, LookVector.Z)

					v3 = if v4.Magnitude < 0.01 then nil else v22.CFrame + v4.Unit * v12
				else
					v3 = nil
				end

				if v3 then
					if not v1 then
						v2.Parent = Temporary
						v1 = true
					end

					v2:SetPrimaryPartCFrame(v3)
				else
					if not v1 then
						debug.profileend()

						return
					end

					v2.Parent = nil
					v1 = false
				end

				debug.profileend()
			end)
		end)
	end
end

local function onInput(p1, p2) --[[ onInput | Line: 349 | Upvalues: tryTeleport (copy) ]]
	if p2 then
		return
	end

	if if p1.UserInputType == Enum.UserInputType.MouseButton1 then true else p1.KeyCode == Enum.KeyCode.ButtonR2 then
		tryTeleport()
	end
end

local function setupCharacter(p1) --[[ setupCharacter | Line: 363 | Upvalues: onToolEquipped (copy), v6 (ref), v2 (ref), v7 (ref), v1 (ref) ]]
	p1.ChildAdded:Connect(function(p1) --[[ Line: 364 | Upvalues: onToolEquipped (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		onToolEquipped(p1)
	end)
	p1.ChildRemoved:Connect(function(p1) --[[ Line: 370 | Upvalues: v6 (ref), v2 (ref), v7 (ref), v1 (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		if v6 ~= p1 then
			return
		end

		v6 = nil

		if v2 then
			v2:Destroy()
			v2 = nil
		end

		if v7 then
			v7:Disconnect()
			v7 = nil
		end

		v1 = false
	end)

	for v12, v22 in p1:GetChildren() do
		if v22:IsA("Tool") then
			onToolEquipped(v22)
		end
	end
end

function SetupPreview() --[[ SetupPreview | Line: 383 | Upvalues: v3 (ref) ]]
	local Character = game.Players.LocalPlayer.Character

	if Character ~= nil then
		Character.Archivable = true
		v3 = Character:Clone()
		v3.Parent = game.ReplicatedStorage.Assets
		v3.Name = "ExtraPreview"
		Character.Archivable = false
	end
end
function t3.Init(p1) --[[ Init | Line: 397 ]] end
function t3.Start(p1) --[[ Start | Line: 400 | Upvalues: UserInputService (copy), tryTeleport (copy), LocalPlayer (copy), setupCharacter (copy), v2 (ref), v7 (ref), v1 (ref), v6 (ref) ]]
	UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 401 | Upvalues: tryTeleport (ref) ]]
		if p2 then
			return
		end

		if if p1.UserInputType == Enum.UserInputType.MouseButton1 then true else p1.KeyCode == Enum.KeyCode.ButtonR2 then
			tryTeleport()
		end
	end)

	local Character = LocalPlayer.Character

	if Character then
		setupCharacter(Character)
	end

	if LocalPlayer:HasAppearanceLoaded() ~= true then
		LocalPlayer.CharacterAdded:Connect(function(p13) --[[ Line: 414 | Upvalues: v2 (ref), v7 (ref), v1 (ref), v6 (ref), setupCharacter (ref) ]]
			if v2 then
				v2:Destroy()
				v2 = nil
			end

			if v7 then
				v7:Disconnect()
				v7 = nil
			end

			v1 = false
			v6 = nil
			setupCharacter(p13)
		end)
		LocalPlayer.CharacterAppearanceLoaded:Connect(function(p13) --[[ Line: 420 ]]
			SetupPreview()
		end)

		return
	end

	SetupPreview()
	LocalPlayer.CharacterAdded:Connect(function(p13) --[[ Line: 414 | Upvalues: v2 (ref), v7 (ref), v1 (ref), v6 (ref), setupCharacter (ref) ]]
		if v2 then
			v2:Destroy()
			v2 = nil
		end

		if v7 then
			v7:Disconnect()
			v7 = nil
		end

		v1 = false
		v6 = nil
		setupCharacter(p13)
	end)
	LocalPlayer.CharacterAppearanceLoaded:Connect(function(p13) --[[ Line: 420 ]]
		SetupPreview()
	end)
end

return t3