-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("TweenService")
local v2 = script.Parent
local v_u_3 = { Color3.fromRGB(255, 174, 93), Color3.fromRGB(255, 81, 0) }
local v_u_4 = Color3.new(0, 0, 0)
local v_u_5 = {
	["Light1"] = {},
	["Light2"] = {}
}
for _, v6 in ipairs(v2:GetDescendants()) do
	if v6.Name == "Light1" or v6.Name == "Light2" then
		local v7 = v_u_5[v6.Name]
		table.insert(v7, v6)
	end
end
local function v_u_11(p8, p9, p10)
	-- upvalues: (copy) v_u_1
	return v_u_1:Create(p8, TweenInfo.new(p9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Color"] = p10
	})
end
local function v_u_17(p12, p13, p14)
	-- upvalues: (copy) v_u_11
	for _, v15 in ipairs(p12) do
		local v16 = v_u_11(v15, p14, p13)
		if v16 then
			v16:Play()
		end
	end
end
local function v18()
	-- upvalues: (copy) v_u_17, (copy) v_u_5, (copy) v_u_3, (copy) v_u_4
	v_u_17(v_u_5.Light1, v_u_3[1], 0.1)
	v_u_17(v_u_5.Light2, v_u_4, 0.04)
	task.wait(0.16)
	v_u_17(v_u_5.Light1, v_u_4, 0.04)
	v_u_17(v_u_5.Light2, v_u_3[2], 0.1)
	task.wait(0.16)
	v_u_17(v_u_5.Light1, v_u_3[2], 0.1)
	v_u_17(v_u_5.Light2, v_u_3[1], 0.1)
	task.wait(0.16)
	v_u_17(v_u_5.Light1, v_u_4, 0.04)
	v_u_17(v_u_5.Light2, v_u_4, 0.04)
	task.wait(0.096)
end
local function v19()
	-- upvalues: (copy) v_u_17, (copy) v_u_5, (copy) v_u_3, (copy) v_u_4
	v_u_17(v_u_5.Light1, v_u_3[1], 0.35)
	v_u_17(v_u_5.Light2, v_u_4, 0.1)
	task.wait(0.5)
	v_u_17(v_u_5.Light2, v_u_3[1], 0.35)
	v_u_17(v_u_5.Light1, v_u_4, 0.1)
	task.wait(0.5)
	v_u_17(v_u_5.Light1, v_u_3[2], 0.35)
	v_u_17(v_u_5.Light2, v_u_4, 0.1)
	task.wait(0.5)
	v_u_17(v_u_5.Light2, v_u_3[2], 0.35)
	v_u_17(v_u_5.Light1, v_u_4, 0.1)
	task.wait(0.5)
	v_u_17(v_u_5.Light1, v_u_4, 0.12)
	v_u_17(v_u_5.Light2, v_u_4, 0.12)
	task.wait(0.3)
end
while true do
	v18()
	v18()
	v19()
end
