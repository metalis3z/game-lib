-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(game:GetService("ReplicatedStorage").Modules.ToolKit)
local v2 = { "Torso", "Head", "Glow" }
for _, v_u_3 in script.Parent:GetDescendants() do
	if not v_u_3.Parent:IsA("Accessory") and (v_u_3:IsA("BasePart") and not table.find(v2, v_u_3.Name)) then
		v_u_3.LocalTransparencyModifier = v_u_3.Transparency
		v_u_3:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
			-- upvalues: (copy) v_u_3
			v_u_3.LocalTransparencyModifier = v_u_3.Transparency
		end)
	end
end
local v_u_4 = {
	["Character"] = script.Parent,
	["Humanoid"] = script.Parent:FindFirstChildOfClass("Humanoid"),
	["RootPart"] = script.Parent:FindFirstChild("HumanoidRootPart")
}
local v_u_5 = game:GetService("UserInputService")
local v_u_6 = v_u_4.Character:WaitForChild("Torso", 100):FindFirstChild("Neck")
local v_u_7 = v_u_6.C0.Y
local v_u_8 = CFrame.new
local v_u_9 = CFrame.Angles
local v_u_10 = math.asin
v_u_4.State = "Standing"
Instance.new("NumberValue")
local v_u_11 = script:WaitForChild("Replicator")
function castRay(p12, p13, p14)
	local v15 = RaycastParams.new()
	v15.FilterDescendantsInstances = {
		p12,
		workspace.IGNORE,
		workspace.PLAYERS,
		workspace.Terrain
	}
	local v16 = workspace:Raycast(p13, p14, v15)
	local v17 = v16 and v16.Position or p13 + p14
	return (p13 - v17).Magnitude, p13, v17, v16
end
game:GetService("RunService"):BindToRenderStep("CameraOffset", Enum.RenderPriority.Camera.Value - 1, function()
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	if workspace.CurrentCamera.CameraSubject == v_u_4.Humanoid then
		local v18 = (workspace.CurrentCamera.CFrame.p - workspace.CurrentCamera.Focus.p).magnitude
		if v_u_5.MouseBehavior == Enum.MouseBehavior.LockCenter and v18 > 2 then
			local v19, _, _, _ = castRay(v_u_4.Character, v_u_4.RootPart.Position, v_u_4.RootPart.CFrame.RightVector * 1.75)
			local v20 = v_u_4.RootPart.CFrame.RightVector * v19
			game:GetService("TweenService"):Create(v_u_4.Humanoid, TweenInfo.new(0.3), {
				["CameraOffset"] = (v_u_4.RootPart.CFrame - Vector3.new(0, -1, 0)):pointToObjectSpace(v_u_4.Character:WaitForChild("Head").CFrame.p + v_u_4.Character:WaitForChild("Head").CFrame.LookVector * 0 + v20)
			}):Play()
			return
		end
		if v_u_5.MouseBehavior == Enum.MouseBehavior.LockCenter and v18 <= 2 then
			local v21 = v_u_4.Character:WaitForChild("Head").CFrame.p - v_u_4.Character:WaitForChild("Head").CFrame.LookVector * 0.5
			local v22 = v_u_4.Character:WaitForChild("Head").CFrame.p + v_u_4.Character:WaitForChild("Head").CFrame.LookVector * 1.25 - v21
			local _, _, v23, v24 = castRay(v_u_4.Character, v21, v22)
			if v24 then
				local _ = v23 - (v22.Magnitude == 0 and Vector3.new(0, 0, 0) or v22.Unit) * 0.1
			end
			game:GetService("TweenService"):Create(v_u_4.Humanoid, TweenInfo.new(0), {
				["CameraOffset"] = (v_u_4.RootPart.CFrame - Vector3.new(0, -1, 0)):pointToObjectSpace(v23)
			}):Play()
			return
		end
		game:GetService("TweenService"):Create(v_u_4.Humanoid, TweenInfo.new(0.3), {
			["CameraOffset"] = (v_u_4.RootPart.CFrame - Vector3.new(0, -1, 0)):pointToObjectSpace(v_u_4.Character:WaitForChild("Head").CFrame.p + v_u_4.Character:WaitForChild("Head").CFrame.LookVector * 0)
		}):Play()
	end
end)
local v_u_25 = 0
local function v_u_29(p26)
	-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_8, (copy) v_u_7, (copy) v_u_9, (ref) v_u_25, (copy) v_u_11, (copy) v_u_10
	if game:GetService("Players"):GetPlayerFromCharacter(v_u_4.Character) == game:GetService("Players").LocalPlayer then
		if v_u_4.Character:HasTag("Cutscene") then
			v_u_6.C0 = v_u_8(0, v_u_7, 0) * v_u_9(4.71238898038469, 0, 3.141592653589793)
			v_u_25 = v_u_25 + p26
			if v_u_25 > 0.25 then
				v_u_25 = 0
				v_u_11:FireServer({ v_u_6 }, { v_u_6.C0 })
			end
		else
			local v27 = v_u_4.RootPart.CFrame:toObjectSpace(game:GetService("Workspace").CurrentCamera.CFrame).lookVector
			local v28
			if v_u_6 then
				v28 = v_u_8(0, v_u_7, 0) * v_u_9(4.71238898038469, 0, 3.141592653589793) * v_u_9(0, 0, -v_u_10(v27.x)) * v_u_9(-v_u_10(v27.y), 0, 0)
				v_u_6.C0 = v_u_6.C0:Lerp(v28, 0.9 * p26 * 15)
			else
				v28 = nil
			end
			v_u_25 = v_u_25 + p26
			if v_u_25 > 0.25 then
				v_u_25 = 0
				v_u_11:FireServer({ v_u_6 }, { v28 or v_u_6.C0 })
			end
		end
	else
		return
	end
end
local v_u_30 = nil
local v_u_31 = 0
local v_u_32 = v_u_4.Character:WaitForChild("Torso").AssemblyLinearVelocity
local v_u_33 = workspace.CurrentCamera
local v_u_34 = nil
local v_u_35 = 0
local v_u_36 = 0
local v_u_37 = nil
v_u_37 = game:GetService("RunService").Stepped:Connect(function(_, p38)
	-- upvalues: (copy) v_u_4, (ref) v_u_37, (copy) v_u_29, (copy) v_u_1, (ref) v_u_30, (ref) v_u_32, (ref) v_u_31, (copy) v_u_33, (ref) v_u_36, (ref) v_u_34, (ref) v_u_35
	if v_u_4.Character == nil then
		v_u_37:Disconnect()
	else
		v_u_29(p38)
		if v_u_4.Character:GetAttribute("Ragdoll") then
			local _, _, _, v39, _, v40 = v_u_1.Obstruction:CastObstruction(v_u_4.Character.HumanoidRootPart.Position, Vector3.new(-0, -3, -0), nil, v_u_30)
			if not v_u_30 then
				v_u_30 = v40
			end
			local v41 = v_u_4.Character.Torso.AssemblyLinearVelocity
			if not v_u_32 then
				v_u_32 = v41
			end
			if v39 and ((v41 - v_u_32).Y > 4 and tick() - v_u_31 > 0.2) then
				v_u_31 = tick()
				local v_u_42 = script["FloorHit" .. math.random(3)]:Clone()
				v_u_42.Parent = v_u_4.Character:FindFirstChild("HumanoidRootPart")
				v_u_42:Play()
				task.spawn(function()
					-- upvalues: (copy) v_u_42
					if not v_u_42.IsLoaded then
						v_u_42.Loaded:Wait()
					end
					task.delay(v_u_42.TimeLength / v_u_42.PlaybackSpeed, v_u_42.Destroy, v_u_42)
				end)
			end
			v_u_32 = v41
		else
			v_u_32 = nil
		end
		local v43 = next
		local v44, v45 = workspace.PLAYERS.KILLER:GetChildren()
		for _, v46 in v43, v44, v45 do
			if v46:FindFirstChild("HumanoidRootPart") and v46 ~= v_u_4.Character then
				local v47 = v_u_4.Character.HumanoidRootPart.Position
				local v48 = v46.HumanoidRootPart.Position
				local v49 = v_u_33.CFrame.Position
				local v50 = v46.HumanoidRootPart.CFrame.LookVector:Dot((v47 - v48).Unit)
				local _, v51 = v_u_33:WorldToViewportPoint(v48)
				local v52 = (v48 - v47).Magnitude
				local v53 = 1 - 8 / (v52 / 2 + 1)
				local v54 = math.min(0.9, v53)
				if v52 < 150 and (v51 and v_u_36 < 0.25 or v_u_36 > 0.25) and (v54 < v50 and not (v46:HasTag("Imitation") or v46:HasTag("UNDETECTABLE"))) then
					local _, _, _, v55, v56 = v_u_1.Obstruction:CastObstruction(v49, v48 - v49, v_u_34)
					if not v_u_34 then
						v_u_34 = v56
					end
					local _, _, _, v57, _ = v_u_1.Obstruction:CastObstruction(v_u_4.Character.HumanoidRootPart.Position, v48 - v47, v_u_34)
					if v57 or v55 then
						v_u_36 = 0
					else
						if v_u_36 > 0.25 then
							if tick() - v_u_35 > 10 then
								script.InView["InView" .. math.random(3)]:Play()
							end
							v_u_35 = tick()
						end
						v_u_36 = v_u_36 + p38
					end
				else
					v_u_36 = 0
					v_u_34 = nil
				end
			end
		end
	end
end)