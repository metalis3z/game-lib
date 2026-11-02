local v_u_1 = game:GetService("Debris")
local v2 = game:GetService("Players")
game:GetService("Lighting")
game:GetService("RunService")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("ReplicatedStorage")
local v5 = v2.LocalPlayer
local v6 = v5.PlayerGui
local v7 = v5.PlayerScripts
local _ = workspace.CurrentCamera
v6:WaitForChild("ToolsScreen")
require(v7:WaitForChild("PlayerModule")):GetControls()
local v8 = v4:WaitForChild("Packages")
local v9 = require(v8.Net)
local v_u_10 = {}
local function v_u_20(p11, p12)
	local v13 = script["F22 Bombing Jet"]:Clone()
	local v14 = v13:WaitForChild("Torso")
	local v15 = p11 + Vector3.new(0, 72, 0)
	v14.CFrame = CFrame.new(v15) * CFrame.Angles(0, 6.283185307179586 * math.random(), 0) * CFrame.new(0, 0, 200)
	v14.Parent = v13
	local v16 = v13:WaitForChild("Head")
	v14:WaitForChild("BodyForce")
	v14:WaitForChild("Neck")
	v13:WaitForChild("Humanoid")
	local v17 = (v15 - v14.Position).Magnitude / 0.3
	local v18 = (v15 - v14.Position).Unit * v17
	v14.AssemblyLinearVelocity = v18
	v16.AssemblyLinearVelocity = v18
	for _, v19 in v13:GetDescendants() do
		if v19:IsA("BasePart") then
			v19.CanCollide = false
			v19.CollisionGroup = "MobFinder"
		end
	end
	v13.Parent = workspace
	v_u_10[p12] = v13
	v_u_1:AddItem(v13, 20)
end
local function v_u_40(p21, p22, p23)
	local v24 = v_u_10[p23]
	local v_u_25 = v24 and v24:GetPivot().Position or p22 + Vector3.new(0, 72, 0)
	for _, v_u_26 in p21 do
		task.delay(v_u_26.TweenTime, function()
			local v27 = v_u_26.FinalPos
			local v_u_28 = v_u_26.Scale
			local v29 = v27.X
			local v30 = v_u_25.Y + 40
			local v31 = v27.Z
			local v32 = Vector3.new(v29, v30, v31)
			local v_u_33 = script.Bomb:Clone()
			v_u_33.Position = v32
			local v34 = (v27 - v32).Unit
			v_u_33.CFrame = CFrame.new(v32, v32 + v34)
			v_u_33.Parent = workspace
			local v_u_35 = v27 + Vector3.new(0, 0.5, 0)
			local v36 = v_u_3:Create(v_u_33, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Position"] = v_u_35
			})
			v36:Play()
			v36.Completed:Connect(function()
				local v37 = script.greenExplosion:Clone()
				v37:PivotTo(CFrame.new(v_u_35 + Vector3.new(0, 3, 0)))
				v37:ScaleTo(v_u_28 * 0.8)
				v37.Parent = workspace
				local v38 = v37:WaitForChild("greenExplosion"):FindFirstChildWhichIsA("Sound")
				if v38 then
					v38:Play()
				end
				for _, v39 in v37:GetDescendants() do
					if v39:IsA("ParticleEmitter") then
						v39:Emit(v39:GetAttribute("EmitCount") or 10)
					end
				end
				v_u_1:AddItem(v37, 2)
				v_u_33:Destroy()
			end)
		end)
	end
end
v9:RemoteEvent("UseItem").OnClientEvent:Connect(function(p41, p42)
	if p41 == "CreateRadioctivatePuddles" then
		v_u_20(p42.MousePosition, p42.JetUUID)
	end
end)
v9:RemoteEvent("UseItem").OnClientEvent:Connect(function(p43, p44)
	if p43 == "DropBombsAt" then
		v_u_40(p44.FinalPositions, p44.MousePosition, p44.JetUUID)
	end
end)
v9:RemoteEvent("UseItem").OnClientEvent:Connect(function(p45, p46)
	if p45 == "LockCircle" then
		local v47 = p46.Pos
		local v48 = Instance.new("Part")
		v48.Size = Vector3.new(37, 0.1, 37)
		v48.Color = Color3.fromRGB(255, 0, 0)
		v48.Material = Enum.Material.Neon
		v48.Position = v47
		v48.Transparency = 0.3
		v48.CanCollide = false
		v48.CanQuery = false
		v48.CanTouch = false
		v48.Anchored = true
		Instance.new("CylinderMesh").Parent = v48
		v_u_1:AddItem(v48, 3)
		v48.Parent = workspace
	end
end)
return {}