---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
if script:IsDescendantOf(workspace) then
	local v_u_1 = script.Parent
	local function v_u_3()
		-- upvalues: (copy) v_u_1, (copy) v_u_3
		v_u_1.Position = UDim2.new(0.5, 0, v_u_1.Position.Y.Scale, v_u_1.Position.Y.Offset)
		local v2 = game:GetService("TweenService"):Create(v_u_1, TweenInfo.new(3, Enum.EasingStyle.Linear), {
			["Position"] = UDim2.new(1, 0, v_u_1.Position.Y.Scale, v_u_1.Position.Y.Offset)
		})
		v2.Completed:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3()
		end)
		v2:Play()
	end
	v_u_3()
end
