-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LocalScript, time of decompilation: Fri Feb 13 19:21:22 2026 ]]
local l_Parent_0 = script.Parent;
l_Parent_0:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 3 ]]
    -- upvalues: l_Parent_0 (copy)
    l_Parent_0.TextScaled = false;
    if not l_Parent_0.TextFits then
        l_Parent_0.TextScaled = true;
    end;
end);