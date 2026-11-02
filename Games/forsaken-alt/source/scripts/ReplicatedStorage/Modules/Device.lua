-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
    GetPlayerDevice = function(v0) --[[ Line: 3 ]] --[[ Name: GetPlayerDevice ]]
        return v0.Value;
    end
};
v1.Init = function(_) --[[ Line: 7 ]] --[[ Name: Init ]]
    -- upvalues: v1 (copy)
    local l_UserInputService_0 = game:GetService("UserInputService");
    local v4 = require(game.ReplicatedStorage.Modules.Network);
    local l_BindableEvent_0 = Instance.new("BindableEvent");
    local v6 = {
        "Keyboard", 
        "Touch", 
        "Gamepad1"
    };
    local v7 = {
        Keyboard = "PC", 
        Touch = "Mobile", 
        Gamepad1 = "Console"
    };
    v1.Changed = l_BindableEvent_0.Event;
    v1.Value = v7[l_UserInputService_0:GetLastInputType().Name];
    v4:FireServerConnection("SetDevice", "REMOTE_EVENT", v1.Value);
    l_UserInputService_0.LastInputTypeChanged:connect(function(v8) --[[ Line: 29 ]]
        -- upvalues: l_UserInputService_0 (copy), v7 (copy), v6 (copy), v1 (ref), l_BindableEvent_0 (copy), v4 (copy)
        if v8 == Enum.UserInputType.Touch and l_UserInputService_0.GamepadEnabled then
            v8 = Enum.UserInputType.Gamepad1;
        end;
        local v9 = v7[v8.Name];
        if table.find(v6, v8.Name) and v1.Value ~= v9 then
            v1.Value = v9;
            l_BindableEvent_0:Fire(v9);
            v4:FireServerConnection("SetDevice", "REMOTE_EVENT", v9);
        end;
    end);
end;
return v1;