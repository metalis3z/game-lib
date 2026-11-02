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
local TS = game:GetService("TweenService")

local Sounds = shared.SoundsFolder
local Animations = shared.AnimsFolder

local MoveAnims = shared.MoveAnims
local MoveSounds = shared.MoveSounds


local PlrSet = shared.PlrSet
local PlrGet = shared.PlrGet


local ReplicateEffects_Set = shared.repfire


local rad = shared.rad
local StartAirDetect = shared.AirDetect
local DefaultJoint = shared.DefaultJoint

return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		
		
		
		local Mode = Instance.new("StringValue", Character)
		Mode.Name = "WeaponMode"
		Mode.Value = "None"
		
		print("Work")
		
		if Mode.Value == "None" then
			Mode.Value = "Sword"
			
			local swordL = script.SwordL:Clone()
			swordL.Parent = Character
			
			for _, v in pairs(swordL:GetChildren()) do
				if v:IsA("BasePart") or v:IsA("MeshPart") then
					v.Color = Character:WaitForChild("Left Arm").Color
				end
			end
			
			local swordR = script.SwordR:Clone()
			swordR.Parent = Character	
			
			for _, v in pairs(swordR:GetChildren()) do
				if v:IsA("BasePart") or v:IsA("MeshPart") then
					v.Color = Character:WaitForChild("Right Arm").Color
				end
			end
			
			local weldL = script.SwordLWeld:Clone()
			weldL.Parent = Character
			weldL.Part0 = Character:WaitForChild("Left Arm")
			weldL.Part1 = swordL.Handle
			
			local weldR = script.SwordRWeld:Clone()
			weldR.Parent = Character
			weldR.Part1 = swordR.Handle
			weldR.Part0 = Character:WaitForChild("Right Arm")
		--[[elseif Mode.Value == "Sword" then
			Mode.Value = "None"]]
		end
	end
}