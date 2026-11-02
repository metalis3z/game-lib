-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ConfettiSequence, time of decompilation: Sun May  3 10:11:05 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local vector2 = Vector2.new(0, 0.28)
local vector2_2 = Vector2.new(0, 1.128)
local t1 = {
	Color3.fromRGB(255, 99, 99),
	Color3.fromRGB(255, 210, 82),
	Color3.fromRGB(112, 255, 153),
	Color3.fromRGB(86, 201, 255),
	Color3.fromRGB(212, 123, 255),
	Color3.fromRGB(255, 145, 211)
}
local n1 = 0

return function(t2: {[any]: any}) -- line: 44
	-- upvalues: Vide (copy), vector2_2 (copy), vector2 (copy), n1 (ref), t1 (copy), RunService (copy), Frame (copy), UICorner (copy)
	local v11 = Vide.source({})
	local n2 = 0
	local u13 = t2.Trigger()
	local v14 = t2.ZIndex or 1
	local v15 = t2.Preset or "celebration"
	local v16 = if v15 ~= "sideCannons" then vector2 else vector2_2

	local function createConfettiPiece(n3: number, n4: number, n5: number, n6: number, vector2_3: Vector2, vector2_4: Vector2) -- line: 52
		-- upvalues: n1 (ref), t1 (copy)
		n1 += 1

		return {
			age = 0,
			id = n1,
			lifetime = 3.1 + math.random() * 1.5,
			position = Vector2.new(n3 + math.random() * (n4 - n3), n5 + math.random() * (n6 - n5)),
			velocity = Vector2.new(vector2_3.X + math.random() * (vector2_4.X - vector2_3.X), vector2_3.Y + math.random() * (vector2_4.Y - vector2_3.Y)),
			rotation = math.random() * 360,
			rotSpeed = -240 + math.random() * 480,
			size = Vector2.new(14 + math.random() * 18, 9 + math.random() * 14),
			color = t1[math.random(1, #t1)],
			swayPhase = math.random() * 3.141592653589793 * 2,
			swaySpeed = 3 + math.random() * 2.5,
			swayAmplitude = 0.025 + math.random() * 0.035
		}
	end
	local function emitConfetti(n7: number, n8: number, n9: number, n10: number) -- line: 81
		-- upvalues: v11 (copy), createConfettiPiece (copy)
		local v33 = table.clone(v11())

		for _ = 1, n7 do
			table.insert(v33, (createConfettiPiece(n8, n9, -0.2, -0.12, Vector2.new(-0.06, n10 + 0.08), Vector2.new(0.06, n10 + 0.2))))
		end

		v11(v33)
	end
	local function emitSideConfetti(n11: number, n12: number, n13: number, n14: number, n15: number, n16: number, n17: number, n18: number, n19: number) -- line: 99
		-- upvalues: v11 (copy), createConfettiPiece (copy)
		if n11 <= 0 then
			return
		end

		local v44 = table.clone(v11())

		for _ = 1, n11 do
			table.insert(v44, (createConfettiPiece(n12, n13, n14, n15, Vector2.new(n16, n18), Vector2.new(n17, n19))))
		end

		v11(v44)
	end
	local function playCelebrationSequence() -- line: 131
		-- upvalues: n2 (ref), emitConfetti (copy)
		n2 += 1

		local v46 = n2

		task.spawn(function() -- line: 135
			-- upvalues: emitConfetti (copy), n2 (ref), v46 (copy)
			local n20 = 0

			for _, v62 in {
				{
					delay = 0,
					apply = function() --[[ apply ]] -- line: 137
						-- upvalues: emitConfetti (copy)
						emitConfetti(16, 0.08, 0.92, 0.12)
					end
				},
				{
					delay = 0.12,
					apply = function() --[[ apply ]] -- line: 140
						-- upvalues: emitConfetti (copy)
						emitConfetti(12, 0.18, 0.82, 0.1)
					end
				},
				{
					delay = 0.24,
					apply = function() --[[ apply ]] -- line: 143
						-- upvalues: emitConfetti (copy)
						emitConfetti(10, 0.02, 0.28, 0.14)
					end
				},
				{
					delay = 0.38,
					apply = function() --[[ apply ]] -- line: 146
						-- upvalues: emitConfetti (copy)
						emitConfetti(10, 0.72, 0.98, 0.14)
					end
				},
				{
					delay = 0.54,
					apply = function() --[[ apply ]] -- line: 149
						-- upvalues: emitConfetti (copy)
						emitConfetti(12, 0.12, 0.88, 0.1)
					end
				},
				{
					delay = 0.72,
					apply = function() --[[ apply ]] -- line: 152
						-- upvalues: emitConfetti (copy)
						emitConfetti(8, 0.04, 0.34, 0.12)
						emitConfetti(8, 0.66, 0.96, 0.12)
					end
				},
				{
					delay = 0.92,
					apply = function() --[[ apply ]] -- line: 156
						-- upvalues: emitConfetti (copy)
						emitConfetti(10, 0.2, 0.8, 0.08)
					end
				},
				{
					delay = 1.18,
					apply = function() --[[ apply ]] -- line: 159
						-- upvalues: emitConfetti (copy)
						emitConfetti(6, 0.1, 0.3, 0.1)
						emitConfetti(6, 0.7, 0.9, 0.1)
					end
				},
				{
					delay = 1.46,
					apply = function() --[[ apply ]] -- line: 163
						-- upvalues: emitConfetti (copy)
						emitConfetti(8, 0.24, 0.76, 0.06)
					end
				}
			} do
				task.wait(v62.delay - n20)
				n20 = v62.delay

				if n2 ~= v46 then
					return
				end

				v62.apply()
			end
		end)
	end
	local function playSideCannonsSequence() -- line: 180
		-- upvalues: n2 (ref), emitSideConfetti (copy)
		n2 += 1

		local v47 = n2

		task.spawn(function() -- line: 184
			-- upvalues: emitSideConfetti (copy), n2 (ref), v47 (copy)
			local n21 = 0

			for _, v65 in {
				{
					delay = 0,
					apply = function() --[[ apply ]] -- line: 186
						-- upvalues: emitSideConfetti (copy)
						emitSideConfetti(14, -0.04, 0.03, 0.84, 0.96, 0.33, 0.51, -1.59, -1.23)
						emitSideConfetti(14, 0.97, 1.04, 0.84, 0.96, -0.51, -0.33, -1.59, -1.23)
					end
				},
				{
					delay = 0.08,
					apply = function() --[[ apply ]] -- line: 190
						-- upvalues: emitSideConfetti (copy)
						emitSideConfetti(12, -0.04, 0.04, 0.82, 0.96, 0.3, 0.48, -1.5, -1.17)
						emitSideConfetti(12, 0.96, 1.04, 0.82, 0.96, -0.48, -0.3, -1.5, -1.17)
					end
				},
				{
					delay = 0.16,
					apply = function() --[[ apply ]] -- line: 194
						-- upvalues: emitSideConfetti (copy)
						emitSideConfetti(12, -0.03, 0.05, 0.8, 0.95, 0.27, 0.45, -1.44, -1.11)
						emitSideConfetti(12, 0.95, 1.03, 0.8, 0.95, -0.45, -0.27, -1.44, -1.11)
					end
				},
				{
					delay = 0.24,
					apply = function() --[[ apply ]] -- line: 198
						-- upvalues: emitSideConfetti (copy)
						emitSideConfetti(10, -0.02, 0.05, 0.78, 0.94, 0.24, 0.42, -1.35, -1.05)
						emitSideConfetti(10, 0.95, 1.02, 0.78, 0.94, -0.42, -0.24, -1.35, -1.05)
					end
				},
				{
					delay = 0.34,
					apply = function() --[[ apply ]] -- line: 202
						-- upvalues: emitSideConfetti (copy)
						emitSideConfetti(10, -0.01, 0.05, 0.78, 0.92, 0.21, 0.36, -1.23, -0.96)
						emitSideConfetti(10, 0.95, 1.01, 0.78, 0.92, -0.36, -0.21, -1.23, -0.96)
					end
				},
				{
					delay = 0.46,
					apply = function() --[[ apply ]] -- line: 206
						-- upvalues: emitSideConfetti (copy)
						emitSideConfetti(8, 0, 0.05, 0.76, 0.9, 0.18, 0.3, -1.11, -0.84)
						emitSideConfetti(8, 0.95, 1, 0.76, 0.9, -0.3, -0.18, -1.11, -0.84)
					end
				}
			} do
				task.wait(v65.delay - n21)
				n21 = v65.delay

				if n2 ~= v47 then
					return
				end

				v65.apply()
			end
		end)
	end

	Vide.effect(function() -- line: 224
		-- upvalues: t2 (copy), u13 (ref), v15 (copy), playSideCannonsSequence (copy), playCelebrationSequence (copy)
		local v48 = t2.Trigger()

		if v48 == u13 then
			return
		end

		u13 = v48
		task.defer(if v15 ~= "sideCannons" then playCelebrationSequence else playSideCannonsSequence)
	end)

	local connection = RunService.Heartbeat:Connect(function(dt: number) -- line: 234
		-- upvalues: v11 (copy), v16 (copy)
		local v50 = v11()

		if #v50 == 0 then
			return
		end

		local t3 = table.create(#v50)

		for _, v53 in v50 do
			local v54 = v53.age + dt

			if v54 < v53.lifetime then
				local v55 = math.sin(v54 * v53.swaySpeed + v53.swayPhase) * v53.swayAmplitude
				local v56 = v53.velocity + v16 * dt

				table.insert(t3, {
					id = v53.id,
					age = v54,
					lifetime = v53.lifetime,
					position = v53.position + Vector2.new(v56.X + v55, v56.Y) * dt,
					velocity = v56,
					rotation = v53.rotation + v53.rotSpeed * dt,
					rotSpeed = v53.rotSpeed,
					size = v53.size,
					color = v53.color,
					swayPhase = v53.swayPhase,
					swaySpeed = v53.swaySpeed,
					swayAmplitude = v53.swayAmplitude
				})
			end
		end

		v11(t3)
	end)

	Vide.cleanup(function() -- line: 266
		-- upvalues: connection (copy), n2 (ref), v11 (copy)
		connection:Disconnect()
		n2 += 1
		v11({})
	end)

	return Frame({
		Name = t2.Name or "ConfettiSequence",
		Size = UDim2.fromScale(1, 1),
		ClipsDescendants = true,
		BackgroundTransparency = 1,
		ZIndex = v14,
		Visible = t2.Visible == nil or t2.Visible,
		Vide.indexes(v11, function(p1, n22: number) -- line: 280
			-- upvalues: Vide (copy), Frame (copy), v14 (copy), UICorner (copy)
			local v59 = Vide.derive(function() -- line: 281
				-- upvalues: p1 (copy)
				local v66 = p1()
				local v67 = math.clamp(v66.age / v66.lifetime, 0, 1)

				return {
					position = v66.position,
					rotation = v66.rotation,
					size = v66.size,
					color = v66.color,
					transparency = if not (v67 < 0.8) then (v67 - 0.8) / 0.2 else 0
				}
			end)

			return Frame({
				Name = "Confetti_" .. tostring(n22),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = function() --[[ Position ]] -- line: 296
					-- upvalues: v59 (copy)
					local v68 = v59()

					return UDim2.fromScale(v68.position.X, v68.position.Y)
				end,
				Size = function() --[[ Size ]] -- line: 300
					-- upvalues: v59 (copy)
					local v69 = v59()

					return UDim2.fromOffset(v69.size.X, v69.size.Y)
				end,
				Rotation = function() --[[ Rotation ]] -- line: 304
					-- upvalues: v59 (copy)
					return v59().rotation
				end,
				BackgroundColor3 = function() --[[ BackgroundColor3 ]] -- line: 307
					-- upvalues: v59 (copy)
					return v59().color
				end,
				BackgroundTransparency = function() --[[ BackgroundTransparency ]] -- line: 310
					-- upvalues: v59 (copy)
					return v59().transparency
				end,
				ZIndex = v14,
				UICorner({
					CornerRadius = UDim.new(0, 2)
				})
			})
		end)
	})
end
