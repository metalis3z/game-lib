-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")

function Flash(p1, p2, p3, p4, p5) --[[ Flash | Line: 4 | Upvalues: RunService (copy) ]]
	local v1 = p2 or 1
	local v2 = p3 or 0.5
	local v3 = if p4 then p4 else Color3.new(255/255, 255/255, 255/255)

	if not p1 then
		warn("Object is missing")

		return function() --[[ Line: 12 ]] end
	end

	local list = {}

	if p1:IsA("BasePart") and (not p5 or p5(p1)) then
		table.insert(list, p1)
	end

	local v4 = v3

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and (not p5 or p5(v)) then
			table.insert(list, v)
		end
	end

	local t = {
		Enum.NormalId.Back,
		Enum.NormalId.Front,
		Enum.NormalId.Left,
		Enum.NormalId.Right,
		Enum.NormalId.Top,
		Enum.NormalId.Bottom
	}
	local t2 = {}

	for i, v in ipairs(list) do
		for i2 = 1, 6 do
			local _SELECTIONFX = Instance.new("Decal")

			_SELECTIONFX.Texture = "rbxassetid://6381483576"
			_SELECTIONFX.Name = "_SELECTIONFX"
			_SELECTIONFX.Transparency = v2
			_SELECTIONFX.Color3 = v4
			_SELECTIONFX.Face = t[i2]
			_SELECTIONFX.Parent = v
			table.insert(t2, _SELECTIONFX)
		end
	end

	local v5 = nil

	local function cleanup() --[[ cleanup | Line: 53 | Upvalues: v5 (ref), t2 (copy) ]]
		if v5 then
			v5:Disconnect()
		end

		for i, v in ipairs(t2) do
			if v then
				v:Destroy()
			end
		end
	end

	local v6 = 0

	v5 = RunService.RenderStepped:Connect(function(p12) --[[ Line: 65 | Upvalues: p1 (copy), t2 (copy), v6 (ref), v1 (ref), v2 (ref), cleanup (copy) ]]
		if p1 and (p1.Parent and t2[1]) then
			v6 = math.clamp(v6 + p12, 0, v1)

			local v3 = v2 + (1 - v2) * (v6 / v1)

			for i, v in ipairs(t2) do
				if not v then
					cleanup()

					return
				end

				v.Transparency = v3
			end

			if v1 <= v6 then
				cleanup()
			end
		else
			cleanup()
		end
	end)

	return cleanup
end

return Flash