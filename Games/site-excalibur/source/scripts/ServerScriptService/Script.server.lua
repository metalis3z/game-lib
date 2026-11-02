for i,v in pairs(game.ServerStorage.Framework:GetChildren()) do
	if v:IsA("ModuleScript") then
		require(v)
	end
end