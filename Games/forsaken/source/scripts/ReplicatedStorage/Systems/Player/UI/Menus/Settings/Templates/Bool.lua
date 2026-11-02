-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
v0.CreateSettingUI = function(_, v2, v3) --[[ Line: 4 ]] --[[ Name: CreateSettingUI ]]
    -- upvalues: v0 (copy)
    if not v2 then
        v2 = Instance.new("BoolValue");
        v2.Name = "SettingValue";
    end;
    local v4 = setmetatable({
        SettingValue = v2
    }, v0);
    v4.isDebounce = false;
    v4.Instance = v3 or script.Checkbox:Clone();
    v4.Instance.CheckboxButton.MouseButton1Click:Connect(function() --[[ Line: 14 ]]
        -- upvalues: v4 (copy), v2 (ref)
        if v4.isDebounce then
            return;
        else
            v4.isDebounce = true;
            task.delay(0.25, function() --[[ Line: 17 ]]
                -- upvalues: v4 (ref)
                v4.isDebounce = false;
            end);
            require(game.ReplicatedStorage.Modules.Sounds):Play("switch");
            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UpdateSettings", "REMOTE_EVENT", v2, not v2.Value);
            return;
        end;
    end);
    return v4;
end;
v0.OnUpdate = function(v5) --[[ Line: 29 ]] --[[ Name: OnUpdate ]]
    v5.Value = v5.SettingValue.Value;
    v5.Instance.CheckboxButton.Checked.Visible = v5.Value;
end;
return v0;