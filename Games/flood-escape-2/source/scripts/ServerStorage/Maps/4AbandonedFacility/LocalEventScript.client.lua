wait(3)
local Fans = workspace.Multiplayer:WaitForChild("Map").Fans:GetChildren()
local function fans(time)
	for _,v in pairs(Fans) do
		v:SetPrimaryPartCFrame(v:GetPrimaryPartCFrame() * CFrame.Angles(0, math.rad(-180 * time), 0))
	end
end
game:GetService("RunService").RenderStepped:Connect(fans)