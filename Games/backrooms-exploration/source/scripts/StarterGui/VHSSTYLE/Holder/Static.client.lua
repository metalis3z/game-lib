-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with x2125.xyz
local v_1 = {
	script.Parent.Static1,
	script.Parent.Static2,
	script.Parent.Static3,
	script.Parent.Static4
}
for index, entry in ipairs(v_1) do
	task.spawn(function() --[[ Line: 4 ]]
		--[[
		Upvalues:
			[1] = index
			[2] = entry
		--]]
		task.wait(index * 0.01)
		while true do
			entry.Rotation = math.random(0, 1) * 180
			task.wait(math.random() * 0.03 + 0.02)
		end
	end)
end