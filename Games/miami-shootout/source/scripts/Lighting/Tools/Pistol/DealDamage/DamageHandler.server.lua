--> LOCAL VARIABLES
local Event = script.Parent
local NPC = false
local Person = false
local Enemy

--> FUNCTIONS
Event.OnServerEvent:Connect(function(Player, Target, Damage)
	Target.Humanoid:TakeDamage(Damage)
end)