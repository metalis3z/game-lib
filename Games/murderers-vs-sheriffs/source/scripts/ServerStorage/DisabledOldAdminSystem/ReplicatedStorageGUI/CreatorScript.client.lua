-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0, _ = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("GetCreatorStatus"):InvokeServer();
local l_Creator_0 = script.Parent:WaitForChild("Creator");
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
l_Creator_0.Visible = v0;
l_Creator_0:WaitForChild("Button").Activated:Connect(function() --[[ Line: 10 ]]
    l_WindowService_0:ToggleFrame("CreatorWindow");
end);