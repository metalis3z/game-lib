local StunHandler = require(game.ServerStorage.Modules.StunHandler)
local HitboxHandler = require(game.ServerStorage.Modules.HitboxHandler)
local DamageHandler = require(game.ServerStorage.Modules.DamageHandler)
local RagdollHandler = require(game.ServerStorage.Modules.RagdollHandler)
local NewKnockback = require(game.ServerStorage.Modules.BodymoverService)
local AnimationService = require(game.ServerStorage.Modules.AnimationService)
local iFramesService = require(game.ServerStorage.Modules.iFramesService)
local WeaponsHandler = require(game.ServerStorage.Modules.WeaponsHandler)
local CollisionsModule = require(game.ServerStorage.Modules.CollisionsModule)
local SoundsModule = require(game.ServerStorage.Modules.SoundsModule)
local DomainHelper = require(game.ServerStorage.Modules.DomainHelper)
local KnockbackModule = require(game.ServerStorage.Modules.KnockbackModule)
--local Module = script.Parent["Domain Expansion"]
local Players = game:GetService("Players")

--local DomainScript = require(game.ServerScriptService.Main.Abilities["Domain Expansion"])

local AnimationEvents = shared.AnimationEvents
local Utility = shared.Utility
local WeldSystem = shared.WeldSystem

local Sounds = shared.SoundsFolder
local Animations = shared.AnimsFolder
local MoveAnims = shared.MoveAnims
local MoveSounds = shared.MoveSounds

local ReplicateEffects_Set = shared.repfire

local rad = shared.rad
local StartAirDetect = shared.AirDetect


local RayCastParamss = RaycastParams.new()
RayCastParamss.IgnoreWater = true
RayCastParamss.RespectCanCollide = false
RayCastParamss.FilterDescendantsInstances = {workspace.Map}
RayCastParamss.FilterType = Enum.RaycastFilterType.Whitelist

local function teleportEnemy(EnemyHumanoidRootPart,HumanoidRootPart,originalOffset)
	local newEnemyPosition = HumanoidRootPart.Position + originalOffset
	EnemyHumanoidRootPart.CFrame = CFrame.new(newEnemyPosition)
end

return {
	--AnimationDur = 2,
	DomainName = "GojoDomain",
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local NormalHealth = Humanoid.Health
		--local Anim = MoveAnims.Gojo['Infinite Void'].Start
		--local AnimTrick = AnimationService:getAnimationTrack(Character, Anim)

		--if Character:GetAttribute("Stunned") then return end

		if Character:GetAttribute("InsideDomain") == true or Character:GetAttribute("DomainActive") == true then return end

		local success = DomainHelper.ActiveDomain(Character, HumRP.Position, 125, require(script.Parent['Infinite Void']))

		--AnimTrick:GetMarkerReachedSignal('Event'):Connect(function()		
		if success then
			StunHandler:Stun(Character,4.4,true)
			iFramesService:AddAlliFrames(Character)

			ReplicateEffects_Set:FireAllClients('DomainExpansion',{Stage = "Domain Bubble"; Char = Character, Position = HumRP.Position - Vector3.new(0, 3, 0), FadeDuration = .5, InitialSize = Vector3.new(1, 1, 1), GoalSize = Vector3.new(125, 125 ,125)})
			ReplicateEffects_Set:FireAllClients('DomainExpansion',{Stage = "HighLight"; Char = Character,FadeDuration = 2, Color = Color3.fromRGB(255, 255, 255), OutColor = Color3.fromRGB(255, 255, 255)})	
			ReplicateEffects_Set:FireAllClients('DomainExpansion',{Stage = "DomainGui"; Char = Character, DomainName = 'GojoDomain', Action = "AddGui", DomainRadius = 75})
			--SoundsModule:PlaySound(MoveSounds.Gojo['Infinite Void'].Start, HumRP, 1, 1)	

		end			
		--end)

		--AnimationService:playAnimation(Character,Anim)

	end,
	StartDomain = function(playerOrCharacter)
		local character
		local player
		if playerOrCharacter:IsA("Player") then
			player = playerOrCharacter
			character = player.Character
			warn("DOMAIN STARTED FOR PLAYER", player.Name)

		elseif playerOrCharacter:IsA("Model") and playerOrCharacter:FindFirstChild("Humanoid") then
			character = playerOrCharacter
			warn("DOMAIN STARTED FOR NPC", character.Name)
		end



		local hum = character.Humanoid
		local root = character.HumanoidRootPart
		local RayPosition = workspace:Raycast(root.Position,Vector3.new(0,-5,0),RayCastParamss)
		local Position = root.Position


		--player.AwakeningProgress.Value = 0

		if RayPosition then
			Position = RayPosition.Position
		else
			Position = root.Position * Vector3.new(0,-2.5,0)
		end
		local Domain = game.ReplicatedStorage.Assets.Domains.InfiniteVoid.Domain:Clone()
		local Collider = game.ReplicatedStorage.Assets.Domains.InfiniteVoid.DomainCollider:Clone()

		task.spawn(function()
			Collider.Name = player.Name..'Collider'
			Collider.Parent  = workspace.Domain
			Collider.CFrame = Collider.CFrame * CFrame.new(math.random(100,10000),math.random(100,10000),math.random(100,10000)) --GenerateSpawnPosition(Collider.Position,Collider.Size,Collider)
			Collider.Ground.CFrame =  Collider.CFrame + Vector3.new(0,-1,0)
			Domain.Parent = workspace.Effects
			Domain.Position = Position + Vector3.new(0,2,0)
			Domain.DomainGround.Position = Position
			Domain.Name = player.Name..'StartupDomain'

			local DomainParams = {Stage = 'Gojo'; Function = "StartUp"; DomainCollider = Collider, Opening = Domain, Sound = false}
			task.wait()

			ReplicateEffects_Set:FireClient(player,'Domains',DomainParams)

			iFramesService:RemoveAlliFrames(character)

			game.TweenService:Create(Domain.Surround, TweenInfo.new(0.8), {
				["ShapePartial"] = 1
			}):Play()
			game.TweenService:Create(Domain, TweenInfo.new(0.8), {
				["Transparency"] = 0
			}):Play()
		end)

		local EnemyStun : ObjectValue
		local Hitbox = HitboxHandler.new()
		Hitbox.Instance = character.HumanoidRootPart.CFrame
		Hitbox.Size = Vector3.new(125,125,125)
		Hitbox.Ignore = {character}
		Hitbox.onTouch = function(EnemyCharacter : Model)
			local EnemyHumanoid = EnemyCharacter:FindFirstChild("Humanoid")
			local EnemyHumRP = EnemyCharacter:FindFirstChild("HumanoidRootPart")
			local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)
			local distance = (EnemyHumRP.Position - character.HumanoidRootPart.Position).Magnitude
			if distance <= 120 then
				task.spawn(function()
					if not Players:GetPlayerFromCharacter(EnemyCharacter) and player then
						EnemyHumRP:SetNetworkOwner(player) --// this make npcs not being able to go out of the domain, or undesirable places
					end

					if EnemyPlayer then
						local DomainParams = {Stage = "Gojo"; Function = "StartUp"; DomainCollider = Collider, Opening = Domain, Sound = false}
						ReplicateEffects_Set:FireClient(EnemyPlayer,'Domains',DomainParams)
					end

					print(EnemyCharacter.Name)

					local Info = game.ReplicatedStorage.Assets.Domains.InfiniteVoid.InfoFlood:Clone()
					game.Debris:AddItem(Info, 15)

					Info.Parent = EnemyCharacter:FindFirstChild("HumanoidRootPart")
					Info.Weld.Part0 = EnemyCharacter:FindFirstChild("Head")



					task.delay(.1,function()
						if Domain.Parent == nil then
							if EnemyStun then
								StunHandler:RemoveAllStuns(EnemyCharacter,true)
							end
						end
					end)

					task.spawn(function()
						Hitbox:Destroy()
						while Info and Domain.Parent ~= nil and Collider.Parent ~= nil and EnemyCharacter do
							task.wait()
							EnemyCharacter:SetAttribute("InsideDomain",true)
							EnemyStun =	StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
		
							if Domain.Parent == nil and Collider.Parent == nil then
								StunHandler:RemoveAllStuns(EnemyCharacter,true)
								Info:Destroy()
								EnemyCharacter:SetAttribute("InsideDomain",false)
								break
							end
							if EnemyHumanoid.Health < 0 then
								if root then
									Info:Destroy()
									StunHandler:RemoveAllStuns(EnemyCharacter,true)

								end
								break
							end
						end

					end)

					local originalOffset = EnemyHumRP.Position - root.Position
					local EnemyRootCframe = EnemyHumRP.CFrame
					task.wait(1.1)
					if root and hum.Health > 0 and player then
						EnemyHumRP.CFrame = EnemyRootCframe
						task.wait()
						teleportEnemy(EnemyHumRP,root,originalOffset)
					end

					while task.wait() do

						if  Domain.Parent == nil or  Collider.Parent == nil or player.Parent == nil then
							task.wait()

							EnemyCharacter:SetAttribute("InsideDomain",false)
							EnemyHumRP.CFrame = EnemyRootCframe
							StunHandler:Unstun(EnemyCharacter,EnemyStun)

							break
						end
					end
				end)
			end
		end
	    Hitbox:Once()
		local removingConnection
		local delayThread

		task.wait(1)
		local RootCFrame = root.CFrame

		task.wait()
		root.CFrame = Collider.CFrame

		task.delay(12,function()
			if Domain.Parent ~= nil and player then
				local Crack = game.ReplicatedStorage.Assets.Domains.DomainDamage:Clone()
				Crack.Parent = workspace.Effects
				Crack.CFrame =Domain.CFrame
				Domain.Destroying:Connect(function()
					Crack:Destroy()
				end)
			end
		end)

		removingConnection = character.AncestryChanged:Once(function()
			--// Disconnect
			removingConnection:Disconnect()
			pcall(task.cancel, delayThread)
			root.CFrame = RootCFrame
			ReplicateEffects_Set:FireAllClients('Domains',{Stage = "Gojo"; Function = "Shatter"; Pos = Domain.Position})
			character:SetAttribute("InsideDomain",false)
			character:SetAttribute("DomainActive", false)
			Collider:Destroy()
			Domain:Destroy()
		end)

		delayThread = task.delay(15, function()
			--// Disconnect
			if removingConnection then
				removingConnection:Disconnect()
			end		
			root.CFrame = RootCFrame
			ReplicateEffects_Set:FireAllClients('Domains',{Stage = "Gojo"; Function = "Shatter"; Pos = Domain.Position})
			character:SetAttribute("InsideDomain",false)
			character:SetAttribute("DomainActive", false)
			Collider:Destroy()
			Domain:Destroy()
		end)
	end,

	CancelDomain = function(playerOrCharacter)
		local character
		local player

		if playerOrCharacter:IsA("Player") then
			player = playerOrCharacter
			character = player.Character
			warn("DOMAIN CANCELLED FOR PLAYER", player.Name)

		elseif playerOrCharacter:IsA("Model") and playerOrCharacter:FindFirstChild("Humanoid") then
			character = playerOrCharacter
			warn("DOMAIN CANCELLED FOR NPC", character.Name)
		end

		--// Reset character's abilities
		StunHandler:Unstun(character)
		iFramesService:RemoveAlliFrames(character)

		character:SetAttribute("DomainExpanding", false)
	end,
}

