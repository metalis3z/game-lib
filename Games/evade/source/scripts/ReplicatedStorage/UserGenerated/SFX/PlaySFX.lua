---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
return function(p1, p2, p3)
	local v_u_4 = Instance.new("Attachment")
	v_u_4.CFrame = p1.CFrame:ToObjectSpace(p2)
	p3.Parent = v_u_4
	v_u_4.Parent = p1
	p3.Ended:Connect(function()
		-- upvalues: (copy) v_u_4
		v_u_4:Destroy()
	end)
	p3:Play()
end
