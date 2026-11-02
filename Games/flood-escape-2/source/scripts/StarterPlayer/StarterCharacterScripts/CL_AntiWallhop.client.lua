--no this isn't Anti Wallhop script
--more like yipeeeee we have wallhop and slide glide!
--maybe wallhop idk


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local OldHumanoidRootPartSize = humanoidRootPart.Size;
local function isNearWall()
	local origin = humanoidRootPart.Position
	local forwardDirection = humanoidRootPart.CFrame.LookVector * 5
	local backwardDirection = humanoidRootPart.CFrame.LookVector * -5
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {character}
	local forwardRaycastResult = workspace:Raycast(origin, forwardDirection, raycastParams)
	if forwardRaycastResult then
		local hitPart = forwardRaycastResult.Instance
		if hitPart and hitPart:IsA("BasePart") then	
			return true
		end
	end
	local backwardRaycastResult = workspace:Raycast(origin, backwardDirection, raycastParams)
	if backwardRaycastResult then
		local hitPart = backwardRaycastResult.Instance
		if hitPart and hitPart:IsA("BasePart") then
			return true
		end
	end
	return false
end
script.CheckNearWall.OnInvoke = function()
	return isNearWall()
end

game:GetService("RunService").Stepped:Connect(function()
	if isNearWall() and game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript.isSlideDiving:Invoke() == true then
		humanoidRootPart.Shape = Enum.PartType.Ball
		humanoidRootPart.Size = Vector3.new(0.95, 0.95, 0.95)
	elseif game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript.isSliding:Invoke() == false then
		humanoidRootPart.Shape = Enum.PartType.Block
		humanoidRootPart.Size = OldHumanoidRootPartSize
	end
end)