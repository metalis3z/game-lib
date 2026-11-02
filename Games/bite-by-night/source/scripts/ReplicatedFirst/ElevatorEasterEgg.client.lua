-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("SoundService")
local v_u_2 = game:GetService("Players")
local v_u_3 = workspace:WaitForChild("Lobby"):WaitForChild("Elevator"):WaitForChild("Elevator Structure"):WaitForChild("Elevator Walls")
repeat
	task.wait(0.5)
until #v_u_3:GetChildren() >= 13
local v_u_4 = {}
local v5 = v_u_2.LocalPlayer:GetAttributeChangedSignal("LOADED")
table.insert(v_u_4, v5:Connect(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
	if v_u_2.LocalPlayer:GetAttribute("LOADED") then
		for _, v6 in v_u_4 do
			if v6.Connected then
				v6:Disconnect()
			end
		end
		for _, v7 in v_u_3:QueryDescendants("ClickDetector") do
			v7.Parent:Destroy()
		end
	end
end))
local v_u_8 = {}
for _, v9 in v_u_3:QueryDescendants("ClickDetector") do
	local v_u_10 = v9.Parent
	local v11 = v9.MouseClick
	table.insert(v_u_4, v11:Connect(function()
		-- upvalues: (copy) v_u_1, (copy) v_u_10, (copy) v_u_8
		v_u_1:PlayLocalSound(script.Click)
		v_u_10.Transparency = 0.7
		if v_u_8[v_u_10] then
			task.cancel(v_u_8[v_u_10])
			v_u_8[v_u_10] = nil
		end
		v_u_8[v_u_10] = task.delay(0.2, function()
			-- upvalues: (ref) v_u_10
			v_u_10.Transparency = 1
		end)
	end))
end