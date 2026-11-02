local Tool = script.Parent
local TweenService = game:GetService("TweenService")

local function SetNumber()
	return math.random(1, 4)
end

Tool.Equipped:Connect(function()
	local Number = SetNumber()
	task.wait(0.1)

	local assetIDs = {
		{texture = "rbxassetid://16856949764"},
		{texture = "rbxassetid://16856951131"},
		{texture = "rbxassetid://16856949398"},
		{texture = "rbxassetid://16856950093"},
	}

	local mesh = script.Parent.Handle:FindFirstChildOfClass("SpecialMesh")
	if not mesh then
		mesh = Instance.new("SpecialMesh")
		mesh.MeshId = "rbxassetid://16806930843"
		mesh.Parent = script.Parent.Handle
	end

	local Out = TweenService:Create(
		script.Parent.Handle,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Transparency = 0}
	)

	local In = TweenService:Create(
		script.Parent.Handle,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Transparency = 0}
	)

	Out:Play()
	Out.Completed:Connect(function()
		mesh.TextureId = assetIDs[Number].texture
		In:Play()
	end)
end)
