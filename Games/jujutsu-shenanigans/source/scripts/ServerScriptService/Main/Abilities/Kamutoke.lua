local Debris = game:GetService('Debris')

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
local voxBreaker = require(game.ReplicatedStorage.Modules.VoxBreaker)


local AnimationEvents = shared.AnimationEvents
local Utility = shared.Utility
local WeldSystem = shared.WeldSystem
local limbtrail = shared['Limb Trail']
local TS = game:GetService("TweenService")

local Sounds = shared.SoundsFolder
local Animations = shared.AnimsFolder

local MoveAnims = shared.MoveAnims
local MoveSounds = shared.MoveSounds


local PlrSet = shared.PlrSet
local PlrGet = shared.PlrGet


local ReplicateEffects_Set = shared.repfire

local RayCastParamss = RaycastParams.new()
RayCastParamss.IgnoreWater = true
RayCastParamss.RespectCanCollide = true
RayCastParamss.FilterDescendantsInstances = {workspace.Map}
RayCastParamss.FilterType = Enum.RaycastFilterType.Include


local rad = shared.rad
local StartAirDetect = shared.AirDetect
local DefaultJoint = shared.DefaultJoint

return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		
		local Stun = StunHandler:Stun(Character, 0.75, true)
		
		local Hit = false
		local anim = MoveAnims.Heian.Kamutoke.Kamutoke
		
		local clone = script.Kamutoke:Clone()
		clone.Handle.Weld.Part0 = Character["Right Arm"]
		clone.Parent = Character
		Debris:AddItem(clone.Handle.Weld, 1.85)
		Debris:AddItem(clone, 2.25)
		
		local Pos = HumRP.Position
		local Raycast2 = workspace:Raycast(HumRP.Position,Vector3.new(0,-3,0),RayCastParamss)
		if Raycast2 then
			Pos = Raycast2.Position
		end
		
		local Hitboxpart
		
		local part = Instance.new("Part")
		part.Anchored = true
		part.CanCollide = false
		part.Transparency = 1
		part.CFrame = CFrame.new(Pos)
		part.Size = Vector3.new(100,1,100)

		local positions = {}

		for i = 1, 12 do
			local randomX = math.random(part.Position.X - part.Size.X/2, part.Position.X + part.Size.X/2)
			local randomY = math.random(part.Position.Y - part.Size.Y/2, part.Position.Y + part.Size.Y/2)
			local randomZ = math.random(part.Position.Z - part.Size.Z/2, part.Position.Z + part.Size.Z/2)
			table.insert(positions, Vector3.new(randomX, randomY, randomZ))
		end

		for _,v in positions do
			task.spawn(function()
				local PosRaycast = workspace:Raycast(v,Vector3.new(0,-20,0),RayCastParamss)
				if PosRaycast then
					
					local folder = Instance.new("Folder", workspace.Effects)
					folder.Name = Player.Name
					
					local RayPospart = Instance.new("Part", workspace.Effects)
					RayPospart.Anchored = true
					RayPospart.Position = PosRaycast.Position
					RayPospart.Parent = folder
					RayPospart.Transparency = 1
					
					ReplicateEffects_Set:FireAllClients('Strike',PosRaycast.Position)
					
					task.wait(0.7)
					local Hitbox = HitboxHandler.new()
					Hitbox.Instance = RayPospart
					Hitbox.Size = Vector3.new(20,30,20)
					Hitbox.onTouch = function(EnemyCharacter)
						if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

						local EnemyHumanoid = EnemyCharacter.Humanoid
						local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

						local LookVector = -CFrame.lookAt(EnemyHumRP.Position, HumRP.Position).LookVector
						
						local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 35, 1, nil, false, false, true, true, false)

						NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 25, 35, LookVector.Z * 25) })
						RagdollHandler.ragdoll(EnemyHumanoid, 1)
					end

					Hitbox:Start()

					task.delay(0.25, function()
						Hitbox:Destroy()
					end)
				end
			end)
		end

		part:Destroy()
		
		AnimationService:playAnimation(Character, anim)
	end
}