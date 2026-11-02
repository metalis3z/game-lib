-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: ServerStorage/Modules/StunHandler.lua  (ModuleScript, 219 lines)
-- What it does: Stun(character, duration, ...): adds a 'Stunned' tag plus CantPunch / CantDash / CantBlock tags, lowers WalkSpeed/JumpPower, stacks stun values in a folder, and restores everything when the last stun ends.

--// Services \\--

local Debris = game:GetService('Debris')
local TS = game:GetService('TweenService')
local SvSt = game:GetService('ServerStorage')



--// Assets \\--

local Assets = SvSt.Assets


local Animations = Assets.Animations
local ThrowableAnims = Animations.Throwables



--// Modules \\--

local SvModules = SvSt.Modules


local AnimationService = require(SvModules.AnimationService)
local module = {}



--// Variables \\--

local Connections = {}
local StunsTags = {
	'CantPunch',
	'CantDash',
	'CantSideDash',
	'CantBlock',
	'CantThrowable'
}



--// Functions \\--

local function TriggerTags(Character: Model, State: boolean)
	if not Character then return end
	
	if State == true then
		for _,Tag in StunsTags do
			Character:AddTag(Tag)
		end
	else
		for _,Tag in StunsTags do
			Character:RemoveTag(Tag)
		end
	end
end

local function Unstun(Character: Model)
	if not Character or (Character and (not Character:FindFirstChild('Humanoid') or (Character:FindFirstChild('Humanoid') and Character.Humanoid.Health <= 0))) then return end
	
	
	Character:RemoveTag('Stunned')

	if Connections[Character.Name] then
		Connections[Character.Name]:Disconnect()
		Connections[Character.Name] = nil
	end

	Character:SetAttribute('DefaultRunSpeed', 25)
	Character:SetAttribute('DefaultWalkSpeed', 16)
	Character:SetAttribute('DefaultJumpPower', 50)

	Character.Humanoid.WalkSpeed = 16
	Character.Humanoid.JumpPower = 50
	
	if game.Players:GetPlayerFromCharacter(Character) then
		game.ReplicatedStorage.Remotes.Comunicator.Set:FireClient(game.Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = true })
	end

	TriggerTags(Character, false)
end



--// Module Functions \\--

function module:Stun(Character: Model, Duration, IgnoreImmunity, WalkSpeed: number, JumpPower: number, DestroyImmunity: boolean)
	if not Character then return end
	
	local Player = game.Players:GetPlayerFromCharacter(Character)
	
	if (Player and Player.Commands.NoStun.Value == true) or (not IgnoreImmunity and Character:HasTag('StunImmunity')) then return end

	
	WalkSpeed = WalkSpeed or 0
	JumpPower = JumpPower or 0
	
	
	local Humanoid: Humanoid = Character.Humanoid
	
	
	local hasDuration = true
	if not Duration then
		Duration = 9999
		hasDuration = false
	end
	
	if not Character:FindFirstChild('Stuns') then
		local StunsFolder = Instance.new('Folder')
		StunsFolder.Parent = Character
		StunsFolder.Name = 'Stuns'
	end
	
	if not Character:HasTag('Stunned') then
		Character:AddTag('Stunned')
	end
	
	local Stunned = Instance.new("NumberValue")
	Stunned.Name = "Stunned"
	Stunned.Value = Duration
	Stunned.Parent = Character.Stuns
	
	if hasDuration then
		Stunned:AddTag('HasDuration')
	end
	
	if DestroyImmunity then
		Stunned:AddTag('DestroyImmunity')
	end
	
	local TN = TS:Create(Stunned, TweenInfo.new(Duration, Enum.EasingStyle.Linear), { Value = 0 })
	TN.Completed:Connect(function()
		module:Unstun(Character, Stunned)
	end)
	
	TN:Play()
	
	
	Character:SetAttribute('DefaultRunSpeed', WalkSpeed)
	Character:SetAttribute('DefaultWalkSpeed', WalkSpeed)
	Character:SetAttribute('DefaultJumpPower', JumpPower)
	
	Humanoid.WalkSpeed = WalkSpeed
	Humanoid.JumpPower = JumpPower
	
	if game.Players:GetPlayerFromCharacter(Character) then
		game.ReplicatedStorage.Remotes.Comunicator.Set:FireClient(game.Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = false })
	end
	
	
	if not Connections[Character.Name] then
		Connections[Character.Name] = Humanoid.Changed:Connect(function(property)
			if not Character or not Humanoid then
				Connections[Character.Name]:Disconnect()
				Connections[Character.Name] = nil
			else
				if property == 'WalkSpeed' and Humanoid.WalkSpeed ~= WalkSpeed then
					Humanoid.WalkSpeed = WalkSpeed
				elseif property == 'JumpPower' and Humanoid.JumpPower ~= JumpPower then
					Humanoid.JumpPower = JumpPower
				end
			end
		end)
	end
	
	TriggerTags(Character, true)
	
	return Stunned
end

function module:Unstun(Character: Model, StunObject: NumberValue)
	if not Character then return end
	
	if StunObject then
		StunObject:Destroy()
	else
		local Stuns = Character.Stuns:GetChildren()
		local lowestValue

		for _,Stun: NumberValue in pairs(Stuns) do
			if not Stun:HasTag('HasDuration') then
				local actualValue = Stun.Value

				if not lowestValue then
					lowestValue = { Object = Stun, Duration = actualValue }
				else
					if actualValue <= lowestValue.Duration then
						lowestValue = { Object = Stun, Duration = actualValue }
					end
				end
			end
		end

		if lowestValue and lowestValue.Object then
			lowestValue.Object:Destroy()
		end
	end
	
	
	if not Character or not Character:FindFirstChild('Stuns') or not Character.Stuns:FindFirstChild('Stunned') then
		Unstun(Character)
	end
end

function module:RemoveAllStuns(Character: Model, IgnoreImmunity: boolean?)
	for _, StunObj: NumberValue in Character.Stuns:GetChildren() do
		if IgnoreImmunity == true or not StunObj:HasTag('DestroyImmunity') then
			StunObj:Destroy()
		end
	end
	
	Unstun(Character)
end

function module:IsStunned(Character: Model)
	return Character.Stuns:FindFirstChild('Stunned') or Character:HasTag('Stunned')
end

return module
