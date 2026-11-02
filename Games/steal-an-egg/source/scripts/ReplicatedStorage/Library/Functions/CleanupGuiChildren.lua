-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end
end