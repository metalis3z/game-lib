-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: ServerStorage/Modules/HitboxHandler.lua  (ModuleScript, 201 lines)
-- What it does: Hitbox object: Box (GetPartBoundsInBox) or Radius (GetPartBoundsInRadius) around a part or CFrame + offset, runs every Heartbeat or once, remembers who was already hit, 'Single' mode hits only the closest target, and visualises boxes in Studio.

--// Services \\--

local RNS = game:GetService("RunService")
local RS = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')



--// Remotes \\--

local Remotes = RS.Remotes

local ReplicateSet = Remotes.Replicate.Set



--// ReplicatedModules \\--

local ReplicatedModules = RS.Modules

local Utility = require(ReplicatedModules.Utility)



--// Utility \\--

local pairsForLoop = Utility('forLoops').pairsForLoop



--// Params \\--

local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Include
overlapParams.FilterDescendantsInstances = { workspace.Live }



--// Variables \\--

local getCframe = 
{
	["Instance"] = function(point)
		return point.CFrame
	end,

	["CFrame"] = function(point)
		return point
	end,
}



--// Metatable \\--

local HB = {}
HB.__index = HB



--// Functions \\--

local function GetPartBoundsInBox(params)
	return workspace:GetPartBoundsInBox(params.cf, params.size, overlapParams)
end

local function GetPartBoundsInRadius(params)
	return workspace:GetPartBoundsInRadius(params.pos, params.radius, overlapParams)
end


function HB.new()
	return setmetatable({
		Size = Vector3.new(1,1,1) * 7,
		HitType = nil,
		Ignore = {},
		Instance = nil,
		Offset = CFrame.new(0, 0, 0),
		Characters = {},
		onTouch = function(EnemyCharacter: Model) end,
		Connection = nil,
		Method = 'Box',
		ResetCharactersList = false
	}, HB)
end


function HB:_Cast(dt)
	assert(self.Instance,'There\'s no instance set for the hitbox')
	assert(self.Size,'There\'s no size set for the hitbox')
	
	
	
	local params
	local detectFunction
	local HitboxCFrame: CFrame = getCframe[typeof(self.Instance)](self.Instance) * self.Offset
	
	task.spawn(function()
		if not RNS:IsStudio() or self.Visualize == false then return end

		ReplicateSet:FireAllClients('Hitbox', { Method = self.Method, Size = self.Size, CF = HitboxCFrame })
	end)
	
	if self.Method == 'Box' then
		detectFunction = GetPartBoundsInBox
		params = { cf = HitboxCFrame, size = self.Size }
	else
		detectFunction = GetPartBoundsInRadius
		params = { pos = HitboxCFrame.Position, radius = self.Size }
	end
	
	local closestCharacter = nil
	
	if self.ResetCharactersList == true then
		self.Characters = {}
	end
	
	local touchingParts = detectFunction(params)
	pairsForLoop(function(v)
		if v and v.Parent then
			local Character: Model = v.Parent

			if Character then
				local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')

				if Humanoid and not table.find(self.Characters, Character) and not table.find(self.Ignore, Character) then
					table.insert(self.Characters,Character)
					
					if self.HitType == 'Single' then
						if Humanoid.Health > 0 then
							if closestCharacter ~= nil then
								if (Character.HumanoidRootPart.Position - HitboxCFrame.Position).Magnitude < (closestCharacter.HumanoidRootPart.Position - HitboxCFrame.Position).Magnitude then
									closestCharacter = Character
								end
							else
								closestCharacter = Character
							end
						end
					else
						self.onTouch(Character, dt)
					end
				end
			end
		end
	end, touchingParts)
	
	if self.HitType == 'Single' and closestCharacter ~= nil then
		self.onTouch(closestCharacter, dt)
	end
end


function HB:Clear()
	self.Characters = {}
	
	if self.Connection then
		self.Connection:Disconnect()
	end
end

function HB:Start()
	spawn(function()
		self.Connection = RNS.Heartbeat:Connect(function(dt)
			if not pcall(function()
				self:_Cast(dt)
			end) then
				self.Connection:Disconnect()
			end
		end)
	end)
end


function HB:Stop()
	self:Clear()
end


function HB:Destroy()
	self:Clear()
	setmetatable(self,nil)
	
	if self.HitboxPart then
		self.HitboxPart:Destroy()
	end
	
	if self.Connection then
		self.Connection:Disconnect()
	end
end


function HB:Once()
	task.spawn(function()
		self:_Cast()
	end)
end



return HB
