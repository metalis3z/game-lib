-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent
local Text = v1.Text

v1.Focused:Connect(function() --[[ Line: 5 | Upvalues: Text (ref), v1 (copy) ]]
	Text = v1.Text
end)
v1:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 9 | Upvalues: v1 (copy), Text (ref) ]]
	if v1.Text == Text then
		return
	end

	v1.Text = Text
end)