-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local v1 = 10;
v0.CreateSettingUI = function(_, v3, v4, v5) --[[ Line: 5 ]] --[[ Name: CreateSettingUI ]]
    -- upvalues: v0 (copy), v1 (ref)
    local v6 = require(game.ReplicatedStorage.Modules.Sounds);
    if not v3 then
        v3 = Instance.new("StringValue");
        v3.Name = "SettingValue";
    end;
    local v7 = setmetatable({
        SettingValue = v3
    }, v0);
    v7.Value = v3.Value;
    v7.Instance = v4 or script.Dropdown:Clone();
    v7.DropdownVisible = false;
    v7.Instance.DropdownFrame.MouseButton1Click:Connect(function() --[[ Line: 18 ]]
        -- upvalues: v6 (copy), v7 (copy), v1 (ref), v3 (ref), v5 (copy)
        v6:Play("click");
        v7.DropdownVisible = not v7.DropdownVisible;
        v7.Instance.DropdownFrame.DropdownArrow.Rotation = v7.DropdownVisible and 180 or 0;
        v7.Instance.DropdownFrame.Options.Visible = v7.DropdownVisible;
        v1 = v1 + 1;
        v7.Instance.ZIndex = v1;
        for _, v9 in pairs(v7.Instance.DropdownFrame.Options:GetChildren()) do
            if v9:IsA("GuiObject") then
                v9:Destroy();
            end;
        end;
        local v10 = v3:GetAttribute("Options") and string.split(v3:GetAttribute("Options"), "|");
        local l_pairs_0 = pairs;
        local v12 = v10 or {};
        for v13, v14 in l_pairs_0(v12) do
            local v15 = script.DropdownOption:Clone();
            v15.Name = v14;
            v15.LayoutOrder = v13;
            v15.Title.Text = v15.Name;
            v15.Parent = v7.Instance.DropdownFrame.Options;
            v15.MouseButton1Click:Connect(function() --[[ Line: 43 ]]
                -- upvalues: v3 (ref), v14 (copy), v7 (ref), v5 (ref), v6 (ref)
                if v3.Name ~= "SettingValue" and v3.Name ~= "Value" then
                    require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UpdateSettings", "REMOTE_EVENT", v3, v14);
                else
                    v7.Value = v14;
                    v7:OnUpdate();
                    if v5 then
                        v5(v7.Value);
                    end;
                end;
                v6:Play("switch");
            end);
        end;
    end);
    return v7;
end;
v0.OnUpdate = function(v16) --[[ Line: 60 ]] --[[ Name: OnUpdate ]]
    v16.Instance.DropdownFrame.ChosenValue.Title.Text = v16.Value;
    v16.Instance.DropdownFrame.Options.Visible = false;
    v16.Instance.DropdownFrame.DropdownArrow.Rotation = 0;
    v16.DropdownVisible = false;
end;
return v0;