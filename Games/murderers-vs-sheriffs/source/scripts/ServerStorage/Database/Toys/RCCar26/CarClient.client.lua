-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local v1 = script.Parent
local CarStateChanged = v1:WaitForChild("CarStateChanged")
local LocalPlayer = Players.LocalPlayer
local Gravity = workspace.Gravity
local v2 = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
local v3 = nil

local function stopDriving() --[[ stopDriving | Line: 9 | Upvalues: v3 (ref) ]]
	if not v3 then
		return
	end

	v3:Disconnect()
	v3 = nil
end

local function startDriving(p1) --[[ startDriving | Line: 15 | Upvalues: v3 (ref), RunService (copy), LocalPlayer (copy), v2 (copy), Players (copy), Gravity (copy) ]]
	if v3 then
		v3:Disconnect()
		v3 = nil
	end

	local Body = p1:WaitForChild("Body")
	local t = {}

	for v1, v22 in Body:GetChildren() do
		if v22:IsA("Weld") then
			table.insert(t, v22)
		end
	end

	local v32, v4 = p1:GetBoundingBox()
	local v5 = p1:GetPivot().Position.Y - (v32.Position.Y - v4.Y / 2)
	local v6 = v4.Z / 2
	local v7 = v4.X / 2
	local LeftFrontWheel = p1:FindFirstChild("LeftFrontWheel")
	local v8 = if LeftFrontWheel then LeftFrontWheel.Size.Y / 2 else 0.374
	local LookVector = p1:GetPivot().LookVector
	local v11 = math.atan2(-LookVector.X, -LookVector.Z)
	local v12 = 0
	local v13 = 0
	local v14 = false
	local v15 = 0
	local v16 = 0
	local v17 = 0
	local v18 = Vector3.new(0, 1, 0)

	v3 = RunService.Heartbeat:Connect(function(p12) --[[ Line: 42 | Upvalues: p1 (copy), v3 (ref), LocalPlayer (ref), v2 (ref), v12 (ref), v14 (ref), v11 (ref), Players (ref), v18 (ref), v6 (copy), v5 (copy), v8 (copy), v7 (copy), v15 (ref), Gravity (ref), v16 (ref), v17 (ref), Body (copy), v13 (ref), t (copy) ]]
		if p1.Parent then
			local Character = LocalPlayer.Character
			local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
			local v22 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

			if v1 and v22 then
				local v32 = v2:GetMoveVector()
				local v4 = -v32.Z
				local X = v32.X

				if v4 > 0.05 then
					if v12 < 0 then
						v12 = math.min(v12 + 60 * p12, 0)
					else
						v12 = math.min(v12 + 40 * v4 * p12, 24)
					end
				elseif v4 < -0.05 then
					if v12 > 0 then
						v12 = math.max(v12 - 60 * p12, 0)
					else
						v12 = math.max(v12 + 40 * v4 * p12, -12)
					end
				elseif v12 > 0 then
					v12 = math.max(v12 - 30 * p12, 0)
				else
					v12 = math.min(v12 + 30 * p12, 0)
				end

				if math.abs(X) > 0.05 and (math.abs(v12) > 0.5 and not v14) then
					v11 = v11 - X * math.pi * math.clamp(math.abs(v12) / 8.399999999999999, 0, 1) * (if v12 >= 0 then 1 else -1) * p12
				end

				local Position = p1:GetPivot().Position
				local v20 = Vector3.new(-math.sin(v11), 0, -math.cos(v11))
				local v21 = RaycastParams.new()
				local t2 = { p1 }

				for v222, v23 in Players:GetPlayers() do
					if v23.Character then
						table.insert(t2, v23.Character)
					end
				end

				local RCCars = workspace:FindFirstChild("RCCars")

				if RCCars then
					table.insert(t2, RCCars)
				end

				v21.ExcludeInstances = t2

				if v12 ~= 0 then
					local v24 = if v12 >= 0 then v20 else -v20
					local v25 = v24 - v18 * v24:Dot(v18)
					local v26 = if v25.Magnitude > 0.01 then v25.Unit else v24
					local v27 = v20:Cross(Vector3.new(0, 1, 0))
					local v29 = v6 + 0.4 + math.abs(v12) * p12
					local v30 = Position - v18 * (v5 - v8)
					local v31 = false

					for v322, v33 in { -v7 * 0.8, 0, v7 * 0.8 } do
						local v34 = v27 * v33

						for v35, v36 in { Position + v34, v30 + v34 } do
							local v37 = workspace:Raycast(v36, v26 * v29, v21)

							if v37 and v37.Normal.Y < 0.7 then
								v31 = true

								break
							end
						end

						if v31 then
							break
						end
					end

					if v31 then
						v12 = 0
					end
				end

				local v38 = Position + v20 * v12 * p12

				if (v38 - v22.Position).Magnitude > 100 then
					v12 = 0
					v38 = Position
				end

				local v39 = Vector3.new(0, 1, 0)
				local v40 = workspace:Raycast(v38 + Vector3.new(0, 2, 0), Vector3.new(0, -62, 0), v21)
				local v41 = if v40 then v40.Position.Y + v5 else nil

				if v14 then
					v15 = v15 - Gravity * p12

					local v42 = Position.Y + v15 * p12

					if v41 and (v15 <= 0 and v42 <= v41) then
						v14 = false
						v15 = 0
						v39 = v40.Normal
						v42 = v41
					end

					Position = Vector3.new(v38.X, v42, v38.Z)
				elseif v41 then
					if Position.Y - 1.5 <= v41 then
						v16 = (v41 - Position.Y) / p12

						local v44 = Vector3.new(v38.X, v41, v38.Z)

						v39 = v40.Normal
						Position = v44
					else
						v14 = true
						v15 = math.max(v16, 0)
						Position = Vector3.new(v38.X, Position.Y + v15 * p12, v38.Z)
					end
				else
					v12 = 0
				end

				local v48 = 0

				if v14 and math.abs(v12) > 0.5 then
					v48 = math.clamp(math.atan2(v15 * (if v12 >= 0 then 1 else -1), (math.abs(v12))), -0.3490658503988659, 0.6981317007977318)
				end

				v17 = v17 + (v48 - v17) * math.min(p12 * 10, 1)

				local v56 = v20 - v39 * v20:Dot(v39)
				local v57 = if v56.Magnitude > 0.01 then v56.Unit else v20

				p1:PivotTo(CFrame.lookAt(Position, Position + v57, v39) * CFrame.Angles(v17, 0, 0))
				v18 = v39
				Body.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
				Body.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
				v13 = v13 + v12 / v8 * p12

				local v58 = CFrame.Angles(v13, 0, 0)

				for v59, v60 in t do
					v60.C1 = v58
				end
			else
				if not v3 then
					return
				end

				v3:Disconnect()
				v3 = nil
			end
		else
			if not v3 then
				return
			end

			v3:Disconnect()
			v3 = nil
		end
	end)
end

CarStateChanged.OnClientEvent:Connect(function(p1) --[[ Line: 181 | Upvalues: startDriving (copy), v3 (ref) ]]
	if p1 then
		startDriving(p1)

		return
	end

	if not v3 then
		return
	end

	v3:Disconnect()
	v3 = nil
end)
v1.Unequipped:Connect(stopDriving)