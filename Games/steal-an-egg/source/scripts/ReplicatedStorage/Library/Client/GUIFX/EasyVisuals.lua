-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Presets = script.Presets
local t = {
	Gradient = require(script.Gradient),
	Stroke = require(script.Stroke),
	Dropshadow = require(script.Dropshadow),
	Templates = require(script.GradientTemplates)
}

t.__index = t
t.CurrentEffects = {}

local t2 = {
	ScreenGui = "Enabled",
	BillboardGui = "Enabled",
	SurfaceGui = "Enabled"
}

local function ValidateIsPreset(p1) --[[ ValidateIsPreset | Line: 31 | Upvalues: Presets (copy) ]]
	return Presets:FindFirstChild(p1) ~= nil
end

function t.new(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ new | Line: 35 | Upvalues: Presets (copy), t (copy), t2 (copy) ]]
	assert(p1, "UIInstance not provided")
	assert(p2, "EffectType not provided")
	assert(p1:IsA("GuiObject") or p1:IsA("UIStroke"), "UIInstance is not a GuiObject")
	assert(if typeof(p2) == "string" then true else false, "effectType is not a string")
	assert(if Presets:FindFirstChild(p2) == nil then false else true, "effectType is not a valid preset")

	if p3 then
		assert(typeof(p3) == "number", "speed is not a number")
	end

	if p4 then
		assert(typeof(p4) == "number", "size is not a number")
	end

	if p6 then
		assert(if typeof(p6) == "ColorSequence" then true elseif typeof(p6) == "Color3" then true else false, "customColor is not a ColorSequence or Color3")
	end

	if p7 then
		assert(if typeof(p7) == "NumberSequence" then true elseif typeof(p7) == "number" then true else false, "customTransparency is not a NumberSequence or number")
	end

	local v9 = setmetatable({}, t)

	v9.IsPaused = false
	v9.Diagnostic = "DIAGNOSTIC VALUE"
	v9.UIInstance = p1
	v9.ResumesOnShown = if p8 == nil then true else p8
	v9.EffectObjects = {}
	v9.SavedObjects = {}
	v9.Connections = {}
	v9.Speed = p3 or 0.007
	v9.Size = p4 or 1

	local v11 = require(Presets:FindFirstChild(p2))(p1, v9.Speed, v9.Size, p6, p7, p9)

	assert(if typeof(v11) == "table" then true else false, "EffectType did not return a table")

	if p5 then
		for v13, v14 in p1:GetChildren() do
			if v14:IsA("UIStroke") or v14:IsA("UIGradient") then
				table.insert(v9.SavedObjects, v14)
				v14.Parent = nil
			end
		end
	end

	if v11.Connections then
		for v15, v16 in v11.Connections do
			table.insert(v9.Connections, v16)
		end
	end

	if v11.Effects then
		for v17, v18 in v11.Effects do
			table.insert(v9.EffectObjects, v18)
		end
	end

	v9.Connection = p1.AncestryChanged:Connect(function() --[[ Line: 109 | Upvalues: p1 (copy), v9 (copy) ]]
		if p1:IsDescendantOf(game) then
			return
		end

		v9:Destroy()
	end);
	(function(p1) --[[ TrackVisibility | Line: 115 | Upvalues: t2 (ref), v9 (copy) ]]
		if typeof(p1) == "Instance" and p1:IsA("GuiBase") then
			local t = {
				hiddenCount = 0,
				isPaused = false,
				connections = {}
			}

			local function getVisibilityProperty(p1) --[[ getVisibilityProperty | Line: 128 | Upvalues: t2 (ref) ]]
				return t2[p1.ClassName] or p1:IsA("GuiObject") and "Visible"
			end

			local function updateVisibility(p1) --[[ updateVisibility | Line: 133 | Upvalues: t (copy), v9 (ref) ]]
				local v1 = t

				v1.hiddenCount = v1.hiddenCount + p1

				if t.hiddenCount > 0 and not t.isPaused then
					t.isPaused = true
					v9:Pause()

					return
				end

				if t.hiddenCount ~= 0 or not t.isPaused then
					return
				end

				t.isPaused = false

				if not v9.ResumesOnShown then
					return
				end

				v9:Resume()
			end

			(function(p1) --[[ initializeTracking | Line: 148 | Upvalues: t2 (ref), t (copy), v9 (ref) ]]
				while p1 and p1:IsA("GuiBase") do
					local v1 = p1
					local v2 = t2[v1.ClassName] or v1:IsA("GuiObject") and "Visible"
					local v3 = p1

					if v2 then
						if not v3[v2] then
							local v4 = t

							v4.hiddenCount = v4.hiddenCount + 1

							if t.hiddenCount > 0 and not t.isPaused then
								t.isPaused = true
								v9:Pause()
							elseif t.hiddenCount == 0 and t.isPaused then
								t.isPaused = false

								if v9.ResumesOnShown then
									v9:Resume()
								end
							end
						end

						local connections = t.connections

						local function f6() --[[ Line: 162 | Upvalues: v3 (copy), v2 (copy), t (ref), v9 (ref) ]]
							local v22 = t

							v22.hiddenCount = v22.hiddenCount + (if v3[v2] then -1 else 1)

							if t.hiddenCount > 0 and not t.isPaused then
								t.isPaused = true
								v9:Pause()

								return
							end

							if t.hiddenCount ~= 0 or not t.isPaused then
								return
							end

							t.isPaused = false

							if not v9.ResumesOnShown then
								return
							end

							v9:Resume()
						end

						table.insert(connections, v3:GetPropertyChangedSignal(v2):Connect(f6))
					end

					p1 = v3.Parent
				end
			end)(p1)
			function t.Cleanup(p1) --[[ Cleanup | Line: 177 ]]
				for i, v in ipairs(p1.connections) do
					v:Disconnect()
				end

				p1.connections = {}
			end
			function t.Destroy(p1) --[[ Destroy | Line: 184 ]]
				p1:Cleanup()
				table.clear(p1)
			end

			local Connections = v9.Connections

			table.insert(Connections, t)

			return t
		end
	end)(p1)

	return v9
end
function t.Pause(p1) --[[ Pause | Line: 198 ]]
	for v1, v2 in p1.EffectObjects do
		if v2.Pause then
			v2:Pause()
		end
	end
end
function t.Resume(p1) --[[ Resume | Line: 207 ]]
	for v1, v2 in p1.EffectObjects do
		if v2.Resume then
			v2:Resume()
		end
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 216 ]]
	for v1, v2 in p1.SavedObjects do
		v2.Parent = p1.UIInstance
	end

	for v3, v4 in p1.Connections do
		if typeof(v4) == "table" and typeof(v4.Destroy) == "function" then
			v4:Destroy()

			continue
		end

		v4:Disconnect()
	end

	table.clear(p1.SavedObjects)
	table.clear(p1.Connections)

	for v5, v6 in p1.EffectObjects do
		if v6.Destroy then
			v6:Destroy()
		end
	end

	p1.Connection:Disconnect()
end

return table.freeze(t)