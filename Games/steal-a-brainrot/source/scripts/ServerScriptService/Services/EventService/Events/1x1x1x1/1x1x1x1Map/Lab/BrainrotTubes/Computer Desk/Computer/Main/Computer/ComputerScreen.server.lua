-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent;
local l_Spin_0 = l_Parent_0:WaitForChild("Spin");
local l_Text_0 = l_Parent_0:WaitForChild("Text");
task.spawn(function() --[[ Line: 8 ]]
    -- upvalues: l_Spin_0 (copy)
    while true do
        l_Spin_0.Rotation = (l_Spin_0.Rotation + 180 * task.wait()) % 360;
    end;
end);
task.spawn(function() --[[ Line: 14 ]]
    -- upvalues: l_Text_0 (copy)
    local v3 = {
        "", 
        ".", 
        "..", 
        "..."
    };
    local v4 = 1;
    while true do
        l_Text_0.Text = "Generating AI" .. v3[v4];
        v4 = v4 % #v3 + 1;
        task.wait(0.4);
    end;
end);