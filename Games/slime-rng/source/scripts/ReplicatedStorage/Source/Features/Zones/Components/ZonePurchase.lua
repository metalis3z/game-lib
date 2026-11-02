-- ZonePurchase (Client UI Component) - FIXED v2
-- BUG FIX 1: Gate reappearing after 3-4 minutes
--   Root cause: LocalTransparencyModifier resets when parts re-stream/refresh.
--   Fix: A persistent task.spawn loop re-applies hidden state every 2 seconds
--        for all already-purchased gates. This ensures even if Roblox resets
--        the transparency, we immediately re-hide it.
-- BUG FIX 2: On rejoin, gates for already-purchased zones were re-appearing
--   because LocalTransparencyModifier resets on new instances.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Vide = require(ReplicatedStorage.Packages.Vide)
local ConfettiSequence = require(ReplicatedStorage.Source.Core.UI.Components.ConfettiSequence)
local ScreenShake = require(ReplicatedStorage.Source.Core.UI.Components.ScreenShake)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local CurrencyLabel = require(ReplicatedStorage.Source.Features.App.Components.CurrencyLabel)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local LuckHudState = require(ReplicatedStorage.Source.Features.Hud.LuckHudState)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Zones = require(ReplicatedStorage.Source.Game.Items.Zones)

local uDim2 = UDim2.fromOffset(124, 124)
local uDim2_2 = UDim2.fromOffset(54, 54)
local uDim2_3 = UDim2.fromOffset(20, 20)

local function getGateParts(n1: number)
	local Zones2 = Workspace:FindFirstChild("Zones")
	local v38 = Zones2 and Zones2:FindFirstChild((tostring(n1)))
	local v39 = if not v38 or not v38:IsA("Model") then nil else v38
	local v40 = v39 and v39:FindFirstChild("Gate")
	local v41 = if not v40 or not v40:IsA("Model") then nil else v40

	if not v41 then
		return {}
	end

	local t1 = {}
	for _, v44 in v41:GetDescendants() do
		if v44:IsA("BasePart") then
			table.insert(t1, v44)
		end
	end
	return t1
end

return function(t2: {[any]: any})
	local v46 = getDataSource("maxZone")
	local v47 = getDataSource("furthestZone")
	local t3 = {}
	local t4 = {}
	local t5 = {}
	local u51 = v46()
	local u52 = v47() or u51
	local v53 = Vide.source(0)
	local v54 = Vide.source(0)
	local v55 = Vide.source("+1")
	local v56 = Vide.source(false)
	local v57 = Vide.source(UDim2.fromScale(0.5, 0.5))
	local v58 = Vide.source(UDim2.fromOffset(0, 0))
	local v59 = Vide.source(0)
	local v60 = Vide.source(1)
	local v61 = Vide.source(1)
	local v62 = Vide.spring(v57, 0.22, 0.7)
	local v63 = Vide.spring(v58, 0.22, 0.72)
	local v64 = Vide.spring(v59, 0.2, 0.65)
	local v65 = Vide.spring(v60, 0.18, 1)
	local v66 = Vide.spring(v61, 0.18, 1)
	local t6 = {}

	local function getZoneLuckTargetPosition()
		local v80 = LuckHudState.getCounterCenter()
		return UDim2.fromOffset(v80.X, v80.Y)
	end

	local function playZoneLuckAnimation(n2: number)
		for _, v83 in t6 do task.cancel(v83) end
		table.clear(t6)
		v55(`+{ math.max(n2, 1) }`)
		Vide.batch(function()
			v56(true)
			v57(UDim2.fromScale(0.5, 0.5))
			v58(UDim2.fromOffset(12, 12))
			v59(-12)
			v60(1)
			v61(1)
		end)

		local function v84()
			Vide.batch(function()
				v58(uDim2)
				v59(4)
				v60(0)
				v61(0)
			end)
		end
		local thread = nil
		thread = task.delay(0.03, function()
			local v160 = table.find(t6, thread)
			if v160 then table.remove(t6, v160) end
			v84()
		end)
		table.insert(t6, thread)

		local function v86()
			Vide.batch(function()
				v58(UDim2.fromOffset(112, 112))
				v59(0)
			end)
		end
		local thread2 = nil
		thread2 = task.delay(0.22, function()
			local v161 = table.find(t6, thread2)
			if v161 then table.remove(t6, v161) end
			v86()
		end)
		table.insert(t6, thread2)

		local function v88()
			Vide.batch(function()
				v57(getZoneLuckTargetPosition())
				v58(uDim2_2)
				v60(0.1)
			end)
		end
		local thread3 = nil
		thread3 = task.delay(1, function()
			local v162 = table.find(t6, thread3)
			if v162 then table.remove(t6, v162) end
			v88()
		end)
		table.insert(t6, thread3)

		local function v90()
			Vide.batch(function()
				v58(uDim2_3)
				v60(1)
				v61(1)
			end)
		end
		local thread4 = nil
		thread4 = task.delay(1.42, function()
			local v163 = table.find(t6, thread4)
			if v163 then table.remove(t6, v163) end
			v90()
		end)
		table.insert(t6, thread4)

		local function v92()
			v56(false)
		end
		local thread5 = nil
		thread5 = task.delay(1.72, function()
			local v164 = table.find(t6, thread5)
			if v164 then table.remove(t6, v164) end
			v92()
		end)
		table.insert(t6, thread5)
	end

	local function hasNextZone()
		return Zones.hasZone(v46() + 1)
	end

	local function ensureGateBlocker(n3: number)
		local Zones3 = Workspace:FindFirstChild("Zones")
		local v98 = Zones3 and Zones3:FindFirstChild((tostring(n3)))
		local v99 = if not v98 or not v98:IsA("Model") then nil else v98
		local v100 = v99 and v99:FindFirstChild("Gate")
		local v101 = if not v100 or not v100:IsA("Model") then nil else v100
		local v102 = v101 and v101:FindFirstChild("Back")
		local v103 = if not v102 or not v102:IsA("BasePart") then nil else v102
		local Zones4 = Workspace:FindFirstChild("Zones")
		local v105 = Zones4 and Zones4:FindFirstChild((tostring(n3)))
		local v106 = if not v105 or not v105:IsA("Model") then nil else v105
		local v107 = v106 and v106:FindFirstChild("Gate")
		local v108 = if not v107 or not v107:IsA("Model") then nil else v107

		if not v103 or not v108 then
			local v109 = t4[n3]
			if v109 then
				v109:Destroy()
				t4[n3] = nil
			end
			return nil
		end

		local v110 = t4[n3]
		if v110 and v110.Parent == nil then
			v110 = nil
			t4[n3] = nil
		end

		if not v110 then
			v110 = Instance.new("Part")
			v110.Name = string.format("ClientGateBlocker_%d", n3)
			v110.Transparency = 1
			v110.Anchored = true
			v110.CanQuery = false
			v110.CanTouch = false
			v110.CastShadow = false
			v110.Massless = true
			v110.Locked = true
			v110.Parent = v108
			t4[n3] = v110
		end

		v110.CFrame = v103.CFrame
		v110.Size = Vector3.new(v103.Size.X, 200, 300)
		v110.CanCollide = v103.CanCollide
		v110.CollisionGroup = v103.CollisionGroup

		return v110
	end

	local function syncGateBlocker(n4: number)
		local v112 = ensureGateBlocker(n4)
		if not v112 then return end

		local Zones5 = Workspace:FindFirstChild("Zones")
		local v114 = Zones5 and Zones5:FindFirstChild((tostring(n4)))
		local v115 = if not v114 or not v114:IsA("Model") then nil else v114
		local v116 = v115 and v115:FindFirstChild("Gate")
		local v117 = if not v116 or not v116:IsA("Model") then nil else v116
		local v118 = v117 and v117:FindFirstChild("Back")
		local v119 = if not v118 or not v118:IsA("BasePart") then nil else v118

		if not v119 then
			v112:Destroy()
			t4[n4] = nil
			return
		end

		v112.CFrame = v119.CFrame
		v112.Size = Vector3.new(v119.Size.X, 200, 300)
		v112.CanCollide = v119.CanCollide
		v112.CollisionGroup = v119.CollisionGroup
	end

	local function applyGateHiddenState(n5: number, b1: boolean)
		for _, v123 in getGateParts(n5) do
			if t3[v123] == nil then
				t3[v123] = {
					canCollide = v123.CanCollide,
					canQuery   = v123.CanQuery,
					canTouch   = v123.CanTouch
				}
			end
			local v124 = t3[v123]
			v123.LocalTransparencyModifier = not b1 and 0 or 1
			v123.CanCollide = not b1 and v124.canCollide
			v123.CanQuery   = not b1 and v124.canQuery
			v123.CanTouch   = not b1 and v124.canTouch
		end
		syncGateBlocker(n5)
	end

	-- Apply hidden state for all already-purchased gates on mount
	local function applyAllPurchasedGates(currentMaxZone: number)
		local Zones6 = Workspace:FindFirstChild("Zones")
		if not Zones6 then return end
		for i = 1, currentMaxZone - 1 do
			applyGateHiddenState(i, true)
		end
	end

	-- Apply on mount after a short wait for Workspace replication
	task.spawn(function()
		local zonesFolder = Workspace:FindFirstChild("Zones")
		if not zonesFolder then
			zonesFolder = Workspace:WaitForChild("Zones", 10)
		end
		if not zonesFolder then return end
		task.wait(0.5)
		local currentMax = v46() or 1
		if currentMax > 1 then
			applyAllPurchasedGates(currentMax)
		end
	end)

	-- ─── BUG FIX: Persistent loop to re-apply gate hidden state ─────────────
	-- LocalTransparencyModifier resets after ~3-4 minutes when Roblox
	-- re-streams or refreshes part instances. We re-apply every 2 seconds
	-- for all purchased zones to permanently keep gates invisible.
	local persistentLoopActive = true
	task.spawn(function()
		-- Wait for zones folder first
		local zonesFolder = Workspace:FindFirstChild("Zones")
		if not zonesFolder then
			zonesFolder = Workspace:WaitForChild("Zones", 10)
		end
		if not zonesFolder then return end
		task.wait(1) -- initial wait

		while persistentLoopActive do
			task.wait(2) -- re-apply every 2 seconds
			local currentMax = v46() or 1
			if currentMax > 1 then
				for i = 1, currentMax - 1 do
					-- Only re-apply if the gate parts exist and are visible
					-- (LocalTransparencyModifier got reset to 0)
					local parts = getGateParts(i)
					for _, part in parts do
						if part.Parent ~= nil and part.LocalTransparencyModifier < 1 then
							-- Gate became visible again — re-hide it
							applyGateHiddenState(i, true)
							break
						end
					end
				end
			end
		end
	end)
	-- ─────────────────────────────────────────────────────────────────────────

	-- Re-apply when a new zone model streams in
	local zonesFolder = Workspace:FindFirstChild("Zones")
	if zonesFolder then
		zonesFolder.ChildAdded:Connect(function(child)
			local num = tonumber(child.Name)
			if num and num < (v46() or 1) then
				task.wait(0.1)
				applyGateHiddenState(num, true)
			end
		end)
	end

	local function playCelebrationEffects()
		v53(v53() + 1)
		v54(v54() + 1)
	end

	Vide.effect(function()
		local v127 = v46()
		local v128 = math.max(v47() or 1, v127)
		local Zones6 = Workspace:FindFirstChild("Zones")

		if not Zones6 then return end

		if v127 > u51 then
			SoundController:Play(Sounds.misc.zoneUnlock)
			task.defer(playCelebrationEffects)

			for i = u51 + 1, v127 do
				local v131 = i - 1
				if v131 >= 1 and not t5[v131] then
					local v132 = getGateParts(v131)
					if #v132 ~= 0 then
						t5[v131] = true
						task.spawn(function()
							local t7 = {}
							for _, v178 in v132 do
								if t3[v178] == nil then
									t3[v178] = {
										canCollide = v178.CanCollide,
										canQuery   = v178.CanQuery,
										canTouch   = v178.CanTouch
									}
								end
								t7[v178] = v178.LocalTransparencyModifier
							end

							local elapsed = os.clock()
							while true do
								local v180 = math.clamp((os.clock() - elapsed) / 0.45, 0, 1)
								local v181 = 1 - (1 - v180) ^ 3
								for _, v183 in v132 do
									if v183.Parent ~= nil then
										local v184 = t7[v183] or 0
										v183.LocalTransparencyModifier = v184 + (1 - v184) * v181
									end
								end
								if v180 >= 1 then break end
								task.wait()
							end

							for _, v186 in v132 do
								if v186.Parent ~= nil then
									v186.LocalTransparencyModifier = 1
									v186.CanCollide = false
									v186.CanQuery   = false
									v186.CanTouch   = false
								end
							end

							syncGateBlocker(v131)
							t5[v131] = nil
						end)
					end
				end
			end
		end

		if v128 > u52 then
			task.defer(playZoneLuckAnimation, v128 - u52)
		end

		for _, v134 in Zones6:GetChildren() do
			local num = tonumber(v134.Name)
			local Gate = v134:FindFirstChild("Gate")
			if num and Gate and Gate:IsA("Model") then
				local v137 = num < v127
				if not t5[num] then
					applyGateHiddenState(num, v137)
				end
			end
		end

		u51 = v127
		u52 = v128
	end)

	Vide.cleanup(function()
		persistentLoopActive = false -- stop the persistent loop

		for _, v139 in t6 do task.cancel(v139) end
		table.clear(t6)

		for _, v141 in t4 do
			if v141.Parent ~= nil then v141:Destroy() end
		end
		table.clear(t4)

		for v142, v143 in t3 do
			if v142.Parent ~= nil then
				v142.LocalTransparencyModifier = 0
				v142.CanCollide = v143.canCollide
				v142.CanQuery   = v143.canQuery
				v142.CanTouch   = v143.canTouch
			end
		end
	end)

	return {
		Vide.create("ScreenGui")({
			Name = "ZonePurchaseEffects",
			ResetOnSpawn = false,
			IgnoreGuiInset = true,
			DisplayOrder = 50,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			Frame({
				Name = "CelebrationLayer",
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ConfettiSequence({
					Name = "UnlockConfetti",
					ZIndex = 60,
					Trigger = v53
				}),
				ScreenShake({
					Name = "UnlockShake",
					Duration = 0.55,
					PositionStrength = 0.18,
					RotationStrength = 0.013962634015954637,
					BindName = "ZonePurchaseCameraShake",
					Trigger = v54
				}),
				Frame({
					Name = "ZoneLuckBurst",
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Visible = v56,
					ZIndex = 70,
					ImageLabel({
						Name = "LuckIcon",
						ZIndex = 71,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = v62,
						Size = v63,
						Rotation = v64,
						Image = ImageIds.luckIcons[1],
						ImageTransparency = v65
					}),
					TextLabel({
						Name = "LuckAmount",
						ZIndex = 72,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = v62,
						Size = function()
							local v144 = v63()
							return UDim2.fromOffset(math.max(v144.X.Offset * 0.72, 44), (math.max(v144.Y.Offset * 0.34, 22)))
						end,
						Rotation = v64,
						Text = v55,
						TextTransparency = v66,
						TextColor3 = Color3.fromRGB(240, 255, 240),
						Stroke = {
							Thickness = 3,
							Transparency = v66
						},
						DropShadow = {
							Transparency = v66
						}
					})
				})
			})
		}),
		Vide.create("SurfaceGui")({
			Name = "ZonePurchase",
			ResetOnSpawn = false,
			AlwaysOnTop = true,
			LightInfluence = 0,
			SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
			PixelsPerStud = 8,
			Face = Enum.NormalId.Left,
			Adornee = function()
				local v145 = v46()
				local Zones7 = Workspace:FindFirstChild("Zones")
				local v147 = Zones7 and Zones7:FindFirstChild((tostring(v145)))
				local v148 = if not v147 or not v147:IsA("Model") then nil else v147
				local v149 = v148 and v148:FindFirstChild("Gate")
				local v150 = if not v149 or not v149:IsA("Model") then nil else v149
				local v151 = v150 and v150:FindFirstChild("Back")
				if v151 and v151:IsA("BasePart") then return v151 end
				return nil
			end,
			Enabled = function()
				local v152 = v46()
				local Zones8 = Workspace:FindFirstChild("Zones")
				local v154 = Zones8 and Zones8:FindFirstChild((tostring(v152)))
				local v155 = if not v154 or not v154:IsA("Model") then nil else v154
				local v156 = v155 and v155:FindFirstChild("Gate")
				local v157 = if not v156 or not v156:IsA("Model") then nil else v156
				local v158 = v157 and v157:FindFirstChild("Back")
				return ((if not v158 or not v158:IsA("BasePart") then nil else v158)) ~= nil
			end,
			Frame({
				Size = UDim2.fromOffset(440, 220),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				TextLabel({
					Name = "ZoneName",
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = function()
						if not Zones.hasZone(v46() + 1) then return "MAXED" end
						return Zones.getZone(v46() + 1).name
					end,
					Size = UDim2.fromOffset(360, 52),
					Position = UDim2.fromScale(0.5, 0.19),
					Stroke = { Thickness = 2.5 },
					DropShadow = {}
				}),
				CurrencyLabel({
					Currency = "coins",
					Amount = function()
						if not Zones.hasZone(v46() + 1) then return 0 end
						return Zones.getZone(v46() + 1).price
					end,
					Size = UDim2.fromOffset(320, 60),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.46),
					Visible = hasNextZone,
					Stroke = {}
				}),
				StylizedButton({
					Name = "BuyButton",
					Theme = function()
						if Zones.hasZone(v46() + 1) then return "Green" end
						return "Grey"
					end,
					Text = function()
						if Zones.hasZone(v46() + 1) then return "Buy" end
						return "MAXED"
					end,
					Size = UDim2.fromOffset(200, 72),
					Position = UDim2.fromScale(0.5, 0.85),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Active = hasNextZone,
					Activated = function()
						if not Zones.hasZone(v46() + 1) then return end
						t2.OnBuy()
					end
				})
			})
		})
	}
end