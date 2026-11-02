--> LOCAL VARIABLES
local Pistol = script.Parent.Parent
local Player = game.Players.LocalPlayer
local BulletHoleEvent = script.Parent

--> FUNCTIONS
Pistol.Activated:Connect(function()
	local Mouse = Player:GetMouse()
	if BulletHoleEvent:WaitForChild("CurrentAmmo").Value ~= 0 then
		BulletHoleEvent:FireServer(Mouse.Hit.Position)
	else end
end)