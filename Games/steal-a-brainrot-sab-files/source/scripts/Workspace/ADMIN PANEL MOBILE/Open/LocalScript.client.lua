local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AuthorizedIds = {1557378019}
local Button = script.Parent

local isAuthorized = false
for _, id in ipairs(AuthorizedIds) do
	if Player.UserId == id then
		isAuthorized = true
		break
	end
end

Button.Visible = isAuthorized

if isAuthorized then
	local CommandExecutor = Player:WaitForChild("PlayerGui"):WaitForChild("Command Executor")

	Button.MouseButton1Click:Connect(function()
		CommandExecutor.Enabled = not CommandExecutor.Enabled
	end)
end