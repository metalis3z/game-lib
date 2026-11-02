--------|     Setting     |--------

--------|     Library     |--------
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end

--------|    Reference    |--------
local StarterGui = game:GetService("StarterGui")

--------|    Variables    |--------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

wait() --- May not work in Studio without

StarterGui:SetCoreGuiEnabled("Health", false)
StarterGui:SetCoreGuiEnabled("Backpack", false)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
StarterGui.ResetPlayerGuiOnSpawn = false
StarterGui:SetCore("ResetButtonCallback", false)

