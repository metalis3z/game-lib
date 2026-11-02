local modifiers = {}

for i,v in pairs(require(game.ReplicatedStorage.Modifiers)) do
	local bl = Instance.new("BoolValue", game.Workspace.Game.Modifiers)
	bl.Value = false
	bl.Name = i
end

local bl = Instance.new("IntValue", game.Workspace.Game.Modifiers)
bl.Value = 0
bl.Name = "KnobBonus"