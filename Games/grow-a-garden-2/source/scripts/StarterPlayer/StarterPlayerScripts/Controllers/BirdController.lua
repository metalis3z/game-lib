--credit to prince games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Robin = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Pets"):WaitForChild("Robin")
local Temporary = workspace:WaitForChild("Temporary")
local v1 = Color3.fromRGB(100, 255, 100)
local v2 = Color3.fromRGB(255, 100, 100)
local v3 = 0
local v4 = nil
local v5 = nil
local v6 = false

local function raycastSkipTransparent(p1, p2, p3) --[[ raycastSkipTransparent | Line: 36 ]]
	for i = 1, 10 do
		local v1 = workspace:Raycast(p1, p2, p3)

		if not v1 then
			break
		end

		if not (v1.Instance.Transparency >= 1) then
			return v1
		end

		local v2 = table.clone(p3.FilterDescendantsInstances)

		table.insert(v2, v1.Instance)
		p3.FilterDescendantsInstances = v2
	end

	return nil
end

function t.Init(p1) --[[ Init | Line: 51 ]] end
function t.Start(p1) --[[ Start | Line: 54 | Upvalues: UserInputService (copy), LocalPlayer (copy) ]]
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 55 | Upvalues: p1 (copy) ]]
		p1:OnInput(p12, p2)
	end)

	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 61 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 66 ]]
	p2.ChildAdded:Connect(function(p12) --[[ Line: 67 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Bird")) then
			return
		end

		p1:EnterPlacingMode()
	end)
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 72 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Bird")) then
			return
		end

		p1:ExitPlacingMode()
	end)

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Bird") then
			p1:EnterPlacingMode()
		end
	end
end
function t.EnterPlacingMode(p1) --[[ EnterPlacingMode | Line: 84 | Upvalues: v6 (ref) ]]
	if not v6 then
		v6 = true
		p1:CreatePreview()
	end
end
function t.ExitPlacingMode(p1) --[[ ExitPlacingMode | Line: 90 | Upvalues: v6 (ref) ]]
	v6 = false
	p1:DestroyPreview()
end
function t.CreatePreview(p1) --[[ CreatePreview | Line: 95 | Upvalues: Robin (copy), Temporary (copy), v4 (ref), v5 (ref), RunService (copy) ]]
	p1:DestroyPreview()

	local BirdPreview = Robin:Clone()

	BirdPreview.Name = "BirdPreview"

	for v1, v2 in BirdPreview:GetDescendants() do
		if v2:IsA("BasePart") then
			if v2.Transparency == 0 then
				v2.Transparency = 0.5
			end

			v2.CanCollide = false
			v2.CanQuery = false
			v2.CanTouch = false
			v2.Anchored = true

			continue
		end

		if v2:IsA("ParticleEmitter") or (v2:IsA("Trail") or v2:IsA("Beam")) then
			v2.Enabled = false
		end
	end

	BirdPreview.Parent = Temporary
	v4 = BirdPreview
	v5 = RunService.RenderStepped:Connect(function() --[[ Line: 116 | Upvalues: p1 (copy) ]]
		debug.profilebegin("Controllers/BirdController/PreviewUpdate")
		p1:UpdatePreview()
		debug.profileend()
	end)
end
function t.DestroyPreview(p1) --[[ DestroyPreview | Line: 123 | Upvalues: v5 (ref), v4 (ref) ]]
	if v5 then
		v5:Disconnect()
		v5 = nil
	end

	if not v4 then
		return
	end

	v4:Destroy()
	v4 = nil
end
function t.SetPreviewColor(p1, p2) --[[ SetPreviewColor | Line: 134 | Upvalues: v4 (ref), v1 (copy), v2 (copy) ]]
	if not v4 then
		return
	end

	local v12 = p2 and v1 or v2

	for v22, v3 in v4:GetDescendants() do
		if v3:IsA("BasePart") then
			v3.Color = v12
		end
	end
end
function t.IsUsingGamepad(p1) --[[ IsUsingGamepad | Line: 144 | Upvalues: UserInputService (copy) ]]
	local v1 = UserInputService:GetLastInputType()

	return if v1 == Enum.UserInputType.Gamepad1 or (v1 == Enum.UserInputType.Gamepad2 or v1 == Enum.UserInputType.Gamepad3) then true else v1 == Enum.UserInputType.Gamepad4
end
function t.GetGamepadPlacementRay(p1) --[[ GetGamepadPlacementRay | Line: 152 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil, nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		return HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0)
	end

	return nil, nil
end
function t.CreateRaycastParams(p1) --[[ CreateRaycastParams | Line: 162 | Upvalues: LocalPlayer (copy), Temporary (copy), v4 (ref) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	local Character = LocalPlayer.Character
	local t = { Temporary }

	if v4 then
		table.insert(t, v4)
	end

	if Character then
		table.insert(t, Character)
	end

	v1.FilterDescendantsInstances = t

	return v1
end
function t.IsValidPlacement(p1, p2) --[[ IsValidPlacement | Line: 173 | Upvalues: CollectionService (copy) ]]
	local v2 = CollectionService:GetTagged("GardenTotalArea")

	if #v2 == 0 then
		return false
	end

	local v3 = RaycastParams.new()

	v3.FilterType = Enum.RaycastFilterType.Include
	v3.FilterDescendantsInstances = v2

	return workspace:Raycast(p2 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0), v3) ~= nil
end
function t.UpdatePreview(p1) --[[ UpdatePreview | Line: 187 | Upvalues: v4 (ref), raycastSkipTransparent (copy), UserInputService (copy), CurrentCamera (copy), Temporary (copy) ]]
	if not v4 then
		return
	end

	local v1 = p1:CreateRaycastParams()
	local v2

	if p1:IsUsingGamepad() then
		local v3, v42 = p1:GetGamepadPlacementRay()

		if not (v3 and v42) then
			v4.Parent = nil

			return
		end

		v2 = raycastSkipTransparent(v3, v42, v1)
	else
		local v6 = UserInputService:GetMouseLocation()
		local v7 = CurrentCamera:ViewportPointToRay(v6.X, v6.Y)

		v2 = raycastSkipTransparent(v7.Origin, v7.Direction * 5000, v1)
	end

	if not v2 then
		v4.Parent = nil

		return
	end

	v4.Parent = Temporary

	local Position = v2.Position

	if not v4.PrimaryPart then
		p1:SetPreviewColor(p1:IsValidPlacement(Position))

		return
	end

	v4:PivotTo(CFrame.new(Position + Vector3.new(0, 14, 0)))
	p1:SetPreviewColor(p1:IsValidPlacement(Position))
end
function t.GetEquippedTool(p1) --[[ GetEquippedTool | Line: 223 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		return Character:FindFirstChildWhichIsA("Tool")
	end

	return nil
end
function t.OnInput(p1, p2, p3) --[[ OnInput | Line: 229 | Upvalues: v6 (ref), v3 (ref), raycastSkipTransparent (copy), CurrentCamera (copy), Networking (copy), LocalPlayer (copy), SoundService (copy) ]]
	if p3 then
		return
	end

	if not v6 then
		return
	end

	if not (if p2.UserInputType == Enum.UserInputType.MouseButton1 or p2.UserInputType == Enum.UserInputType.Touch then true elseif p2.KeyCode == Enum.KeyCode.ButtonR2 then true else false) then
		return
	end

	local v2 = os.clock()

	if v2 - v3 < 0.5 then
		return
	end

	local v32 = p1:GetEquippedTool()

	if not v32 then
		return
	end

	local v4 = v32:GetAttribute("Bird")

	if not v4 then
		return
	end

	local v5 = p1:CreateRaycastParams()
	local v62

	if p1:IsUsingGamepad() then
		local v7, v8 = p1:GetGamepadPlacementRay()

		if not (v7 and v8) then
			return
		end

		v62 = raycastSkipTransparent(v7, v8, v5)
	else
		local Position = p2.Position
		local v10 = CurrentCamera:ScreenPointToRay(Position.X, Position.Y)

		v62 = raycastSkipTransparent(v10.Origin, v10.Direction * 5000, v5)
	end

	if not v62 then
		return
	end

	if not p1:IsValidPlacement(v62.Position) then
		return
	end

	v3 = v2
	Networking.Place.PlaceBird:Fire(v62.Position, v4, v32)

	local Character = LocalPlayer.Character
	local v12 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v12 then
		return
	end

	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://135948019584556"
	Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound.Parent = v12
	Sound:Play()
	game.Debris:AddItem(Sound, 3)
end

return t