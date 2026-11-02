--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQNVBmNhbmNlbApEaXNjb25uZWN0B0Rlc3Ryb3kFcGNhbGwVY2FuY2VsVGFyZ2V0SGVhbE1ldGVyBlBhcmVudBBIdW1hbm9pZFJvb3RQYXJ0DkZpbmRGaXJzdENoaWxkCFBvc2l0aW9uCU1hZ25pdHVkZQRtYXRoBWNsYW1wBVVEaW0yA25ldwRTaXplBkNvbG9yMwdmcm9tUkdCEEJhY2tncm91bmRDb2xvcjMDbWF4BWZsb29yAARUZXh0ClRleHRDb2xvcjMNQmVpbmdIZWFsZWRCeQxHZXRBdHRyaWJ1dGUTQmVpbmdIZWFsZWREdXJhdGlvbgl3b3Jrc3BhY2UNSW5HYW1lUGxheWVycwZjcmVhdGUJYmlsbGJvYXJkAVgFU2NhbGUGT2Zmc2V0AVkLU3R1ZHNPZmZzZXQBWgdWZWN0b3IzCVRleHRMYWJlbA5IRUFMIElOQ09NSU5HIQhJbnN0YW5jZQVGcmFtZQ5SYW5nZUluZGljYXRvcgROYW1lD0JvcmRlclNpemVQaXhlbAdWaXNpYmxlCFVJQ29ybmVyBFVEaW0MQ29ybmVyUmFkaXVzBEZpbGwJUmFuZ2VUZXh0FkJhY2tncm91bmRUcmFuc3BhcmVuY3kQVGV4dFN0cm9rZUNvbG9yMxZUZXh0U3Ryb2tlVHJhbnNwYXJlbmN5BEVudW0ERm9udApHb3RoYW1Cb2xkClRleHRTY2FsZWQCMjAFc3RhcnQJSGVhcnRiZWF0B0Nvbm5lY3QUQmVpbmdIZWFsZWRDYW5jZWxsZWQEdGFzawVkZWxheQdjbGVhbnVwGUdldEF0dHJpYnV0ZUNoYW5nZWRTaWduYWwFdGFibGUGaW5zZXJ0BGluaXQGaXBhaXJzBnR5cGVvZhNSQlhTY3JpcHRDb25uZWN0aW9uBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQpSdW5TZXJ2aWNlB3JlcXVpcmUHTW9kdWxlcwhDbGllbnRVSRVHaW5nZXJNZXRlckNvbnRyb2xsZXILU2hhcmVkVXRpbHMIVG93ZXJMVVQGR2luZ2VyCEdldFRvd2VyCUhlYWxSYW5nZQAKAgACAAAABvsAAABNAACBAAAAAPsBAQCfAAIBggABAAEDAQA2AAEYAAAAAAAANgAAAAADAAUAAAAk+wAAAA4ABgD7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

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GingerMeterController = require(ReplicatedStorage.Modules.ClientUI.GingerMeterController)
local t = {}
local v3 = false
local v4 = nil
local t2 = {}
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local HealRange = require((require(ReplicatedStorage.SharedUtils.TowerLUT):GetTower("Ginger"))).HealRange

local function cancelTargetHealMeter() --[[ cancelTargetHealMeter | Line: 38 | Upvalues: v6 (ref), v7 (ref), v8 (ref), v5 (ref), GingerMeterController (copy) ]]
	if v6 then
		v6:Disconnect()
		v6 = nil
	end

	if v7 then
		v7:Destroy()
		v7 = nil
	end

	if v8 then
		v8:Destroy()
		v8 = nil
	end

	if not v5 then
		return
	end

	local v1 = v5

	v5 = nil
	pcall(function() --[[ Line: 54 | Upvalues: GingerMeterController (ref), v1 (copy) ]]
		GingerMeterController.cancel(v1)
	end)
end

function t.init(p1) --[[ init | Line: 59 | Upvalues: v3 (ref), t (copy), v4 (ref), t2 (ref), cancelTargetHealMeter (copy), v5 (ref), GingerMeterController (copy), v7 (ref), v8 (ref), v6 (ref), RunService (copy), HealRange (copy) ]]
	local v2, v32, v52, v62

	if v3 then
		t.cleanup()
	end

	v4 = p1
	v2 = v4:GetAttributeChangedSignal("BeingHealedBy")
	v32 = function() --[[ Line: 67 | Upvalues: v4 (ref), cancelTargetHealMeter (ref), v5 (ref), GingerMeterController (ref), v7 (ref), v8 (ref), v6 (ref), RunService (ref), HealRange (ref) ]]
		local v1 = v4:GetAttribute("BeingHealedBy")

		if v1 then
			local v2 = v4:GetAttribute("BeingHealedDuration") or 3

			cancelTargetHealMeter()

			local InGamePlayers = workspace:FindFirstChild("InGamePlayers")
			local v3 = InGamePlayers and InGamePlayers:FindFirstChild(v1)

			v5 = GingerMeterController.create(v4)

			if not (v5 and v5.billboard) then
				return
			end

			local billboard = v5.billboard

			billboard.Size = UDim2.new(billboard.Size.X.Scale * 0.5, billboard.Size.X.Offset * 0.5, billboard.Size.Y.Scale * 0.5, billboard.Size.Y.Offset * 0.5)
			billboard.StudsOffset = Vector3.new(billboard.StudsOffset.X, billboard.StudsOffset.Y * 0.7, billboard.StudsOffset.Z)

			local TextLabel = billboard:FindFirstChild("TextLabel")

			if TextLabel then
				TextLabel.Text = "HEAL INCOMING!"
			end

			local RangeIndicator = Instance.new("Frame")

			RangeIndicator.Name = "RangeIndicator"
			RangeIndicator.Size = UDim2.new(0.8, 0, 0.08, 0)
			RangeIndicator.Position = UDim2.new(0.1, 0, 0.92, 0)
			RangeIndicator.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			RangeIndicator.BorderSizePixel = 0
			RangeIndicator.Parent = billboard
			RangeIndicator.Visible = true

			local UICorner = Instance.new("UICorner")

			UICorner.CornerRadius = UDim.new(0.5, 0)
			UICorner.Parent = RangeIndicator

			local Fill = Instance.new("Frame")

			Fill.Name = "Fill"
			Fill.Size = UDim2.new(1, 0, 1, 0)
			Fill.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
			Fill.BorderSizePixel = 0
			Fill.Parent = RangeIndicator

			local UICorner2 = Instance.new("UICorner")

			UICorner2.CornerRadius = UDim.new(0.5, 0)
			UICorner2.Parent = Fill
			v7 = Fill

			local RangeText = Instance.new("TextLabel")

			RangeText.Name = "RangeText"
			RangeText.Size = UDim2.new(0.3, 0, 0.12, 0)
			RangeText.Position = UDim2.new(0.35, 0, 1.02, 0)
			RangeText.BackgroundTransparency = 1
			RangeText.TextColor3 = Color3.fromRGB(255, 255, 255)
			RangeText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			RangeText.TextStrokeTransparency = 0.5
			RangeText.Font = Enum.Font.GothamBold
			RangeText.TextScaled = true
			RangeText.Text = "20"
			RangeText.Parent = billboard
			v8 = RangeText
			GingerMeterController.start(v5, v2)

			if v3 then
				v6 = RunService.Heartbeat:Connect(function() --[[ Line: 135 | Upvalues: v5 (ref), v3 (copy), v6 (ref), v4 (ref), HealRange (ref), v7 (ref), v8 (ref) ]]
					if v5 and (v3 and v3.Parent) then
						local HumanoidRootPart = v4:FindFirstChild("HumanoidRootPart")
						local HumanoidRootPart2 = v3:FindFirstChild("HumanoidRootPart")

						if not (HumanoidRootPart and HumanoidRootPart2) then
							return
						end

						local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude
						local v2 = math.clamp(1 - Magnitude / HealRange, 0, 1)

						if v7 then
							v7.Size = UDim2.new(v2, 0, 1, 0)

							if v2 > 0.5 then
								v7.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
							elseif v2 > 0.25 then
								v7.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
							else
								v7.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
							end
						end

						if not v8 then
							return
						end

						v8.Text = math.floor((math.max(0, HealRange - Magnitude))) .. ""
						v8.TextColor3 = v7 and v7.BackgroundColor3 or Color3.fromRGB(255, 255, 255)
					else
						if not v6 then
							return
						end

						v6:Disconnect()
						v6 = nil
					end
				end)
			end
		else
			local v52 = v4:GetAttribute("BeingHealedCancelled")

			if not v5 then
				return
			end

			if v52 then
				cancelTargetHealMeter()

				return
			end

			if v6 then
				v6:Disconnect()
				v6 = nil
			end

			if v7 then
				v7:Destroy()
				v7 = nil
			end

			if v8 then
				v8:Destroy()
				v8 = nil
			end

			local v62 = v5

			v5 = nil
			task.delay(1, function() --[[ Line: 193 | Upvalues: GingerMeterController (ref), v62 (copy) ]]
				pcall(function() --[[ Line: 194 | Upvalues: GingerMeterController (ref), v62 (ref) ]]
					GingerMeterController.cancel(v62)
				end)
			end)
		end
	end
	table.insert(t2, v2:Connect(v32))
	v52 = v4:GetAttributeChangedSignal("BeingHealedCancelled")
	v62 = function() --[[ Line: 202 | Upvalues: v4 (ref), v5 (ref), cancelTargetHealMeter (ref) ]]
		if not (v4:GetAttribute("BeingHealedCancelled") and v5) then
			return
		end

		cancelTargetHealMeter()
	end
	table.insert(t2, v52:Connect(v62))
	v3 = true
end
function t.cleanup() --[[ cleanup | Line: 213 | Upvalues: cancelTargetHealMeter (copy), t2 (ref), v3 (ref), v4 (ref) ]]
	cancelTargetHealMeter()

	for i, v in ipairs(t2) do
		if typeof(v) == "RBXScriptConnection" then
			v:Disconnect()
		end
	end

	t2 = {}
	v3 = false
	v4 = nil
end

return t