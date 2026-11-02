script.Parent.OnServerEvent:connect(function(Player,Target)
			script.Parent.Parent.Parent.Parent = game.Workspace
			Target:EquipTool(script.Parent.Parent.Parent)
end)