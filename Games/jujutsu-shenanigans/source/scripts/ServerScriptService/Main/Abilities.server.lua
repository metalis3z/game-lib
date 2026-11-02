--// Services \\--

local SvSt = game:GetService('ServerStorage')
local RS = game:GetService('ReplicatedStorage')
local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')
local Players = game:GetService('Players')



--// Bindables \\--

shared.AirDetect = SvSt.Bindables.AirDetector



--// Assets \\--

local Assets = SvSt.Assets

shared.Assets = Assets


local SoundsFolder = Assets.Sounds
local AnimsFolder = Assets.Animations

shared.SoundsFolder = SoundsFolder
shared.AnimsFolder = AnimsFolder

shared.MoveSounds = SoundsFolder.Moves
shared.MoveAnims = AnimsFolder.Moves


local Remotes = RS.Remotes



--// Comunicator \\--

local ComunicatorFolder = Remotes.Comunicator

shared.PlrSet = ComunicatorFolder.Set
shared.PlrGet = ComunicatorFolder.Get



--// ReplicateAbilities \\--

local ReplicateAbilities = Remotes.AbilitiesHandler

shared.moveget = ReplicateAbilities.Get
shared.movefire = ReplicateAbilities.Set



--// ReplicateEffects \\--

local ReplicateEffects = Remotes.Replicate

shared.repget = ReplicateEffects.Get
shared.repfire = ReplicateEffects.Set



--// ReplicatedModules \\--

local ReplicatedModules = RS.Modules

shared.AnimationEvents = require(ReplicatedModules.AnimationEvents)
shared.Utility = require(ReplicatedModules.Utility)
shared.WeldSystem = require(ReplicatedModules.WeldSystem)
shared.LimbTrail = require(ReplicatedModules.LimbTrail)



--// Variables \\--

local specialUseMoves = {
	["Five Seasons"] = "FiveSeasonsTwice",
	["Virgule Cascade"] = "GlimpseOPVariant"
}

shared.rad = math.rad
shared.DefaultJoint = game.StarterPlayer.StarterCharacter.HumanoidRootPart.RootJoint


shared.Abilities = {}



--// Functions \\--

local function addToolCDS(Player: Player, Tool: Tool)
	if Player.Commands.NoCooldown.Value == false then
		local toolCooldowns = Tool:GetAttribute('Cooldowns')
		
		if not toolCooldowns then
			Tool:SetAttribute('Cooldowns', 1)
		else
			Tool:SetAttribute('Cooldowns', toolCooldowns + 1)
		end
		
		Tool:AddTag('onCDS')
		task.delay(Tool:GetAttribute('CDS'), function()
			Tool:SetAttribute('Cooldowns', Tool:GetAttribute('Cooldowns') - 1)
			
			if Tool:GetAttribute('Cooldowns') <= 0 then
				Tool:SetAttribute('Cooldowns', 0)
				
				Tool:RemoveTag('onCDS')
			end
		end)
	end
end



--// Connections \\--

shared.moveget.OnServerInvoke = function(Player: Player, ToolName)
	local Character = Player.Character
	if not Character then return false end

	local Tool: Tool = Player.Moveset:FindFirstChild(ToolName)
	if not Tool then return end
	
	local specialUseName = specialUseMoves[ToolName]
	if specialUseName ~= nil and Character:GetAttribute(specialUseName) == true and not Tool:HasTag('onCDS') then
		Character:SetAttribute(specialUseName, nil)

		addToolCDS(Player, Tool)

		return Tool, false
	end

	if Character:HasTag('Stunned') or Tool:HasTag('onCDS') then return false end

	addToolCDS(Player, Tool)

	coroutine.wrap(function()
		shared.Abilities[ToolName].Start(Player, Tool)
	end)()

	return Tool
end

for _,v in script:GetChildren() do
	if v:IsA('ModuleScript') then
		shared.Abilities[v.Name] = require(v)
	end
end