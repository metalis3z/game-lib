
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Net = require(ReplicatedStorage.Packages.Net)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local v9 = Net:RemoteEvent("EventService/EggrotHunt/SpawnCoin")
local v10 = Net:RemoteEvent("EventService/EggrotHunt/ClaimCoin")
local v11 = Net:RemoteEvent("EventService/EggrotHunt/DestroyCoin")
local v12 = Net:RemoteEvent("EventService/EggrotHunt/GoldEggReward")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local raycastParams = RaycastParams.new()

raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map }

local clone = script.Drop:Clone()
local Motor6D = Instance.new("Motor6D")

Motor6D.Name = "CoinMotor"
Motor6D.Parent = clone

local u18 = clone
local t1 = {}
local t2 = {}

local function AnimateLabel(t3: {[any]: any})
	local Billboard = t3.Billboard
	local TextLabel = t3.TextLabel
	local UIStroke = t3.UIStroke

	Billboard.StudsOffset = Vector3.new(0, 0, 2.200000047683716)
	TextLabel.TextTransparency = 0
	UIStroke.Transparency = 0
	TextLabel.Size = UDim2.fromScale(1.3, 1.3)
	CreateTween(TextLabel, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.fromScale(1, 1)
	})
	CreateTween(Billboard, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		StudsOffset = Vector3.new(0, 2.5, 2.200000047683716)
	})
	CreateTween(TextLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
		TextTransparency = 1
	})
	CreateTween(UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
		Transparency = 1
	})
end
local function SanitizeAmount(p1)
	if type(p1) == "number" and (p1 == p1 and p1 ~= 1e999 and p1 ~= -1e999) then
		return (math.max(math.floor(p1), 1))
	end

	return 1
end
local function createRewardBillboard(p2, n1: number)
	local v32 = (type(n1) ~= "number" or (n1 ~= n1 or (n1 == 1e999 or n1 == -1e999))) and 1 or math.max(math.floor(n1), 1)
	local v33 = t2[p2]

	if v33 and (v33.Billboard.Parent and os.clock() - v33.StartTime < 1.2000000000000002) then
		local Amount = v33.Amount

		v33.Amount = ((type(Amount) ~= "number" or (Amount ~= Amount or (Amount == 1e999 or Amount == -1e999))) and 1 or math.max(math.floor(Amount), 1)) + v32

		local TextLabel = v33.TextLabel
		local Amount2 = v33.Amount

		TextLabel.Text = `+{ (type(Amount2) ~= "number" or (Amount2 ~= Amount2 or (Amount2 == 1e999 or Amount2 == -1e999))) and 1 or math.max(math.floor(Amount2), 1) }`
		v33.StartTime = os.clock()

		if v33.CleanupThread then
			task.cancel(v33.CleanupThread)
		end

		AnimateLabel(v33)
		v33.CleanupThread = task.delay(5, function()
			if t2[p2] == v33 then
				t2[p2] = nil
			end

			v33.Billboard:Destroy()
		end)

		return
	end

	local BillboardGui = Instance.new("BillboardGui")

	BillboardGui.Size = UDim2.fromScale(4.5, 2)
	BillboardGui.StudsOffset = Vector3.new(0, 0, 2.200000047683716)
	BillboardGui.LightInfluence = 1.5
	BillboardGui.MaxDistance = 1e999
	BillboardGui.ClipsDescendants = true
	BillboardGui.ResetOnSpawn = false

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = "Amount"
	TextLabel.Size = UDim2.fromScale(1, 1)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = `+{ (type(v32) ~= "number" or (v32 ~= v32 or (v32 == 1e999 or v32 == -1e999))) and 1 or math.max(math.floor(v32), 1) }`
	TextLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
	TextLabel.TextScaled = true
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
	TextLabel.Parent = BillboardGui

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(100, 60, 20)
	UIStroke.Thickness = 2
	UIStroke.Parent = TextLabel
	BillboardGui.Parent = p2

	local t4 = {
		CleanupThread = nil,
		Billboard = BillboardGui,
		TextLabel = TextLabel,
		UIStroke = UIStroke,
		Amount = v32,
		StartTime = os.clock()
	}

	if v33 and v33.CleanupThread then
		task.cancel(v33.CleanupThread)
	end

	t2[p2] = t4
	AnimateLabel(t4)
	t4.CleanupThread = task.delay(5, function()
		if t2[p2] == t4 then
			t2[p2] = nil
		end

		BillboardGui:Destroy()
	end)
end

local t6 = {
	OnLoad = function(_)
		v10.OnClientEvent:Connect(function(s1: string, p4, n2: number)
			local v45 = t1[s1]

			if not v45 then
				return
			end

			local LastCFrame = v45.LastCFrame

			t1[s1] = nil

			local clone2 = v45.Model:Clone()

			v45.Model:Destroy()

			local CoinMotor = clone2:FindFirstChild("CoinMotor")

			if CoinMotor then
				CoinMotor:Destroy()
			end

			clone2.Anchored = true
			clone2.CFrame = LastCFrame
			clone2.Parent = workspace

			local Position = clone2:GetPivot().Position
			local n3 = 0
			local clone2Size = clone2.Size
			local u52 = nil

			u52 = RunService.PostSimulation:Connect(function(n4: number)
				n3 += n4

				local v105 = p4.Character and p4.Character:GetPivot().Position or Vector3.new(0, 0, 0)
				local v106 = Position + (v105 - Position) * 0.25 + Vector3.new(0, 10, 0)
				local Value = TweenService:GetValue(n3 / 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

				clone2:PivotTo(CFrame.new(MathUtils.quadBezier(Value, Position, v106, v105)) * clone2:GetPivot().Rotation)
				clone2.Size = clone2Size * 0.5 + clone2Size * 0.5 * (1 - Value)

				if Value >= 1 and u52 then
					u52:Disconnect()
					u52 = nil
					clone2:Destroy()
					task.spawn(function()
						pcall(function()
							SoundController:PlaySound(ReplicatedStorage.Sounds.Events["St Patricks"].CoinPickup, v105)
						end)
					end)

					local Character = p4.Character
					local v109 = Character and Character:FindFirstChild("HumanoidRootPart")

					if v109 then
						createRewardBillboard(v109, n2)
					end
				end
			end)
		end)
		v9.OnClientEvent:Connect(function(s2: string, vector3: Vector3, vector3_2: Vector3, n5: number, n6: number, b1: boolean?)
			local clone3 = u18:Clone()

			clone3.Name = s2
			clone3.CFrame = CFrame.new(0, 10000, 0)
			clone3.Trail.Enabled = false
			clone3.Parent = workspace

			local CoinMotor = clone3:FindFirstChild("CoinMotor")

			CoinMotor.Part0 = workspace.Terrain
			CoinMotor.Part1 = clone3
			clone3.Anchored = false

			local ProximityPrompt = Instance.new("ProximityPrompt")

			ProximityPrompt.ActionText = ""
			ProximityPrompt.RequiresLineOfSight = b1 == true
			ProximityPrompt.Enabled = false
			ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
			ProximityPrompt.MaxActivationDistance = 20
			ProximityPrompt:SetAttribute("CustomStyleDisabled", true)
			ProximityPrompt.Parent = clone3

			local raycastResult = workspace:Raycast(vector3_2 + Vector3.new(0, 10, 0), Vector3.new(0, -30, 0), raycastParams)
			local v63 = raycastResult and raycastResult.Position + Vector3.new(0, 2, 0) or vector3_2
			local vector3_3 = Vector3.new(v63.X, v63.Y + 30, v63.Z)
			local v65 = math.random(0, 10000)
			local v66 = vector3
			local n7 = 0
			local t5 = { 0 }

			for i = 1, 20 do
				local v70 = MathUtils.cubicBezier(i / 20, vector3, vector3, vector3_3, v63)

				n7 += (v70 - v66).Magnitude
				t5[i + 1] = n7
				v66 = v70
			end

			t1[s2] = {
				ArcSamples = 20,
				Landed = false,
				PromptEnabled = false,
				IsPromptShowing = false,
				LastFire = 0,
				UpdateInterval = 0,
				LastUpdate = 0,
				TrailEnabled = false,
				Model = clone3,
				Motor = CoinMotor,
				ProximityPrompt = ProximityPrompt,
				SpawnTime = n5,
				TweenTime = n6,
				P0 = vector3,
				P1 = vector3,
				P2 = vector3_3,
				P3 = v63,
				ArcLengths = t5,
				ArcTotal = n7,
				Seed = v65,
				LastCFrame = CFrame.new(vector3)
			}
			ProximityPrompt.PromptShown:Connect(function()
				if t1[s2] then
					t1[s2].IsPromptShowing = true
				end
			end)
			ProximityPrompt.PromptHidden:Connect(function()
				if t1[s2] then
					t1[s2].IsPromptShowing = false
				end
			end)
			clone3.Destroying:Connect(function()
				t1[s2] = nil
			end)
		end)
		v11.OnClientEvent:Connect(function(s3: string)
			local v72 = t1[s3]

			if not v72 then
				return
			end

			v72.Model:Destroy()
			t1[s3] = nil
		end)
		v12.OnClientEvent:Connect(function(n8: number)
			local Character = LocalPlayer.Character
			local v75 = Character and Character:FindFirstChild("HumanoidRootPart")

			if v75 then
				createRewardBillboard(v75, n8)
			end
		end)
		RunService.PostSimulation:Connect(function(_: number)
			local elapsed = os.clock()
			local CurrentCameraCFrame = CurrentCamera.CFrame
			local CurrentCameraCFramePosition = CurrentCameraCFrame.Position
			local LookVector = CurrentCameraCFrame.LookVector
			local v81 = math.rad(CurrentCamera.FieldOfView / 2) + 0.20943951023931956

			for v82, v83 in t1 do
				if not v83.Landed then
					local v84 = workspace:GetServerTimeNow() - v83.SpawnTime
					local v85 = if v83.TweenTime ~= 0 then math.clamp(v84 / v83.TweenTime, 0, 1) else 1
					local Value = TweenService:GetValue(v85, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					local v87 = Value * v83.ArcTotal
					local P3 = v83.P3

					for i = 1, #v83.ArcLengths do
						local v90 = v83.ArcLengths[i]

						if v87 <= v90 then
							local v91 = v83.ArcLengths[i - 1]
							local v92 = (v87 - v91) / (v90 - v91)
							local v93 = (i - 2 + v92) / v83.ArcSamples

							P3 = MathUtils.cubicBezier(v93, v83.P0, v83.P1, v83.P2, v83.P3)

							break
						end
					end

					local v94 = elapsed + v83.Seed
					local v95 = P3 + Vector3.new(0, math.sin(v94 * 4) * 0.5 + 2, 0)
					local v96 = v94 * 1.5707963267948966
					local v97 = CFrame.new(v95) * CFrame.Angles(0, v96, 0)

					v83.Motor.Transform = v97
					v83.LastCFrame = v97

					if not v83.PromptEnabled and Value >= 0.95 then
						v83.PromptEnabled = true
						v83.ProximityPrompt.Enabled = true
					end

					if not v83.TrailEnabled then
						v83.TrailEnabled = true
						task.delay(0, function()
							v83.Model.Trail.Enabled = true
						end)
					end

					if Value >= 1 then
						v83.Landed = true
					end
				else
					local v98 = CurrentCameraCFramePosition - v83.P3
					local Magnitude = v98.Magnitude

					if Magnitude > 5000 then
						v83.UpdateInterval = 60
					elseif Magnitude < 300 then
						v83.UpdateInterval = 0
					elseif v81 > math.acos((math.clamp(LookVector:Dot(v98.Unit), -1, 1))) then
						v83.UpdateInterval = 0.5
					else
						v83.UpdateInterval = Magnitude // 25 / 60
					end

					if v83.IsPromptShowing and elapsed - v83.LastFire > 0.05 then
						v83.LastFire = elapsed
						v10:FireServer(v82)
					end

					if not (elapsed - v83.LastUpdate < v83.UpdateInterval) then
						v83.LastUpdate = elapsed

						local v100 = elapsed + v83.Seed
						local v101 = v83.P3 + Vector3.new(0, math.sin(v100 * 4) * 0.5 + 2, 0)
						local v102 = v100 * 1.5707963267948966
						local v103 = CFrame.new(v101) * CFrame.Angles(0, v102, 0)

						v83.Motor.Transform = v103
						v83.LastCFrame = v103
					end
				end
			end
		end)
	end
}

return table.freeze(t6)
