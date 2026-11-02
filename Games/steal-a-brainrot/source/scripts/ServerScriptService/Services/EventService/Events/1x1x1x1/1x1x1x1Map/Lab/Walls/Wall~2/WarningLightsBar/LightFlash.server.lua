-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_Parent_0 = script.Parent;
local v2 = {
    Color3.fromRGB(204, 153, 64), 
    Color3.fromRGB(204, 161, 124)
};
local v3 = Color3.new(0, 0, 0);
local v4 = {
    Light1 = {}, 
    Light2 = {}
};
for _, v6 in ipairs(l_Parent_0:GetDescendants()) do
    if v6.Name == "Light1" or v6.Name == "Light2" then
        table.insert(v4[v6.Name], v6);
    end;
end;
local function v10(v7, v8, v9) --[[ Line: 14 ]] --[[ Name: TweenColor ]]
    -- upvalues: l_TweenService_0 (copy)
    return l_TweenService_0:Create(v7, TweenInfo.new(v8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Color = v9
    });
end;
local function v17(v11, v12, v13) --[[ Line: 18 ]] --[[ Name: Flash ]]
    -- upvalues: v10 (copy)
    for _, v15 in ipairs(v11) do
        local v16 = v10(v15, v13, v12);
        if v16 then
            v16:Play();
        end;
    end;
end;
local function v18() --[[ Line: 25 ]] --[[ Name: RapidSection ]]
    -- upvalues: v17 (copy), v4 (copy), v2 (copy), v3 (copy)
    v17(v4.Light1, v2[1], 0.1);
    v17(v4.Light2, v3, 0.04);
    task.wait(0.16);
    v17(v4.Light1, v3, 0.04);
    v17(v4.Light2, v2[2], 0.1);
    task.wait(0.16);
    v17(v4.Light1, v2[2], 0.1);
    v17(v4.Light2, v2[1], 0.1);
    task.wait(0.16);
    v17(v4.Light1, v3, 0.04);
    v17(v4.Light2, v3, 0.04);
    task.wait(0.096);
end;
while true do
    v18();
    v18();
end;