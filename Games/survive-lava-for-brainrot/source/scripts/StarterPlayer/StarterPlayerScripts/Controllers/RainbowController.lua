-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {}
game:GetService("TweenService")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = {}
function v1.Init(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	for _, v4 in v_u_2:GetTagged("Rainbow") do
		local v5 = v_u_3
		table.insert(v5, v4)
	end
	v_u_2:GetInstanceAddedSignal("Rainbow"):Connect(function(p6)
		-- upvalues: (ref) v_u_3
		local v7 = v_u_3
		table.insert(v7, p6)
	end)
	v_u_2:GetInstanceRemovedSignal("Rainbow"):Connect(function(p8)
		-- upvalues: (ref) v_u_3
		table.remove(v_u_3, table.find(v_u_3, p8))
	end)
	local v_u_9 = Instance.new("NumberValue")
	v_u_9.Changed:Connect(function()
		-- upvalues: (ref) v_u_3, (copy) v_u_9
		for _, v10 in v_u_3 do
			if not v10:GetFullName():find("ReplicatedStorage") then
				if v10:IsA("BasePart") then
					v10.Color = Color3.fromHSV(v_u_9.Value, 1, 1)
				elseif v10:IsA("ImageButton") then
					v10.ImageColor3 = Color3.fromHSV(v_u_9.Value, 1, 1)
				else
					v10.TextColor3 = Color3.fromHSV(v_u_9.Value, 1, 1)
				end
			end
		end
	end)
	task.spawn(function()
		-- upvalues: (copy) v_u_9
		while true do
			for v11 = 0, 50 do
				v_u_9.Value = v11 / 50
				task.wait(0.15)
			end
		end
	end)
end
return v1
