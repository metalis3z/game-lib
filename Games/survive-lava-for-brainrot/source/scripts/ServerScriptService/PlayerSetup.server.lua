local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerController = require(ServerScriptService.Controllers.PlayerController)

local BASE_JUMPPOWER = 50
local BASE_WALKSPEED = 10

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.UseJumpPower = true

		-- obtener profile
		local profile = PlayerController:GetProfile(player)
		if not profile then return end

		local rebirths = profile.Data.Rebirths or 0

		-- 🔥 reaplicar salto (1.5x por rebirth)
		humanoid.JumpPower = BASE_JUMPPOWER * (1.5 ^ rebirths)

		-- reaplicar speed
		humanoid.WalkSpeed = profile.Data.Speed or BASE_WALKSPEED
	end)
end)

