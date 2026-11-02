local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
-- Sample assumes a Main Portal Template model exists under Workspace
local mainPortal = Workspace:WaitForChild("Main Portal Template")

-- Get the policy info for the user
local success, result = pcall(PolicyService.GetPolicyInfoForPlayerAsync, PolicyService, player)
if success and result then
	if not result.AreAdsAllowed then
		-- Destroy all Main Portal Template instances on the user's client if ads are not allowed
		mainPortal:Destroy()
	end
else
	print("Failed to get policy for player", player.Name, "Exception:", result)
end