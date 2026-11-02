-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Datas.Animals);
local v2 = require(l_ReplicatedStorage_0.Shared.Animals);
local v3 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local v4 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v5 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v6 = require(script.ButtonFX);
local v7 = require(script.AutomaticCanvasSizeModule);
local l_TextBox_0 = script.Parent.Parent.Parent.Parent.Search.TextBox;
local v9 = v3:Register("AdminSelection", script.Parent.Parent.Parent.Parent, "TopQuint");
v9:AttachCloseButton(script.Parent.Parent.Parent.Parent.Header.Txts.Close);
v9:Close();
script.Parent.Parent.Parent.Parent.Header.Txts.Close.Activated:Connect(function() --[[ Line: 17 ]]
    -- upvalues: v3 (copy)
    task.wait(0.1);
    v3:Toggle("Admin", true);
end);
local function v15(v10) --[[ Line: 23 ]] --[[ Name: filterItems ]]
    -- upvalues: v7 (copy)
    v10 = string.lower(v10 or "");
    for _, v12 in pairs(script.Parent:GetChildren()) do
        if v12:IsA("TextButton") and v12.Name ~= "Template" then
            local l_Text_0 = v12.TextLabel.Text;
            local v14 = true;
            if v10 ~= "" then
                v14 = string.find(string.lower(l_Text_0), v10, 1, true);
            end;
            v12.Visible = v14;
        end;
    end;
    v7(script.Parent);
end;
l_TextBox_0:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 38 ]]
    -- upvalues: v15 (copy), l_TextBox_0 (copy)
    v15(l_TextBox_0.Text);
end);
v9.OnClose:Connect(function() --[[ Line: 43 ]]
    -- upvalues: l_TextBox_0 (copy)
    l_TextBox_0.Text = "";
end);
v9.OnOpen:Connect(function() --[[ Line: 48 ]]
    -- upvalues: l_TextBox_0 (copy), v15 (copy)
    l_TextBox_0.Text = "";
    v15("");
end);
local v16 = nil;
local v17 = nil;
local v18 = {};
_G.SetAdminContent = function(v19, v20, v21, v22) --[[ Line: 57 ]]
    -- upvalues: v17 (ref), v18 (ref), v3 (copy), v16 (ref), v1 (copy), v5 (copy), v6 (copy), v2 (copy), v4 (copy), v7 (copy)
    v21 = v21 or "single";
    v17 = v21;
    if v21 == "multiple" and v22 and v22 ~= "None" and v22 ~= "" then
        v18 = {};
        for v23 in string.gmatch(v22, "[^, ]+") do
            table.insert(v18, v23);
        end;
    else
        v18 = {};
    end;
    v3:Toggle("AdminSelection", true);
    for _, v25 in pairs(script.Parent:GetChildren()) do
        if v25:IsA("TextButton") and v25.Name ~= "Template" then
            v25:Destroy();
        end;
    end;
    if v19 ~= v16 then
        script.Parent.CanvasPosition = Vector2.new(0, 0);
    end;
    v16 = v19;
    for _, v27 in pairs(v19) do
        local v28 = script.Parent.Template:Clone();
        v28.Name = "Kiwi";
        v28.TextLabel.Text = v27.DisplayName or "";
        v28.Parent = script.Parent;
        v28.Visible = true;
        v28.ImageLabel.Image = v27.Icon or "";
        local v29 = nil;
        if not v27.Icon then
            for v30, v31 in pairs(v1) do
                if v31 == v27 then
                    v29 = v30;
                    break;
                end;
            end;
        end;
        local v32 = v29 or v27.DisplayName;
        local v33 = false;
        if v17 == "multiple" then
            v33 = table.find(v18, v32);
        end;
        local v34 = v27.Color or Color3.fromRGB(20, 20, 20);
        if v33 then
            v28.BackgroundColor3 = Color3.fromRGB(80, 80, 80);
        elseif v27.GradientPreset then
            v28.BackgroundColor3 = Color3.fromRGB(150, 150, 150);
            v5.apply(v28, v27.GradientPreset, 0.5);
        else
            v28.BackgroundColor3 = v34;
        end;
        v6(v28);
        if v29 and not v27.Icon then
            local v35 = v2:AttachOnViewport(v29, v28.ViewportFrame, true, nil);
            if v35 then
                local l_v35_0 = v35 --[[ copy: 14 -> 16 ]];
                v28.Destroying:Once(function() --[[ Line: 118 ]]
                    -- upvalues: l_v35_0 (copy)
                    l_v35_0:Destroy();
                end);
            end;
        end;
        local v37 = v4.new(v28);
        v37:Animate();
        v37.OnActivated:Connect(function() --[[ Line: 125 ]]
            -- upvalues: v17 (ref), v18 (ref), v32 (copy), v27 (copy), v28 (copy), v5 (ref), v34 (copy), v20 (copy), v3 (ref)
            if v17 == "multiple" then
                local v38 = table.find(v18, v32);
                if v38 then
                    table.remove(v18, v38);
                    if v27.GradientPreset then
                        v28.BackgroundColor3 = Color3.fromRGB(150, 150, 150);
                        v5.apply(v28, v27.GradientPreset, 0.5);
                    else
                        v28.BackgroundColor3 = v34;
                    end;
                else
                    table.insert(v18, v32);
                    v28.BackgroundColor3 = Color3.fromRGB(80, 80, 80);
                end;
                if #v18 > 0 then
                    v20(table.concat(v18, ", "));
                    return;
                else
                    v20("None");
                    return;
                end;
            else
                v3:Toggle("Admin", true);
                v20(v32);
                return;
            end;
        end);
    end;
    v7(script.Parent);
end;