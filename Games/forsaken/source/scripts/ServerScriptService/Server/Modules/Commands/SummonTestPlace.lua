-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Summon Test Place", 
    LayoutOrder = -4, 
    Executable = true, 
     
    Parameters = {
    }, 
    Executed = function(_, _, v2, v3) --[[ Line: 24 ]] --[[ Name: Executed ]]
		if workspace:FindFirstChild("StudioAssets") then
			for i, v in ipairs(game.ServerStorage.Assets.DevMaps["Testing Place"].Survivors:GetChildren()) do
				v:Clone().Parent = workspace.Players.Survivors
			end
		else
			local newMap = game.ServerStorage.Assets.DevMaps["Testing Place"]:Clone()
			newMap.Name = "StudioAssets"
			newMap.Parent = workspace
			for i, v in ipairs(newMap.Survivors:GetChildren()) do
				v.Parent = workspace.Players.Survivors
			end
		end
    end
};