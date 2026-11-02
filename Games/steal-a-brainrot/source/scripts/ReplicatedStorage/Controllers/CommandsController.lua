local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)
require(ReplicatedStorage.Shared.ConchTypes)

return {
	["Start"] = function(_)
		if Net:Invoke("CommandsService/ViewCommands") then
			Conch.initiate_default_lifecycle()
			Conch.ui.bind_to(Enum.KeyCode.F2)
			Net:Connect("CommandsService/OpenCommandBar", function()
				Conch.ui.opened(true)
			end)
		end
	end
}