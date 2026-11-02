-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local GameplayToolGuard = require(ServerScriptService.Library.Tools.Internal.GameplayToolGuard)
local AntiCheatService = require(ServerScriptService.Controllers.AntiCheatService)
local Audio = require(ReplicatedStorage.Library.Audio)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Network = require(ServerScriptService.Library.Network)

return {
	Install = function(p1) --[[ Install | Line: 39 | Upvalues: Players (copy), Network (copy), Constants (copy), GameplayToolGuard (copy), AntiCheatService (copy), Audio (copy), ReplicatedStorage (copy) ]]
		local v1 = p1:GetAttribute("Owner")
		local v2 = false
		local t = {}
		local v3 = nil
		local Hitbox = p1:WaitForChild("Hitbox")

		assert(Hitbox:IsA("BasePart"), "Trap Hitbox must be a BasePart")
		p1.CanTouch = true
		Hitbox.CanTouch = true

		local function createTrapBillboard(p1) --[[ createTrapBillboard | Line: 54 ]]
			local TrapBillboard = Instance.new("BillboardGui")

			TrapBillboard.Name = "TrapBillboard"
			TrapBillboard.Size = UDim2.fromScale(6, 3)
			TrapBillboard.StudsOffset = Vector3.new(0, 3, 0)
			TrapBillboard.AlwaysOnTop = true
			TrapBillboard.MaxDistance = 50

			local Frame = Instance.new("Frame")

			Frame.Size = UDim2.fromScale(1, 1)
			Frame.BackgroundTransparency = 1
			Frame.Parent = TrapBillboard

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.fromScale(1, 0.4)
			TextLabel.Position = UDim2.new(0, 0, 0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = "TRAPPED"
			TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
			TextLabel.TextScaled = true
			TextLabel.Font = Enum.Font.SourceSansBold
			TextLabel.Parent = Frame

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Thickness = 2.5
			UIStroke.Parent = TextLabel

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Size = UDim2.fromScale(1, 0.5)
			TextLabel2.Position = UDim2.fromScale(0, 0.5)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.Text = tostring(7) .. "s"
			TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel2.TextScaled = true
			TextLabel2.Font = Enum.Font.SourceSansBold
			TextLabel2.Parent = Frame

			local UIStroke2 = Instance.new("UIStroke")

			UIStroke2.Thickness = 2.5
			UIStroke2.Parent = TextLabel2

			local Head = p1:FindFirstChild("Head")

			if Head then
				TrapBillboard.Parent = Head
			else
				if not p1.PrimaryPart then
					TrapBillboard:Destroy()

					return nil
				end

				TrapBillboard.Parent = p1.PrimaryPart
			end

			task.spawn(function() --[[ Line: 105 | Upvalues: TrapBillboard (copy), TextLabel2 (copy) ]]
				for i = 7, 1, -1 do
					if not (TrapBillboard and TrapBillboard.Parent) then
						break
					end

					TextLabel2.Text = tostring(i) .. "s"
					task.wait(1)
				end

				if not (TrapBillboard and TrapBillboard.Parent) then
					return
				end

				TrapBillboard:Destroy()
			end)

			return TrapBillboard
		end

		local function getModelHeight(p1) --[[ getModelHeight | Line: 122 ]]
			if p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart then
				local _, v2 = p1:GetBoundingBox()

				return v2.Y / 2
			end

			error("HumanoidRootPart or PrimaryPart not found")
		end

		local function getCharacterFromPart(p1) --[[ getCharacterFromPart | Line: 133 ]]
			local v1 = p1

			while v1 and v1 ~= workspace do
				if v1:IsA("Model") and v1:FindFirstChildOfClass("Humanoid") then
					return v1
				end

				v1 = v1.Parent
			end

			return nil
		end

		local function positionCloseModel(p12) --[[ positionCloseModel | Line: 148 | Upvalues: p1 (copy) ]]
			if p12:IsA("BasePart") then
				p12.CFrame = p1.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
				p12.Anchored = true

				return
			end

			if p12:IsA("PVInstance") then
				p12:PivotTo(p1.CFrame)
			end

			for v1, v2 in p12:GetDescendants() do
				if v2:IsA("BasePart") then
					v2.Anchored = true
				end
			end
		end

		local function releaseTrappedCharacter(p1) --[[ releaseTrappedCharacter | Line: 166 | Upvalues: t (copy) ]]
			local v1 = t[p1]

			if not v1 then
				return
			end

			t[p1] = nil

			local carrierConnection = v1.carrierConnection

			if carrierConnection then
				carrierConnection:Disconnect()
			end

			local trapStateConnection = v1.trapStateConnection

			if trapStateConnection then
				trapStateConnection:Disconnect()
			end

			local billboard = v1.billboard

			if billboard and billboard.Parent then
				billboard:Destroy()
			end

			local rootPart = v1.rootPart

			if rootPart and rootPart.Parent then
				rootPart.Anchored = v1.originalRootAnchored
			end

			local humanoid = v1.humanoid

			if humanoid then
				humanoid.JumpHeight = v1.originalJumpHeight
				humanoid.AutoRotate = v1.originalAutoRotate
				humanoid.PlatformStand = false
			end

			if not (p1 and p1.Parent) then
				return
			end

			p1:SetAttribute("IsTrapped", nil)
		end

		local function notifyTrapOwner(p1) --[[ notifyTrapOwner | Line: 208 | Upvalues: v1 (copy), Players (ref), Network (ref), Constants (ref) ]]
			if typeof(v1) ~= "string" then
				return
			end

			local v2 = Players:FindFirstChild(v1)

			if v2 and v2:IsA("Player") then
				Network.Fire(Constants.NETWORK_MAP.Notifications.SHOW, v2, "Message", "Bottom", {
					Time = 2,
					Message = ("You <font color=\"#00FF00\">trapped</font> %*!"):format(p1.DisplayName),
					Color = Color3.new(255/255, 255/255, 255/255)
				})
			end
		end

		local function freezeCharacter(p1, p2) --[[ freezeCharacter | Line: 225 | Upvalues: t (copy), Players (ref), GameplayToolGuard (ref), AntiCheatService (ref), notifyTrapOwner (copy), createTrapBillboard (copy), Audio (ref), releaseTrappedCharacter (copy) ]]
			if t[p1] or p1:GetAttribute("IsTrapped") then
				return false
			end

			local Humanoid = p1:FindFirstChildOfClass("Humanoid")
			local v1 = p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart

			if not (Humanoid and (v1 and v1:IsA("BasePart"))) then
				return false
			end

			local v3

			if p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart then
				local _, v4 = p1:GetBoundingBox()

				v3 = v4.Y / 2
			else
				error("HumanoidRootPart or PrimaryPart not found")
			end

			local v5 = p2 + Vector3.new(0, v3, 0)
			local v6 = Players:GetPlayerFromCharacter(p1)

			if not (v6 and GameplayToolGuard.DropHeldEggFromPlayerHit(v6)) then
				return false
			end

			if AntiCheatService.TeleportCharacter(v6, (CFrame.new(v5))) then
				local Anchored = v1.Anchored
				local JumpHeight = Humanoid.JumpHeight
				local AutoRotate = Humanoid.AutoRotate

				v1.Anchored = true
				Humanoid:UnequipTools()
				Humanoid.JumpHeight = 0
				Humanoid.AutoRotate = false
				Humanoid.PlatformStand = true
				p1:SetAttribute("IsTrapped", true)
				notifyTrapOwner(v6)

				local t2 = {
					character = p1,
					humanoid = Humanoid,
					rootPart = v1,
					originalRootAnchored = Anchored,
					originalJumpHeight = JumpHeight,
					originalAutoRotate = AutoRotate
				}

				t[p1] = t2
				t2.billboard = createTrapBillboard(p1)
				Audio.Play(9091607929, v1.CFrame, { 0.9, 1.1 }, 1.3, 70)
				t2.carrierConnection = p1:GetAttributeChangedSignal("CarrierUserId"):Connect(function() --[[ Line: 277 | Upvalues: p1 (copy), releaseTrappedCharacter (ref) ]]
					if p1:GetAttribute("CarrierUserId") == nil then
						return
					end

					releaseTrappedCharacter(p1)
				end)
				t2.trapStateConnection = p1:GetAttributeChangedSignal("IsTrapped"):Connect(function() --[[ Line: 284 | Upvalues: p1 (copy), releaseTrappedCharacter (ref) ]]
					if p1:GetAttribute("IsTrapped") == true then
						return
					end

					releaseTrappedCharacter(p1)
				end)
				task.delay(7, function() --[[ Line: 290 | Upvalues: t (ref), p1 (copy), t2 (copy), releaseTrappedCharacter (ref) ]]
					if t[p1] == t2 then
						releaseTrappedCharacter(p1)
					end
				end)

				return true
			end

			return false
		end

		local function activateTrap(p12) --[[ activateTrap | Line: 301 | Upvalues: v2 (ref), p1 (copy), freezeCharacter (copy), Hitbox (copy), v3 (ref), ReplicatedStorage (ref), positionCloseModel (copy) ]]
			if v2 or not p1.Parent then
				return
			end

			if not freezeCharacter(p12, Hitbox.Position - Vector3.new(0, 1, 0) * (Hitbox.Size.Y / 2)) then
				return
			end

			v2 = true
			p1:SetAttribute("TrapActive", true)

			local v1

			if not v3 then
				v1 = ReplicatedStorage.Assets.Extra.Close:Clone()
				positionCloseModel(v1)
				v1.Parent = p1
				p1.Transparency = 1
				p1.CanCollide = false
				p1.CanTouch = false
				task.delay(7.5, function() --[[ Line: 325 | Upvalues: v1 (copy), p1 (ref) ]]
					if v1 and v1.Parent then
						v1:Destroy()
					end

					if not (p1 and p1.Parent) then
						return
					end

					p1:Destroy()
				end)

				return
			end

			v3:Disconnect()
			v3 = nil
			v1 = ReplicatedStorage.Assets.Extra.Close:Clone()
			positionCloseModel(v1)
			v1.Parent = p1
			p1.Transparency = 1
			p1.CanCollide = false
			p1.CanTouch = false
			task.delay(7.5, function() --[[ Line: 325 | Upvalues: v1 (copy), p1 (ref) ]]
				if v1 and v1.Parent then
					v1:Destroy()
				end

				if not (p1 and p1.Parent) then
					return
				end

				p1:Destroy()
			end)
		end

		local function onTouched(p12) --[[ onTouched | Line: 336 | Upvalues: v2 (ref), p1 (copy), getCharacterFromPart (copy), Players (ref), v1 (copy), GameplayToolGuard (ref), activateTrap (copy) ]]
			if v2 or not p1.Parent then
				return
			end

			if not p12 or p12:IsDescendantOf(p1) then
				return
			end

			local v12 = getCharacterFromPart(p12)

			if not v12 then
				return
			end

			local v22 = Players:GetPlayerFromCharacter(v12)

			if v22 and v22.Name == v1 then
				return
			end

			if not (v22 and GameplayToolGuard.IsPlayerInGameplayArea(v22)) then
				return
			end

			if not GameplayToolGuard.IsHoldingEgg(v22) then
				return
			end

			local Humanoid = v12:FindFirstChildOfClass("Humanoid")

			if Humanoid and not (Humanoid.Health <= 0) then
				activateTrap(v12)
			end
		end

		v3 = Hitbox.Touched:Connect(onTouched)
	end
}