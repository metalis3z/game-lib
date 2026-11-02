--[[
	Made by:
	no one
--]]

--Variables
--local setting = require(script.Settings)

local char = script.Parent
local hum = char.Humanoid

local gui = script.InjuredGui
local currentGui

--Run time code
--if char:FindFirstChild("Health") then char.Health:Destroy() end

--Functions
hum.HealthChanged:Connect(function(health)
	if health == 0 then
		local clone = gui:Clone()
		clone.Enabled = true
		clone.Parent = char.Head
		currentGui = clone
	end	
end)