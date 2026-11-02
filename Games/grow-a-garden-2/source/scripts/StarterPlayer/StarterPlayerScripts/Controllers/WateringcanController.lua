--credit to leon games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local WateringcanData = require(ReplicatedStorage.SharedModules.WateringcanData)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Water = game.SoundService.SFX.Water
local Temporary = workspace.Temporary
local Baseplate = workspace:FindFirstChild("Baseplate") -- MODDED: no bloquear el boot del controller (Baseplate puede replicar tarde y colgaba el loading)
local v1 = Color3.fromRGB(100, 175, 255)
local v2 = Color3.fromRGB(255, 100, 100)
local v3 = 0
local v4 = nil
local v5 = false
local v6 = nil
local v7 = Color3.fromRGB(100, 175, 255)
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local t2 = {}

local function debugPrint(...) --[[ debugPrint | Line: 71 ]] end

local function debugWarn(...) --[[ debugWarn | Line: 77 ]] end

function t.Init(p1) --[[ Init | Line: 87 | Upvalues: WateringcanData (copy), t2 (copy), debugPrint (copy) ]]
	for v1, v2 in WateringcanData do
		t2[v2.Name] = v2
	end

	debugPrint("Init complete. Loaded", #WateringcanData, "watering can definitions")
end
function t.Start(p1) --[[ Start | Line: 94 | Upvalues: debugPrint (copy), UserInputService (copy), LocalPlayer (copy), Networking (copy) ]]
	debugPrint("Start. TouchEnabled =", UserInputService.TouchEnabled, "| MouseEnabled =", UserInputService.MouseEnabled)
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 98 | Upvalues: p1 (copy) ]]
		p1:OnInputBegan(p12, p2)
	end)
	UserInputService.InputEnded:Connect(function(p12, p2) --[[ Line: 102 | Upvalues: p1 (copy) ]]
		p1:OnInputEnded(p12)
	end)
	UserInputService.TouchTapInWorld:Connect(function(p12, p2) --[[ Line: 109 | Upvalues: debugPrint (ref), p1 (copy) ]]
		if p2 then
			debugPrint("TouchTapInWorld ignored (processed by UI)")

			return
		end

		local v1 = p1:GetEquippedTool()

		if v1 and v1:GetAttribute("WateringCan") then
			debugPrint(("TouchTapInWorld at screen (%.0f, %.0f)"):format(p12.X, p12.Y))
			p1:TryWater(p12)
		else
			debugPrint("TouchTapInWorld ignored (no watering can equipped)")
		end
	end)

	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 129 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	Networking.WateringCan.WateringCanFx.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 133 | Upvalues: debugPrint (ref), p1 (copy) ]]
		local v5, v6, v7

		if p3 then
			v5 = p3.Name

			if v5 then
				v6 = p2
				v7 = p12
			else
				v6 = p2
				v7 = p12
				v5 = "nil"
			end
		else
			v6 = p2
			v7 = p12
			v5 = "nil"
		end

		debugPrint("FX event received:", v6, "at", v7, "from", v5)
		p1:PlayWateringEffect(p12, p2)
		p1:PlayWaterStream(p3, p12, p2)
	end)
end
function t.PlayWateringEffect(p1, p2, p3) --[[ PlayWateringEffect | Line: 144 | Upvalues: t2 (copy), debugWarn (copy), v7 (copy), RunService (copy), Temporary (copy), Water (copy), TweenService (copy), Debris (copy), debugPrint (copy) ]]
	local v1 = t2[p3]
	local v2 = t2[p3] and v1.SplashRadius or 8
	local v3 = v1 and v1.EffectTime or 10

	if not v1 then
		debugWarn("PlayWateringEffect: unknown can name \'" .. tostring(p3) .. "\', using defaults")
	end

	local v4 = Vector3.new(0.15, v2, v2)
	local v5 = Vector3.new(0.15, v2 * 2, v2 * 2)
	local WateringCanFx = game.ReplicatedStorage.Assets.Stud_Part:Clone()

	WateringCanFx.BackSurface = Enum.SurfaceType.Studs
	WateringCanFx.TopSurface = Enum.SurfaceType.Studs
	WateringCanFx.LeftSurface = Enum.SurfaceType.Studs
	WateringCanFx.RightSurface = Enum.SurfaceType.Studs
	WateringCanFx.FrontSurface = Enum.SurfaceType.Studs
	WateringCanFx.BottomSurface = Enum.SurfaceType.Studs
	WateringCanFx.Material = Enum.Material.Glacier
	WateringCanFx.MaterialVariant = "2022 Weld"
	WateringCanFx.Name = "WateringCanFx"
	WateringCanFx.Shape = Enum.PartType.Cylinder
	WateringCanFx.Size = v4
	WateringCanFx.CFrame = CFrame.new(p2 + Vector3.new(0, 0.075, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
	WateringCanFx.Transparency = 1
	WateringCanFx.Color = v7

	local v6 = if p3 == "Super Watering Can" then RunService.RenderStepped:Connect(function() --[[ Line: 178 | Upvalues: WateringCanFx (copy) ]]
	if not (WateringCanFx and WateringCanFx.Parent) then
		return
	end

	WateringCanFx.Color = Color3.fromHSV(os.clock() * 0.5 % 1, 1, 1)
end) else nil

	WateringCanFx.CanCollide = false
	WateringCanFx.CanQuery = false
	WateringCanFx.CanTouch = false
	WateringCanFx.Anchored = true
	WateringCanFx.CastShadow = false
	WateringCanFx.Parent = Temporary

	local WateringCanSFX = Water:Clone()

	WateringCanSFX.Name = "WateringCanSFX"
	WateringCanSFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	WateringCanSFX.RollOffMode = Enum.RollOffMode.InverseTapered
	WateringCanSFX.RollOffMinDistance = 10
	WateringCanSFX.RollOffMaxDistance = 80
	WateringCanSFX.Parent = WateringCanFx
	WateringCanSFX:Play()
	WateringCanSFX.Ended:Once(function() --[[ Line: 200 | Upvalues: WateringCanSFX (copy) ]]
		WateringCanSFX:Destroy()
	end)

	local v72 = TweenService:Create(WateringCanFx, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Transparency = 0.5,
		Size = v5
	})
	local v8 = Vector3.new(0.15, v2 * 2 * 0.6, v2 * 2 * 0.6)
	local v9 = TweenService:Create(WateringCanFx, TweenInfo.new(v3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
		Transparency = 0.8,
		Size = v8
	})
	local v10 = TweenService:Create(WateringCanFx, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Transparency = 1
	})

	v72:Play()
	Debris:AddItem(v72, 1.3)
	task.delay(0.3, function() --[[ Line: 228 | Upvalues: WateringCanFx (copy), v9 (copy), Debris (ref), v3 (copy) ]]
		if not (WateringCanFx and WateringCanFx.Parent) then
			return
		end

		v9:Play()
		Debris:AddItem(v9, v3 + 1)
	end)
	task.delay(0.3 + v3, function() --[[ Line: 235 | Upvalues: WateringCanFx (copy), v10 (copy), Debris (ref) ]]
		if not (WateringCanFx and WateringCanFx.Parent) then
			return
		end

		v10:Play()
		Debris:AddItem(v10, 1.2)
	end)
	task.delay(0.3 + v3 + 0.2, function() --[[ Line: 242 | Upvalues: v6 (ref), WateringCanFx (copy), debugPrint (ref) ]]
		if v6 then
			v6:Disconnect()
			v6 = nil
		end

		if WateringCanFx and WateringCanFx.Parent then
			WateringCanFx:Destroy()
		end

		debugPrint("Puddle FX cleaned up")
	end)
end
Color3.fromRGB(100, 175, 255)
function t.PlayWaterStream(p1, p2, p3, p4) --[[ PlayWaterStream | Line: 261 | Upvalues: debugWarn (copy), t2 (copy), Temporary (copy), RunService (copy), TweenService (copy), Debris (copy) ]]
	if not p2 then
		return
	end

	local Character = p2.Character

	if not Character then
		debugWarn("PlayWaterStream: no character for", p2.Name)

		return
	end

	local v2 = t2[p4] and t2[p4].SplashRadius or 8
	local v3 = Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
	local v4

	if v3 and v3:IsA("BasePart") then
		v4 = (v3.CFrame * CFrame.new(0, -v3.Size.Y / 2 - 2, 0.65)).Position
	else
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
			debugWarn("PlayWaterStream: no arm or HumanoidRootPart found")

			return
		end

		v4 = HumanoidRootPart.Position + Vector3.new(0, 1, 0)
	end

	task.spawn(function() --[[ Line: 288 | Upvalues: p4 (copy), v2 (copy), p3 (copy), Temporary (ref), RunService (ref), v4 (ref), TweenService (ref), Debris (ref) ]]
		local t = {}
		local t2 = {}
		local t3 = {}
		local v1 = p4 == "Super Watering Can"

		for i = 1, 12 do
			local v22 = math.random() * math.pi * 2
			local v3 = math.random() * v2
			local v7 = p3 + Vector3.new(math.cos(v22) * v3, -3, math.sin(v22) * v3)
			local v13 = CFrame.Angles(math.rad((math.random(0, 360))), math.rad((math.random(0, 360))), (math.rad((math.random(0, 360)))))
			local v14 = game.ReplicatedStorage.Assets.Stud_Part:Clone()

			v14.BackSurface = Enum.SurfaceType.Studs
			v14.TopSurface = Enum.SurfaceType.Studs
			v14.LeftSurface = Enum.SurfaceType.Studs
			v14.RightSurface = Enum.SurfaceType.Studs
			v14.FrontSurface = Enum.SurfaceType.Studs
			v14.BottomSurface = Enum.SurfaceType.Studs
			v14.Material = Enum.Material.Glacier
			v14.MaterialVariant = "2022 Weld"
			v14.Color = v1 and Color3.fromHSV(v14.Position.Y % 6 / 6, 1, 1) or Color3.new(0, 0.666667, 1)
			v14.Size = Vector3.new(1, 1, 1)
			v14.Transparency = 0.3
			v14.Anchored = true
			v14.CanCollide = false
			v14.CanQuery = false
			v14.CanTouch = false
			v14.CastShadow = false
			v14.Parent = Temporary
			table.insert(t, v14)
			table.insert(t2, v7)
			table.insert(t3, v13)
		end

		local v16 = 0
		local v17 = nil

		v17 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 340 | Upvalues: v16 (ref), t (copy), t2 (copy), v4 (ref), t3 (copy), v1 (copy), v17 (ref), TweenService (ref), Debris (ref) ]]
			v16 = v16 + p1

			local v12 = true

			for v2, v3 in t do
				local v42 = t2[v2]
				local v7 = math.clamp(v16 / 0.4 - (v2 - 1) / 12 * 0.6, 0, 1)

				if v7 < 1 then
					v12 = false
				end

				v3.CFrame = CFrame.new((1 - v7) * (1 - v7) * v4 + (1 - v7) * 2 * v7 * ((v4 + v42) / 2 + Vector3.new(0, 8, 0)) + v7 * v7 * v42) * t3[v2]
				v3.Transparency = v7 * 0.4 + 0.3

				if v1 then
					v3.Color = Color3.fromHSV(v3.Position.Y % 6 / 6, 1, 1)
				end

				v3.Size = Vector3.new(1, 1, 1) * (1 - v7 * 0.5)
			end

			if not v12 then
				return
			end

			v17:Disconnect()

			local v9 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

			for v10, v11 in t do
				local v122 = TweenService:Create(v11, v9, {
					Transparency = 1,
					Size = Vector3.new(0.1, 0.1, 0.1)
				})

				v122:Play()
				Debris:AddItem(v122, v9.Time)
			end

			task.delay(0.35, function() --[[ Line: 381 | Upvalues: t (ref) ]]
				for v1, v2 in t do
					v2:Destroy()
				end
			end)
		end)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 393 | Upvalues: debugPrint (copy) ]]
	debugPrint("SetupCharacter for", p2.Name)
	p2.ChildAdded:Connect(function(p12) --[[ Line: 396 | Upvalues: debugPrint (ref), p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("WateringCan")) then
			return
		end

		debugPrint("Watering can equipped:", p12:GetAttribute("WateringCan"))
		p1:CreatePreview(p12:GetAttribute("WateringCan"))
	end)
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 403 | Upvalues: debugPrint (ref), p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("WateringCan")) then
			return
		end

		debugPrint("Watering can unequipped:", p12:GetAttribute("WateringCan"))
		p1:DestroyPreview()
		p1:StopHold()
	end)

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("WateringCan") then
			p1:CreatePreview(v2:GetAttribute("WateringCan"))
		end
	end
end
function t.IsTouchInput(p1) --[[ IsTouchInput | Line: 418 | Upvalues: UserInputService (copy) ]]
	return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end
function t.GetFacingTargetPosition(p1) --[[ GetFacingTargetPosition | Line: 422 | Upvalues: LocalPlayer (copy), CurrentCamera (copy), UserInputService (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
		return nil
	end

	if p1:IsUsingGamepad() then
		local LookVector = CurrentCamera.CFrame.LookVector
		local v1 = Vector3.new(LookVector.X, 0, LookVector.Z)

		if v1.Magnitude < 0.001 then
			return nil
		end

		return HumanoidRootPart.Position + v1.Unit * 10
	end

	if p1:IsTouchInput() then
		return nil
	end

	local v2 = UserInputService:GetMouseLocation()
	local v3 = CurrentCamera:ViewportPointToRay(v2.X, v2.Y)
	local Origin = v3.Origin
	local Direction = v3.Direction

	if math.abs(Direction.Y) < 0.001 then
		return nil
	end

	local v4 = (HumanoidRootPart.Position.Y - Origin.Y) / Direction.Y

	if v4 < 0 then
		return nil
	end

	return Origin + Direction * v4
end
function t.UpdateFacing(p1) --[[ UpdateFacing | Line: 450 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not (HumanoidRootPart and (HumanoidRootPart:IsA("BasePart") and Humanoid)) then
		return
	end

	if Humanoid.Health <= 0 then
		return
	end

	if Humanoid.Sit then
		return
	end

	local v1 = p1:GetFacingTargetPosition()

	if not v1 then
		Humanoid.AutoRotate = true

		return
	end

	local v2 = Vector3.new(v1.X, HumanoidRootPart.Position.Y, v1.Z)

	if (v2 - HumanoidRootPart.Position).Magnitude < 0.1 then
		Humanoid.AutoRotate = true
	else
		Humanoid.AutoRotate = false
		HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, v2)
	end
end
function t.EnableCharacterFacing(p1) --[[ EnableCharacterFacing | Line: 477 | Upvalues: v11 (ref), RunService (copy) ]]
	p1:DisableCharacterFacing()
	v11 = RunService.RenderStepped:Connect(function() --[[ Line: 480 | Upvalues: p1 (copy) ]]
		p1:UpdateFacing()
	end)
end
function t.DisableCharacterFacing(p1) --[[ DisableCharacterFacing | Line: 485 | Upvalues: v11 (ref), LocalPlayer (copy) ]]
	if v11 then
		v11:Disconnect()
		v11 = nil
	end

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	Humanoid.AutoRotate = true
end
function t.CreatePreview(p1, p2) --[[ CreatePreview | Line: 500 | Upvalues: debugPrint (copy), v10 (ref), t2 (copy), debugWarn (copy), v8 (ref), v1 (copy), Temporary (copy), v9 (ref), RunService (copy) ]]
	p1:DestroyPreview()
	debugPrint("CreatePreview for", p2)
	v10 = t2[p2]

	if not v10 then
		debugWarn("CreatePreview: no data found for \'" .. tostring(p2) .. "\', using default radius")
	end

	if p1:IsTouchInput() then
		debugPrint("CreatePreview skipped (mobile) - no preview, no facing")

		return
	end

	local v12 = if v10 then v10.SplashRadius or 8 else 8

	v8 = game.ReplicatedStorage.Assets.Stud_Part:Clone()
	v8.BackSurface = Enum.SurfaceType.Studs
	v8.TopSurface = Enum.SurfaceType.Studs
	v8.LeftSurface = Enum.SurfaceType.Studs
	v8.RightSurface = Enum.SurfaceType.Studs
	v8.FrontSurface = Enum.SurfaceType.Studs
	v8.BottomSurface = Enum.SurfaceType.Studs
	v8.Material = Enum.Material.Glacier
	v8.MaterialVariant = "2022 Weld"
	v8.Name = "WateringCanPreview"
	v8.Shape = Enum.PartType.Cylinder
	v8.Size = Vector3.new(0.15, v12 * 2, v12 * 2)
	v8.CFrame = CFrame.Angles(0, 0, 1.5707963267948966)
	v8.Transparency = 0.6
	v8.Color = v1
	v8.CanCollide = false
	v8.CanQuery = false
	v8.CanTouch = false
	v8.Anchored = true
	v8.CastShadow = false
	v8.Parent = Temporary
	v9 = RunService.RenderStepped:Connect(function() --[[ Line: 545 | Upvalues: p1 (copy) ]]
		p1:UpdatePreview()
	end)
	p1:EnableCharacterFacing()
end
function t.DestroyPreview(p1) --[[ DestroyPreview | Line: 552 | Upvalues: v8 (ref), debugPrint (copy), v9 (ref), v10 (ref) ]]
	if v8 then
		debugPrint("DestroyPreview")
		v8:Destroy()
		v8 = nil
	end

	if not v9 then
		v10 = nil
		p1:DisableCharacterFacing()

		return
	end

	v9:Disconnect()
	v9 = nil
	v10 = nil
	p1:DisableCharacterFacing()
end
function t.SetPreviewColor(p1, p2) --[[ SetPreviewColor | Line: 569 | Upvalues: v8 (ref), v1 (copy), v2 (copy) ]]
	if not v8 then
		return
	end

	v8.Color = p2 and v1 or v2
end
function t.IsUsingGamepad(p1) --[[ IsUsingGamepad | Line: 578 | Upvalues: UserInputService (copy) ]]
	local v1 = UserInputService:GetLastInputType()

	return if v1 == Enum.UserInputType.Gamepad1 or (v1 == Enum.UserInputType.Gamepad2 or v1 == Enum.UserInputType.Gamepad3) then true else v1 == Enum.UserInputType.Gamepad4
end
function t.GetGamepadPlacementRay(p1) --[[ GetGamepadPlacementRay | Line: 586 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		return HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0)
	end

	return nil
end
function t.CreateRaycastParams(p1) --[[ CreateRaycastParams | Line: 601 | Upvalues: CollectionService (copy), Baseplate (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Include

	local v2 = CollectionService:GetTagged("PlantArea")

	if not Baseplate then
		Baseplate = workspace:FindFirstChild("Baseplate") -- lazy: por si no estaba al cargar el módulo
	end
	if Baseplate then
		table.insert(v2, Baseplate)
	end
	v1.FilterDescendantsInstances = v2

	return v1
end
function t.IsValidPlacement(p1, p2) --[[ IsValidPlacement | Line: 612 | Upvalues: CollectionService (copy) ]]
	return CollectionService:HasTag(p2, "PlantArea")
end
function t.UpdatePreview(p1) --[[ UpdatePreview | Line: 616 | Upvalues: v8 (ref), UserInputService (copy), CurrentCamera (copy), Temporary (copy), v10 (ref) ]]
	if not v8 then
		return
	end

	local v1 = p1:CreateRaycastParams()
	local v2

	if p1:IsUsingGamepad() then
		local v3, v4 = p1:GetGamepadPlacementRay()

		if not v3 then
			v8.Parent = nil

			return
		end

		v2 = workspace:Raycast(v3, v4, v1)
	else
		local v6 = UserInputService:GetMouseLocation()
		local v7 = CurrentCamera:ViewportPointToRay(v6.X, v6.Y)

		v2 = workspace:Raycast(v7.Origin, v7.Direction * 5000, v1)
	end

	if not v2 then
		v8.Parent = nil

		return
	end

	v8.Parent = Temporary

	local v9 = p1:IsValidPlacement(v2.Instance)

	v8.CFrame = CFrame.new(v2.Position + Vector3.new(0, -0.225, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)

	if v9 and (v10 and v10.Name == "Super Watering Can") then
		v8.Color = Color3.fromHSV(os.clock() * 0.5 % 1, 1, 1)
	else
		p1:SetPreviewColor(v9)
	end
end
function t.GetEquippedTool(p1) --[[ GetEquippedTool | Line: 655 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		return Character:FindFirstChildWhichIsA("Tool")
	end

	return nil
end
function t.IsValidWateringInput(p1, p2) --[[ IsValidWateringInput | Line: 664 ]]
	return if p2.UserInputType == Enum.UserInputType.MouseButton1 then true else p2.KeyCode == Enum.KeyCode.ButtonR2
end
function t.TryWater(p1, p2) --[[ TryWater | Line: 677 | Upvalues: v3 (ref), debugPrint (copy), UserInputService (copy), CurrentCamera (copy), Networking (copy) ]]
	local v1 = os.clock()

	if v1 - v3 < 0.5 then
		debugPrint(("TryWater blocked: cooldown (%.2fs remaining)"):format(0.5 - (v1 - v3)))

		return false
	end

	local v2 = p1:GetEquippedTool()

	if not v2 then
		debugPrint("TryWater blocked: no tool equipped")

		return false
	end

	local v32 = v2:GetAttribute("WateringCan")

	if not v32 then
		debugPrint("TryWater blocked: equipped tool is not a watering can")

		return false
	end

	local v4 = p1:CreateRaycastParams()
	local v5

	if p1:IsUsingGamepad() then
		local v6, v7 = p1:GetGamepadPlacementRay()

		if not v6 then
			debugPrint("TryWater blocked: gamepad ray unavailable (no character?)")

			return false
		end

		v5 = workspace:Raycast(v6, v7, v4)
	else
		local v9 = if p2 then p2 else UserInputService:GetMouseLocation()
		local v10 = CurrentCamera:ViewportPointToRay(v9.X, v9.Y)

		v5 = workspace:Raycast(v10.Origin, v10.Direction * 5000, v4)
	end

	if not v5 then
		debugPrint("TryWater blocked: raycast hit nothing")

		return false
	end

	if p1:IsValidPlacement(v5.Instance) then
		v3 = v1
		debugPrint(("Watering with \'%s\' at (%.1f, %.1f, %.1f)"):format(v32, v5.Position.X, v5.Position.Y, v5.Position.Z))
		Networking.WateringCan.UseWateringCan:Fire(v5.Position - Vector3.new(0, 0.3, 0), v32, v2)

		return true
	end

	debugPrint("TryWater blocked: hit", v5.Instance:GetFullName(), "(not tagged \'PlantArea\')")

	return false
end
function t.StopHold(p1) --[[ StopHold | Line: 733 | Upvalues: v5 (ref), debugPrint (copy), v4 (ref), v6 (ref) ]]
	if v5 then
		debugPrint("Hold stopped")
	end

	v5 = false
	v4 = nil

	if not v6 then
		return
	end

	v6:Disconnect()
	v6 = nil
end
function t.OnInputBegan(p1, p2, p3) --[[ OnInputBegan | Line: 745 | Upvalues: debugPrint (copy), v4 (ref), v5 (ref), v6 (ref), RunService (copy) ]]
	if p3 then
		return
	end

	if not p1:IsValidWateringInput(p2) then
		return
	end

	local v1 = debugPrint

	v1("InputBegan:", p2.UserInputType.Name, if p2.KeyCode == Enum.KeyCode.Unknown then "" else p2.KeyCode.Name or "")
	p1:TryWater()
	v4 = os.clock()
	v5 = true

	local v52

	if not v6 then
		v52 = v4
		v6 = RunService.Heartbeat:Connect(function() --[[ Line: 766 | Upvalues: v5 (ref), v4 (ref), v52 (copy), p1 (copy), debugPrint (ref) ]]
			if not v5 or v4 ~= v52 then
				p1:StopHold()

				return
			end

			local v1 = p1:GetEquippedTool()

			if not (v1 and v1:GetAttribute("WateringCan")) then
				debugPrint("Hold cancelled: tool unequipped mid-hold")
				p1:StopHold()

				return
			end

			if not (os.clock() - v4 < 1) then
				p1:TryWater()
			end
		end)

		return
	end

	v6:Disconnect()
	v6 = nil
	v52 = v4
	v6 = RunService.Heartbeat:Connect(function() --[[ Line: 766 | Upvalues: v5 (ref), v4 (ref), v52 (copy), p1 (copy), debugPrint (ref) ]]
		if not v5 or v4 ~= v52 then
			p1:StopHold()

			return
		end

		local v1 = p1:GetEquippedTool()

		if not (v1 and v1:GetAttribute("WateringCan")) then
			debugPrint("Hold cancelled: tool unequipped mid-hold")
			p1:StopHold()

			return
		end

		if not (os.clock() - v4 < 1) then
			p1:TryWater()
		end
	end)
end
function t.OnInputEnded(p1, p2) --[[ OnInputEnded | Line: 788 ]]
	if p1:IsValidWateringInput(p2) then
		p1:StopHold()
	end
end

return t