
local ViewportFrame = Instance.new("ViewportFrame")

ViewportFrame.Size = UDim2.new(1, 0, 1, 0)
ViewportFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
ViewportFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ViewportFrame.BackgroundTransparency = 1

local function getSurfaceInfo(p1)
	local p1Adornee = p1.Adornee
	local p1AdorneeCFrame = p1Adornee.CFrame
	local p1AdorneeSize = p1Adornee.Size
	local v7 = -Vector3.FromNormalId(p1.Face)
	local v8 = math.abs(v7.Y) == 1 and Vector3.new(v7.Y, 0, 0) or Vector3.new(0, 1, 0)
	local v9 = CFrame.fromAxisAngle(v8, 1.5707963267948966) * v7
	local Unit = v7:Cross(v9).Unit

	return p1AdorneeCFrame * CFrame.fromMatrix(-v7 * p1AdorneeSize / 2, v9, Unit, v7), (Vector2.new((p1AdorneeSize * v9).Magnitude, (p1AdorneeSize * Unit).Magnitude))
end

return table.freeze({
	bindToSurfaceGui = function(p2)
		local Camera = Instance.new("Camera")

		Camera.Parent = p2

		local clone = ViewportFrame:Clone()

		clone.CurrentCamera = Camera
		clone.Parent = p2

		return table.freeze({
			camera = Camera,
			viewportFrame = clone,
			surfaceGui = p2
		})
	end,
	render = function(t1: {[any]: any})
		local camera = t1.camera
		local viewportFrame = t1.viewportFrame
		local surfaceGui = t1.surfaceGui
		local CurrentCamera = workspace.CurrentCamera
		local CurrentCameraCFrame = CurrentCamera.CFrame
		local v20, v21 = getSurfaceInfo(surfaceGui)
		local ViewportSizeY = CurrentCamera.ViewportSize.Y
		local v23 = v20:PointToObjectSpace(CurrentCameraCFrame.Position)
		local v24 = v23.X / v21.X
		local v25 = v23.Y / v21.Y
		local v26 = math.abs(v24) * 2 + 1
		local v27 = math.abs(v25) * 2 + 1
		local v28 = math.sqrt(v26 * v26 + v27 * v27)
		local v29 = (CurrentCameraCFrame.Position - v20.Position):Dot(v20.LookVector)
		local v30 = math.atan2(v21.Y / 2, v29) * 2
		local v31 = math.clamp(math.deg(v30), 1, 120)
		local v32 = v29 / (v21.Y / 2 / math.tan(math.rad(v31) / 2))
		local v33 = (v30 > 2.0943951023931953 and v32 or 1) / v28
		local cFrame = CFrame.new(0, 0, 0, v33, 0, 0, 0, v33, 0, 0, 0, 1)

		viewportFrame.Position = UDim2.new(viewportFrame.AnchorPoint.X - v24, 0, viewportFrame.AnchorPoint.Y - v25, 0)
		viewportFrame.Size = UDim2.new(v28, 0, v28, 0)
		surfaceGui.CanvasSize = Vector2.new(ViewportSizeY * (v21.X / v21.Y), ViewportSizeY)
		camera.FieldOfView = v31
		camera.CFrame = CFrame.new(CurrentCameraCFrame.Position) * (v20 - v20.Position) * CFrame.Angles(0, 3.141592653589793, 0) * cFrame
	end
})
