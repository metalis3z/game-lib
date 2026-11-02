--// Services \\--

local SvSt = game:GetService('ServerStorage')
local Debris = game:GetService('Debris')
local RNS = game:GetService('RunService')
local RS = game:GetService('ReplicatedStorage')



--// Remotes \\--

local Remotes = RS.Remotes

local ReplicateSet = Remotes.Replicate.Set



--// Assets \\--

local Assets = SvSt.Assets

local Models = Assets.Models
local Animations = Assets.Animations



--// Replicated Modules \\--

local RpModules = RS.Modules

local AnimationEvents = require(RpModules.AnimationEvents)



--// Server Modules \\--

local SvModules = SvSt.Modules

local AnimationService = require(SvModules.AnimationService)
local SoundsModule = require(SvModules.SoundsModule)
local NewKnockback = require(SvModules.BodymoverService)



--// Raycast Things \\--

local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Include
RayParams.FilterDescendantsInstances = { workspace.Map }
RayParams.IgnoreWater = true


local function raycast(origin, direction)
	return workspace:Raycast(origin, direction, RayParams)
end



return {
	['KJ'] = function(Player: Player)
		if not Player then return end
		
		
		local Character = Player.Character
		
		if not Character then return end
		
		
		local HumRP: BasePart = Character.HumanoidRootPart
		local Torso: BasePart = Character.Torso
		
		
		local AnimObjects = {}
		local animTrack = AnimationService:getAnimationTrack(Character, Animations["Spawn Animations"].KJ)
		local AnimEvents = AnimationEvents.new(animTrack)
		
		local phone = Models.KJ["Spawn Animation"].phone:Clone()
		phone.Parent = Character
		phone.Handle.Handle.Part0 = Character['Right Arm']
		SoundsModule:PlaySound(Assets.Sounds["Spawn Animations"].KJ.Phone, phone.Handle, 1, 1)
		table.insert(AnimObjects, phone)
		Debris:AddItem(phone, animTrack.Length)
		
		AnimEvents:AddEvent('ThrowPhone', { .917 }, function()
			if not phone or not phone.Parent then return end
			
			phone.Handle.Handle:Destroy()

			local mainVel = Instance.new('BodyVelocity')
			mainVel.MaxForce = Vector3.new(1,1,1) * math.huge
			mainVel.Velocity = HumRP.CFrame.LookVector * 15
			mainVel.Parent = phone.Handle
			Debris:AddItem(mainVel, .1)

			task.wait(.4)

			phone.Handle:Destroy()

			local topVel = Instance.new('BodyVelocity')
			topVel.MaxForce = Vector3.new(1,1,1) * math.huge
			topVel.Velocity = HumRP.CFrame.LookVector * math.random(1.5, 2)
			topVel.Parent = phone.Top.Main
			SoundsModule:PlaySound(Assets.Sounds["Spawn Animations"].KJ["Phone Break"], phone.Top.Main, 1, 1)
			Debris:AddItem(topVel, .1)

			local bottomVel = Instance.new('BodyVelocity')
			bottomVel.MaxForce = Vector3.new(1,1,1) * math.huge
			bottomVel.Velocity = HumRP.CFrame.LookVector * math.random(.5, 1)
			bottomVel.Parent = phone.Bottom.Main
			SoundsModule:PlaySound(Assets.Sounds["Spawn Animations"].KJ["Phone Break"], phone.Bottom.Main, 1, 1)
			Debris:AddItem(bottomVel, .1)
		end)
		
		AnimEvents:AddEvent('Stopped', {}, function()
			for _, Object in AnimObjects do
				Object:Destroy()
			end
		end)
		
		animTrack.Ended:Once(function()
			ReplicateSet:FireClient(Player, 'fixspeedbug')
		end)

		AnimEvents:Play()
		AnimationService:playAnimation(Character, Animations["Spawn Animations"].KJ)
		table.insert(AnimObjects, SoundsModule:PlaySound(Assets.Sounds["Spawn Animations"].KJ.Walk, Character.Torso, 1, 1))
	end
}