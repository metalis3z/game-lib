local AdminSettings = script.Parent.AdminSettings
local l_WindowService_0 = require(game:GetService("ReplicatedStorage").Modules.WindowService);
AdminSettings.Visible = game.ReplicatedStorage.Remotes.Extras.CheckAdmin:InvokeServer()
AdminSettings:WaitForChild("Button").Activated:Connect(function()
	l_WindowService_0:ToggleFrame("AdminSettings");
end);