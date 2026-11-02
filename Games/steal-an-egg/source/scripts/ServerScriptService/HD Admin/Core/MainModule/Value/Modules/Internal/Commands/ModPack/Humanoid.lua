--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")
local getHumanoid = CommandAPI.getHumanoid
local getHRP = CommandAPI.getHRP
local outfitBuff = CommandAPI.outfitBuff
local applyDescription = CommandAPI.applyDescription
local getDescription = CommandAPI.getDescription


-- LOCAL FUNCTIONS
local function healthBuff(target: Player, number: number, hasEnded, originalValue: any)
	local humanoid = getHumanoid(target)
	local originalHealthDetails = if humanoid then {humanoid.Health, humanoid.MaxHealth} else {100, 100}
	local health = if hasEnded then originalValue[1] else number
	local currentMaxHealth = if humanoid then humanoid.MaxHealth else number
	local maxHealth = if hasEnded then originalValue[2] else math.max(number, currentMaxHealth)
	if humanoid then
		humanoid.Health = health
		humanoid.MaxHealth = maxHealth
	end
	return originalHealthDetails
end

local function humanoidBuff(target: Player, property: string, value: any, backupOriginalValue: any, hasEnded: boolean, originalValue: any)
	local humanoid = getHumanoid(target) :: any
	local originalPropertyValue = if humanoid then humanoid[property] else backupOriginalValue
	local newValue = if hasEnded then originalValue else value
	if humanoid then
		humanoid[property] = newValue
	end
	return originalPropertyValue
end

local function getRigAsync(target: Player, rigType: Enum.HumanoidRigType): (boolean, Model? | string)
	local humanoid = getHumanoid(target)
	if not humanoid then
		return false, "You have no humanoid"
	end
	if humanoid.RigType == rigType then
		return false, `You're already {rigType.Name}!`
	end
	local char = target.Character
	local primaryPart = char and char.PrimaryPart
	if not primaryPart then
		return false, `Missing PrimaryPart`
	end
	local success, mainDesc = pcall(function()
		return Players:GetHumanoidDescriptionFromUserId(target.CharacterAppearanceId)
	end)
	if not success then
		mainDesc:Destroy()
		return false, `You're already {mainDesc}!`
	end
	local rig = Players:CreateHumanoidModelFromDescription(mainDesc, rigType)
	mainDesc:Destroy()
	return true, rig
end

local function runRigCommand(task: CommandAPI.Task, rigType: Enum.HumanoidRigType)
	local target = task.target
	local success, rig: (Model | string)? = getRigAsync(target, rigType)
	if not success or typeof(rig) ~= "Instance" then
		local caller = task.caller
		if caller == target then
			CommandAPI.prompt("warn", caller, tostring(rig))
		end
		return
	end
	local char = target.Character
	local primaryPart = char and char.PrimaryPart
	if not primaryPart then
		return
	end
	rig:SetPrimaryPartCFrame(primaryPart.CFrame)
	rig.Name = target.Name
	target.Character = rig
	rig.Parent = workspace
end


-- COMMANDS
local commands: CommandAPI.Commands = {

	--------------------
	{
		name = "Speed",
		aliases = {"WalkSpeed"},
		groups = {"WalkSpeed"},
		args = {
			"Player",
			{arg = "Number", display = "Speed", default = 50, min = 0, max = 1000, step = 1, logarithmic = true},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "WalkSpeed", function(...)
				return humanoidBuff(target, "WalkSpeed", task:getArg("Number"), StarterPlayer.CharacterWalkSpeed, ...)
			end)
			task:bindPrompt({
				args = {"Number"},
				onChange = function(arg, value)
					task:updateBuffs(target, "WalkSpeed")
				end,
			})
		end,
	},

	--------------------
	{
		name = "JumpHeight",
		args = {
			"Player",
			{arg = "Number", display = "Jump Height", default = 50, min = 0, max = 500, step = 1, logarithmic = true}
		},
		groups = {"JumpHeight"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "JumpHeight", function(...)
				return humanoidBuff(target, "JumpHeight", task:getArg("Number"), StarterPlayer.CharacterJumpHeight, ...)
			end)
			task:bindPrompt({
				args = {"Number"},
				onChange = function(arg, value)
					task:updateBuffs(target, "JumpHeight")
				end,
			})
		end
	},

	--------------------
		{
		name = "Damage",
		args = {
			"Player",
			{arg = "Number", default = 20},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local number = task:getArg("Number")
			local humanoid = getHumanoid(target)
			if humanoid then
				humanoid.Health = humanoid.Health - number
			end
		end
	},

	--------------------
	{
		name = "Heal",
		args = {
			"Player",
			{arg = "Number", default = 50},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local number = task:getArg("Number")
			local humanoid = getHumanoid(target)
			if humanoid then
				humanoid.Health = humanoid.Health + number
			end
		end
	},

	--------------------
	{
		name = "Health",
		args = {
			"Player",
			{arg = "Number", display = "Health", default = 200, min = 0, max = 10000, step = 1, logarithmic = true},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local number = task:getArg("Number")
			task:buff(target, "Health", function(...)
				return healthBuff(target, number, ...)
			end)
		end
	},

	--------------------
	{
		name = "God",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local number = math.huge
			task:keep("UntilTargetRespawns")
			task:buff(target, "Health", function(...)
				return healthBuff(target, number, ...)
			end)
		end
	},

	--------------------
	{
		name = "Kill",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local humanoid = getHumanoid(target)
			if humanoid then
				humanoid.Health = 0
			end
		end
	},

	--------------------
	{
		name = "Explode",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local hrp = getHRP(target)
			local char = target.Character
			if not hrp or not char then return end
			local explosion = Instance.new("Explosion")
			explosion.Position = hrp.Position
			explosion.Parent = char
			explosion.DestroyJointRadiusPercent = 0
			char:BreakJoints()
		end
	},

    --------------------
	{
		name = "ForceField",
		aliases	= {"FF"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local hrp = getHRP(target)
			if not hrp then return end
			task:keep("UntilTargetRespawns")
			local item = task.janitor:add(Instance.new("ForceField"))
			item.Parent = hrp.Parent
		end
	},

	--------------------
	{
		name = "Respawn",
		aliases = {"Res"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local player: Player = task.target
			local loadCharacter = CommandAPI.loadCharacter
			loadCharacter(player)
		end
	},

	--------------------
	{
		name = "Anchor",
		aliases = {"Freeze"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local setAnchored = CommandAPI.setAnchored
			task:keep("UntilTargetRespawns")
			setAnchored(target.Character, true)
			task:onEnded(function()
				setAnchored(target.Character, false)
			end)
		end
	},

	--------------------
	{
		name = "BodyTypeScale",
		aliases = {"BTScale"},
		args = {"Player", "Scale"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local scale = task:getArg("Scale")
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				BodyTypeScale = scale,
			}))
		end
	},

	--------------------
	{
		name = "HeadSize",
		aliases = {"HeadScale"},
		groups = {"HeadSize"},
		args = {"Player", "Scale"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local scale = task:getArg("Scale")
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				HeadScale = 1*scale,
			}))
		end
	},

	--------------------
	{
		name = "Width",
		aliases	= {"WScale", "WidthScale"};
		groups = {"CharWidth"},
		args = {"Player", "Scale"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local number = task:getArg("Scale")
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				WidthScale = number,
			}))
		end
	},

	--------------------
	{
		name = "Char",
		aliases = {"Character", "Become"},
		args = {"OptionalPlayer", "AnyUser"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local userId = task:getArg("AnyUser")
			local success, newDescription = pcall(function()
				return Players:GetHumanoidDescriptionFromUserIdAsync(userId)
			end)
			if not success then
				CommandAPI.prompt("warn", task.caller, tostring(newDescription))
				return
			end
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", -10, function(hasEnded, originalValue: any)
				local humanoid = getHumanoid(target)
				if not humanoid then return end
				local originalDescription = (originalValue or getDescription(humanoid)) :: any
				if hasEnded then
					applyDescription(humanoid, originalDescription)
				else
					applyDescription(humanoid, originalValue, newDescription)
				end
				return originalDescription
			end)
		end
	},

	--------------------
	{
		name = "R15",
		groups = {"RigType"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			runRigCommand(task, Enum.HumanoidRigType.R15)
		end
	},

	--------------------
	{
		name = "R6",
		groups = {"RigType"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			runRigCommand(task, Enum.HumanoidRigType.R6)
		end
	},

	--------------------

}


return commands
