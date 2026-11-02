--credit to prince games studio
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Signal = require(script.Parent.Signal)
local CurrentCamera = Workspace.CurrentCamera
local ViewportSize = CurrentCamera.ViewportSize
local v1 = ViewportSize.Y / 1080
local v2 = math.clamp(v1, 0.33, 2)
local v3 = ViewportSize
local v4 = 0
local t = {
	Changed = Signal.new(),
	GetViewportSize = function() --[[ GetViewportSize | Line: 27 | Upvalues: ViewportSize (ref) ]]
		return ViewportSize
	end,
	GetResolutionScale = function() --[[ GetResolutionScale | Line: 31 | Upvalues: v2 (ref) ]]
		return v2
	end
}

function t.Observe(p1) --[[ Observe | Line: 35 | Upvalues: t (copy) ]]
	local v1 = t.Changed:Connect(function() --[[ Line: 36 | Upvalues: p1 (copy) ]]
		task.spawn(p1)
	end)

	task.spawn(p1)

	return function() --[[ Line: 42 | Upvalues: v1 (copy) ]]
		v1:Disconnect()
	end
end
CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 48 | Upvalues: ViewportSize (ref), CurrentCamera (copy), v2 (ref) ]]
	ViewportSize = CurrentCamera.ViewportSize
	v2 = math.clamp(ViewportSize.Y / 1080, 0.33, 2)
end)
RunService.RenderStepped:Connect(function() --[[ Line: 53 | Upvalues: ViewportSize (ref), v3 (ref), v4 (ref), t (copy) ]]
	if ViewportSize == v3 or not (os.clock() - v4 >= 0.15) then
		return
	end

	v4 = os.clock()
	v3 = ViewportSize
	t.Changed:Fire()
end)

return table.freeze(t)