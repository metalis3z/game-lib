-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Assets_0 = script.Parent.Parent.Parent.Assets;
local l_Tabs_0 = l_Assets_0.Tabs;
local v3 = require(l_Assets_0.Utility);
script.Parent.Parent.Parent.Main.Segments.FireButton.MouseButton1Click:Connect(function() --[[ Line: 6 ]]
    -- upvalues: v3 (copy), l_Tabs_0 (copy)
    local l_SelectedModule_0 = v3.SelectedModule;
    local v5 = require(l_Tabs_0:FindFirstChild(l_SelectedModule_0));
    if v5.Fire then
        v5.Fire();
    end;
end);
return v0;