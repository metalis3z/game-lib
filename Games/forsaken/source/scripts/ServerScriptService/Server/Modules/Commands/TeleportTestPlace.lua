-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Teleport to Test Place", 
    LayoutOrder = -5, 
    Executable = true, 
     
    Parameters = {
    }, 
	Executed = function(v0, v1 : Instance, v2, v3) --[[ Line: 24 ]] --[[ Name: Executed ]]
		if workspace:FindFirstChild("StudioAssets") then
			if typeof(v1) == "Instance" and v1:IsA("Player") and v1.Character and v1.Character.PrimaryPart then
				v1.Character.PrimaryPart.CFrame = workspace.StudioAssets.Spawnn.CFrame
			end
		end
    end
};