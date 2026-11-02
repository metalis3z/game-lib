--credit to leon games studio
local t = {
	StartOrder = 0
}
local TweenService = game:GetService("TweenService")
local v1 = 70
local v2 = 0
local v3 = nil

local function getCurrentCamera() --[[ getCurrentCamera | Line: 16 ]]
	return workspace.CurrentCamera
end

local function getTargetFOV() --[[ getTargetFOV | Line: 20 | Upvalues: v1 (ref), v2 (ref) ]]
	return v1 + v2
end

local function applyFOV(p1, p2) --[[ applyFOV | Line: 24 | Upvalues: v1 (ref), v2 (ref), v3 (ref), TweenService (copy) ]]
	local CurrentCamera = workspace.CurrentCamera

	if not CurrentCamera then
		return
	end

	local v12 = v1 + v2

	if v3 then
		v3:Cancel()
		v3:Destroy()
		v3 = nil
	end

	if p1 then
		CurrentCamera.FieldOfView = v12
	else
		local v22 = TweenService:Create(CurrentCamera, TweenInfo.new(p2 or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			FieldOfView = v12
		})

		v3 = v22
		v22.Completed:Once(function() --[[ Line: 42 | Upvalues: v3 (ref), v22 (copy) ]]
			if v3 == v22 then
				v3 = nil
			end

			v22:Destroy()
		end)
		v22:Play()
	end
end

function t.GetBaseFOV(p1) --[[ GetBaseFOV | Line: 54 | Upvalues: v1 (ref) ]]
	return v1
end
function t.SetBaseFOV(p1, p2, p3, p4) --[[ SetBaseFOV | Line: 58 | Upvalues: v1 (ref), v2 (ref), applyFOV (copy) ]]
	v1 = p2
	v2 = 0
	applyFOV(p3, p4)
end
function t.GetAdjuster(p1) --[[ GetAdjuster | Line: 64 | Upvalues: v2 (ref) ]]
	return v2
end
function t.SetAdjuster(p1, p2, p3) --[[ SetAdjuster | Line: 68 | Upvalues: v2 (ref), applyFOV (copy) ]]
	v2 = p2
	applyFOV(p3)
end
function t.GetTargetFOV(p1) --[[ GetTargetFOV | Line: 74 | Upvalues: v1 (ref), v2 (ref) ]]
	return v1 + v2
end
function t.GetCurrentFOV(p1) --[[ GetCurrentFOV | Line: 78 | Upvalues: v1 (ref) ]]
	return workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView or v1
end
function t.ClearAdjuster(p1, p2) --[[ ClearAdjuster | Line: 83 | Upvalues: v2 (ref), applyFOV (copy) ]]
	v2 = 0
	applyFOV(p2)
end
function t.Reset(p1, p2) --[[ Reset | Line: 89 | Upvalues: v1 (ref), v2 (ref), applyFOV (copy) ]]
	v1 = 70
	v2 = 0
	applyFOV(p2)
end
function t.Init(p1) --[[ Init | Line: 100 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
	v1 = 70

	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera then
		CurrentCamera.FieldOfView = v1
	end

	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 106 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
		local CurrentCamera = workspace.CurrentCamera

		if not CurrentCamera then
			return
		end

		local v12 = v1 + v2

		if not v3 then
			CurrentCamera.FieldOfView = v12

			return
		end

		v3:Cancel()
		v3:Destroy()
		v3 = nil
		CurrentCamera.FieldOfView = v12
	end)
end
function t.Start(p1) --[[ Start | Line: 111 ]] end

return t