while wait(60) do
	for _,Child in pairs(game.Workspace:GetChildren()) do
		if Child:IsA("Accessory") then
			Child:Destroy();
		end
	end
end;