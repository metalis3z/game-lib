local Character = script.Parent
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local GameDetails = require(game.ServerScriptService.Game.Directory:FindFirstChild("GameDetails"))

local function OnHumanoidFreeFalling(Active)
	while Active == true do
		if HumanoidRootPart.Position.Y < 300 then
			game.ReplicatedStorage.ClientBricks.Entities.VoidClient:FireClient(game.Players:GetPlayerFromCharacter(script.Parent))
		end
		wait(0.02)
	end
end

Humanoid.FreeFalling:Connect(OnHumanoidFreeFalling)