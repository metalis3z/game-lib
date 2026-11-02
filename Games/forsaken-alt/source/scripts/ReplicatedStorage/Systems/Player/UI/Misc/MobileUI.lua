-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
return {
    UI = nil, 
    GetComponent = function(v2, v3) --[[ Line: 8 ]] --[[ Name: GetComponent ]]
        local l_FirstChild_0 = v2.UI:FindFirstChild(v3);
        if l_FirstChild_0 then
            return l_FirstChild_0;
        else
            error((("%* does not exist in MobileUI"):format(v3)));
            return;
        end;
    end, 
    Start = function(v5) --[[ Line: 18 ]] --[[ Name: Start ]]
        -- upvalues: l_Players_0 (copy)
        local l_MainUI_0 = l_Players_0.LocalPlayer.PlayerGui:WaitForChild("MainUI");
        local v7 = script.MobileUI:Clone();
        v7.Parent = l_MainUI_0;
        v5.UI = v7;
    end
};