-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local t = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(255, 127, 0),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 255, 255),
	Color3.fromRGB(0, 0, 255),
	Color3.fromRGB(255, 0, 255)
}

return function(p1, p2, p3) --[[ Line: 15 | Upvalues: t (copy), RunService (copy) ]]
	local v1 = p2 or 3
	local v3 = p3 or t

	assert(v1, "luau")

	local v4 = v3

	assert(v4, "luau")

	local v5 = true
	local v6 = #v3
	local v7 = 1 / v6

	task.spawn(function() --[[ Line: 26 | Upvalues: RunService (ref), p1 (copy), v5 (ref), v1 (ref), v6 (copy), v3 (ref), v7 (copy) ]]
		local v12 = nil

		v12 = RunService.Heartbeat:Connect(function() --[[ Line: 28 | Upvalues: p1 (ref), v5 (ref), v1 (ref), v6 (ref), v3 (ref), v7 (ref), v12 (ref) ]]
			if not (p1 and (p1.Parent and v5)) then
				v12:Disconnect()

				return
			end

			local v13 = tick() % v1 / v1
			local t = {}
			local v2 = false

			for i = 1, v6 + 1 do
				local count = v13 + (i - 1) / v6

				if count > 1 then
					count = count - 1
				end

				if count == 0 or count == 1 then
					v2 = true
				end

				table.insert(t, ColorSequenceKeypoint.new(count, v3[i] or v3[i - v6]))
			end

			if not v2 then
				local v52 = (1 - v13) / v7 + 1
				local v62 = math.floor(v52)
				local v72 = math.ceil(v52)
				local v122 = v3[math.clamp(v62, 1, v6)]:Lerp(v3[math.clamp(v72, 1, v6)] or v3[1], v52 % 1)

				table.insert(t, ColorSequenceKeypoint.new(0, v122))
				table.insert(t, ColorSequenceKeypoint.new(1, v122))
			end

			table.sort(t, function(p1, p2) --[[ Line: 58 ]]
				return p1.Time < p2.Time
			end)
			p1.Color = ColorSequence.new(t)
		end)
	end)

	return function() --[[ Line: 68 | Upvalues: v5 (ref) ]]
		v5 = false
	end
end