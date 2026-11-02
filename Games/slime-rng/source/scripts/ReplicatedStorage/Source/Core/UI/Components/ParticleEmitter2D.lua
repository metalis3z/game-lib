-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ParticleEmitter2D, time of decompilation: Sun May  3 10:11:06 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local Gif = require(ReplicatedStorage.Source.Core.UI.Components.Gif)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local n1 = 0

local function evaluateNumberSequence(p1, n2: number) -- line: 79
	local Keypoints = p1.Keypoints

	if n2 <= Keypoints[1].Time then
		return Keypoints[1].Value
	end

	for i = 1, #Keypoints - 1 do
		local v16 = Keypoints[i]
		local v17 = Keypoints[i + 1]

		if n2 <= v17.Time then
			local v18 = (n2 - v16.Time) / math.max(v17.Time - v16.Time, 1E-06)

			return v16.Value + (v17.Value - v16.Value) * v18
		end
	end

	return Keypoints[#Keypoints].Value
end
local function evaluateColorSequence(p2, n3: number) -- line: 95
	local Keypoints = p2.Keypoints

	if n3 <= Keypoints[1].Time then
		return Keypoints[1].Value
	end

	for i = 1, #Keypoints - 1 do
		local v23 = Keypoints[i]
		local v24 = Keypoints[i + 1]

		if n3 <= v24.Time then
			local v25 = (n3 - v23.Time) / math.max(v24.Time - v23.Time, 1E-06)

			return v23.Value:Lerp(v24.Value, v25)
		end
	end

	return Keypoints[#Keypoints].Value
end

return function(p3) -- line: 111
	-- upvalues: Vide (copy), n1 (ref), RunService (copy), Frame (copy), evaluateNumberSequence (copy), evaluateColorSequence (copy), Gif (copy), ImageLabel (copy)
	local v27 = Vide.source({})
	local n4 = 0
	local Burst = p3.Burst
	local u30 = ((if type(Burst) ~= "function" then Burst else Burst())) or 0

	local function spawnParticle() -- line: 116
		-- upvalues: p3 (copy), n1 (ref)
		local p3Lifetime = p3.Lifetime
		local v34 = ((if type(p3Lifetime) ~= "function" then p3Lifetime else p3Lifetime())) or NumberRange.new(1, 2)
		local v35 = v34.Min + math.random() * (v34.Max - v34.Min)
		local p3Speed = p3.Speed
		local v37 = ((if type(p3Speed) ~= "function" then p3Speed else p3Speed())) or NumberRange.new(0, 0)
		local v38 = v37.Min + math.random() * (v37.Max - v37.Min)
		local p3Rotation = p3.Rotation
		local v40 = ((if type(p3Rotation) ~= "function" then p3Rotation else p3Rotation())) or NumberRange.new(0, 360)
		local v41 = v40.Min + math.random() * (v40.Max - v40.Min)
		local RotSpeed = p3.RotSpeed
		local v43 = ((if type(RotSpeed) ~= "function" then RotSpeed else RotSpeed())) or NumberRange.new(-60, 60)
		local v44 = v43.Min + math.random() * (v43.Max - v43.Min)
		local Direction = p3.Direction
		local v46 = ((if type(Direction) ~= "function" then Direction else Direction())) or Vector2.new(0, 1)
		local SpreadAngle = p3.SpreadAngle
		local v48 = ((if type(SpreadAngle) ~= "function" then SpreadAngle else SpreadAngle())) or Vector2.new(45, 0)
		local SpawnPositionMin = p3.SpawnPositionMin
		local v50 = ((if type(SpawnPositionMin) ~= "function" then SpawnPositionMin else SpawnPositionMin())) or Vector2.new(0, 0)
		local SpawnPositionMax = p3.SpawnPositionMax
		local v52 = ((if type(SpawnPositionMax) ~= "function" then SpawnPositionMax else SpawnPositionMax())) or Vector2.new(1, 1)
		local v53 = math.atan2(v46.Y, v46.X) + math.rad((math.random() - 0.5) * 2 * v48.X)
		local v54 = Vector2.new(math.cos(v53), (math.sin(v53))) * v38
		local v55 = v50.X + math.random() * (v52.X - v50.X)
		local v56 = v50.Y + math.random() * (v52.Y - v50.Y)

		n1 += 1

		return {
			age = 0,
			id = n1,
			lifetime = v35,
			position = Vector2.new(v55, v56),
			velocity = v54,
			rotation = v41,
			rotSpeed = v44
		}
	end
	local function emit(n5: number) -- line: 144
		-- upvalues: v27 (copy), spawnParticle (copy)
		if n5 <= 0 then
			return
		end

		local v58 = table.clone(v27())

		for _ = 1, n5 do
			table.insert(v58, (spawnParticle()))
		end

		v27(v58)
	end

	Vide.effect(function() -- line: 155
		-- upvalues: RunService (copy), p3 (copy), n4 (ref), emit (copy), u30 (ref), v27 (copy), Vide (copy)
		local connection = RunService.Heartbeat:Connect(function(dt) -- line: 156
			-- upvalues: p3 (copy), n4 (ref), emit (copy), u30 (ref), v27 (copy)
			local p3Enabled = p3.Enabled
			local v66

			if ((if type(p3Enabled) ~= "function" then p3Enabled else p3Enabled())) == nil then
				v66 = true
			else
				local p3Enabled2 = p3.Enabled

				v66 = if type(p3Enabled2) ~= "function" then p3Enabled2 else p3Enabled2()
			end

			if v66 then
				local v68 = n4
				local p3Rate = p3.Rate

				n4 = v68 + (((if type(p3Rate) ~= "function" then p3Rate else p3Rate())) or 0) * dt

				local v70 = math.floor(n4)

				if v70 > 0 then
					n4 -= v70
					emit(v70)
				end
			end

			local Burst2 = p3.Burst
			local v72 = ((if type(Burst2) ~= "function" then Burst2 else Burst2())) or 0

			if v72 < u30 then
				u30 = v72
			end

			if v72 > u30 then
				emit(v72 - u30)
			end

			u30 = v72

			local Acceleration = p3.Acceleration
			local v74 = ((if type(Acceleration) ~= "function" then Acceleration else Acceleration())) or Vector2.zero
			local Drag = p3.Drag
			local v76 = math.max(((if type(Drag) ~= "function" then Drag else Drag())) or 0, 0)
			local t1 = table.create(#v27())

			for _, v79 in v27() do
				local v80 = v79.age + dt

				if v80 < v79.lifetime then
					local v81 = math.clamp(1 - v76 * dt, 0, 1)
					local v82 = v79.velocity * v81 + v74 * dt

					table.insert(t1, {
						id = v79.id,
						age = v80,
						lifetime = v79.lifetime,
						position = v79.position + v82 * dt,
						velocity = v82,
						rotation = v79.rotation + v79.rotSpeed * dt,
						rotSpeed = v79.rotSpeed
					})
				end
			end

			v27(t1)
		end)

		Vide.cleanup(function() -- line: 198
			-- upvalues: connection (copy)
			connection:Disconnect()
		end)
	end)

	return Frame({
		Name = p3.UIName,
		BackgroundTransparency = if p3.UIBackgroundTransparency ~= nil then p3.UIBackgroundTransparency else 1,
		Size = if p3.UISize ~= nil then p3.UISize else UDim2.fromScale(1, 1),
		Position = p3.UIPosition,
		AnchorPoint = p3.UIAnchorPoint,
		BackgroundColor3 = p3.UIBackgroundColor3,
		ClipsDescendants = p3.UIClipsDescendants == nil or p3.UIClipsDescendants,
		LayoutOrder = p3.UILayoutOrder,
		ZIndex = p3.UIZIndex,
		Visible = p3.UIVisible,
		Rotation = p3.UIRotation,
		SizeConstraint = p3.UISizeConstraint,
		AutomaticSize = p3.UIAutomaticSize,
		Vide.indexes(v27, function(p4, n6: number) -- line: 218
			-- upvalues: Vide (copy), p3 (copy), evaluateNumberSequence (copy), evaluateColorSequence (copy), Gif (copy), ImageLabel (copy)
			local v63 = Vide.derive(function() -- line: 219
				-- upvalues: p4 (copy), p3 (copy), evaluateNumberSequence (copy), evaluateColorSequence (copy)
				local v83 = p4()
				local v84 = math.clamp(v83.age / v83.lifetime, 0, 1)
				local p3Size = p3.Size
				local v86 = ((if type(p3Size) ~= "function" then p3Size else p3Size())) or NumberSequence.new(0.06)
				local p3Transparency = p3.Transparency
				local v88 = ((if type(p3Transparency) ~= "function" then p3Transparency else p3Transparency())) or NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(1, 1)
				})
				local p3Color = p3.Color
				local v90 = ((if type(p3Color) ~= "function" then p3Color else p3Color())) or ColorSequence.new(Color3.fromRGB(255, 255, 255))

				return {
					position = v83.position,
					rotation = v83.rotation,
					alpha = v84,
					size = evaluateNumberSequence(v86, v84),
					transparency = evaluateNumberSequence(v88, v84),
					color = evaluateColorSequence(v90, v84),
					age = v83.age
				}
			end)

			if p3.Flipbook then
				return Gif({
					BackgroundTransparency = 1,
					Name = "Particle_" .. tostring(n6),
					Image = p3.Texture,
					AnchorPoint = Vector2.new(0.5, 0.5),
					SizeConstraint = Enum.SizeConstraint.RelativeYY,
					Size = function() --[[ Size ]] -- line: 247
						-- upvalues: v63 (copy)
						local v91 = v63()

						return UDim2.fromScale(v91.size, v91.size)
					end,
					Position = function() --[[ Position ]] -- line: 251
						-- upvalues: v63 (copy)
						local v92 = v63()

						return UDim2.fromScale(v92.position.X, v92.position.Y)
					end,
					Rotation = function() --[[ Rotation ]] -- line: 255
						-- upvalues: v63 (copy)
						return v63().rotation
					end,
					ImageTransparency = function() --[[ ImageTransparency ]] -- line: 258
						-- upvalues: v63 (copy)
						return v63().transparency
					end,
					ImageColor3 = function() --[[ ImageColor3 ]] -- line: 261
						-- upvalues: v63 (copy)
						return v63().color
					end,
					ZIndex = p3.UIZIndex,
					Time = function() --[[ Time ]] -- line: 265
						-- upvalues: v63 (copy)
						return v63().age
					end,
					FrameSize = p3.Flipbook.FrameSize,
					FramesPerRow = p3.Flipbook.FramesPerRow,
					TotalFrames = p3.Flipbook.TotalFrames,
					FPS = p3.Flipbook.FPS,
					StartFrame = p3.Flipbook.StartFrame,
					EndFrame = p3.Flipbook.EndFrame,
					Looped = p3.Flipbook.Looped ~= nil and p3.Flipbook.Looped
				})
			end

			return ImageLabel({
				BackgroundTransparency = 1,
				Name = "Particle_" .. tostring(n6),
				Image = p3.Texture,
				AnchorPoint = Vector2.new(0.5, 0.5),
				SizeConstraint = Enum.SizeConstraint.RelativeYY,
				Size = function() --[[ Size ]] -- line: 284
					-- upvalues: v63 (copy)
					local v93 = v63()

					return UDim2.fromScale(v93.size, v93.size)
				end,
				Position = function() --[[ Position ]] -- line: 288
					-- upvalues: v63 (copy)
					local v94 = v63()

					return UDim2.fromScale(v94.position.X, v94.position.Y)
				end,
				Rotation = function() --[[ Rotation ]] -- line: 292
					-- upvalues: v63 (copy)
					return v63().rotation
				end,
				ImageTransparency = function() --[[ ImageTransparency ]] -- line: 295
					-- upvalues: v63 (copy)
					return v63().transparency
				end,
				ImageColor3 = function() --[[ ImageColor3 ]] -- line: 298
					-- upvalues: v63 (copy)
					return v63().color
				end,
				ZIndex = p3.UIZIndex
			})
		end)
	})
end
