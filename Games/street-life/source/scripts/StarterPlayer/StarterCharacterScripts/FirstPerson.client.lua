if not game:IsLoaded() then game.Loaded:Wait() end

local Character = script.Parent
local Humanoid = Character:WaitForChild('Humanoid')
local Head = Character:WaitForChild('Head')
task.wait(2)
repeat task.wait(.1) until _G.FOV ~= nil
workspace.CurrentCamera.FieldOfView = _G.FOV
local Change = {'LeftUpperArm', 'LeftLowerArm', 'LeftHand', 'RightUpperArm', 'RightLowerArm', 'RightHand'}

for _,v in pairs(Character:GetChildren()) do
	if v:IsA('BasePart') then
		if table.find(Change, v.Name) then
			v.LocalTransparencyModifier = 0
			v.Changed:Connect(function() 
				v.LocalTransparencyModifier = 0
			end)
		end
	end
end

while task.wait(.1) do
	if Head then
		if Head.LocalTransparencyModifier == 1 then
			workspace.CurrentCamera.FieldOfView = _G.GunFOV
			if Head:FindFirstChildOfClass('BillboardGui') then Head:FindFirstChildOfClass('BillboardGui').Enabled = false end
			if Character.RightHand:FindFirstChild('RightGlove') then Character.RightHand.Transparency = 0 end
			if Character.LeftHand:FindFirstChild('LeftGlove') then Character.LeftHand.Transparency = 0 end
		elseif Head.LocalTransparencyModifier <= .5 then
			workspace.CurrentCamera.FieldOfView = _G.FOV
			if Head:FindFirstChildOfClass('BillboardGui') then Head:FindFirstChildOfClass('BillboardGui').Enabled = true end
			if Character.RightHand:FindFirstChild('RightGlove') then Character.RightHand.Transparency = 1 end
			if Character.LeftHand:FindFirstChild('LeftGlove') then Character.LeftHand.Transparency = 1 end
		end
	else
		workspace.CurrentCamera.FieldOfView = _G.FOV
	end
	if Humanoid.Sit then  
		if Humanoid.SeatPart and Humanoid.SeatPart.Name == 'DriveSeat' then
			if game:FindService('StarterGui'):GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) == true then
				game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
			end
			if Character:FindFirstChildOfClass('Tool') then
				Character:FindFirstChildOfClass('Tool').Parent = game:FindService('Players'):GetPlayerFromCharacter(Character).Backpack
			end
		end
	end
end