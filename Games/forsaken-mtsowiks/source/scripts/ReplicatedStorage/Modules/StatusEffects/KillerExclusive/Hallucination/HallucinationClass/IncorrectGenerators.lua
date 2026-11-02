-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IncorrectGenerators, time of decompilation: Fri Nov 28 21:06:23 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(script:FindFirstAncestor("HallucinationClass"));
local v2 = {};
v2.__index = v2;
setmetatable(v2, v1);
local v3 = require(l_ReplicatedStorage_0.Modules.Util);
v2.new = function(...) --[[ Line: 16 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy), v2 (copy)
    return (setmetatable(v1.new(...), v2));
end;
v2.Init = function(v4) --[[ Line: 22 ]] --[[ Name: Init ]]
    -- upvalues: v3 (copy)
    print(v4);
    local l_Objectives_0 = v4.Gui.MainUI:FindFirstChild("Objectives");
    v4.OriginalUI = {};
    v4.FakeUI = {};
    if l_Objectives_0 then
        local v6 = v3:RemoveInstancesFromTableOfInstances(l_Objectives_0:GetChildren(), {
            "UIListLayout"
        });
        for _, v8 in pairs(v6) do
            local l_Title_0 = v8:FindFirstChild("Title");
            local l_Description_0 = v8:FindFirstChild("Description");
            if l_Title_0 and l_Description_0 then
                local v11 = script.Title:Clone();
                local v12 = script.Description:Clone();
                v11.Text = l_Title_0.Text;
                v11.Parent = v8;
                task.spawn(function() --[[ Line: 49 ]]
                    -- upvalues: v4 (copy), l_Description_0 (copy), v12 (copy)
                    while v4 and v4.Running and l_Description_0 and v12 do
                        local v13, v14 = l_Description_0.Text:match("(%d+)/(%d+)");
                        local v15 = math.random(v13, v14 - 1);
                        v12.Text = l_Description_0.Text:gsub(("%*/%*"):format(v13, v14), (("%*/%*"):format(tostring(v15), v14)));
                        task.wait(math.random(9, 18));
                    end;
                end);
                v12.Parent = v8;
                table.insert(v4.FakeUI, v11);
                table.insert(v4.FakeUI, v12);
                l_Title_0.Visible = false;
                l_Description_0.Visible = false;
                table.insert(v4.OriginalUI, l_Title_0);
                table.insert(v4.OriginalUI, l_Description_0);
            end;
        end;
    end;
end;
v2.Destroy = function(v16) --[[ Line: 73 ]] --[[ Name: Destroy ]]
    for _, v18 in ipairs(v16.OriginalUI) do
        v18.Visible = true;
    end;
    for _, v20 in ipairs(v16.FakeUI) do
        v20:Destroy();
    end;
    v16:Clean();
end;
return v2;