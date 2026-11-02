--------|     Setting     |--------

--------|     Library     |--------
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end

--------|    Reference    |--------
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

--------|    Variables    |--------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function Check(child)
	if child.ClassName == "ScreenGui" then
		child.Parent = playerGui
	end
end


for _, child in ipairs(game.Players.LocalPlayer:GetChildren()) do
	Check(child)
end


game.Players.LocalPlayer.ChildAdded:Connect(function(child)
	Check(child)
end)
