-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OfflineEarningsBurstLayer, time of decompilation: Sun May  3 10:12:13 2026 ]]
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local AutoScaledFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.AutoScaledFrame)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local viewportSizeSource = require(ReplicatedStorage.Source.Core.UI.Sources.viewportSizeSource)
local OfflineEarningsSlice = require(ReplicatedStorage.Source.Features.OfflineEarnings.OfflineEarningsSlice)
local TopBarHudState = require(ReplicatedStorage.Source.Features.Hud.TopBarHudState)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local vector2 = Vector2.new(1500, 803)

local function createParticleState(s1: string) -- line: 117
	-- upvalues: Vide (copy)
	return {
		visible = Vide.source(false),
		position = Vide.source(UDim2.fromScale(0.5, 0.5)),
		size = Vide.source(UDim2.fromOffset(0, 0)),
		imageTransparency = Vide.source(1),
		rotation = Vide.source(0),
		image = Vide.source(s1)
	}
end
local function prepareParticle(t1: {[any]: any}, s2: string, vector2_2: Vector2, n1: number, n2: number) -- line: 133
	t1.image(s2)
	t1.position(UDim2.fromOffset(vector2_2.X, vector2_2.Y))
	t1.size(UDim2.fromOffset(n1, n1))
	t1.rotation(n2)
	t1.imageTransparency(1)
	t1.visible(true)
end
local function updateParticleAnimation(t2: {[any]: any}, n3: number) -- line: 142
	local v45 = n3 - t2.startTime

	if v45 < 0 then
		return false
	end

	if not t2.started then
		t2.started = true
		t2.state.visible(true)
	end

	local v46 = math.clamp(v45 / t2.duration, 0, 1)
	local v47 = if not (v46 < 0.5) then 1 - math.pow(v46 * -2 + 2, 3) / 2 else v46 * 4 * v46 * v46
	local p0 = t2.p0
	local p1 = t2.p1
	local p2 = t2.p2
	local p3 = t2.p3
	local v52 = 1 - v47
	local v53 = p0 * v52 * v52 * v52 + p1 * 3 * v52 * v52 * v47 + p2 * 3 * v52 * v47 * v47 + p3 * v47 * v47 * v47
	local startSize = t2.startSize
	local v55 = startSize + (t2.endSize - startSize) * v47
	local startRotation = t2.startRotation
	local v57 = startRotation + (t2.endRotation - startRotation) * v47
	local v58 = if not (v46 < 0.15) then not (v46 > 0.78) and 0 or (v46 - 0.78) / 0.22 else 1 - v46 / 0.15

	t2.state.position(UDim2.fromOffset(v53.X, v53.Y))
	t2.state.size(UDim2.fromOffset(v55, v55))
	t2.state.rotation(v57)
	t2.state.imageTransparency((math.clamp(v58, 0, 1)))

	if v46 >= 1 then
		local state = t2.state

		state.visible(false)
		state.imageTransparency(1)

		return true
	end

	return false
end
local function renderParticle(s3: string, t3: {[any]: any}, n4: number) -- line: 176
	-- upvalues: ImageLabel (copy)
	return ImageLabel({
		Name = s3,
		Visible = t3.visible,
		Image = t3.image,
		ScaleType = Enum.ScaleType.Fit,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = t3.position,
		Size = t3.size,
		Rotation = t3.rotation,
		ImageTransparency = t3.imageTransparency,
		ZIndex = n4
	})
end
local function BurstParticles() -- line: 191
	-- upvalues: OfflineEarningsSlice (copy), createParticleState (copy), ImageIds (copy), TopBarHudState (copy), viewportSizeSource (copy), vector2 (copy), GuiService (copy), prepareParticle (copy), RunService (copy), updateParticleAnimation (copy), Vide (copy), renderParticle (copy), Frame (copy)
	local burstId = OfflineEarningsSlice.burstId
	local latestBurst = OfflineEarningsSlice.latestBurst
	local u65 = burstId()
	local t4 = {}
	local t5 = {}

	for _ = 1, 24 do
		table.insert(t4, (createParticleState(ImageIds.coin)))
	end

	local function queueParticleBurst(s4: string, n5: number, uDim2: UDim2) -- line: 219
		-- upvalues: TopBarHudState (copy), viewportSizeSource (copy), vector2 (copy), GuiService (copy), t4 (copy), prepareParticle (copy), ImageIds (copy), t5 (copy)
		local v81 = TopBarHudState.getCounterAbsolutePosition(s4)
		local v82 = viewportSizeSource()
		local g97 = nil
		local v96 = nil

		if v82.X <= 0 or v82.Y <= 0 then
		else
			local v83 = math.min(v82.X / vector2.X, v82.Y / vector2.Y)

			v81 = if not (v83 <= 0) then (v81 - (v82 - vector2 * v83) / 2) / v83 else v81
		end

		local v84 = v81 + GuiService:GetGuiInset()
		local v85 = viewportSizeSource()
		local vector2_3 = Vector2.new(v85.X * uDim2.X.Scale + uDim2.X.Offset, v85.Y * uDim2.Y.Scale + uDim2.Y.Offset)
		local v87 = viewportSizeSource()

		if v87.X <= 0 or v87.Y <= 0 then
		else
			local v88 = math.min(v87.X / vector2.X, v87.Y / vector2.Y)

			vector2_3 = if not (v88 <= 0) then (vector2_3 - (v87 - vector2 * v88) / 2) / v88 else vector2_3
		end

		local v89 = v84 - vector2_3
		local v90 = if not (v89.Magnitude > 0.001) then Vector2.new(0, -1) else v89.Unit
		local vector2_4 = Vector2.new(-v90.Y, v90.X)
		local v92 = math.clamp(math.ceil(math.log10(math.max(n5, 1) + 1) * 2.25) + 6, 6, 12)

		for i = 1, v92 do
			for _, v95 in t4 do
				if not v95.visible() then
					v96 = v95
					g97 = true
				end

				if g97 then
					break
				end
			end

			if not g97 then
				v96 = nil
			end

			g97 = false

			if not v96 then
				return
			end

			local v98 = i / v92 * 3.141592653589793 * 2 + (-0.45 + 0.9 * math.random())
			local vector2_5 = Vector2.new(math.cos(v98), (math.sin(v98)))
			local v100 = 14 + 24 * math.random()
			local v101 = 70 + 75 * math.random()
			local v102 = vector2_3 + vector2_5 * v100 * 0.25
			local v103 = vector2_3 + vector2_5 * v101
			local v104 = vector2_3:Lerp(v84, 0.45 + 0.23000000000000004 * math.random()) + vector2_4 * (-105 + 210 * math.random()) + Vector2.new(0, -(18 + 54 * math.random()))
			local v105 = 0.56 + 0.17999999999999994 * math.random()
			local v106 = (i - 1) * 0.025 + (0 + 0.035 * math.random())
			local v107 = 50 + 27 * math.random()
			local v108 = 27 + 14 * math.random()
			local v109 = v84 + Vector2.new(v108 * 0.5, v108 * 0.5)

			prepareParticle(v96, if s4 ~= "goop" then ImageIds.coin else ImageIds.goop, v102, v107, -30 + 60 * math.random())
			table.insert(t5, {
				started = false,
				state = v96,
				startTime = os.clock() + v106,
				duration = v105,
				p0 = v102,
				p1 = v103,
				p2 = v104,
				p3 = v109,
				startSize = v107,
				endSize = v108,
				startRotation = -40 + 80 * math.random(),
				endRotation = -280 + 560 * math.random()
			})
		end
	end

	local connection = RunService.Heartbeat:Connect(function() -- line: 281
		-- upvalues: t5 (copy), updateParticleAnimation (copy)
		local elapsed = os.clock()

		for i = #t5, 1, -1 do
			if updateParticleAnimation(t5[i], elapsed) then
				table.remove(t5, i)
			end
		end
	end)

	Vide.effect(function() -- line: 290
		-- upvalues: burstId (copy), u65 (ref), latestBurst (copy), t5 (copy), t4 (copy), queueParticleBurst (copy)
		local v117 = burstId()

		if v117 == u65 then
			return
		end

		u65 = v117

		local v118 = latestBurst()

		if not v118 then
			table.clear(t5)

			for _, v120 in t4 do
				v120.visible(false)
				v120.imageTransparency(1)
			end

			return
		end

		local entries = v118.entries

		table.clear(t5)

		for _, v123 in t4 do
			v123.visible(false)
			v123.imageTransparency(1)
		end

		for _, v125 in entries do
			queueParticleBurst(v125.currencyPath, v125.amount, v125.startPosition)
		end
	end)
	Vide.cleanup(function() -- line: 306
		-- upvalues: connection (copy), t5 (copy), t4 (copy)
		connection:Disconnect()
		table.clear(t5)

		for _, v127 in t4 do
			v127.visible(false)
			v127.imageTransparency(1)
		end
	end)

	local t6 = {}

	for v72, v73 in t4 do
		table.insert(t6, renderParticle(`OfflineEarningsParticle{ v72 }`, v73, 81 + v72))
	end

	return Frame({
		Name = "OfflineEarningsBurstParticles",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 80,
		t6
	})
end

return function() -- line: 329
	-- upvalues: AutoScaledFrame (copy), vector2 (copy), BurstParticles (copy)
	return AutoScaledFrame({
		Name = "OfflineEarningsBurstLayer",
		Size = UDim2.fromOffset(vector2.X, vector2.Y),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 80,
		BurstParticles()
	})
end
