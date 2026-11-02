-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent

v1:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 2 | Upvalues: v1 (copy) ]]
	v1.Text = v1.Text:gsub("%D+", "")
end)