

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("ReplicatedStorage")
local v_u_5 = v_u_1.LocalPlayer
local v6 = v_u_4:WaitForChild("Packages")
local v_u_7 = require(v6.Net)
local v_u_8 = script.Parent
local v_u_9 = RaycastParams.new()
v_u_9.FilterType = Enum.RaycastFilterType.Exclude
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local function v_u_16()
	if v_u_10 and v_u_10.Parent then
		return v_u_10
	end
	local v13 = Instance.new("Part")
	v13.Size = Vector3.new(36, 0.1, 36)
	v13.Color = Color3.fromRGB(255, 0, 0)
	v13.Material = Enum.Material.Neon
	v13.Transparency = 0.3
	v13.CanCollide = false
	v13.CanQuery = false
	v13.CanTouch = false
	v13.Anchored = true
	Instance.new("CylinderMesh").Parent = v13
	v13.Orientation = Vector3.new(0, 0, 0)
	v13.Parent = workspace
	v_u_10 = v13
	if not v_u_11 then
		v_u_11 = task.spawn(function()
			while v_u_10 do
				local v14 = v_u_3:Create(v_u_10, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Transparency"] = 0.3
				})
				v14:Play()
				v14.Completed:Wait()
				if not (v_u_10 and v_u_10.Parent) then
					return
				end
				local v15 = v_u_3:Create(v_u_10, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Transparency"] = 0.7
				})
				v15:Play()
				v15.Completed:Wait()
			end
			v_u_11 = nil
		end)
	end
	return v_u_10
end
v_u_8.Activated:Connect(function()
	local v17 = require(v_u_4.Packages.PlayerMouse)
	v_u_7:RemoteEvent("UseItem"):FireServer(v_u_12 and v_u_12 or v17.Hit.Position)
end)
v_u_8.Equipped:Connect(function()
	local v_u_18 = require(v_u_4.Packages.PlayerMouse)
	local v_u_19 = v_u_5.Character
	if v_u_19 then
		v_u_2:UnbindFromRenderStep("ShowCircle")
		v_u_2:BindToRenderStep("ShowCircle", Enum.RenderPriority.Character.Value + 1, function()
			if v_u_8:GetAttribute("CooldownTime") then
				v_u_12 = nil
				return
			else
				local v20 = v_u_16()
				local v21 = v_u_18.Hit
				if v21 then
					local v22 = v21.Position + Vector3.new(0, 5, 0)
					local v23 = {}
					for _, v24 in v_u_1:GetPlayers() do
						if v24 ~= v_u_5 then
							local v25 = v24.Character
							if v25 then
								table.insert(v23, v25)
							end
						end
					end
					v_u_9.FilterDescendantsInstances = { v_u_19, table.unpack(v23) }
					local v26 = workspace:Raycast(v22, Vector3.new(0, -50, 0), v_u_9)
					if v26 then
						v20.Position = v26.Position + Vector3.new(0, 0.02, 0)
						v_u_12 = v26.Position + Vector3.new(0, 0.02, 0)
					end
				else
					v_u_12 = nil
				end
			end
		end)
	end
end)
v_u_8.Unequipped:Connect(function()
	v_u_2:UnbindFromRenderStep("ShowCircle")
	if v_u_11 then
		if coroutine.status(v_u_11) ~= "suspended" then
			task.cancel(v_u_11)
		end
		v_u_11 = nil
	end
	if v_u_10 then
		v_u_10:Destroy()
		v_u_10 = nil
	end
end)
v_u_8:GetAttributeChangedSignal("CooldownTime"):Connect(function()
	if v_u_8:GetAttribute("CooldownTime") then
		if v_u_11 then
			if coroutine.status(v_u_11) ~= "suspended" then
				task.cancel(v_u_11)
			end
			v_u_11 = nil
		end
		v_u_12 = nil
		if v_u_10 then
			v_u_10:Destroy()
			v_u_10 = nil
		end
	end
end)
