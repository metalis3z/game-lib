--credit to leon games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local Environment = require(ReplicatedStorage.SharedModules.Environment)
local MessagePrompt = require(ReplicatedStorage.ClientModules.MessagePrompt)
local PlayerStateClient = require(ReplicatedStorage.ClientModules.PlayerStateClient)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local t2 = { "Dig it up", "Cancel" }
local v1 = nil
local v2 = false
local v3 = false

LocalPlayer:WaitForChild("HideCollectProximityPrompts")

local Gardens = workspace:WaitForChild("Gardens")
local GardenZoneData = ReplicatedStorage:WaitForChild("GardenZoneData")
local Gnomes = workspace:WaitForChild("Gnomes")
local v4 = nil
local v5 = 0
local v6 = false
local v7 = nil
local v8 = 0
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local t3 = {}
local v14 = RunService:IsStudio() or Environment.env == "Dev"

local function dbgHit(...) --[[ dbgHit | Line: 59 | Upvalues: v14 (copy) ]]
	if not v14 then
		return
	end

	print("[ShovelController:Hit]", ...)
end

local function profileBegin(p1) --[[ profileBegin | Line: 67 ]]
	debug.profilebegin("Controllers/ShovelController/" .. p1)
end

local function profileEnd() --[[ profileEnd | Line: 71 ]]
	debug.profileend()
end

local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil

local function getGnomeVisuals() --[[ getGnomeVisuals | Line: 85 | Upvalues: v4 (ref) ]]
	if v4 then
		return v4
	end

	v4 = workspace:FindFirstChild("GnomeVisuals")

	return v4
end

local function playAnimation() --[[ playAnimation | Line: 97 | Upvalues: LocalPlayer (copy), v21 (ref) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	local Animator = Humanoid:FindFirstChildOfClass("Animator")

	if Animator then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = "rbxassetid://78592768207309"
		v21 = Animator:LoadAnimation(Animation)
		v21.Looped = false
		v21.Priority = Enum.AnimationPriority.Action4
		v21:Play()
	end
end

local function stopAnimation() --[[ stopAnimation | Line: 114 | Upvalues: v21 (ref) ]]
	if not v21 then
		return
	end

	v21:Stop()
end

local function hasDugBefore() --[[ hasDugBefore | Line: 120 | Upvalues: v2 (ref), v1 (ref) ]]
	if v2 then
		return true
	end

	return v1 and v1.Data.HasShoveledPlant == true and true or false
end

local TweenService = game:GetService("TweenService")
local v22 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

function t.Init(p1) --[[ Init | Line: 129 | Upvalues: Networking (copy), TweenService (copy), v22 (copy) ]]
	Networking.ShovelFX.Protected.OnClientEvent:Connect(function(p1) --[[ Line: 130 | Upvalues: TweenService (ref), v22 (ref) ]]
		local v1 = game.Players:FindFirstChild(p1)

		if not v1 then
			return
		end

		local Character = v1.Character

		if not Character then
			return
		end

		if Character:FindFirstChild("HitHighlight") then
			return
		end

		local HitHighlight = Instance.new("Highlight")

		HitHighlight.Name = "HitHighlight"
		HitHighlight.Parent = Character
		HitHighlight.FillTransparency = 0
		HitHighlight.FillColor = Color3.new(255/255, 255/255, 255/255)
		HitHighlight.OutlineTransparency = 1

		local v2 = TweenService:Create(HitHighlight, v22, {
			FillTransparency = 1
		})

		v2:Play()
		game.Debris:AddItem(v2, v22.Time)
		game.Debris:AddItem(HitHighlight, v22.Time)
	end)
end
function t.GetHoldProgressGui(p1) --[[ GetHoldProgressGui | Line: 151 | Upvalues: v10 (ref), LocalPlayer (copy), v11 (ref), v12 (ref) ]]
	if v10 then
		return v10
	end

	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local ShovelHoldProgress = Instance.new("ScreenGui")

	ShovelHoldProgress.Name = "ShovelHoldProgress"
	ShovelHoldProgress.ResetOnSpawn = false
	ShovelHoldProgress.IgnoreGuiInset = true
	ShovelHoldProgress.DisplayOrder = 200

	local Ring = Instance.new("Frame")

	Ring.Name = "Ring"
	Ring.AnchorPoint = Vector2.new(0.5, 0.5)
	Ring.Size = UDim2.fromOffset(64, 64)
	Ring.BackgroundTransparency = 1
	Ring.Visible = false
	Ring.Parent = ShovelHoldProgress

	local Background = Instance.new("ImageLabel")

	Background.Name = "Background"
	Background.Size = UDim2.fromScale(1, 1)
	Background.BackgroundTransparency = 1
	Background.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
	Background.ImageColor3 = Color3.fromRGB(120, 20, 20)
	Background.ImageTransparency = 0.62
	Background.Parent = Ring

	local function createHalf(p1, p2) --[[ createHalf | Line: 180 | Upvalues: Ring (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.Name = p1
		Frame.Size = UDim2.fromScale(0.5, 1)
		Frame.Position = p2 and UDim2.fromScale(0.5, 0) or UDim2.new()
		Frame.BackgroundTransparency = 1
		Frame.ClipsDescendants = true
		Frame.Parent = Ring

		local ProgressBarImage = Instance.new("ImageLabel")

		ProgressBarImage.Name = "ProgressBarImage"
		ProgressBarImage.Size = UDim2.fromScale(2, 1)
		ProgressBarImage.Position = p2 and UDim2.fromScale(-1, 0) or UDim2.new()
		ProgressBarImage.BackgroundTransparency = 1
		ProgressBarImage.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
		ProgressBarImage.ImageColor3 = Color3.fromRGB(255, 60, 60)
		ProgressBarImage.Parent = Frame

		local UIGradient = Instance.new("UIGradient")

		UIGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.499, 0),
			NumberSequenceKeypoint.new(0.5, 1),
			NumberSequenceKeypoint.new(1, 1)
		})
		UIGradient.Parent = ProgressBarImage

		return Frame, UIGradient
	end

	local _, v1 = createHalf("RightGradient", true)
	local _2, v2 = createHalf("LeftGradient", false)
	local Progress = Instance.new("NumberValue")

	Progress.Name = "Progress"
	Progress.Value = 0
	Progress.Parent = Ring
	Progress.Changed:Connect(function(p1) --[[ Line: 217 | Upvalues: v1 (copy), v2 (copy) ]]
		local v12 = math.clamp(p1 * 360, 0, 360)

		v1.Rotation = math.clamp(v12, 0, 180)
		v2.Rotation = math.clamp(v12, 180, 360)
	end)
	ShovelHoldProgress.Parent = PlayerGui
	v10 = ShovelHoldProgress
	v11 = Ring
	v12 = Progress

	return ShovelHoldProgress
end
function t.HideHoldProgress(p1) --[[ HideHoldProgress | Line: 232 | Upvalues: v9 (ref), v13 (ref), v11 (ref), v12 (ref) ]]
	if v9 then
		v9:Disconnect()
		v9 = nil
	end

	v13 = nil

	if v11 then
		v11.Visible = false
	end

	if not v12 then
		return
	end

	v12.Value = 0
end
function t.ShouldHoldToDelete(p1) --[[ ShouldHoldToDelete | Line: 246 | Upvalues: v17 (ref) ]]
	if not v17 then
		return false
	end

	if v17.isPlayer then
		return false
	end

	return v17.isGnome or (v17.isFruit or v17.plantId ~= nil)
end
function t.ShowHoldProgress(p1) --[[ ShowHoldProgress | Line: 256 | Upvalues: v11 (ref), UserInputService (copy) ]]
	p1:GetHoldProgressGui()

	if v11 then
		local v1 = UserInputService:GetMouseLocation()

		v11.Position = UDim2.fromOffset(v1.X, v1.Y)
		v11.Visible = true
	end
end
function t.StartDeleteHold(p1) --[[ StartDeleteHold | Line: 266 | Upvalues: v13 (ref), v16 (ref), v9 (ref), RunService (copy), v6 (ref), UserInputService (copy), v11 (ref), v5 (ref), v12 (ref) ]]
	p1:HideHoldProgress()
	v13 = v16
	p1:ShowHoldProgress()
	v9 = RunService.RenderStepped:Connect(function() --[[ Line: 270 | Upvalues: v6 (ref), p1 (copy), v13 (ref), v16 (ref), UserInputService (ref), v11 (ref), v5 (ref), v12 (ref) ]]
		if not v6 then
			p1:HideHoldProgress()

			return
		end

		if not v13 or v13 ~= v16 then
			p1:HideHoldProgress()

			return
		end

		if not p1:ShouldHoldToDelete() then
			p1:HideHoldProgress()

			return
		end

		local v1 = UserInputService:GetMouseLocation()

		if v11 then
			v11.Position = UDim2.fromOffset(v1.X, v1.Y)
		end

		local v3 = math.clamp((os.clock() - v5) / 0.65, 0, 1)

		if v12 then
			v12.Value = v3
		end

		if not (v3 >= 1) then
			return
		end

		p1:HideHoldProgress()
		p1:ProcessShovelAction()
	end)
end
function t.Start(p1) --[[ Start | Line: 301 | Upvalues: UserInputService (copy), v8 (ref), v19 (ref), dbgHit (copy), v6 (ref), v5 (ref), v7 (ref), RunService (copy), v1 (ref), PlayerStateClient (copy), LocalPlayer (copy), v20 (ref) ]]
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 302 | Upvalues: p1 (copy), v8 (ref), v19 (ref), dbgHit (ref), v6 (ref), v5 (ref), v7 (ref), RunService (ref) ]]
		if p2 then
			return
		end

		local isMouseButton1 = p12.UserInputType == Enum.UserInputType.MouseButton1
		local v1 = if p12.UserInputType == Enum.UserInputType.Touch then true else false

		if not (if isMouseButton1 then isMouseButton1 elseif v1 then v1 elseif p12.KeyCode == Enum.KeyCode.ButtonR2 then true else false) then
			return
		end

		local v4 = os.clock()
		local v52 = p1:ShouldHoldToDelete()
		local v62 = v4 - v8

		if v52 or not (v62 < 0.65) then
			v6 = true
			v5 = v4

			if v1 then
				if not v52 then
					return
				end

				p1:StartDeleteHold()
			else
				if v52 then
					dbgHit("input routed to hold-to-delete (plant/fruit/gnome highlighted) - no player hit detection this click")
					p1:StartDeleteHold()

					return
				end

				p1:ProcessShovelAction()

				if v7 then
					return
				end

				v7 = RunService.Heartbeat:Connect(function() --[[ Line: 346 | Upvalues: v6 (ref), v5 (ref), p1 (ref), v8 (ref) ]]
					debug.profilebegin("Controllers/ShovelController/AutoShovel")

					if v6 and os.clock() - v5 >= 1 and (not p1:ShouldHoldToDelete() and os.clock() - v8 >= 0.1) then
						p1:ProcessShovelAction()
					end

					debug.profileend()
				end)
			end
		else
			if not v19 then
				return
			end

			dbgHit(("input ignored: client swing cooldown (%.2fs since last, need %.2fs)"):format(v62, 0.65))
		end
	end)
	UserInputService.InputEnded:Connect(function(p12) --[[ Line: 364 | Upvalues: v6 (ref), p1 (copy), v7 (ref) ]]
		if not (if p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch then true else p12.KeyCode == Enum.KeyCode.ButtonR2) then
			return
		end

		v6 = false
		p1:HideHoldProgress()

		if not v7 then
			return
		end

		v7:Disconnect()
		v7 = nil
	end)
	UserInputService.TouchTapInWorld:Connect(function(p12, p2) --[[ Line: 379 | Upvalues: v8 (ref), p1 (copy) ]]
		if p2 then
			return
		end

		if os.clock() - v8 < 0.65 then
			return
		end

		if not p1:ShouldHoldToDelete() then
			p1:ProcessShovelAction()
		end
	end)
	task.spawn(function() --[[ Line: 390 | Upvalues: v1 (ref), PlayerStateClient (ref) ]]
		v1 = PlayerStateClient:WaitForLocalReplica(30)
	end)

	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 396 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	LocalPlayer:GetAttributeChangedSignal("PlotId"):Connect(function() --[[ Line: 397 | Upvalues: v20 (ref) ]]
		v20 = nil
	end)
end
function t.ActivateHitDetection(p1) --[[ ActivateHitDetection | Line: 400 | Upvalues: dbgHit (copy), LocalPlayer (copy), Networking (copy), Players (copy), t3 (copy) ]]
	local v1 = p1:GetEquippedTool()

	if not v1 then
		return
	end

	local t = {}
	local t2 = {}
	local t4 = {}
	local t5 = {}
	local v2 = if LocalPlayer:GetAttribute("IsInOwnGarden") then "NormalCollision" else "GardenCollision"

	for v3, v4 in v1:GetDescendants() do
		if v4:IsA("BasePart") and v4.Name ~= v2 then
			table.insert(t5, v4)
		end
	end

	dbgHit(("swing started: listening on %d shovel part(s) for %.2fs (ignoring \'%s\' parts)"):format(#t5, 0.4, v2))

	if #t5 == 0 then
		dbgHit("WARNING: 0 hittable parts on the shovel - Touched can never fire, no player can be hit this swing")
	end

	Networking.Shovel.SwingShovel:Fire()

	local Character = LocalPlayer.Character
	local v5 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if v5 then
		local _PetVisualClient = workspace:FindFirstChild("_PetVisualClient")
		local v6 = if _PetVisualClient then _PetVisualClient:FindFirstChild("Models") else _PetVisualClient

		if v6 then
			local Position = v5.Position

			for k, v in pairs(v6:GetChildren()) do
				local v7 = v:GetAttribute("PetID")
				local v8 = v:GetAttribute("Owner")

				if typeof(v7) == "string" and (v7 ~= "" and (typeof(v8) == "string" and v8 ~= LocalPlayer.Name)) then
					local PrimaryPart = v.PrimaryPart

					if PrimaryPart and not ((PrimaryPart.Position - Position).Magnitude > 8) then
						local v9 = Players:FindFirstChild(v8)

						if v9 then
							t4[v7] = true
							Networking.Pets.ScarePet:Fire(v9.UserId, v7)
						end
					end
				end
			end
		end
	end

	for v10, v11 in t5 do
		local v12 = v11.Touched:Connect(function(p1) --[[ Line: 456 | Upvalues: t4 (copy), Players (ref), LocalPlayer (ref), Networking (ref), t2 (copy), t3 (ref), dbgHit (ref) ]]
			local v1 = p1:FindFirstAncestorWhichIsA("Model")

			if not v1 then
				return
			end

			local v2 = v1:GetAttribute("Owner")
			local v3 = v1:GetAttribute("PetID")

			if typeof(v2) == "string" and (typeof(v3) == "string" and v3 ~= "") then
				if t4[v3] then
					return
				end

				local v4 = Players:FindFirstChild(v2)

				if not v4 then
					return
				end

				if v4 ~= LocalPlayer then
					t4[v3] = true
					Networking.Pets.ScarePet:Fire(v4.UserId, v3)
				end
			else
				local v5 = Players:GetPlayerFromCharacter(v1)

				if not v5 or v5 == LocalPlayer then
					return
				end

				if t2[v5] then
					return
				end

				local v6 = os.clock()

				if t3[v5] and v6 - t3[v5] < 0.5 then
					dbgHit(("touched %s but per-target cooldown active (%.2fs since last, need %.2fs) - not firing HitPlayer"):format(v5.Name, v6 - t3[v5], 0.5))

					return
				end

				t2[v5] = true
				t3[v5] = v6

				local v7 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart")

				if v7 and HumanoidRootPart then
					local v8 = HumanoidRootPart.Position - v7.Position

					dbgHit(("touched %s -> firing HitPlayer (client dist %.1f, facing dot %.2f). Server requires dist <= 12 and dot >= 0.3"):format(v5.Name, (HumanoidRootPart.Position - v7.Position).Magnitude, v8.Magnitude > 0.001 and v8.Unit:Dot(v7.CFrame.LookVector) or 1))
				else
					dbgHit("touched", v5.Name, "-> firing HitPlayer")
				end

				Networking.Shovel.HitPlayer:Fire(v5.UserId)
			end
		end)

		table.insert(t, v12)
	end

	task.delay(0.4, function() --[[ Line: 503 | Upvalues: t (copy), t2 (copy), dbgHit (ref) ]]
		for v1, v2 in t do
			v2:Disconnect()
		end

		if next(t2) ~= nil then
			return
		end

		dbgHit(("swing window closed after %.2fs: shovel never touched another player\'s character (check reach, CanTouch, collision groups, swing animation timing vs window)"):format(0.4))
	end)
end
function t.ProcessShovelAction(p1) --[[ ProcessShovelAction | Line: 513 | Upvalues: dbgHit (copy), v17 (ref), v8 (ref), playAnimation (copy), v16 (ref), Networking (copy), v2 (ref), v1 (ref), v3 (ref), MessagePrompt (copy), t2 (copy) ]]
	local v12 = p1:GetEquippedTool()

	if not v12 then
		return
	end

	local v22 = v12:GetAttribute("Shovel")

	if not v22 then
		dbgHit("ProcessShovelAction aborted: equipped tool", v12.Name, "has no \'Shovel\' attribute")

		return
	end

	local v32 = v17 and (if v17.plantId == nil then v17.isFruit or v17.isGnome else true)
	local v4 = os.clock()
	local v5 = v4 - v8

	if not v32 then
		if v5 < 0.65 then
			return
		end

		v8 = v4
	end

	playAnimation()

	if v16 and v17 then
		if v17.isPlayer and v17.player then
			p1:ActivateHitDetection()
			p1:ClearHighlight()

			return
		end

		if v17.isGnome and v17.gnomePart then
			Networking.Place.RemoveGnome:Fire(v17.gnomePart)
			p1:ClearHighlight()

			return
		end

		local plantId = v17.plantId
		local v6 = v17.fruitId or ""
		local v7 = if v2 then true elseif v1 and v1.Data.HasShoveledPlant == true then true else false

		if v7 then
			Networking.Shovel.UseShovel:Fire(plantId, v6, v22, v12)
			p1:ActivateHitDetection()

			if not v16 then
				return
			end

			v16:Destroy()
			p1:ClearHighlight()
		elseif not v3 then
			v3 = true

			local v82 = v16

			task.spawn(function() --[[ Line: 568 | Upvalues: MessagePrompt (ref), t2 (ref), v3 (ref), v2 (ref), Networking (ref), plantId (copy), v6 (copy), v22 (copy), v12 (copy), v82 (copy), p1 (copy) ]]
				v3 = false

				if not MessagePrompt.Prompt({
					message = "The Shovel will <b>permanently remove</b> this from your garden. You won\'t get it back.",
					titleOverride = "Dig This Up?",
					yield = true,
					hideClose = true,
					options = t2
				}) then
					return
				end

				v2 = true
				Networking.Shovel.UseShovel:Fire(plantId, v6, v22, v12)

				if v82 then
					v82:Destroy()
				end

				p1:ClearHighlight()
			end)
		end
	else
		p1:ActivateHitDetection()
	end
end
function t.OnInput(p1, p2, p3) --[[ OnInput | Line: 598 | Upvalues: v8 (ref) ]]
	if p3 then
		return
	end

	if not (if p2.UserInputType == Enum.UserInputType.MouseButton1 then true else p2.KeyCode == Enum.KeyCode.ButtonR2) then
		return
	end

	if not (os.clock() - v8 < 0.65) then
		p1:ProcessShovelAction()
	end
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 612 | Upvalues: v19 (ref) ]]
	p2.ChildAdded:Connect(function(p12) --[[ Line: 613 | Upvalues: v19 (ref), p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Shovel")) then
			return
		end

		v19 = p12
		p1:StartHoverDetection()
	end)
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 620 | Upvalues: v19 (ref), p1 (copy) ]]
		if not p12:IsA("Tool") or (not p12:GetAttribute("Shovel") or v19 ~= p12) then
			return
		end

		v19 = nil
		p1:StopHoverDetection()
	end)

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Shovel") then
			v19 = v2
			p1:StartHoverDetection()
		end
	end
end
function t.GetPlayerPlantsFolder(p1) --[[ GetPlayerPlantsFolder | Line: 637 | Upvalues: v20 (ref), LocalPlayer (copy), Gardens (copy) ]]
	if v20 then
		return v20
	end

	local v1 = LocalPlayer:GetAttribute("PlotId")

	if not v1 then
		return nil
	end

	local v2 = Gardens:FindFirstChild("Plot" .. tostring(v1))

	if v2 then
		v20 = v2:FindFirstChild("Plants")

		return v20
	end

	return nil
end
function t.IsPlayerInMyGarden(p1, p2) --[[ IsPlayerInMyGarden | Line: 647 | Upvalues: LocalPlayer (copy), GardenZoneData (copy) ]]
	if p2 == LocalPlayer then
		return false
	end

	local v1 = LocalPlayer:GetAttribute("PlotId")

	if not v1 then
		return false
	end

	local v2 = GardenZoneData:FindFirstChild(p2.Name)

	if not v2 then
		return false
	end

	return v2.Value == v1
end
function t.IsPlayerStealingFromMe(p1, p2) --[[ IsPlayerStealingFromMe | Line: 656 | Upvalues: LocalPlayer (copy) ]]
	return p2 ~= LocalPlayer
end
function t.GetPlayerFromCharacter(p1, p2) --[[ GetPlayerFromCharacter | Line: 661 | Upvalues: Players (copy) ]]
	return Players:GetPlayerFromCharacter(p2)
end
function t.GetNearbyPlayerInGarden(p1) --[[ GetNearbyPlayerInGarden | Line: 665 | Upvalues: LocalPlayer (copy), Players (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil, nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return nil, nil
	end

	local Position = HumanoidRootPart.Position
	local v1 = 7
	local v2 = nil
	local v3 = nil

	for v4, v5 in Players:GetPlayers() do
		if v5 ~= LocalPlayer and (p1:IsPlayerInMyGarden(v5) or p1:IsPlayerStealingFromMe(v5)) then
			local Character2 = v5.Character

			if Character2 then
				local HumanoidRootPart2 = Character2:FindFirstChild("HumanoidRootPart")

				if HumanoidRootPart2 then
					local Magnitude = (HumanoidRootPart2.Position - Position).Magnitude

					if Magnitude < v1 then
						v1 = Magnitude
						v2 = v5
						v3 = Character2
					end
				end
			end
		end
	end

	if v2 and v3 then
		return v3, {
			plantId = nil,
			fruitId = nil,
			isFruit = false,
			isPlayer = true,
			isGnome = false,
			gnomePart = nil,
			player = v2
		}
	end

	return nil, nil
end
function t.GetGnomePartFromVisual(p1, p2) --[[ GetGnomePartFromVisual | Line: 695 | Upvalues: Gnomes (copy) ]]
	return Gnomes:FindFirstChild((string.gsub(p2.Name, "^GnomeVisual_", "")))
end
function t.GetHighlightTarget(p1, p2) --[[ GetHighlightTarget | Line: 700 | Upvalues: v4 (ref), LocalPlayer (copy) ]]
	if not p2 then
		return nil, nil
	end

	local v1 = p2

	while v1 and v1 ~= workspace do
		if not v4 then
			v4 = workspace:FindFirstChild("GnomeVisuals")
		end

		if v1.Parent == v4 and v1:IsA("Model") then
			local v3 = p1:GetGnomePartFromVisual(v1)

			if v3 and v3:GetAttribute("Owner") == LocalPlayer.Name then
				return v1, {
					plantId = nil,
					fruitId = nil,
					isFruit = false,
					isPlayer = false,
					player = nil,
					isGnome = true,
					gnomePart = v3
				}
			end

			return nil, nil
		end

		v1 = v1.Parent
	end

	local v42 = p1:GetPlayerPlantsFolder()

	if not v42 then
		return nil, nil
	end

	local v5 = p2

	while v5 and v5 ~= workspace do
		local v6 = v5.Parent

		if v6 and v6.Name == "Fruits" then
			local v7 = v6.Parent

			if v7 and v7.Parent == v42 then
				return v5, {
					isFruit = true,
					isPlayer = false,
					player = nil,
					isGnome = false,
					gnomePart = nil,
					plantId = v7.Name,
					fruitId = v5.Name
				}
			end
		end

		if v6 == v42 then
			return v5, {
				fruitId = nil,
				isFruit = false,
				isPlayer = false,
				player = nil,
				isGnome = false,
				gnomePart = nil,
				plantId = v5.Name
			}
		end

		v5 = v6
	end

	return nil, nil
end
function t.ClearHighlight(p1) --[[ ClearHighlight | Line: 736 | Upvalues: v15 (ref), v16 (ref), v17 (ref) ]]
	if v15 then
		v15:Destroy()
		v15 = nil
	end

	v16 = nil
	v17 = nil
end
function t.CreateRaycastParams(p1) --[[ CreateRaycastParams | Line: 742 | Upvalues: LocalPlayer (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	local Character = LocalPlayer.Character

	if Character then
		v1.FilterDescendantsInstances = { Character }
	end

	return v1
end
function t.IsPartVisible(p1, p2) --[[ IsPartVisible | Line: 750 ]]
	return p2.Transparency < 1
end
function t.RaycastIgnoreInvisible(p1, p2, p3, p4) --[[ RaycastIgnoreInvisible | Line: 754 | Upvalues: v4 (ref), LocalPlayer (copy) ]]
	local v1, v2, v3 = p2, p3, {}

	for i = 1, 10 do
		local v42 = workspace:Raycast(v1, v2, p4)

		if not v42 then
			break
		end

		if p1:IsPartVisible(v42.Instance) then
			return v42
		end

		if not v4 then
			v4 = workspace:FindFirstChild("GnomeVisuals")
		end

		if v4 then
			if not v4 then
				v4 = workspace:FindFirstChild("GnomeVisuals")
			end

			if v42.Instance:IsDescendantOf(v4) then
				return v42
			end
		end

		table.insert(v3, v42.Instance)
		p4.FilterDescendantsInstances = { LocalPlayer.Character, unpack(v3) }

		local Magnitude = (v42.Position - v1).Magnitude

		v1 = v42.Position + p3.Unit * 0.01
		v2 = p3.Unit * (v2.Magnitude - Magnitude)

		if v2.Magnitude < 0.1 then
			break
		end
	end

	return nil
end
function t.IsUsingGamepad(p1) --[[ IsUsingGamepad | Line: 774 | Upvalues: UserInputService (copy) ]]
	local v1 = UserInputService:GetLastInputType()

	return if v1 == Enum.UserInputType.Gamepad1 or (v1 == Enum.UserInputType.Gamepad2 or v1 == Enum.UserInputType.Gamepad3) then true else v1 == Enum.UserInputType.Gamepad4
end
function t.GetGamepadPlacementRay(p1) --[[ GetGamepadPlacementRay | Line: 779 | Upvalues: LocalPlayer (copy) ]]
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
function t.GetTargetFromRaycast(p1) --[[ GetTargetFromRaycast | Line: 791 | Upvalues: UserInputService (copy), CurrentCamera (copy) ]]
	debug.profilebegin("Controllers/ShovelController/GetTargetFromRaycast")

	local v1 = p1:CreateRaycastParams()
	local v2

	if p1:IsUsingGamepad() then
		local v3, v4 = p1:GetGamepadPlacementRay()

		if not v3 then
			debug.profileend()

			return nil
		end

		v2 = p1:RaycastIgnoreInvisible(v3, v4, v1)
	else
		local v6 = UserInputService:GetMouseLocation()
		local v7 = CurrentCamera:ViewportPointToRay(v6.X, v6.Y)

		v2 = p1:RaycastIgnoreInvisible(v7.Origin, v7.Direction * 5000, v1)
	end

	local v9 = if v2 then v2.Instance or nil else nil

	debug.profileend()

	return v9
end
function t.UpdateHighlightBlink(p1) --[[ UpdateHighlightBlink | Line: 812 | Upvalues: v15 (ref), v6 (ref) ]]
	if not v15 then
		return
	end

	local v1 = if v6 and p1:ShouldHoldToDelete() then 5.2 else 1.8
	local v3 = (math.sin(os.clock() * v1 * math.pi * 2) + 1) * 0.5

	v15.FillTransparency = v3 * 0.4 + 0.35
	v15.OutlineTransparency = v3 * 0.7 + 0.2
end
function t.UpdateHighlight(p1) --[[ UpdateHighlight | Line: 823 | Upvalues: v16 (ref), v15 (ref), v17 (ref) ]]
	debug.profilebegin("Controllers/ShovelController/UpdateHighlight")

	local v1, v2 = p1:GetHighlightTarget((p1:GetTargetFromRaycast()))

	if v1 ~= v16 then
		p1:ClearHighlight()

		if v1 then
			local Highlight = Instance.new("Highlight")

			if v2 and v2.isPlayer then
				Highlight.FillColor = Color3.fromRGB(255, 165, 0)
			elseif v2 and v2.isGnome then
				Highlight.FillColor = Color3.fromRGB(255, 100, 100)
			else
				Highlight.FillColor = Color3.fromRGB(255, 0, 0)
			end

			Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
			Highlight.FillTransparency = 0.35
			Highlight.OutlineTransparency = 0.9
			Highlight.Parent = v1
			Highlight.Adornee = v1
			v15 = Highlight
			v16 = v1
			v17 = v2
		end
	end

	p1:UpdateHighlightBlink()
	debug.profileend()
end
function t.StartHoverDetection(p1) --[[ StartHoverDetection | Line: 848 | Upvalues: v18 (ref), RunService (copy) ]]
	if not v18 then
		v18 = RunService.RenderStepped:Connect(function() --[[ Line: 850 | Upvalues: p1 (copy) ]]
			debug.profilebegin("Controllers/ShovelController/RenderStepped")
			p1:UpdateHighlight()
			debug.profileend()
		end)
	end
end
function t.StopHoverDetection(p1) --[[ StopHoverDetection | Line: 857 | Upvalues: v18 (ref) ]]
	if v18 then
		v18:Disconnect()
		v18 = nil
	end

	p1:HideHoldProgress()
	p1:ClearHighlight()
end
function t.GetEquippedTool(p1) --[[ GetEquippedTool | Line: 863 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		return Character:FindFirstChildWhichIsA("Tool")
	end

	return nil
end

return t