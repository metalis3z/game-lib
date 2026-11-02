-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GenerateUID = require(game.ReplicatedStorage.Library.Functions.GenerateUID)
local BindToRenderStep = require(game.ReplicatedStorage.Library.Functions.BindToRenderStep)

return function(p1, p2, p3, p4, p5) --[[ Line: 9 | Upvalues: GenerateUID (copy), BindToRenderStep (copy) ]]
	local v2 = p4 or UDim2.new()
	local v3 = p5 or 1
	local Scale = p1.Size.X.Scale
	local Scale2 = p1.Size.Y.Scale
	local v4 = (p2 or 1) / (Scale * Scale2)
	local v5 = GenerateUID()
	local v6 = false
	local v7 = tick()
	local v8 = 1
	local sum = Scale * Scale2

	if p3 then
		sum = sum - p3
	end

	local v9 = nil

	local function CleanupAnimation() --[[ CleanupAnimation | Line: 34 | Upvalues: v6 (ref), v9 (ref) ]]
		if v6 then
			return
		end

		v6 = true

		if not v9 then
			return
		end

		v9()
		v9 = nil
	end

	v9 = BindToRenderStep(v5, 1, function() --[[ Line: 45 | Upvalues: v7 (ref), v4 (copy), v8 (ref), sum (ref), Scale (copy), v3 (copy), p1 (copy), v2 (copy) ]]
		local v1 = tick()

		if not (v4 < v1 - v7) then
			return
		end

		v8 = if v8 < sum then v8 + 1 else 1
		v7 = v1
		p1.Position = UDim2.new(-((v8 - 1) % Scale * v3), 0, -(math.floor((v8 - 1) / Scale) * v3), 0) + v2
	end)
	p1.AncestryChanged:Connect(function() --[[ Line: 58 | Upvalues: p1 (copy), v6 (ref), v9 (ref) ]]
		if p1.Parent then
			return
		end

		if v6 then
			return
		end

		v6 = true

		if not v9 then
			return
		end

		v9()
		v9 = nil
	end)

	return CleanupAnimation
end