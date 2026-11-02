--credit to prince games studio
return {
	Name = "setskillpointlevel",
	Description = "Sets a player\'s skill (BaseSpeed/BaseJump/ShovelPower/MaxBackpack) to a specific level",
	Group = "DefaultAdmin",
	Aliases = { "setskillpointlevel", "setskill", "setskilllevel" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to set the skill level for"
		},
		{
			Type = "skillName",
			Name = "SkillName",
			Description = "The skill to set (BaseSpeed, BaseJump, ShovelPower, MaxBackpack)"
		},
		{
			Type = "positiveInteger",
			Name = "Level",
			Description = "The level to set the skill to (>=1)"
		}
	}
,
	ClientRun = function(context, ...)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local bridge = ReplicatedStorage:WaitForChild("AdminCommandBridge", 10)
		if not bridge then
			return "AdminCommandBridge remote not found."
		end
		return bridge:InvokeServer(context.Name or script.Name, {...})
	end
}