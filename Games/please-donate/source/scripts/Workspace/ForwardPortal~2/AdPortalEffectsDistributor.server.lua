--


local PlayersService = game:GetService("Players")
local portalModel = script.Parent
local templateLocalScript = script:WaitForChild("LocalAdPortalEffectsController")


-- Give local portal controllers to new and existing players
function GiveToPlayer(player)
	if portalModel and portalModel.Parent then
		
		local playerGui = player:WaitForChild("PlayerGui", 30)
		if playerGui then
			
			-- Encapsulate the localscript in a LayerCollector to prevent destruction on respawn. (I hate this.)
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "LocalScriptContainer"
			screenGui.ResetOnSpawn = false
			
			local newLocalScript = templateLocalScript:Clone()
			local portalTag = Instance.new("ObjectValue")
			portalTag.Name = "PortalTag"
			portalTag.Value = portalModel
			portalTag.Parent = newLocalScript
			newLocalScript.Parent = screenGui
			screenGui.Parent = playerGui
			newLocalScript.Disabled = false
		end
	end
end

PlayersService.PlayerAdded:connect(GiveToPlayer)
for _, player in pairs(PlayersService:GetPlayers()) do
	task.spawn(function()
		GiveToPlayer(player)
	end)
end


-- If this portal is destroyed, destroy local portal controllers that point to this portal
function CleanUp()
	print("CleanUp!")
	for _, player in pairs(PlayersService:GetPlayers()) do
		local playerGui = player:FindFirstChild("PlayerGui")
		if playerGui then
			for _, screenGui in pairs(playerGui:GetChildren()) do
				if screenGui.Parent and screenGui.Name == "LocalScriptContainer" then
					local portalTag = screenGui:FindFirstChild("PortalTag", true)
					if portalTag and portalTag.Value == portalModel then
						screenGui:Destroy()
					end
				end
			end
		end
	end
end

portalModel.Destroying:Connect(CleanUp)