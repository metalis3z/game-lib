-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local Lighting = game:GetService("Lighting")
local t = {
	"Ambient",
	"OutdoorAmbient",
	"Brightness",
	"ExposureCompensation",
	"EnvironmentDiffuseScale",
	"EnvironmentSpecularScale",
	"GlobalShadows",
	"FogColor",
	"FogStart",
	"FogEnd"
}
local t2 = {}
local t3 = {}
for v1, v2 in t do
	t2[v2] = {}
end
local t4 = {}
local t5 = {}
local t6 = {}
local t7 = {}
local v3 = false
local t8 = {}
local t9 = {}
local function ensureCaptured(p1)
	if t5[p1] then
		return
	end
	t4[p1] = Lighting[p1]
	t5[p1] = true
end
local function setLightingProp(p1, p2)
	local v1 = Lighting
	if v1[p1] ~= p2 then
		t9[p1] = true
		v1[p1] = p2
		t9[p1] = false
	end
end
local function applyTop(p1)
	if v3 then
		if not t5[p1] then
			return
		end
		local v1 = t4[p1]
		local v2 = Lighting
		if v2[p1] == v1 then
			return
		end
		t9[p1] = true
		v2[p1] = v1
		t9[p1] = false
	else
		local v32 = t2[p1]
		local v4 = v32[#v32]
		if v4 then
			local value = v4.value
			local v5 = Lighting
			if v5[p1] ~= value then
				t9[p1] = true
				v5[p1] = value
				t9[p1] = false
			end
		else
			if not t5[p1] then
				return
			end
			local v6 = t4[p1]
			local v7 = Lighting
			if v7[p1] ~= v6 then
				t9[p1] = true
				v7[p1] = v6
				t9[p1] = false
			end
			t4[p1] = nil
			t5[p1] = false
		end
	end
end
local function attachDriftConn(p1)
	if not t8[p1] then
		t8[p1] = Lighting:GetPropertyChangedSignal(p1):Connect(function()
			if t9[p1] then
				return
			end
			if v3 then
				return
			end
			local v1 = t2[p1]
			local v2 = v1[#v1]
			if not v2 then
				return
			end
			local v32_2 = Lighting
			if v32_2[p1] == v2.value then
				return
			end
			t9[p1] = true
			v32_2[p1] = v2.value
			t9[p1] = false
		end)
	end
end
local function detachDriftConn(p1)
	local v1 = t8[p1]
	if v1 then
		v1:Disconnect()
		t8[p1] = nil
	end
end
local function insertSorted(p1, p2)
	for i = #p1, 1, -1 do
		if p1[i].priority <= p2.priority then
			table.insert(p1, i + 1, p2)
			return
		end
	end
	table.insert(p1, 1, p2)
end
function t3.Push(p1, p2, p3)
	local v1 = p3.Priority or 0
	local t3 = {}
	for v2, v32 in t do
		local v4 = p3[v32]
		if v4 ~= nil then
			if not t5[v32] then
				t4[v32] = Lighting[v32]
				t5[v32] = true
			end
			local t10 = {
				context = p2,
				value = v4,
				priority = v1
			}
			insertSorted(t2[v32], t10)
			table.insert(t3, {
				prop = v32,
				entry = t10
			})
			t6[v32] = true
			if not t8[v32] then
				t8[v32] = Lighting:GetPropertyChangedSignal(v32):Connect(function()
					if t9[v32] then
						return
					end
					if v3 then
						return
					end
					local v1 = t2[v32]
					local v2 = v1[#v1]
					if not v2 then
						return
					end
					local v32_2 = Lighting
					if v32_2[v32] == v2.value then
						return
					end
					t9[v32] = true
					v32_2[v32] = v2.value
					t9[v32] = false
				end)
			end
			if v3 then
				if t5[v32] then
					local v5 = t4[v32]
					local v6 = Lighting
					if v6[v32] ~= v5 then
						t9[v32] = true
						v6[v32] = v5
						t9[v32] = false
					end
				end
				continue
			end
			local v7 = t2[v32]
			local v8 = v7[#v7]
			if v8 then
				local value = v8.value
				local v9 = Lighting
				if v9[v32] ~= value then
					t9[v32] = true
					v9[v32] = value
					t9[v32] = false
				end
				continue
			end
			if t5[v32] then
				local v10 = t4[v32]
				local v11 = Lighting
				if v11[v32] ~= v10 then
					t9[v32] = true
					v11[v32] = v10
					t9[v32] = false
				end
				t4[v32] = nil
				t5[v32] = false
			end
		end
	end
	local v12
	if p3.ColorCorrection then
		local ColorCorrection = p3.ColorCorrection
		local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
		ColorCorrectionEffect.Name = ("LightingController_%*"):format(p2)
		if ColorCorrection.TintColor ~= nil then
			ColorCorrectionEffect.TintColor = ColorCorrection.TintColor
		end
		if ColorCorrection.Brightness ~= nil then
			ColorCorrectionEffect.Brightness = ColorCorrection.Brightness
		end
		if ColorCorrection.Saturation ~= nil then
			ColorCorrectionEffect.Saturation = ColorCorrection.Saturation
		end
		if ColorCorrection.Contrast ~= nil then
			ColorCorrectionEffect.Contrast = ColorCorrection.Contrast
		end
		if v3 then
			ColorCorrectionEffect.Enabled = false
		end
		ColorCorrectionEffect.Parent = workspace.CurrentCamera or Lighting
		t7[ColorCorrectionEffect] = true
		v12 = ColorCorrectionEffect
	else
		v12 = nil
	end
	local v14 = false
	return function()
		if v14 then
			return
		end
		v14 = true
		for v1, v2 in t3 do
			local v32 = t2[v2.prop]
			local v4 = table.find(v32, v2.entry)
			if v4 then
				table.remove(v32, v4)
			end
			if #v32 == 0 then
				t6[v2.prop] = nil
				local prop = v2.prop
				local v5 = t8[prop]
				if v5 then
					v5:Disconnect()
					t8[prop] = nil
				end
			end
			local prop = v2.prop
			if v3 then
				if t5[prop] then
					local v6 = t4[prop]
					local v7 = Lighting
					if v7[prop] ~= v6 then
						t9[prop] = true
						v7[prop] = v6
						t9[prop] = false
					end
				end
				continue
			end
			local v8 = t2[prop]
			local v9 = v8[#v8]
			if v9 then
				local value = v9.value
				local v10 = Lighting
				if v10[prop] ~= value then
					t9[prop] = true
					v10[prop] = value
					t9[prop] = false
				end
				continue
			end
			if t5[prop] then
				local v11 = t4[prop]
				local v122 = Lighting
				if v122[prop] ~= v11 then
					t9[prop] = true
					v122[prop] = v11
					t9[prop] = false
				end
				t4[prop] = nil
				t5[prop] = false
			end
		end
		if not v12 then
			return
		end
		t7[v12] = nil
		v12:Destroy()
	end
end
function t3.SetSuspended(p1, p2)
	if v3 == p2 then
		return
	end
	v3 = p2
	if p2 then
		for v1 in t6 do
			if t5[v1] then
				local v2 = t4[v1]
				local v32 = Lighting
				if v32[v1] ~= v2 then
					t9[v1] = true
					v32[v1] = v2
					t9[v1] = false
				end
			end
		end
		for v4 in t7 do
			v4.Enabled = false
		end
	else
		for v5 in t6 do
			if p2 then
				if t5[v5] then
					local v6 = t4[v5]
					local v7 = Lighting
					if v7[v5] ~= v6 then
						t9[v5] = true
						v7[v5] = v6
						t9[v5] = false
					end
				end
				continue
			end
			local v8 = t2[v5]
			local v9 = v8[#v8]
			if v9 then
				local value = v9.value
				local v10 = Lighting
				if v10[v5] ~= value then
					t9[v5] = true
					v10[v5] = value
					t9[v5] = false
				end
				continue
			end
			if t5[v5] then
				local v11 = t4[v5]
				local v12 = Lighting
				if v12[v5] ~= v11 then
					t9[v5] = true
					v12[v5] = v11
					t9[v5] = false
				end
				t4[v5] = nil
				t5[v5] = false
			end
		end
		for v13 in t7 do
			v13.Enabled = true
		end
	end
end
function t3.IsSuspended(p1)
	return v3
end
return t3