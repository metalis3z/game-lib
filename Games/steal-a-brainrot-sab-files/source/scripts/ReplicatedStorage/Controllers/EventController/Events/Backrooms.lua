

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
local LocalPlayer = Players.LocalPlayer
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local LightingController = require(ReplicatedStorage.Controllers.LightingController)
local WorldBrainrotController = require(ReplicatedStorage.Controllers.WorldBrainrotController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local BackroomsSpeedData = require(ReplicatedStorage.Datas.BackroomsSpeedData)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local v21 = Net:RemoteFunction("BackroomsService/RequestBuySpeed")
local v22 = Net:RemoteEvent("BackroomsService/UpdateOwnedSpeedTier")
local t2 = {
	Idle = "Idle",
	Walk = "Walk",
	Attack = "Attack"
}
local t3 = {
	Priority = 100,
	Brightness = 2,
	ExposureCompensation = 0,
	EnvironmentDiffuseScale = 0.8,
	EnvironmentSpecularScale = 0.4,
	GlobalShadows = false,
	Ambient = Color3.fromRGB(110, 100, 80),
	OutdoorAmbient = Color3.fromRGB(90, 80, 60),
	ColorCorrection = {
		Brightness = -0.1,
		Saturation = -0.2,
		Contrast = 0.1,
		TintColor = Color3.fromRGB(255, 235, 145)
	}
}
local v25 = Net:RemoteEvent("BackroomsService/RequestOwnedSpeedTier")
local CurrentCamera = workspace.CurrentCamera
local v27 = Trove.new()
local t4 = {}
local color3 = Color3.fromRGB(255, 242, 153)
local color3_2 = Color3.fromRGB(255, 30, 30)
local random = Random.new()
local color3_3 = Color3.new(0, 0, 0)

local function attachLight(p1, color3_4: Color3?, n1: number?, n2: number?, n3: number?)
	local Attachment = Instance.new("Attachment")

	Attachment.Name = "BackroomsAttachment"
	Attachment.CFrame = CFrame.new(0, n3 or 3, 0)

	local PointLight = Instance.new("PointLight")

	PointLight.Name = "BackroomsPointLight"
	PointLight.Brightness = n1 or 3
	PointLight.Color = color3_4 or color3
	PointLight.Range = n2 or 12
	PointLight.Parent = Attachment
	Attachment.Parent = p1

	return function()
		Attachment:Destroy()
		PointLight:Destroy()
	end, PointLight
end
local function isInsideLightingArea(vector3: Vector3)
	for v50 in t4 do
		local v51 = v50.CFrame:PointToObjectSpace(vector3)
		local Size = v50.Size

		if math.abs(v51.X) <= Size.X * 0.5 and math.abs(v51.Y) <= Size.Y * 0.5 and math.abs(v51.Z) <= Size.Z * 0.5 then
			return true
		end
	end

	return false
end

local u35 = nil
local t5 = {
	"ColorCorrectionEffect",
	"BlurEffect",
	"BloomEffect",
	"SunRaysEffect",
	"DepthOfFieldEffect"
}

local function applyLighting()
	if u35 then
		return
	end

	local v56 = Trove.new()

	u35 = v56
	v56:Add(LightingController:Push("Backrooms", t3))
	LocalPlayer:SetAttribute("BackroomsCaveInside", true)
	v56:Add(function()
		LocalPlayer:SetAttribute("BackroomsCaveInside", nil)
	end)

	local SunRaysEffect = Lighting:FindFirstChildOfClass("SunRaysEffect")
	local ClockTime = Lighting.ClockTime
	local v59 = if not SunRaysEffect then nil else SunRaysEffect.Intensity
	local u60 = false
	local u61 = false

	u60 = true
	Lighting.ClockTime = 0
	u60 = false

	local g68 = nil
	local v67 = nil

	if SunRaysEffect then
		u61 = true
		SunRaysEffect.Intensity = 0
		u61 = false
	end

	v56:Add(Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
		if u60 then
			return
		end

		u60 = true
		Lighting.ClockTime = 0
		u60 = false
	end))

	if SunRaysEffect then
		v56:Add(SunRaysEffect:GetPropertyChangedSignal("Intensity"):Connect(function()
			if u61 then
				return
			end

			if not SunRaysEffect then
				return
			end

			u61 = true
			SunRaysEffect.Intensity = 0
			u61 = false
		end))
	end

	v56:Add(function()
		local v100 = ClockTime

		u60 = true
		Lighting.ClockTime = v100
		u60 = false

		if v59 ~= nil then
			local v101 = v59

			if not SunRaysEffect then
				return
			end

			u61 = true
			SunRaysEffect.Intensity = v101
			u61 = false
		end
	end)

	if CurrentCamera then
		local t6 = {}

		for _, v64 in CurrentCamera:GetChildren() do
			if t6[v64] == nil then
				for _, v66 in t5 do
					if v64:IsA(v66) then
						v67 = true
						g68 = true
					end

					if g68 then
						break
					end
				end

				if not g68 then
					v67 = false
				end

				g68 = false

				if v67 and string.sub(v64.Name, 1, 19) ~= "LightingController_" then
					t6[v64] = v64.Enabled
					v64.Enabled = false
				end
			end
		end

		v56:Add(CurrentCamera.ChildAdded:Connect(function(child)
			if t6[child] ~= nil then
				return
			end

			local g106 = nil
			local v105 = nil

			for _, v104 in t5 do
				if child:IsA(v104) then
					v105 = true
					g106 = true
				end

				if g106 then
					break
				end
			end

			if not g106 then
				v105 = false
			end

			g106 = false

			if not v105 then
				return
			end

			if string.sub(child.Name, 1, 19) == "LightingController_" then
				return
			end

			t6[child] = child.Enabled
			child.Enabled = false
		end))
		v56:Add(function()
			for v107, v108 in t6 do
				if v107.Parent then
					v107.Enabled = v108
				end
			end

			table.clear(t6)
		end)
	end

	v56:Add(Observers.observeTag("MapVFX", function(p2)
		local p2Parent = p2.Parent

		p2.Parent = script

		return function()
			pcall(function()
				p2.Parent = p2Parent
			end)
		end
	end, {
		workspace,
		script
	}))
	v56:Add(Observers.observeCharacters(function(_, p4)
		local v113 = Trove.new()

		v113:Add(task.spawn(function()
			local UpperTorso = p4:WaitForChild("UpperTorso", 10)

			if not UpperTorso then
				return
			end

			local v153 = attachLight(UpperTorso)

			v113:Add(v153)
		end))

		return v113:WrapClean()
	end))

	local RenderedMovingAnimals = workspace:FindFirstChild("RenderedMovingAnimals")

	if RenderedMovingAnimals then
		v56:Add(Observers.observeChildren(RenderedMovingAnimals, function(p5)
			local v115 = Trove.new()

			v115:Add(task.spawn(function()
				local RootPart = p5:WaitForChild("RootPart", 10)

				if not RootPart then
					return
				end

				local v155 = attachLight(RootPart)

				v115:Add(v155)
			end))

			return v115:WrapClean()
		end))
	end
end
local function removeLighting()
	if not u35 then
		return
	end

	u35:Destroy()
	u35 = nil
end
local function startSpeedShop()
	local BackroomsSpeedUpgrade = LocalPlayer.PlayerGui:WaitForChild("BackroomsSpeedUpgrade", 30)

	if not BackroomsSpeedUpgrade then
		warn("[Backrooms] PlayerGui.BackroomsSpeedUpgrade missing — speed shop disabled")

		return
	end

	local BackroomsSpeedUpgrade2 = BackroomsSpeedUpgrade:WaitForChild("BackroomsSpeedUpgrade", 5)

	if not BackroomsSpeedUpgrade2 then
		warn("[Backrooms] BackroomsSpeedUpgrade.BackroomsSpeedUpgrade frame missing")

		return
	end

	local v72 = InterfaceController:Get("BackroomsSpeedShop")
	local v73 = v72 or InterfaceController:Register("BackroomsSpeedShop", BackroomsSpeedUpgrade2, "TopQuint")

	if not v73 then
		warn("[Backrooms] failed to get/register BackroomsSpeedShop interface")

		return
	end

	if not v72 then
		v73:AttachCloseButton(BackroomsSpeedUpgrade2.Header.Close)
	end

	InterfaceController:SetState("BackroomsSpeedShop", false)
	v27:Add(function()
		InterfaceController:SetState("BackroomsSpeedShop", false)
	end)

	local v74 = Synchronizer:Wait(LocalPlayer)

	if not v74 then
		return
	end

	local n4 = 0
	local t7 = {}
	local List = BackroomsSpeedUpgrade2.Content.List
	local Template = List.Template

	for v79, v80 in BackroomsSpeedData.upgrades do
		local clone = Template:Clone()

		clone.Name = tostring(v79)
		clone.LayoutOrder = v79
		clone.Frame.Label.Text = `+{ v80 } Speed`
		clone.Visible = true
		clone.Parent = List
		v27:Add(clone)

		local t8 = {
			locked = false,
			copy = clone,
			amount = v80
		}

		table.insert(t7, t8)

		local v83 = AnimatedButton.new(clone.Frame.Buy)

		v83:Animate()
		v27:Add(v83)
		v27:Add(v83.OnActivated:Connect(function()
			if t8.locked then
				return
			end

			v21:InvokeServer(v80)
		end))
	end

	local function updateRow(t9: {[any]: any})
		local v119 = v74:Get("Rebirth") or 0

		if type(v119) ~= "number" then
			v119 = 0
		end

		local v120 = BackroomsSpeedData.getRequiredRebirthForAmount(n4 + t9.amount)
		local v121 = v120 <= v119

		t9.locked = not v121

		local copy = t9.copy
		local v123 = copy:FindFirstChild("Locked") or copy.Frame:FindFirstChild("Locked")
		local v124 = v123 and v123:FindFirstChild("Txt")

		if v123 then
			v123.Visible = not v121

			if not v121 and v124 then
				v124.Text = `YOU NEED { v120 } REBIRTHS`
			end
		end

		local v125 = BackroomsSpeedData.canBuy(n4, t9.amount, v119)
		local v126 = BackroomsSpeedData.getUpgradeCost(n4, t9.amount)

		t9.copy.Frame.PreviousAmount.Text = NumberUtils:Comma(BackroomsSpeedData.getTotalSpeed(n4))

		local v127 = BackroomsSpeedData.getMaxUpgradesForRebirth(v119)

		t9.copy.Frame.TargetAmount.Text = NumberUtils:Comma(BackroomsSpeedData.getTotalSpeed((math.min(n4 + t9.amount, v127))))

		if not v125 then
			t9.copy.Frame.Buy.Price.Text = "MAX"
		else
			t9.copy.Frame.Buy.Price.Text = `Buy (${ NumberUtils:ToString(v126) })`
		end

		local v128 = v74:Get("Coins")
		local v129 = type(v128) == "number" and v126 <= v128
		local v130 = v121 and (v125 and v129)

		Spr.target(t9.copy.Frame.Buy, 1, 5, {
			BackgroundColor3 = if not v130 then Color3.fromRGB(158, 158, 158) else Color3.fromRGB(81, 158, 86)
		})
	end
	local function updateAll()
		for _, v132 in t7 do
			updateRow(v132)
		end
	end

	v27:Add(v22.OnClientEvent:Connect(function(n5: number?)
		n4 = n5 or 0

		for _, v135 in t7 do
			updateRow(v135)
		end
	end))
	v27:Add(v74:OnChanged("Coins", updateAll))
	v27:Add(v74:OnChanged("Rebirth", updateAll))
	task.spawn(updateAll)
	task.spawn(function()
		v25:FireServer()
	end)
end

function t1.OnStart(_)
	EffectController:Activate("Blink")
	v27:Add(function()
		EffectController:Activate("Blink")
	end)
	v27:Clone(script.BackroomsMapWalls).Parent = workspace
	v27:Add(function()
		SoundController:UpdateAmbience()
	end)
	SoundController:UpdateAmbience()
	EffectController:Run("BackroomsEvent", "GrassRecolor")
	v27:Add(function()
		EffectController:Stop("BackroomsEvent", "GrassRecolor")
	end)
	v27:Add(Observers.observeTag("BackroomsLightingArea", function(p7)
		if not p7:IsA("BasePart") then
			return nil
		end

		t4[p7] = true

		return function()
			t4[p7] = nil
		end
	end, { workspace }))
	v27:Add(function()
		table.clear(t4)
	end)
	v27:Add(Timer.Simple(0.016666666666666666, function()
		if not CurrentCamera then
			if not u35 then
				return
			end

			u35:Destroy()
			u35 = nil

			return
		end

		if isInsideLightingArea(CurrentCamera.CFrame.Position) then
			applyLighting()

			return
		end

		if not u35 then
			return
		end

		u35:Destroy()
		u35 = nil
	end, true))
	v27:Add(removeLighting)

	local t10 = {}
	local v88 = ReplicatorClient.get("Backrooms/Brainrots")

	v27:Add(WorldBrainrotController:RenderPool({
		PoolId = "Backrooms/Brainrots",
		ReplicatorId = "Backrooms/Brainrots",
		ShowTimer = true,
		ShowDropButton = true,
		GrabHoldDuration = 1.5,
		GrabMaxDistance = 10,
		KeepWhenGrabbed = false,
		RenderedBrainrots = t10,
		OnRendered = function(s1: string)
			local v138 = t10[s1]

			if not v138 or (not v138.model or not v138.model.PrimaryPart) then
				return
			end

			local _, v140 = attachLight(v138.model.PrimaryPart, color3, 3, 16, 2)

			local function v141()
				local v156 = v88:TryIndex({
					"brainrots",
					s1
				})

				if v156 then
					return v156.despawnTimer
				end

				return nil
			end

			task.spawn(function()
				task.wait(random:NextNumber(0, 8))

				while v140.Parent do
					local v157 = false

					if v141 then
						local v158 = v141()

						v157 = v158 ~= nil and v158 < 30
					end

					local v159 = not v157 and 8 or 0.4
					local v160 = not v157 and 25 or 1.5

					task.wait(random:NextNumber(v159, v160))

					if not v140.Parent then
						return
					end

					local v161 = not v157 and 2 or 4
					local v162 = not v157 and 6 or 10

					for _ = 1, random:NextInteger(v161, v162) do
						if not v140.Parent then
							return
						end

						v140.Enabled = false
						task.wait(random:NextNumber(0.04, 0.18))

						if not v140.Parent then
							return
						end

						v140.Enabled = true
						task.wait(random:NextNumber(0.04, 0.18))
					end
				end
			end)
		end
	}))
	v27:Add(Observers.observeTag("BackroomsSpeedShop", function(p8)
		if not p8:IsA("ProximityPrompt") then
			return nil
		end

		local connection = p8.Triggered:Connect(function()
			InterfaceController:Toggle("BackroomsSpeedShop")
		end)

		return function()
			connection:Disconnect()
		end
	end))
	v27:Add(Observers.observeTag("BackroomsSammy", function(p9)
		if not p9:IsA("Model") then
			return nil
		end

		local v145 = Trove.new()

		v145:Add(task.spawn(function()
			local v164 = nil
			local v165 = os.clock() + 10

			while v165 > os.clock() do
				v164 = p9:FindFirstChild("HumanoidRootPart") or (p9:FindFirstChild("RootPart") or p9.PrimaryPart)

				if v164 and v164:IsA("BasePart") then
					break
				end

				v164 = nil
				task.wait(0.1)
			end

			if not v164 then
				return
			end

			local BackroomsSammyTier = p9:GetAttribute("BackroomsSammyTier")
			local v167 = if BackroomsSammyTier ~= 1 then BackroomsSammyTier ~= 3 and 32 or 40 else 22
			local v168 = attachLight(v164, color3_2, 4, v167, 2)

			v145:Add(v168)
		end))
		v145:Add(task.spawn(function()
			local AnimationController = p9:WaitForChild("AnimationController", 10)

			if not AnimationController then
				return
			end

			local Animator = AnimationController:WaitForChild("Animator", 10)

			if not Animator then
				return
			end

			local Animations = p9:WaitForChild("Animations", 10)

			if not Animations then
				return
			end

			local function loadAnim(s2: string, b1: boolean, p10)
				local s2_2 = Animations:FindFirstChild(s2)

				if not s2_2 or not s2_2:IsA("Animation") then
					return nil
				end

				local v182 = Animator:LoadAnimation(s2_2)

				v182.Looped = b1
				v182.Priority = p10
				v145:Add(function()
					v182:Stop(0)
					v182:Destroy()
				end)

				return v182
			end

			local v173 = loadAnim(t2.Idle, true, Enum.AnimationPriority.Idle)
			local v174 = loadAnim(t2.Walk, true, Enum.AnimationPriority.Movement)
			local v175 = loadAnim(t2.Attack, false, Enum.AnimationPriority.Action)
			local u176 = nil

			if p9:GetAttribute("Walking") then
				if v174 ~= u176 then
					if u176 then
						u176:Stop(0.2)
					end

					u176 = v174

					if u176 then
						u176:Play(0.2)
					end
				end
			elseif v173 ~= u176 then
				if u176 then
					u176:Stop(0.2)
				end

				u176 = v173

				if u176 then
					u176:Play(0.2)
				end
			end

			v145:Add(p9:GetAttributeChangedSignal("Walking"):Connect(function()
				if p9:GetAttribute("Walking") then
					local v184 = v174

					if v184 == u176 then
						return
					end

					if u176 then
						u176:Stop(0.2)
					end

					u176 = v184

					if u176 then
						u176:Play(0.2)

						return
					end
				else
					local v185 = v173

					if v185 == u176 then
						return
					end

					if u176 then
						u176:Stop(0.2)
					end

					u176 = v185

					if u176 then
						u176:Play(0.2)
					end
				end
			end))
			v145:Add(p9:GetAttributeChangedSignal("BackroomsAttackCounter"):Connect(function()
				if v175 then
					v175:Play(0.1)
				end
			end))
		end))

		return v145:WrapClean()
	end, { workspace }))
	v27:Add(Observers.observeTag("HideInBackrooms", function(p11)
		local p11Parent = p11.Parent

		p11.Parent = script

		return function()
			pcall(function()
				p11.Parent = p11Parent
			end)
		end
	end, {
		workspace,
		script
	}))
	v27:Add(Observers.observeTag("BackroomsFlicker", function(p12)
		if not p12:IsA("SpotLight") then
			return nil
		end

		local p12Parent = p12.Parent

		if not p12Parent or not p12Parent:IsA("BasePart") then
			return nil
		end

		local p12ParentColor = p12Parent.Color
		local v151 = Trove.new()

		v151:Add(function()
			p12Parent.Color = p12ParentColor
			p12.Enabled = true
		end)
		v151:Add(task.spawn(function()
			task.wait(random:NextNumber(0, 8))

			while true do
				task.wait(random:NextNumber(8, 25))

				for _ = 1, random:NextInteger(2, 6) do
					p12Parent.Color = color3_3
					p12.Enabled = false
					task.wait(random:NextNumber(0.04, 0.18))
					p12Parent.Color = p12ParentColor
					p12.Enabled = true
					task.wait(random:NextNumber(0.04, 0.18))
				end
			end
		end))

		return v151:WrapClean()
	end, { workspace }))
	startSpeedShop()
end
function t1.OnStop(_)
	v27:Destroy()
end
function t1.OnLoad(_)
end

return t1
