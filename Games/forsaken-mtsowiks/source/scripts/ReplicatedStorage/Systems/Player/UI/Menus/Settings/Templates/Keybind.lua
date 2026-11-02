-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
v0.CreateSettingUI = function(_, v2, v3) --[[ Line: 4 ]] --[[ Name: CreateSettingUI ]]
    -- upvalues: v0 (copy)
    local v4 = require(game.ReplicatedStorage.Modules.Sounds);
    local v5 = require(game.ReplicatedStorage.Modules.Device);
    if not v2 then
        v2 = Instance.new("StringValue");
        v2.Name = "SettingValue";
    end;
    local v6 = setmetatable({
        SettingValue = v2
    }, v0);
    v6.Instance = v3 or script.KeybindFrame:Clone();
    v6.IsKeybind = true;
    local function _() --[[ Line: 18 ]] --[[ Name: clearCurrentConnection ]]
        -- upvalues: v0 (ref)
        if v0.__currentConnection then
            v0.__currentConnection:Disconnect();
            v0.__currentConnection = nil;
        end;
    end;
    local v8 = {
        "None", 
        "Unknown", 
        "MouseMovement", 
        "Focus", 
        "Accelerometer", 
        "TextInput"
    };
    v6.Instance.KeybindButton.MouseButton1Click:Connect(function() --[[ Line: 36 ]]
        -- upvalues: v4 (copy), v0 (ref), v6 (copy), v8 (copy), v2 (ref)
        v4:Play("click");
        if v0.__currentConnection then
            return;
        elseif v6.__debounce then
            return;
        else
            v6.__debounce = true;
            task.delay(0.25, function() --[[ Line: 46 ]]
                -- upvalues: v6 (ref)
                v6.__debounce = nil;
            end);
            task.wait(0.05);
            v6.Instance.KeybindButton.CurrentBind.Title.Text = "...";
            v0.__currentConnection = game.UserInputService.InputEnded:Connect(function(v9) --[[ Line: 51 ]]
                -- upvalues: v0 (ref), v8 (ref), v2 (ref), v4 (ref), v6 (ref)
                if v0.__currentConnection then
                    local v10 = v9.KeyCode == Enum.KeyCode.Unknown and v9.UserInputType.Name or v9.KeyCode.Name;
                    if table.find(v8, v10) or v9.KeyCode == Enum.KeyCode.Unknown and v2:GetAttribute("KeycodeOnly") then
                        v4:Play("error");
                        return;
                    else
                        local v11 = require(game.ReplicatedStorage.Initializer);
                        for v12, v13 in pairs(v11.PlayerSettings) do
                            if v13.IsKeybind and v13.Value == v10 and v12 ~= v2.Name then
                                v4:Play("error");
                                return;
                            end;
                        end;
                        require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UpdateSettings", "REMOTE_EVENT", v2, v10);
                        v4:Play("switch");
                        if v0.__currentConnection then
                            v0.__currentConnection:Disconnect();
                            v0.__currentConnection = nil;
                        end;
                        v6.Instance.KeybindButton.CurrentBind.Title.Text = v10;
                    end;
                end;
            end);
            return;
        end;
    end);
    local function v15() --[[ Line: 82 ]] --[[ Name: updateVisibility ]]
        -- upvalues: v5 (copy), v2 (ref), v6 (copy)
        local l_v5_PlayerDevice_0 = v5:GetPlayerDevice();
        if l_v5_PlayerDevice_0 == "Console" and v2.Name:find("~Console") then
            v6.Instance.Visible = true;
            return;
        elseif l_v5_PlayerDevice_0 == "PC" and not v2.Name:find("~Console") then
            v6.Instance.Visible = true;
            return;
        else
            v6.Instance.Visible = false;
            return;
        end;
    end;
    v15();
    v5.Changed:Connect(v15);
    return v6;
end;
v0.OnUpdate = function(v16) --[[ Line: 100 ]] --[[ Name: OnUpdate ]]
    v16.Instance.KeybindButton.CurrentBind.Title.Text = v16.Value;
end;
return v0;