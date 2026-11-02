local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local v1 = Lib.UI.Get("PhotoUI")
local v2 = Lib.UI.Get("PhotoUI2")

Random.new()

local function CleanOldModels(p1) --[[ CleanOldModels | Line: 8 | Upvalues: v2 (copy), v1 (copy) ]]
	for v22, v3 in (p1 and v2 or v1):WaitForChild("ViewportFrame"):WaitForChild("WorldModel"):GetChildren() do
		if v3.Name == "PhotoVisitor" then
			v3:Destroy()
		end
	end
end

local function ResetPhoto(p1) --[[ ResetPhoto | Line: 21 | Upvalues: CleanOldModels (copy), v2 (copy), v1 (copy) ]]
	CleanOldModels(p1)

	local v12 = p1 and v2 or v1
	local v22 = v12.Adornee and v12.Adornee.Parent

	v12.Enabled = false
	v12:WaitForChild("Dark").BackgroundTransparency = 0

	if not v22 then
		return
	end

	v22.Parent = game.ReplicatedStorage.Misc
end

local function RevealPhoto(p1, p2, p3) --[[ RevealPhoto | Line: 33 | Upvalues: CleanOldModels (copy), v2 (copy), v1 (copy), Lib (copy) ]]
	CleanOldModels(p3)

	local v12 = p3 and v2 or v1

	v12.Enabled = true
	v12:WaitForChild("static").Visible = false

	local v22 = p3 or v12.Adornee and v12.Adornee.Parent
	local PhotoVisitor = p2:Clone()

	PhotoVisitor.Parent = v12:WaitForChild("ViewportFrame"):WaitForChild("WorldModel")
	PhotoVisitor:PivotTo(v12.ViewportFrame.RootPart.CFrame)
	PhotoVisitor.Name = "PhotoVisitor"

	local vp = v12.ViewportFrame
	local dark = v12:FindFirstChild("Dark")

	-- Cámara del ViewportFrame apuntando a la CARA del NPC (sin CurrentCamera = negro).
	local cam = vp:FindFirstChildOfClass("Camera")
	if not cam then
		cam = Instance.new("Camera")
		cam.Parent = vp
	end
	vp.CurrentCamera = cam
	vp.RootPart.Transparency = 1
	local rootCF = vp.RootPart.CFrame
	local focus = rootCF.Position + Vector3.new(0, 1.2, 0)
	cam.CFrame = CFrame.lookAt(focus + rootCF.LookVector * 6, focus)
	cam.FieldOfView = 40

	-- El "Dark" es la capa negra de la foto revelándose. Antes solo se desvanecía si
	-- v22.Parent==p1 (casi nunca) -> quedaba NEGRO. Ahora la desvanecemos SIEMPRE.
	if dark then
		local goal = { BackgroundTransparency = 1 }
		if dark:IsA("ImageLabel") then goal.ImageTransparency = 1 end
		Lib.TS:Create(dark, TweenInfo.new(1.2, Enum.EasingStyle.Quad), goal):Play()
	end

	task.delay(2.5, function()
		if not PhotoVisitor:GetAttribute("Cursed") or (v22 and Lib.GetCurrentInspect() ~= v22) then
			return
		end
		Lib.MusicService.Get("Horror1Bump", "jumpscare"):Play()
		Lib.PlayerLostSanity(10, "Cursed Photo")
	end)

	local Idle = game.ReplicatedStorage:WaitForChild("Animations"):WaitForChild("Idle")

	PhotoVisitor:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(Idle):Play(1, 1, 0)
	Lib.ApplySkinwalkerDisguiseReveal(PhotoVisitor, "PhotoEffect", v22)
end

Lib.Network:BindEvents({
	RevealPhoto = RevealPhoto,
	ResetPhoto = ResetPhoto
})
task.spawn(function() --[[ Line: 65 | Upvalues: CleanOldModels (copy), v1 (copy), v2 (copy) ]]
	CleanOldModels(nil)

	local v12 = v1
	local v22 = v12.Adornee and v12.Adornee.Parent

	v12.Enabled = false
	v12:WaitForChild("Dark").BackgroundTransparency = 0

	if v22 then
		v22.Parent = game.ReplicatedStorage.Misc
	end

	CleanOldModels(true)

	local v3 = v2 or v1
	local v4 = v3.Adornee and v3.Adornee.Parent

	v3.Enabled = false
	v3:WaitForChild("Dark").BackgroundTransparency = 0

	if not v4 then
		return
	end

	v4.Parent = game.ReplicatedStorage.Misc
end)

return {}