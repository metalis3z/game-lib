--  █████╗ ███╗   ██╗ ██████╗ ███████╗██╗     ██╗   ██╗███████╗    ██████╗ ███████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ ██╗██╗     ███████╗███████╗
-- ██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     ██║   ██║██╔════╝    ██╔══██╗██╔════╝██╔════╝ ██╔═══██╗████╗ ████║██╔══██╗██║██║     ██╔════╝██╔════╝
-- ███████║██╔██╗ ██║██║  ███╗█████╗  ██║     ██║   ██║███████╗    ██║  ██║█████╗  ██║      ██║   ██║██╔████╔██║██████╔╝██║██║     █████╗  ███████╗
-- ██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     ██║   ██║╚════██║    ██║  ██║██╔══╝  ██║      ██║   ██║██║╚██╔╝██║██╔═══╝ ██║██║     ██╔══╝  ╚════██║
-- ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗╚██████╔╝███████║    ██████╔╝███████╗╚██████╗ ╚██████╔╝██║ ╚═╝ ██║██║     ██║███████╗███████╗███████║
-- ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚══════╝    ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

-- @ Angelus Decompiles — @Chlorls & @imoRR
-- @ Discord : discord.gg/nDWm6PkFrT
-- @ Decompiled

-- https://lua.expert/
local ViewportFrame = Instance.new("ViewportFrame")
ViewportFrame.Size = UDim2.new(1, 0, 1, 0)
ViewportFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
ViewportFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ViewportFrame.BackgroundTransparency = 1
local function getSurfaceInfo(p1) --[[ getSurfaceInfo | Line: 14 ]]
	local Adornee = p1.Adornee
	local Size = Adornee.Size
	local v2 = -Vector3.FromNormalId(p1.Face)
	local v4 = CFrame.fromAxisAngle(math.abs(v2.Y) == 1 and Vector3.new(v2.Y, 0, 0) or Vector3.new(0, 1, 0), 1.5707963267948966) * v2
	local Unit = v2:Cross(v4).Unit
	return Adornee.CFrame * CFrame.fromMatrix(-v2 * Size / 2, v4, Unit, v2), Vector2.new((Size * v4).Magnitude, (Size * Unit).Magnitude)
end
local function bindToSurfaceGui(p1) --[[ bindToSurfaceGui | Line: 35 | Upvalues: ViewportFrame (copy) ]]
	local Camera = Instance.new("Camera")
	Camera.Parent = p1
	local v1 = ViewportFrame:Clone()
	v1.CurrentCamera = Camera
	v1.Parent = p1
	return table.freeze({
		camera = Camera,
		viewportFrame = v1,
		surfaceGui = p1
	})
end
local function render(p1) --[[ render | Line: 50 | Upvalues: getSurfaceInfo (copy) ]]
	local camera = p1.camera
	local viewportFrame = p1.viewportFrame
	local surfaceGui = p1.surfaceGui
	local CurrentCamera = workspace.CurrentCamera
	local v1 = CurrentCamera.CFrame
	local v2, v3 = getSurfaceInfo(surfaceGui)
	local Y = CurrentCamera.ViewportSize.Y
	local v4 = v2:PointToObjectSpace(v1.Position)
	local v5 = v4.X / v3.X
	local v6 = v4.Y / v3.Y
	local v7 = math.abs(v5) * 2 + 1
	local v8 = math.abs(v6) * 2 + 1
	local v9 = math.sqrt(v7 * v7 + v8 * v8)
	local v10 = (v1.Position - v2.Position):Dot(v2.LookVector)
	local v12 = math.atan2(v3.Y / 2, v10) * 2
	local v14 = math.clamp(math.deg(v12), 1, 120)
	local v17 = v10 / (v3.Y / 2 / math.tan(math.rad(v14) / 2))
	local v19 = (if v12 > 2.0943951023931953 and v17 then v17 else 1) / v9
	local v20 = CFrame.new(0, 0, 0, v19, 0, 0, 0, v19, 0, 0, 0, 1)
	viewportFrame.Position = UDim2.new(viewportFrame.AnchorPoint.X - v5, 0, viewportFrame.AnchorPoint.Y - v6, 0)
	viewportFrame.Size = UDim2.new(v9, 0, v9, 0)
	surfaceGui.CanvasSize = Vector2.new(Y * (v3.X / v3.Y), Y)
	camera.FieldOfView = v14
	camera.CFrame = CFrame.new(v1.Position) * (v2 - v2.Position) * CFrame.Angles(0, math.pi, 0) * v20
end
return table.freeze({
	bindToSurfaceGui = bindToSurfaceGui,
	render = render
})