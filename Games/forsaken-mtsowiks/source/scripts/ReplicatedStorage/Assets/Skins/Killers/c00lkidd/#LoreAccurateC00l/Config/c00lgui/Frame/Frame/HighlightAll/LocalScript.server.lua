local player = script.Parent.Parent.Parent.Parent.Parent.Parent
local button = script.Parent

button.MouseButton1Click:Connect(function()
	for _, child in ipairs(workspace.Players.Survivors:GetChildren()) do
		require(game.ReplicatedStorage.Modules.Util):RevealPlayerAuraTo(player, child, 99999999999)
	end
end)
