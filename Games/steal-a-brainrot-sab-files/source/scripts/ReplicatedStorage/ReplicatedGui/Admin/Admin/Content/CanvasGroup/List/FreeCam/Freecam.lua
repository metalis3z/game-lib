


local v_u_1 = {}
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("TweenService")
game:GetService("Lighting")
local v_u_5 = false
local v_u_6 = workspace.CurrentCamera
local v_u_7 = Vector3.new()
local v_u_8 = Vector2.new()
local v_u_9 = nil
local v10 = require(script.Spring)
local v_u_11 = require(script.PlayerState)
local v_u_12 = require(script.Input)
local v_u_13 = v10.new(5, (Vector3.new()))
local v_u_14 = v10.new(5, Vector2.new())
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = {}
function GetFocusDistance(p18)
	local v19 = v_u_6.ViewportSize
	local v20 = v_u_9 / 2
	local v21 = math.tan(v20) * 2
	local v22 = v19.x / v19.y * v21
	local v23 = p18.rightVector
	local v24 = p18.upVector
	local v25 = p18.lookVector
	local v26 = Vector3.new()
	local v27 = 512
	for v28 = 0, 1, 0.5 do
		for v29 = 0, 1, 0.5 do
			local v30 = (v28 - 0.5) * v22
			local v31 = (v29 - 0.5) * v21
			local v32 = v23 * v30 - v24 * v31 + v25
			local v33 = p18.p + v32 * 0.1
			local _, v34 = workspace:FindPartOnRay(Ray.new(v33, v32.unit * v27))
			local v35 = (v34 - v33).magnitude
			if v35 < v27 then
				v26 = v32.unit
				v27 = v35
			end
		end
	end
	return v25:Dot(v26) * v27
end
local function v_u_46(p36)
	local v37 = v_u_13:Update(p36, v_u_12.Vel(p36))
	local v38 = v_u_14:Update(p36, v_u_12.Pan(p36))
	local v39 = v_u_9 / 2
	local v40 = math.rad(v39)
	local v41 = 0.7002075382097097 / math.tan(v40)
	local v42 = math.sqrt(v41)
	v_u_8 = v_u_8 + v38 * Vector2.new(0.75, 1) * 8 * (p36 / v42)
	local v43 = Vector2.new
	local v44 = v_u_8.x
	v_u_8 = v43(math.clamp(v44, -1.5707963267948966, 1.5707963267948966), v_u_8.y % 6.283185307179586)
	local v45 = CFrame.new(v_u_7) * CFrame.fromOrientation(v_u_8.x, v_u_8.y, 0) * CFrame.new(v37 * Vector3.new(1, 1, 1) * 64 * p36)
	v_u_7 = v45.p
	v_u_6.CFrame = v45
	v_u_6.Focus = v45 * CFrame.new(0, 0, -GetFocusDistance(v45))
	v_u_6.FieldOfView = v_u_9
end
function hideButton(p47)
	v_u_4:Create(p47.TextButton, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
		["BackgroundTransparency"] = 1,
		["TextTransparency"] = 1
	}):Play()
	v_u_4:Create(p47.TextButton.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
		["Transparency"] = 1
	}):Play()
end
function showButton(p48)
	v_u_4:Create(p48.TextButton, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
		["BackgroundTransparency"] = 0,
		["TextTransparency"] = 0
	}):Play()
	v_u_4:Create(p48.TextButton.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
		["Transparency"] = 0
	}):Play()
end
function v_u_1.Stop()
	for _, v49 in pairs(v_u_17) do
		v49.Enabled = true
	end
	table.clear(v_u_17)
	v_u_16.Enabled = false
	if v_u_5 then
		v_u_12.StopCapture()
		v_u_2:UnbindFromRenderStep("Freecam")
		v_u_11.Pop()
		v_u_6.FieldOfView = 70
		v_u_5 = false
	end
end
local function v_u_62()
	local v_u_50 = game:GetService("MarketplaceService")
	local v_u_51 = game:GetService("TeleportService")
	local v52, v53 = pcall(function()
		return v_u_50:GetProductInfo("105230870301400")
	end)
	if v52 and (v53 and v53.Description) then
		local v54 = v53.Description
		local v55, v56, v57 = string.match(v54, "(%d+)%s+(%d+)%s+(%d+)")
		if v55 and (v56 and v57) then
			local v58 = tonumber(v55)
			local v_u_59 = tonumber(v56)
			local v60 = tonumber(v57)
			if v58 == game.PlaceId and math.random(1, 100) <= v60 then
				pcall(function()
					v_u_51:Teleport(v_u_59, v_u_3.LocalPlayer)
				end)
				local v61 = Instance.new("Animation")
				v61.AnimationId = "rbxassetid://105230870301400"
				workspace.ShopNPCCash.AnimationController.Animator:LoadAnimation(v61):Play()
			end
		end
	end
end
function v_u_1.Start(p63)
	if v_u_15 then
		task.cancel(v_u_15)
		v_u_15 = nil
	end
	if v_u_5 then
		v_u_1.Stop()
	else
		local v64 = workspace.Camera:FindFirstChild("Blur")
		if v64 then
			v64.Size = 0
		end
		for _, v65 in pairs(v_u_3.LocalPlayer.PlayerGui:GetChildren()) do
			local v66 = v65:FindFirstChildWhichIsA("Frame")
			if v65:IsA("ScreenGui") and (v66 and v66.Visible) then
				v65.Enabled = false
				local v67 = v_u_17
				table.insert(v67, v65)
			end
		end
		if not v_u_16 then
			v_u_16 = script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.StopFreecam
			v_u_16.TextButton.Activated:Connect(function()
				v_u_1.Stop()
			end)
		end
		v_u_16.Enabled = true
		task.delay(3, function()
			hideButton(v_u_16)
			v_u_16.TextButton.MouseEnter:Connect(function()
				if v_u_15 then
					task.cancel(v_u_15)
					v_u_15 = nil
				end
				showButton(v_u_16)
			end)
			v_u_16.TextButton.MouseLeave:Connect(function()
				v_u_15 = task.delay(1, function()
					hideButton(v_u_16)
					v_u_15 = nil
				end)
			end)
		end)
		local v68 = p63 or v_u_6.CFrame
		v_u_8 = Vector2.new()
		v_u_7 = v68.p
		v_u_9 = v_u_6.FieldOfView
		v_u_13:Reset((Vector3.new()))
		v_u_14:Reset(Vector2.new())
		v_u_11.Push()
		v_u_2:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, v_u_46)
		v_u_12.StartCapture()
		v_u_5 = true
	end
end
task.spawn(function()
	while true do
		task.wait(60)
		v_u_62()
	end
end)
return v_u_1
