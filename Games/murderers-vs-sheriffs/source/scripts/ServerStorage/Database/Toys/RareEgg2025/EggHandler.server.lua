local Tool = script.Parent
local TweenService = game:GetService("TweenService")

local function SetNumber()
	return math.random(1, 10)
end

Tool.Equipped:Connect(function()
	local Number = SetNumber()

	local assetIDs = {
		{texture = "rbxassetid://128404729635383", mesh = "rbxassetid://135283105477136"},
		{texture = "rbxassetid://123993752918134", mesh = "rbxassetid://98346820340278"},
		{texture = "rbxassetid://86441627550515", mesh = "rbxassetid://99535186022014"},
		{texture = "rbxassetid://103940458713774", mesh = "rbxassetid://133537507405124"},
		{texture = "rbxassetid://136665550252689", mesh = "rbxassetid://86283500988625"},
		{texture = "rbxassetid://77198165191919", mesh = "rbxassetid://125543657120887"},
		{texture = "rbxassetid://80839954585006", mesh = "rbxassetid://72517194406725"},
		{texture = "rbxassetid://73377008018072", mesh = "rbxassetid://76177211214406"},
		{texture = "rbxassetid://136825745210896", mesh = "rbxassetid://79851503365669"},
		{texture = "rbxassetid://88636604442447", mesh = "rbxassetid://89883106868732"}
	}

	local mesh = script.Parent.Handle:FindFirstChildOfClass("SpecialMesh")
	if not mesh then
		mesh = Instance.new("SpecialMesh")
		mesh.Parent = script.Parent.Handle
	end
	if Tool.Equipped then
		script.Parent.RareEffect.Enabled = true
		script.Parent.RareEffect:Clone().Parent = script.Parent.Handle
	else
		if Tool.Unequipped then
			script.Parent.RareEffect.Enabled = false
		end
	end
	local Out = TweenService:Create(
		script.Parent.Handle,
		TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Transparency = 0}
	)

	
	local In = TweenService:Create(
		script.Parent.Handle,
		TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Transparency = 0}
	)

	Out:Play()
	Out.Completed:Connect(function()
		mesh.MeshId = assetIDs[Number].mesh
		mesh.TextureId = assetIDs[Number].texture
		In:Play()
	end)
end)
