---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("RunService")
local v2 = script.Parent
for _, v_u_3 in ipairs(v2:GetDescendants()) do
	if v_u_3.Name == "Balloon" and v_u_3:IsA("BasePart") then
		task.spawn(function()
			-- upvalues: (copy) v_u_3, (copy) v_u_1
			local v4 = Random.new()
			local v5 = v_u_3.CFrame
			local v6 = v4:NextNumber(0.4, 0.8)
			local v7 = v4:NextNumber(2, 4)
			local v8 = v4:NextNumber(0.08726646259971647, 0.17453292519943295)
			local v9 = v4:NextNumber(0, 6.283185307179586)
			while v_u_3.Parent do
				local v10 = os.clock() * v6 + v9
				local v11 = math.sin(v10) * v7
				local v12 = math.sin(v10) * v8
				v_u_3.CFrame = v5 * CFrame.new(0, v11, 0) * CFrame.Angles(v12, 0, v12)
				v_u_1.Heartbeat:Wait()
			end
		end)
	end
end
