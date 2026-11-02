-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Activate_0 = script.Parent:WaitForChild("Activate");
require(game.ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("PerkService")).PerkActivated.Event:Connect(function() --[[ Line: 8 ]] --[[ Name: onActivate ]]
	-- upvalues: l_LocalPlayer_0 (copy), l_Activate_0 (copy)
	if not l_LocalPlayer_0.Character then
		return;
	else
		local l_HumanoidRootPart_0 = l_LocalPlayer_0.Character:FindFirstChild("HumanoidRootPart");
		if not l_HumanoidRootPart_0 then 
			return;
		end;
		l_Activate_0:FireServer(l_HumanoidRootPart_0.CFrame);
	end;
end);