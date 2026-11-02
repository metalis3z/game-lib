local t = { 0, 1, 2, 3, 4, 5, 6, 7 }
local t2 = { 0, 1, 3, 4, 5, 7 }
local t3 = { 0, 1, 4, 5, 6 }
local t4 = {}

t4.__index = t4
t4.ClassName = "ViewportModel"

local v1 = Random.new()

local function getIndices(p1) --[[ getIndices | Line: 37 | Upvalues: t2 (copy), t3 (copy), t (copy) ]]
	if p1:IsA("WedgePart") then
		return t2
	end

	if p1:IsA("CornerWedgePart") then
		return t3
	end

	return t
end

local function getCorners(p1, p2, p3) --[[ getCorners | Line: 46 ]]
	local t = {}

	for k, v in pairs(p3) do
		local v1 = math.floor(v / 4) % 2 * 2 - 1

		t[k] = p1 * (p2 * Vector3.new(v1, math.floor(v / 2) % 2 * 2 - 1, 2 * (v % 2) - 1))
	end

	return t
end

local function getModelPointCloud(p1) --[[ getModelPointCloud | Line: 58 | Upvalues: t2 (copy), t3 (copy), t (copy), getCorners (copy) ]]
	local t4 = {}

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			for k2, v3 in pairs((getCorners(v.CFrame, v.Size / 2, if v:IsA("WedgePart") then t2 elseif v:IsA("CornerWedgePart") then t3 else t))) do
				table.insert(t4, v3)
			end
		end
	end

	return t4
end

local function viewProjectionEdgeHits(p1, p2, p3, p4) --[[ viewProjectionEdgeHits | Line: 72 ]]
	local v1 = (-1 / 0)
	local v2 = (1 / 0)

	for k, v in pairs(p1) do
		local v3 = p4 * (p3 - v.Z)
		local v4 = v[p2] + v3
		local v5 = v[p2] - v3
		local v6 = math.max(v1, v4, v5)

		v1, v2 = v6, math.min(v2, v4, v5)
	end

	return v1, v2
end

function t4.new(p1, p2) --[[ new | Line: 91 | Upvalues: t4 (copy) ]]
	local v2 = setmetatable({}, t4)

	v2.Model = nil
	v2.ViewportFrame = p1
	v2.Camera = p2
	v2._points = {}
	v2._modelCFrame = CFrame.new()
	v2._modelSize = Vector3.new()
	v2._modelRadius = 0
	v2._viewport = {}
	v2:Calibrate()

	return v2
end
function t4.SetModel(p1, p2) --[[ SetModel | Line: 115 | Upvalues: getModelPointCloud (copy) ]]
	p1.Model = p2

	local v1, v2 = p2:GetBoundingBox()

	p1._points = getModelPointCloud(p2)
	p1._modelCFrame = v1
	p1._modelSize = v2
	p1._modelRadius = v2.Magnitude / 2
end
function t4.Calibrate(p1) --[[ Calibrate | Line: 128 ]]
	local t = {}
	local AbsoluteSize = p1.ViewportFrame.AbsoluteSize

	t.aspect = AbsoluteSize.X / AbsoluteSize.Y
	t.yFov2 = math.rad(p1.Camera.FieldOfView / 2)
	t.tanyFov2 = math.tan(t.yFov2)
	t.xFov2 = math.atan(t.tanyFov2 * t.aspect)
	t.tanxFov2 = math.tan(t.xFov2)
	t.cFov2 = math.atan(t.tanyFov2 * math.min(1, t.aspect))
	t.sincFov2 = math.sin(t.cFov2)
	p1._viewport = t
end
function t4.GetFitDistance(p1, p2) --[[ GetFitDistance | Line: 150 ]]
	return (p1._modelRadius + (p2 and (p2 - p1._modelCFrame.Position).Magnitude or 0)) / p1._viewport.sincFov2
end
function t4.GetMinimumFitCFrame(p1, p2) --[[ GetMinimumFitCFrame | Line: 162 | Upvalues: viewProjectionEdgeHits (copy) ]]
	if not p1.Model then
		return CFrame.new()
	end

	local v1 = (p2 - p2.Position):Inverse()
	local _points = p1._points
	local t = { v1 * _points[1] }
	local Z = t[1].Z

	for i = 2, #_points do
		local v2 = v1 * _points[i]
		local v3 = math.min(Z, v2.Z)

		t[i] = v2
		Z = v3
	end

	local v4, v5 = viewProjectionEdgeHits(t, "X", Z, p1._viewport.tanxFov2)
	local v6, v7 = viewProjectionEdgeHits(t, "Y", Z, p1._viewport.tanyFov2)

	return p2 * CFrame.new((v4 + v5) / 2, (v6 + v7) / 2, Z + math.max((v4 - v5) / 2 / p1._viewport.tanxFov2, (v6 - v7) / 2 / p1._viewport.tanyFov2))
end

local function isVisible(p1) --[[ isVisible | Line: 196 ]]
	local v1 = true

	while p1 and (v1 and (p1:IsA("GuiObject") and not (p1:IsA("ScreenGui") or p1:IsA("Folder")))) do
		local v2 = if v1 then p1.Visible else v1

		p1 = p1.Parent
		v1 = v2
	end

	return v1
end

local t5 = {}

function t4.SetUpViewport(p1, p2, p3, p4, p5) --[[ SetUpViewport | Line: 207 | Upvalues: t5 (copy), t4 (copy), v1 (copy), isVisible (copy) ]]
	if p1.viewport:FindFirstChild(p2) then
		return
	end

	local v12 = p1.viewport:FindFirstChildOfClass("WorldModel") or p1.viewport

	if p4 then
		if t5[p1] then
			t5[p1]:Disconnect()
		end

		local Camera = v12:FindFirstChildOfClass("Camera")
		local Model = v12:FindFirstChildOfClass("Model")

		if Camera then
			Camera:Destroy()
		end

		if Model then
			Model:Destroy()
		end
	end

	local Camera = Instance.new("Camera")
	local v2 = p3:FindFirstChild(p2)

	if not v2 then
		print(p2, "not found")

		return
	end

	local v3 = v2:Clone()
	local list, v4 = {}, v3

	for i, v in ipairs(v3:GetChildren()) do
		if v:IsA("Accessory") then
			list[#list + 1] = v
			v.Parent = nil
		end
	end

	Camera.FieldOfView = 70
	Camera.Parent = v12
	v4.Parent = v12
	p1.viewport.CurrentCamera = Camera
	p1.viewport.LightColor = Color3.new(1.25, 1.25, 1.4)

	local v5 = t4.new(p1.viewport, Camera)
	local v6, _ = v4:GetBoundingBox()

	v5:SetModel(v4)

	local v7 = 0
	local v8 = CFrame.new()
	local v9 = v5:GetFitDistance(v6.Position)

	task.spawn(function() --[[ Line: 252 | Upvalues: p5 (copy), v8 (ref), Camera (copy), v6 (copy), v9 (copy), p4 (copy), v1 (ref), t5 (ref), p1 (copy), isVisible (ref), v7 (ref) ]]
		game:GetService("UserInputService")

		if not p5 then
			v8 = CFrame.fromEulerAnglesYXZ(-0.17453292519943295, -1.0471975511965976, 0)
			Camera.CFrame = CFrame.new(v6.Position) * v8 * CFrame.new(0, 0, v9) + Vector3.new(0, 0.5, 0)

			return
		end

		local v12 = task.wait

		v12(if p4 then 0 else v1:NextNumber(0, 2))
		t5[p1] = game:GetService("RunService").Heartbeat:Connect(function(p12) --[[ Line: 262 | Upvalues: isVisible (ref), p1 (ref), v7 (ref), v8 (ref), Camera (ref), v6 (ref), v9 (ref) ]]
			if isVisible(p1) then
				v7 = v7 + math.rad(30 * p12) * 1
				v8 = CFrame.fromEulerAnglesYXZ(0, v7, 0)
				Camera.CFrame = CFrame.new(v6.Position) * v8 * CFrame.new(0, 0, v9)
			end
		end)
	end)

	for i, v in ipairs(list) do
		v.Parent = v4
	end

	return v4
end

return t4