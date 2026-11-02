--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getHumanoid = CommandAPI.getHumanoid
local getHead = CommandAPI.getHead
local getHRP = CommandAPI.getHRP
local StarterPlayer = game:GetService("StarterPlayer")


-- LOCAL FUNCTIONS
local function humanoidBuff(target: Player, property: string, value: any, backupOriginalValue: any, hasEnded: boolean, originalValue: any)
	local humanoid = getHumanoid(target) :: any
	local originalPropertyValue = if humanoid then humanoid[property] else backupOriginalValue
	local newValue = if hasEnded then originalValue else value
	if humanoid then
		humanoid[property] = newValue
	end
	return originalPropertyValue
end


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	{
		name = "Spin",
		args = {
			"Player",
			{arg = "Number", default = 14, min = 0, max = 100, step = 1},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local head = getHead(target)
			if not head then return end
			task:keep("UntilTargetRespawns")
			local spin1 = task.janitor:add(Instance.new("BodyAngularVelocity"))
			spin1.MaxTorque = Vector3.new(300000, 300000, 300000)
			spin1.P = 300
			spin1.Parent = head
			local spin2 = task.janitor:add(Instance.new("BodyGyro"))
			spin2.MaxTorque = Vector3.new(400000, 0, 400000)
			spin2.D = 500
			spin2.P = 300
			spin2.Parent = head
			local function applySpinSpeed()
				if spin1.Parent then
					spin1.AngularVelocity = Vector3.new(0, task:getArg("Number"), 0)
				end
			end
			applySpinSpeed()
			task:bindPrompt({
				args = {"Number"},
				onChange = applySpinSpeed,
			})
		end
	},

    --------------------
	{
		name = "Fire",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local hrp = getHRP(target)
			if not hrp then return end
			task:keep("UntilTargetRespawns")
			local item = task.janitor:add(Instance.new("Fire"))
			item.Parent = hrp
		end
	},

    --------------------
	{
		name = "Smoke",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local hrp = getHRP(target)
			if not hrp then return end
			task:keep("UntilTargetRespawns")
			local item = task.janitor:add(Instance.new("Smoke"))
			item.Parent = hrp
		end
	},

    --------------------
	{
		name = "Sparkles",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local hrp = getHRP(target)
			if not hrp then return end
			task:keep("UntilTargetRespawns")
			local item = task.janitor:add(Instance.new("Sparkles"))
			item.Parent = hrp
		end
	},

    --------------------
	{
		name = "Sit",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local humanoid = getHumanoid(target)
			if not humanoid then return end
			humanoid.Sit = true
		end
	},

    --------------------
	{
		name = "Jump",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local humanoid = getHumanoid(target)
			if not humanoid then return end
			humanoid.Jump = true
		end
	},

    --------------------
	{
		name = "Fast",
		groups = {"WalkSpeed"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "WalkSpeed", function(...)
				return humanoidBuff(target, "WalkSpeed", 100, StarterPlayer.CharacterWalkSpeed, ...)
			end)
		end
	},

    --------------------
	{
		name = "Slow",
		groups = {"WalkSpeed"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "WalkSpeed", function(...)
				return humanoidBuff(target, "WalkSpeed", 5, StarterPlayer.CharacterWalkSpeed, ...)
			end)
		end
	},

    --------------------
	{
		name = "SuperJump",
		groups = {"JumpHeight"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "JumpHeight", function(...)
				return humanoidBuff(target, "JumpHeight", 100, StarterPlayer.CharacterJumpHeight, ...)
			end)
		end
	},

    --------------------
	{
		name = "HeavyJump",
		groups = {"JumpHeight"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "JumpHeight", function(...)
				return humanoidBuff(target, "JumpHeight", 3, StarterPlayer.CharacterJumpHeight, ...)
			end)
		end
	},

    --------------------
	--!!! bring back later
	--[[{
		name = "Warp",
		args = {"Player"},
		cooldown = 7.5,
		run = function(task: CommandAPI.Task)
			local target = task.target
			task.client:run(target)
		end
	},--]]

    --------------------

}


return commands
