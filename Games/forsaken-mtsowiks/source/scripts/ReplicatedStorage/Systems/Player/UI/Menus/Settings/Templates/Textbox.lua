-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
v0.CreateSettingUI = function(_, v2, v3, v4) --[[ Line: 5 ]] --[[ Name: CreateSettingUI ]]
    -- upvalues: v0 (copy)
    local v5 = require(game.ReplicatedStorage.Modules.Sounds);
    if not v2 then
        v2 = Instance.new("StringValue");
        v2.Name = "SettingValue";
    end;
    local v6 = setmetatable({
        SettingValue = v2
    }, v0);
    v6.Value = v2.Value;
    v6.Instance = v3 or script.Textbox:Clone();
    v6.Instance.TextboxBackground.Textbox.Focused:Connect(function() --[[ Line: 21 ]]
        -- upvalues: v5 (copy)
        v5:Play("click");
    end);
    v6.Instance.TextboxBackground.Textbox.FocusLost:Connect(function() --[[ Line: 25 ]]
        -- upvalues: v2 (ref), v6 (copy), v4 (copy), v5 (copy)
        if v2.Name ~= "SettingValue" and v2.Name ~= "Value" then
            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UpdateSettings", "REMOTE_EVENT", v2, v6.Instance.TextboxBackground.Textbox.Text);
        else
            v6.Value = v6.Instance.TextboxBackground.Textbox.Text;
            v6:OnUpdate();
            if v4 then
                v4(v6.Value);
            end;
        end;
        v5:Play("click");
    end);
    return v6;
end;
v0.OnUpdate = function(v7) --[[ Line: 40 ]] --[[ Name: OnUpdate ]]
    v7.Instance.TextboxBackground.Textbox.Text = v7.Value or "";
end;
return v0;