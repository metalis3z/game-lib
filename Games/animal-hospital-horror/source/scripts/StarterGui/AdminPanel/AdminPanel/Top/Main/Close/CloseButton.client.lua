--[[ Cierra el AdminPanel al hacer click/tap. ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lib = require(ReplicatedStorage:WaitForChild("Lib"))

Lib.Buttons.OnActivate(script.Parent, function()
	local panel = script:FindFirstAncestor("AdminPanel") -- el Frame AdminPanel
	if panel then
		Lib.Buttons.ChangeVisibility(panel)
	end
end)
