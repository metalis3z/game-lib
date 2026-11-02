local Gun = script.Parent
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerSounds = ServerStorage.Sounds:WaitForChild("Gameplay")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local WeaponService = require(ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("WeaponService"))

local Handle = Gun:WaitForChild("Handle")
local ShootRemote = Gun:WaitForChild("Shoot")
local SoundsFolder = Gun:WaitForChild("Sounds")

local CanFire = true

for _, Sound in SoundsFolder:GetChildren() do
	Sound.Parent = Handle
end

if Handle:FindFirstChild("AltSound") then
	Handle.Gunshot.SoundId = Handle.AltSound.SoundId
	Handle.Gunshot.PlaybackSpeed = Handle.AltSound.PlaybackSpeed
end

local function FindHumanoid(Part)
	local CurrentPart = Part
	while CurrentPart do
		local Humanoid = CurrentPart:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			return Humanoid
		end
		CurrentPart = CurrentPart.Parent
	end
	return nil
end

local function PlayKillSound()
	local KillSound = ServerSounds.GunKill:Clone()
	KillSound.Parent = Handle
	KillSound:Play()
	Debris:AddItem(KillSound, KillSound.TimeLength)
end

ShootRemote.OnServerEvent:Connect(function(ShooterPlayer, Origin, Direction)
	if not CanFire or _G.RoundEnded then
		return
	end

	CanFire = false

	local ShootParticle = game.ServerStorage.ShootParticle:Clone()
	ShootParticle.Parent = Handle
	
	local RaycastDirection = (Direction.Position - Origin.Position).Unit * 900
	local Params = RaycastParams.new()

	local IgnoreList = { ShooterPlayer.Character }
	for _, DisplayModel in pairs(CollectionService:GetTagged("WeaponDisplay")) do
		table.insert(IgnoreList, DisplayModel)
	end
	Params.FilterDescendantsInstances = IgnoreList

	local Result = Workspace:Raycast(Origin.Position, RaycastDirection, Params)
	local HitPart = Result and Result.Instance
	local HitPosition = Result and Result.Position
	
	local Decoy = HitPart:FindFirstAncestorOfClass("Model")
	if Decoy and CollectionService:HasTag(Decoy, "Decoy") then
		local FreezeEffect = require(game.ServerScriptService.GameScript.Modules.PerksController.Decoy.DecoyServer.HoloDeath)
		FreezeEffect(Decoy)
	end
	if (HitPart and HitPart:IsA("BasePart") and HitPart.Transparency == 1) then
		while true do
			table.insert(IgnoreList, HitPart)
			Params.FilterDescendantsInstances = IgnoreList

			local NextResult = Workspace:Raycast(Origin.Position, RaycastDirection, Params)

			HitPart = NextResult and NextResult.Instance
			HitPosition = NextResult and NextResult.Position

			if not (HitPart ~= nil and HitPart.Transparency == 1) then
				break
			end			
		end
	end

	if HitPosition or HitPart then
		Handle.Gunshot:Play()
		ShootParticle:Emit(1)
		task.spawn(function()
			task.wait(0.1)
			ShootParticle:Destroy()
		end)
		task.spawn(function()
			local Character = ShooterPlayer.Character
			if Character and Character.Humanoid and Character.Humanoid.Animator then
				Character.Humanoid.Animator:LoadAnimation(Gun.Animations.Shoot):Play()
			end

			WeaponService.GunFired:FireAllClients(Handle, Origin.Position, Direction.Position, HitPart)
			
			task.wait(0.5)
			if Character and Character.Humanoid and Character.Humanoid.Animator then
				local ReloadAnimation = Character.Humanoid.Animator:LoadAnimation(Gun.Animations.Reload)
				ReloadAnimation.Priority = Enum.AnimationPriority.Action2
				ReloadAnimation:Play()
			end
			Handle.Reload:Play()
		end)

		if HitPart then
			if HitPart.Parent and HitPart.Name ~= "Footstep" then
				local Humanoid = FindHumanoid(HitPart)
				
				if Humanoid and Humanoid.Parent:FindFirstChild("CloneDeath") then
					Humanoid.Parent.CloneDeath:Fire()
				end
				
				if Humanoid and Humanoid ~= ShooterPlayer.Character.Humanoid then
					local VictimPlayer = Players:GetPlayerFromCharacter(Humanoid.Parent)

					if VictimPlayer then
						local PlayerData = ReplicatedStorage.GetPlayerData_REMOTE:Invoke(ShooterPlayer)

						if PlayerData and PlayerData[VictimPlayer.Name] then
							if PlayerData[VictimPlayer.Name].Role == "Murderer" then
								PlayKillSound()
							end
							Remotes.Gameplay.GunKill:Fire(ShooterPlayer, VictimPlayer, Humanoid)
						end
					end
				end
			end
		end
	end

	task.wait(3)
	CanFire = true
end)

game.ReplicatedStorage.Remotes.Misc.WhL.Event:Connect(function(ShouldDestroy)
	if ShouldDestroy then
		Gun:Destroy()
	else
		script.Disabled = true
	end
end)

--[[     
		 //   \\
         //   \\
         ||___||
	    / *   * \
	   |   \_/   |
	   |         |
--=======================--
--//  bonnie was here  \\--
--=======================--
]]