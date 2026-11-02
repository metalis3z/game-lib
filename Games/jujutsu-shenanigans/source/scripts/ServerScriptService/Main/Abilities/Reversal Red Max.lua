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
local KnockbackModule = require(game.ServerStorage.Modules.KnockbackModule)

local AnimationEvents = shared.AnimationEvents
local Utility = shared.Utility
local WeldSystem = shared.WeldSystem

local Sounds = shared.SoundsFolder
local Animations = shared.AnimsFolder
local MoveAnims = shared.MoveAnims
local MoveSounds = shared.MoveSounds

local ReplicateEffects_Set : RemoteEvent = shared.repfire

local rad = shared.rad
local StartAirDetect = shared.AirDetect

return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		--[[local Anim = MoveAnims['Honored One']['Reversal Red Max'].Start
		local AnimTrick = AnimationService:getAnimationTrack(Character, Anim)
		local Stun = StunHandler:Stun(Character,nil,true,0,0,true)
		iFramesService:AddAlliFrames(Character)
		local AnimEvents = {}		
		local Connection : RBXScriptConnection

		ReplicateEffects_Set:FireAllClients('ReversalRed',{Stage = "Start", Char = Character})

		local Connection = AnimTrick:GetMarkerReachedSignal("Function"):Connect(function(Parameter)
			if Parameter == "Hitbox" then
				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = HumRP.CFrame
				Hitbox.Offset = CFrame.new(0, 0, -67) * CFrame.Angles(0,1.57,0)
				Hitbox.Size = Vector3.new(130,5,5)
				Hitbox.Characters = {}
				Hitbox.onTouch = function(EnemyCharacter : Model)
					local EnemyHumRP : BasePart = EnemyCharacter.HumanoidRootPart
					local EnemyHumanoid : Humanoid = EnemyCharacter.Humanoid

					if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1,1,1) * 1000000, Velocity = HumRP.CFrame.LookVector * 100 })
					--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1,1,1) * math.huge, Velocity = Vector3.new(300, 0, 300) })
					DamageHandler:TakeDamage(Character,EnemyHumanoid,25,nil,nil,false,false,true,false,true)
					ReplicateEffects_Set:FireAllClients('ReversalRed',{Stage = "Hit", Enemy = EnemyCharacter, Char = Character})
					RagdollHandler.ragdoll(EnemyHumanoid, 3)
				end
				Hitbox:Once()
				Hitbox:Destroy()
			elseif Parameter == "End" then
				iFramesService:RemoveAlliFrames(Character)
				StunHandler:Unstun(Character)
				if Connection then
					Connection:Disconnect()
					Connection = nil
				end
			end
		end)


		AnimationService:playAnimation(Character,Anim)]]
	end
}
