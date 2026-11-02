local CollectionService = game:GetService("CollectionService")
CollectionService:AddTag(script.Parent, "InteractiveBox")

local TweenService = game:GetService("TweenService")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local TouchingPlayers = {}
local Main = script.Parent.Parent
local InUse = script.Parent.InUse

local CloneSuccessful = false

local CloningChamber1 = Main.CloningChamber1
local CloningChamber2 = Main.CloningChamber2
local ClonePipe = Main.ClonePipe

CloningChamber1.TorsoScanner.Touched:Connect(function(TouchPart)
	if game.Players:GetPlayerFromCharacter(TouchPart.Parent) and TouchPart.Name == "UpperTorso" then
		if not table.find(TouchingPlayers,game.Players:GetPlayerFromCharacter(TouchPart.Parent)) then
			table.insert(TouchingPlayers,game.Players:GetPlayerFromCharacter(TouchPart.Parent))
		end
	end
end)
CloningChamber1.TorsoScanner.TouchEnded:Connect(function(TouchPart)
	if game.Players:GetPlayerFromCharacter(TouchPart.Parent) and TouchPart.Name == "UpperTorso" then
		if table.find(TouchingPlayers,game.Players:GetPlayerFromCharacter(TouchPart.Parent)) then
			for Index,Table in pairs(TouchingPlayers) do
				if Table == game.Players:GetPlayerFromCharacter(TouchPart.Parent) then
					table.remove(TouchingPlayers,Index)
				end
			end
		end 
	end
end)

local function SetTablet(Frame)
	local Screen = Main.Tablet.Screen
	if Frame == "Error" then
		Screen.SurfaceGui.Ready.Visible = false
		Screen.SurfaceGui.Error.Visible = true
		Screen.ErrorParticles.Enabled = true
	elseif Frame == "Complete" then
		Screen.SurfaceGui.Ready.Visible = false
		Screen.SurfaceGui.Complete.Visible = true
	else
		Screen.SurfaceGui.Ready.Visible = true
		Screen.SurfaceGui.Complete.Visible = false
		Screen.SurfaceGui.Error.Visible = false
		Screen.ErrorParticles.Enabled = false
	end
end

local function ResetCloneMachine()
	InUse.Value = false
	SetTablet()
	
	CloningChamber1.Liquid.CFrame = CloningChamber1.LiquidEmpty.CFrame
	CloningChamber1.Liquid.Size = CloningChamber1.LiquidEmpty.Size
	CloningChamber2.Liquid.CFrame = CloningChamber2.LiquidEmpty.CFrame
	CloningChamber2.Liquid.Size = CloningChamber2.LiquidEmpty.Size
	ClonePipe.Ball.CFrame = ClonePipe.BallEmpty.CFrame
	ClonePipe.Ball.Transparency = 0
	ClonePipe.Horizontal.CFrame = ClonePipe.HorizontalEmpty.CFrame
	ClonePipe.Horizontal.Size = ClonePipe.HorizontalEmpty.Size
	ClonePipe.Horizontal.Transparency = 0
	ClonePipe.Vertical.CFrame = ClonePipe.VerticalEmpty.CFrame
	ClonePipe.Vertical.Size = ClonePipe.VerticalEmpty.Size
	ClonePipe.Vertical.Transparency = 1
	CloningChamber2.MiniTube.CFrame = CloningChamber2.MiniTubeEmpty.CFrame
	CloningChamber2.MiniTube.Size = CloningChamber2.MiniTubeEmpty.Size
end

local function SetPlayerEffect()
	if TouchingPlayers[1] and not TouchingPlayers[2] then
		local Chance = math.random(1, 100)

		if Chance == 1 then
			TouchingPlayers[1].Character.Humanoid:ApplyDescription(game.Players:GetHumanoidDescriptionFromUserId(1848960))
			SetTablet("Error")
		elseif Chance >= 2 and Chance <= 13 then
			local defaultRig = ServerStorage.Gameplay.DefaultRig:Clone()
			local humanoid = defaultRig:FindFirstChild("Humanoid")
			
			local appearance = game.Players:GetHumanoidDescriptionFromUserId(TouchingPlayers[1].UserId)

			defaultRig:AddTag("FakeHuman")
			defaultRig:SetPrimaryPartCFrame(CloningChamber2.TorsoScanner.CFrame)

			defaultRig.Parent = workspace
			humanoid:ApplyDescription(appearance)
			
			CloningChamber2.Collision.CanCollide = false
			
			task.spawn(function()
				local PlayerImage = game.Players:GetUserThumbnailAsync(TouchingPlayers[1].UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352);
				task.wait(2)

				local tween = TweenService:Create(CloningChamber2.Visual, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = CloningChamber2.VisualOpen.Size,CFrame = CloningChamber2.VisualOpen.CFrame,})
				tween:Play()
				Main.PlayerTablet.Screen.SurfaceGui.Container.CharacterIcon.Image = PlayerImage
				require(script.AIModule):AddRig(defaultRig)
				SetTablet("Complete")
			end)
		else
			local Effects = {
				"Burn",
				"BigHead",
				"Ghostify",
				"BlooGoo",
				"Teleport"
			}
			local Effect = Effects[math.random(1, #Effects)]
			if Effect == "Teleport" then
				TouchingPlayers[1].Character.HumanoidRootPart.CFrame = Main.RandomTeleport.CFrame
				SetTablet("Error")
			else
				require(script.Effects[Effect])(TouchingPlayers[1].Character)
				SetTablet("Error")
			end
		end
	elseif TouchingPlayers[1] and TouchingPlayers[2] then
		for Index,Player in pairs(TouchingPlayers) do
			Player.Character.Humanoid:TakeDamage(1000)
		end
	end
end

local function CloneAnimation()
	TweenService:Create(CloningChamber1.Visual,TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),{CFrame = CloningChamber1.VisualClosed.CFrame}):Play()
	CloningChamber1.Collision.CanCollide = true
	wait(2)
	TweenService:Create(CloningChamber1.Liquid,TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{CFrame = CloningChamber1.LiquidFull.CFrame,Size = CloningChamber1.LiquidFull.Size}):Play()
	wait(3)
	if not TouchingPlayers[1] then
		TweenService:Create(CloningChamber1.Liquid,TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{CFrame = CloningChamber1.LiquidDrained.CFrame,Size = CloningChamber1.LiquidDrained.Size}):Play()
		wait(0.3)
		TweenService:Create(CloningChamber1.Visual,TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),{CFrame = CloningChamber1.VisualOpen.CFrame}):Play()
		CloningChamber1.Collision.CanCollide = false
		SetTablet("Error")
		return false
	else
		TweenService:Create(ClonePipe.Ball,TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = ClonePipe.BallFull.CFrame}):Play()
		TweenService:Create(ClonePipe.Horizontal,TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = ClonePipe.HorizontalFull.CFrame,Size = ClonePipe.HorizontalFull.Size}):Play()
		wait(1)
		ClonePipe.Vertical.Transparency = 0
		TweenService:Create(ClonePipe.Vertical,TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = ClonePipe.VerticalFull.CFrame,Size = ClonePipe.VerticalFull.Size}):Play()
		wait(1)
		TweenService:Create(CloningChamber2.MiniTube,TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = CloningChamber2.MiniTubeFull.CFrame,Size = CloningChamber2.MiniTubeFull.Size}):Play()
		wait(0.5)
		TweenService:Create(CloningChamber2.Liquid,TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{CFrame = CloningChamber2.LiquidFull.CFrame,Size = CloningChamber2.LiquidFull.Size}):Play()
		wait(3)
		return true
	end
end

local function DrainPipes(Cloned)
	TweenService:Create(ClonePipe.Horizontal,TweenInfo.new(0.499, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = ClonePipe.HorizontalDrained.CFrame,Size = ClonePipe.HorizontalDrained.Size}):Play()
	wait(0.5)
	ClonePipe.Horizontal.Transparency = 1
	TweenService:Create(ClonePipe.Ball,TweenInfo.new(0.249, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = ClonePipe.BallDrained.CFrame}):Play()
	TweenService:Create(ClonePipe.Vertical,TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = ClonePipe.VerticalDrained.CFrame,Size = ClonePipe.VerticalDrained.Size}):Play()
	wait(0.25)
	ClonePipe.Ball.Transparency = 1
	TweenService:Create(CloningChamber2.MiniTube,TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = CloningChamber2.MiniTubeDrain.CFrame,Size = CloningChamber2.MiniTubeDrain.Size}):Play()
	wait(0.25)
	TweenService:Create(CloningChamber2.Liquid,TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{CFrame = CloningChamber2.LiquidDrained.CFrame,Size = CloningChamber2.LiquidDrained.Size}):Play()
	TweenService:Create(CloningChamber1.Liquid,TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{CFrame = CloningChamber1.LiquidDrained.CFrame,Size = CloningChamber1.LiquidDrained.Size}):Play()
	wait(0.5)
	TweenService:Create(CloningChamber1.Visual,TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),{CFrame = CloningChamber1.VisualOpen.CFrame}):Play()
	CloningChamber1.Collision.CanCollide = false
end

script.Parent.Interact.OnServerEvent:Connect(function(player)
	if not InUse.Value then
		InUse.Value = true
		if CloneAnimation() then
			wait(1)
			SetPlayerEffect()
			DrainPipes()
			wait(12)
			if not CloneSuccessful then
				ResetCloneMachine()
			end
		else
			wait(12)
			ResetCloneMachine()
		end
	end
end)