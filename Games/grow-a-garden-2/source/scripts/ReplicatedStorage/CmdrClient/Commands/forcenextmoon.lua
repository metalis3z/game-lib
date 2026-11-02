--credit to leon games studio
return {
	Name = "forcenextmoon",
	Description = "GLOBAL: queue a moon for the NEXT natural night on EVERY live server (and servers that boot before that night ends, via MemoryStore). No phase jump.",
	Group = "DefaultAdmin",
	Aliases = { "forcenextmoon" },
	Args = {
		{
			Type = "moonType",
			Name = "MoonType",
			Description = "The moon type (e.g. Moon, Bloodmoon, Goldmoon, Rainbow Moon, Chained Moon, Pizza Moon)."
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