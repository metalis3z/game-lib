local PS_OwnerId = game.PrivateServerOwnerId

game.ReplicatedStorage.PS_Owner.Value = PS_OwnerId



--// Services \\--

local W = game:GetService('Workspace')
local Players = game:GetService('Players')
local RNS = game:GetService('RunService')
local RS = game:GetService('ReplicatedStorage')
local SvSt = game:GetService('ServerStorage')
local MPS = game:GetService('MarketplaceService')



--// Variables \\--

local CounterConnections = {}
local DefaultJoint = game.StarterPlayer.StarterCharacter.HumanoidRootPart.RootJoint



--// Assets \\--

local Assets = SvSt.Assets

local MoveAnims = Assets.Animations.Moves
local MoveSounds = Assets.Sounds.Moves



--// Bindables \\--

local Bindables = SvSt.Bindables

local SpnDmy = Bindables.SpawnDummy



--// Remotes \\--

local Remotes = RS.Remotes

local ReplicateSet = Remotes.Replicate.Set

local CommandRemotes = Remotes.Commands
local SetCommand = CommandRemotes.Set
local GetCommand = CommandRemotes.Get



--// Modules \\--

local SvModules = SvSt.Modules
local RpModules = RS.Modules


local AnimationService = require(SvModules.AnimationService)
local iFramesService = require(SvModules.iFramesService)
local StunHandler = require(SvModules.StunHandler)
local DamageHandler = require(SvModules.DamageHandler)
local NewKnockback = require(SvModules.BodymoverService)
local SoundsModule = require(SvModules.SoundsModule)
local RagdollHandler = require(SvModules.RagdollHandler)


local WeldSystem = require(RpModules.WeldSystem)
local AnimationEvents = require(RpModules.AnimationEvents)
local Utility = require(RpModules.Utility)
local forLoops = Utility('forLoops')



--// Functions \\--

local function clearDummies(Player: Player)
	for _, Dummy: Model in workspace.Live:GetChildren() do
		if Dummy:FindFirstChild('Dummy') then
			Dummy:AddTag('Destroying')
			Dummy:Destroy()
		end
	end
end

local ConfigFunctions = {
	Mode = function(Player: Player)
		if Player.Commands.Mode.Value == 'All' then
			Player.Commands.Mode.Value = 'Others'
			workspace.Configuration.Mode.Value = 'Others'
		elseif Player.Commands.Mode.Value == 'Others' then
			Player.Commands.Mode.Value = 'Me'
			workspace.Configuration.Mode.Value = 'Me'
		elseif Player.Commands.Mode.Value == 'Me' then
			Player.Commands.Mode.Value = 'All'
			workspace.Configuration.Mode.Value = 'All'
		end
	end,
	
	NoCooldown = function(Player, Params)
		local Val: BoolValue = Player.Commands.NoCooldown
		Val.Value = not Val.Value
		local CurrValue = Val.Value
		workspace.Configuration.NoCooldown.Value = Val.Value
		
		if Player.Commands.Mode.Value == 'All' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				TargetPlayer.Commands.NoCooldown.Value = CurrValue
				forLoops.pairsForLoop(function(Tool: Tool)
					if Tool:IsA('Tool') then
						if CurrValue == true then
							Tool:SetAttribute('CDS', 0)
							Tool:RemoveTag('onCDS')

							require(game.ServerStorage.Modules.MovesetHandler):UpdateMoveset(Player, false)
						else
							Tool:SetAttribute('CDS', Tool:GetAttribute('originalCDS'))
						end
					end
				end, TargetPlayer.Moveset:GetChildren())
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Others' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				if TargetPlayer ~= Player then
					TargetPlayer.Commands.NoCooldown.Value = CurrValue
					forLoops.pairsForLoop(function(Tool: Tool)
						if Tool:IsA('Tool') then
							if CurrValue == true then
								Tool:SetAttribute('CDS', 0)
								Tool:RemoveTag('onCDS')

								require(game.ServerStorage.Modules.MovesetHandler):UpdateMoveset(Player, false)
							else
								Tool:SetAttribute('CDS', Tool:GetAttribute('originalCDS'))
							end
						end
					end, TargetPlayer.Moveset:GetChildren())
				end
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Me' then
			forLoops.pairsForLoop(function(Tool: Tool)
				if Tool:IsA('Tool') then
					if CurrValue == true then
						Tool:SetAttribute('CDS', 0)
						Tool:RemoveTag('onCDS')

						require(game.ServerStorage.Modules.MovesetHandler):UpdateMoveset(Player, false)
					else
						Tool:SetAttribute('CDS', Tool:GetAttribute('originalCDS'))
					end
				end
			end, Player.Moveset:GetChildren())
		end
	end,
	
	GiveAwk = function(Player)
		if Player.Commands.Mode.Value == 'All' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				TargetPlayer.AwakeningProgress.Value = 100
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Others' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				if TargetPlayer ~= Player then
					TargetPlayer.AwakeningProgress.Value = 100
				end
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Me' then
			Player.AwakeningProgress.Value = 100
		end
	end,
	
	--[[OverPower = function(Player)
		local Val: BoolValue = Player.Commands.OverPower
		Val.Value = not Val.Value
		local CurrValue = Val.Value
		workspace.Configuration.OverPower.Value = CurrValue

		forLoops.pairsForLoop(function(TargetPlayer: Player)
			TargetPlayer.Commands.OverPower.Value = CurrValue
		end, Players:GetPlayers())
	end,]]
	
	
	
	SpawnDummy = function(Player: Player, Params: {any})
		SpnDmy:Fire(Player.Character.HumanoidRootPart.CFrame, Params.InitialHp, Params.ScriptName)
	end,
	
	ClearDummies = function(Player: Player)
		clearDummies(Player)
	end,
	
	RemoveAwk = function(Player: Player)
		if Player.Commands.Mode.Value == 'All' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				TargetPlayer.AwakeningProgress.Value = 0
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Others' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				if TargetPlayer ~= Player then
					TargetPlayer.AwakeningProgress.Value = 0
				end
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Me' then
			Player.AwakeningProgress.Value = 0
		end
	end,
	
	InfiniteAwk = function(Player: Player)
		local Val: BoolValue = Player.Commands.InfiniteAwk
		Val.Value = not Val.Value
		local CurrValue = Val.Value
		workspace.Configuration.InfiniteAwk.Value = CurrValue
		
		if Player.Commands.Mode.Value == 'All' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				TargetPlayer.Commands.InfiniteAwk.Value = CurrValue
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Others' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				if TargetPlayer ~= Player then
					TargetPlayer.Commands.InfiniteAwk.Value = CurrValue
				end
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Me' then
			Player.Commands.InfiniteAwk.Value = CurrValue
		end
	end,
	
	Bring = function(Player: Player)
		if not Player.Character or not Player.Character:FindFirstChild('HumanoidRootPart') then return end
		
		forLoops.pairsForLoop(function(TargetCharacter: Model)
			if TargetCharacter ~= Player.Character then
				TargetCharacter:PivotTo(Player.Character.HumanoidRootPart.CFrame)
			end
		end, workspace.Live:GetChildren())
	end,
	
	NoStun = function(Player: Player)
		local Val: BoolValue = Player.Commands.NoStun
		Val.Value = not Val.Value
		local CurrValue = Val.Value
		workspace.Configuration.NoStun.Value = CurrValue
		
		if Player.Commands.Mode.Value == 'All' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				TargetPlayer.Commands.NoStun.Value = CurrValue
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Others' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				if TargetPlayer ~= Player then
					TargetPlayer.Commands.NoStun.Value = CurrValue
				end
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Me' then
			Player.Commands.NoStun.Value = CurrValue
		end
	end,
	
	Heal = function(Player: Player)
		if Player.Commands.Mode.Value == 'All' then
			forLoops.pairsForLoop(function(Character: Model)
				local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
				if Humanoid and Humanoid.Health > 0 then
					Humanoid.Health = Humanoid.MaxHealth
				end
			end, workspace.Live:GetChildren())
		elseif Player.Commands.Mode.Value == 'Others' then
			forLoops.pairsForLoop(function(Character: Model)
				if Character == Player.Character then return end
				
				local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
				if Humanoid and Humanoid.Health > 0 then
					Humanoid.Health = Humanoid.MaxHealth
				end
			end, workspace.Live:GetChildren())
		elseif Player.Commands.Mode.Value == 'Me' then
			local Character = Player.Character
			if Character then
				local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
				if Humanoid and Humanoid.Health > 0 then
					Humanoid.Health = Humanoid.MaxHealth
				end
			end
		end
	end,
	
	Respawn = function(Player: Player)
		if Player.Commands.Mode.Value == 'All' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				if TargetPlayer.Character then
					TargetPlayer:LoadCharacter()
				end
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Others' then
			forLoops.pairsForLoop(function(TargetPlayer: Player)
				if TargetPlayer ~= Player and TargetPlayer.Character then
					TargetPlayer:LoadCharacter()
				end
			end, Players:GetPlayers())
		elseif Player.Commands.Mode.Value == 'Me' then
			if Player.Character then
				Player:LoadCharacter()
			end
		end
	end,
	
	Ragdoll = function(Player: Player)
		if Player.Commands.Mode.Value == 'All' then
			forLoops.pairsForLoop(function(Character: Model)
				local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
				if Humanoid then
					RagdollHandler.ragdoll(Humanoid, 5, false, nil, nil)
				end
			end, workspace.Live:GetChildren())
		elseif Player.Commands.Mode.Value == 'Others' then
			forLoops.pairsForLoop(function(Character: Model)
				if Character == Player.Character then return end

				local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
				if Humanoid then
					RagdollHandler.ragdoll(Humanoid, 5, false, nil, nil)
				end
			end, workspace.Live:GetChildren())
		elseif Player.Commands.Mode.Value == 'Me' then
			local Character = Player.Character
			if Character then
				local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
				if Humanoid then
					RagdollHandler.ragdoll(Humanoid, 5, false, nil, nil)
				end
			end
		end
	end,
	
	Counter = function(Player: Player)
		Player.Commands.Counter.Value = not Player.Commands.Counter.Value
		
		local Character = Player.Character
		
		if Player.Commands.Counter.Value == true then
			local HumRP: BasePart = Character.HumanoidRootPart
			local Humanoid: Humanoid = Character.Humanoid

			Character:AddTag('Countering')

			CounterConnections[Character] = Character.ChildAdded:Connect(function(child: ObjectValue?)
				if child.Name == 'DamagedLog' and child:HasTag('IsM1') then
					local Stun = StunHandler:Stun(Character, nil, true)

					local EnemyCharacter: Model = child.Value
					local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart


					HumRP.Anchored = true
					iFramesService:AddAlliFrames(Character)
					iFramesService:AddAlliFrames(EnemyCharacter)
					AnimationService:stopAll(EnemyCharacter)
					local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.rad(180), 0))
					local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true)


					local HitAnim = MoveAnims.Other.CMDCounterPlayer
					local VictimAnim = MoveAnims.Other.CMDCounterVictim

					local HitTrack = AnimationService:getAnimationTrack(Character, HitAnim)
					local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnim)

					local HitEvents = AnimationEvents.new(HitTrack)
					HitEvents:AddEvent('Hit', { 1.583, 3.717, 3.867, 4.033, 4.283, 4.367, 4.450, 4.567, 4.750, 4.850, 4.967, 5.183, 5.350, 5.483, 5.983 }, function()
						if (EnemyHumanoid.Health - 7) <= 0 then
							EnemyHumRP.Anchored = true
							
							if Weld ~= nil then
								Weld:Stop()
								Weld = nil
							end
						end
						
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 7, nil, nil, false, false, true, true)
					end)
					HitEvents:AddEvent('Desintegrate', { 6.5 }, function()
						ReplicateSet:FireAllClients('CommandCounter', { Stage = 'Desintegrate'; Character = EnemyCharacter; })
					end)
					HitEvents:AddEvent('End', { 8 }, function()
						Utility('TriggerTransparency')(Character, 1)
						ReplicateSet:FireAllClients('CommandCounter', { Stage = 'TP'; Pos = Character.Torso.Position; })
						AnimationService:stopAll(Character)

						task.wait(.1)

						Utility('TriggerTransparency')(Character, 0)
						ReplicateSet:FireAllClients('CommandCounter', { Stage = 'TP'; Pos = Character.Torso.Position; })
						ReplicateSet:FireClient(Player, 'CommandCounter', { Stage = 'Final'; })


						if Weld ~= nil then
							Weld:Stop()
							Weld = nil
						end

						StunHandler:Unstun(Character, Stun)
						iFramesService:RemoveAlliFrames(Character)
						HumRP.Anchored = false
						
						Character:RemoveTag('CantRotate')
						Humanoid.AutoRotate = true
					end)

					local VictimEvents = AnimationEvents.new(VictimTrack)
					VictimEvents:AddEvent('Stopped', {}, function()
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						iFramesService:RemoveAlliFrames(EnemyCharacter)

						if Weld ~= nil then
							Weld:Stop()
							Weld = nil
						end

						EnemyHumRP.Anchored = true
						EnemyHumRP.CFrame *= CFrame.new(0, 0, 40.037)
					end)


					AnimationService:stopAll(Character)
					AnimationService:stopAll(EnemyCharacter)
					AnimationService:playAnimation(Character, HitAnim)
					AnimationService:playAnimation(EnemyCharacter, VictimAnim)
					SoundsModule:PlaySound(MoveSounds.Other.CMDCounter, Character.Torso, 1, 1)
					HitEvents:Play()
					VictimEvents:Play()
					Weld:Start()
					EnemyCharacter:AddTag('DontDoDieFunction')

					Character:AddTag('CantRotate')
					Humanoid.AutoRotate = false
					
					EnemyCharacter:AddTag('CantRotate')
					EnemyHumanoid.AutoRotate = false
					
					ReplicateSet:FireClient(Player, 'CommandCounter', { Stage = 'Start'; CF = HumRP; })
					if EnemyPlayer then
						ReplicateSet:FireClient(EnemyPlayer, 'CommandCounter', { Stage = 'Start'; CF = HumRP; })
					end
				end
			end)
		else
			Character:RemoveTag('Countering')
			
			if not CounterConnections[Character] then return end
			
			CounterConnections[Character]:Disconnect()
			CounterConnections[Character] = nil
		end
	end,
}

local function GivePermission(Player: Player)
	SetCommand.OnServerEvent:Connect(function(p, ConfigName, Params)
		if p ~= Player then return end
		
		ConfigFunctions[ConfigName](Player, Params)
	end)
end



--// Runtime \\--

shared.giveCommands = function(Player: Player)
	Remotes.Comunicator.Set:FireClient(Player, 'PS+')
	GivePermission(Player)

	local Commands = Player:WaitForChild('Commands')

	if workspace.Configuration.Mode.Value == 'All' then
		for _,v in workspace.Configuration:GetChildren() do
			if v.Name ~= 'Mode' then
				Commands:WaitForChild(v.Name).Value = v.Value
			end
		end
	elseif workspace.Configuration.Mode.Value == 'Me' then
		for _,v in workspace.Configuration:GetChildren() do
			if v.Name ~= 'Mode' then
				Commands:WaitForChild(v.Name).Value = v.Value
			end
		end
	end
end