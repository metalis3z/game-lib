-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- decompilation:
local v0 = {};
local v1 = {};
v0.EnterVehicleKeyboard = Enum.KeyCode.E;
v0.EnterVehicleGamepad = Enum.KeyCode.ButtonY;
v0.Handbrake = {
    {
        KeyCode = Enum.KeyCode.Space
    }, 
    {
        KeyCode = Enum.KeyCode.ButtonA
    }
};
v0.SteerLeft = {
    {
        KeyCode = Enum.KeyCode.A
    }, 
    {
        KeyCode = Enum.KeyCode.Left
    }, 
    {
        KeyCode = Enum.KeyCode.Thumbstick1, 
        Axis = Vector3.new(-1, 0, 0, 0)
    }
};
v0.SteerRight = {
    {
        KeyCode = Enum.KeyCode.D, 
        Sign = -1
    }, 
    {
        KeyCode = Enum.KeyCode.Right, 
        Sign = -1
    }, 
    {
        KeyCode = Enum.KeyCode.Thumbstick1, 
        Axis = Vector3.new(-1, 0, 0, 0)
    }
};
v0.Throttle = {
    {
        KeyCode = Enum.KeyCode.W
    }, 
    {
        KeyCode = Enum.KeyCode.Up
    }, 
    {
        KeyCode = Enum.KeyCode.ButtonR2, 
        Axis = Vector3.new(0, 0, 1, 0)
    }
};
v0.Brake = {
    {
        KeyCode = Enum.KeyCode.S
    }, 
    {
        KeyCode = Enum.KeyCode.Down
    }, 
    {
        KeyCode = Enum.KeyCode.ButtonL2, 
        Axis = Vector3.new(0, 0, 1, 0)
    }
};
for _, v3 in pairs(v0) do
    if type(v3) == "table" then
        for _, v5 in ipairs(v3) do
            if type(v5) == "table" then
                v1[v5.KeyCode] = v5;
            end;
        end;
    end;
end;
v0.KeysForAction = function(v6) --[[ Line: 50 ]] --[[ Name: KeysForAction ]]
    -- upvalues: v0 (copy)
    local v7 = {};
    for v8, v9 in ipairs(v0[v6]) do
        v7[v8] = v9.KeyCode;
    end;
    return v7;
end;
v0.allKeys = function() --[[ Line: 58 ]] --[[ Name: allKeys ]]
    -- upvalues: v1 (copy)
    local v10 = {};
    for v11, _ in pairs(v1) do
        table.insert(v10, v11);
    end;
    return v10;
end;
v0.getData = function(v13) --[[ Line: 68 ]] --[[ Name: getData ]]
    -- upvalues: v1 (copy)
    return v1[v13];
end;
v0.newInputTable = function() --[[ Line: 72 ]] --[[ Name: newInputTable ]]
    -- upvalues: v1 (copy)
    local v14 = {};
    for v15, _ in pairs(v1) do
        v14[v15] = 0;
    end;
    return v14;
end;
return v0;
