local Player = game:GetService("Players").LocalPlayer
local Button = script.Parent

if not Player:GetAttribute("Role") then
	Player:GetAttributeChangedSignal("Role"):Wait()
end

local Allowed = { Lead = true, Dev = true, Tester = true }

if Allowed[Player:GetAttribute("Role")] then
	Button.Visible = true
	Button.Text = "VERSION: " .. tostring(game.PlaceVersion)
else
	Button.Visible = false
end