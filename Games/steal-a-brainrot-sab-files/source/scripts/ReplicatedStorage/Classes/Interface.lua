
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local CameraController = require(Controllers.CameraController)
local Classes = ReplicatedStorage:WaitForChild("Classes")
local AnimatedButton = require(Classes.AnimatedButton)
local Packages = ReplicatedStorage.Packages
local Signal = require(Packages.Signal)
local Trove = require(Packages.Trove)
local Styles = require(script.Styles)
local Toggle = Controllers.InterfaceController.Toggle
local t1 = {}

t1.__index = t1

function t1.AttachCloseButton(t2: {[any]: any}, p1, p2)
	local v16 = AnimatedButton.new(p1, p2)

	t2.Collector:Add(v16, "Destroy")
	v16:Animate(nil, nil, 5)
	t2.Collector:Add(v16.OnActivated:Connect(function()
		Toggle:Fire(t2.Name, false)
	end))
end
function t1.GetName(t3: {[any]: any})
	return t3.Name
end
function t1.GetStyleData(t4: {[any]: any})
	return Styles[t4:GetStyle()]
end
function t1.GetStyle(t5: {[any]: any})
	return t5.Style
end
function t1.SetStyle(t6: {[any]: any}, p3)
	t6.Style = p3
end
function t1.Open(t7: {[any]: any}, _: boolean?)
	if t7.ToggleConnection then
		t7.ToggleConnection:Disconnect()
		t7.ToggleConnection = nil
	end

	t7.State = true
	t7.Object.Visible = t7.State

	if t7.Style ~= "Custom" then
		local v24 = Styles[t7.Style]
		local DefaultsPosition = t7.Defaults.Position
		local DefaultsSize = t7.Defaults.Size
		local tweenInfo = TweenInfo.new(v24.ToggleTime, v24.Style)

		TweenService:Create(t7.Object, tweenInfo, {
			Position = DefaultsPosition,
			Size = DefaultsSize
		}):Play()
		CameraController:Blur(v24.BlurSize or 0, v24.ToggleTime)
		CameraController:Fov(v24.Fov or CameraController:GetDefaultFov(), v24.ToggleTime)
	end

	t7.OnOpen:Fire()
end
function t1.Close(t8: {[any]: any}, _: boolean?)
	if t8.ToggleConnection then
		t8.ToggleConnection:Disconnect()
		t8.ToggleConnection = nil
	end

	t8.State = false

	if t8.Style ~= "Custom" then
		local v30 = Styles[t8.Style]
		local v31 = t8.Defaults.Position + v30.Position
		local v32 = t8.Defaults.Size + v30.Size
		local tweenInfo = TweenInfo.new(v30.ToggleTime, v30.Style)
		local v34 = TweenService:Create(t8.Object, tweenInfo, {
			Position = v31,
			Size = v32
		})

		t8.ToggleConnection = v34.Completed:Connect(function()
			t8.Object.Visible = false
		end)
		v34:Play()
	end

	t8.OnClose:Fire()
end
function t1.Toggle(t9: {[any]: any}, b3: boolean?)
	t9[(b3 and b3 or not t9.State) ~= true and "Close" or "Open"](t9)
end
function t1.IsOpened(t10: {[any]: any})
	return t10.State
end
function t1.new(s1: string, p4, p5)
	local v41 = setmetatable({}, t1)

	v41.Name = s1
	v41.Object = p4
	v41.Defaults = {}
	v41.Defaults.Position = v41.Object.Position
	v41.Defaults.Size = v41.Object.Size
	v41.State = true
	v41.Style = p5 or "TopQuint"
	v41.OnOpen = Signal.new()
	v41.OnClose = Signal.new()
	v41.Collector = Trove.new()

	local LayerCollector = p4:FindFirstAncestorWhichIsA("LayerCollector")

	if LayerCollector then
		local function updateLayerCollectorVisibility()
			if #LayerCollector:GetChildren() ~= 1 then
				LayerCollector.Enabled = true

				return
			end

			LayerCollector.Enabled = p4.Visible
		end

		v41.Collector:Add(LayerCollector.ChildAdded:Connect(updateLayerCollectorVisibility))
		v41.Collector:Add(LayerCollector.ChildRemoved:Connect(updateLayerCollectorVisibility))
		v41.Collector:Add(p4:GetPropertyChangedSignal("Visible"):Connect(updateLayerCollectorVisibility))
		task.spawn(updateLayerCollectorVisibility)
	end

	return v41
end

return t1
