local Tool = script.Parent
local TweenService = game:GetService("TweenService")

local function SetNumber()
	return math.random(1, 10)
end

Tool.Equipped:Connect(function()
	local Number = SetNumber()
	task.wait(0.1)

	local assetIDs = {
		{texture = "rbxassetid://16806930640", mesh = "rbxassetid://16806930843"},
		{texture = "rbxassetid://16807228774", mesh = "rbxassetid://16807226135"},
		{texture = "rbxassetid://16861012990", mesh = "rbxassetid://16861009954"},
		{texture = "rbxassetid://16862775479", mesh = "rbxassetid://16862773620"},
		{texture = "rbxassetid://16820442213", mesh = "rbxassetid://16820438884"},
		{texture = "rbxassetid://16857072565", mesh = "rbxassetid://16857113728"},
		{texture = "rbxassetid://16885774041", mesh = "rbxassetid://16885772430"},
		{texture = "rbxassetid://16819999790", mesh = "rbxassetid://16820007911"},
		{texture = "rbxassetid://16857936296", mesh = "rbxassetid://16857926712"},
		{texture = "rbxassetid://16861479362", mesh = "rbxassetid://16861476789"}
	}

	local mesh = script.Parent.Handle:FindFirstChildOfClass("SpecialMesh")
	if not mesh then
		mesh = Instance.new("SpecialMesh")
		mesh.Parent = script.Parent.Handle
	end

	local Out = TweenService:Create(
		script.Parent.Handle,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Transparency = 0}
	)

	if Tool.Equipped then
		script.Parent.RareEffect.Enabled = true
		script.Parent.RareEffect:Clone().Parent = script.Parent.Handle
	else
	if Tool.Unequipped then
		script.Parent.RareEffect.Enabled = false
	end
	end
	local In = TweenService:Create(
		script.Parent.Handle,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Transparency = 0}
	)

	Out:Play()
	Out.Completed:Connect(function()
		mesh.MeshId = assetIDs[Number].mesh
		mesh.TextureId = assetIDs[Number].texture
		In:Play()
	end)
end)
