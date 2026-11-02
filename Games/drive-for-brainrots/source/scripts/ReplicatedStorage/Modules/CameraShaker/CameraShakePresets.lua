-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- decompilation:
local v0 = require(script.Parent.CameraShakeInstance);
local v8 = {
    Bump = function() --[[ Line: 26 ]] --[[ Name: Bump ]]
        -- upvalues: v0 (copy)
        local v1 = v0.new(2.5, 4, 0.1, 0.75);
        v1.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448, 0);
        v1.RotationInfluence = Vector3.new(1, 1, 1, 0);
        return v1;
    end, 
    Explosion = function() --[[ Line: 36 ]] --[[ Name: Explosion ]]
        -- upvalues: v0 (copy)
        local v2 = v0.new(5, 10, 0, 1.5);
        v2.PositionInfluence = Vector3.new(0.25, 0.25, 0.25, 0);
        v2.RotationInfluence = Vector3.new(4, 1, 1, 0);
        return v2;
    end, 
    Earthquake = function() --[[ Line: 46 ]] --[[ Name: Earthquake ]]
        -- upvalues: v0 (copy)
        local v3 = v0.new(0.6, 3.5, 2, 10);
        v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25, 0);
        v3.RotationInfluence = Vector3.new(1, 1, 4, 0);
        return v3;
    end, 
    BadTrip = function() --[[ Line: 56 ]] --[[ Name: BadTrip ]]
        -- upvalues: v0 (copy)
        local v4 = v0.new(10, 0.15, 5, 10);
        v4.PositionInfluence = Vector3.new(0, 0, 0.15000000596046448, 0);
        v4.RotationInfluence = Vector3.new(2, 1, 4, 0);
        return v4;
    end, 
    HandheldCamera = function() --[[ Line: 66 ]] --[[ Name: HandheldCamera ]]
        -- upvalues: v0 (copy)
        local v5 = v0.new(1, 0.25, 5, 10);
        v5.PositionInfluence = Vector3.new(0, 0, 0, 0);
        v5.RotationInfluence = Vector3.new(1, 0.5, 0.5, 0);
        return v5;
    end, 
    Vibration = function() --[[ Line: 76 ]] --[[ Name: Vibration ]]
        -- upvalues: v0 (copy)
        local v6 = v0.new(0.4, 20, 2, 2);
        v6.PositionInfluence = Vector3.new(0, 0.15000000596046448, 0, 0);
        v6.RotationInfluence = Vector3.new(1.25, 0, 4, 0);
        return v6;
    end, 
    RoughDriving = function() --[[ Line: 86 ]] --[[ Name: RoughDriving ]]
        -- upvalues: v0 (copy)
        local v7 = v0.new(1, 2, 1, 1);
        v7.PositionInfluence = Vector3.new(0, 0, 0, 0);
        v7.RotationInfluence = Vector3.new(1, 1, 1, 0);
        return v7;
    end
};
return (setmetatable({}, {
    __index = function(_, v10) --[[ Line: 98 ]] --[[ Name: __index ]]
        -- upvalues: v8 (copy)
        local v11 = v8[v10];
        if type(v11) == "function" then
            return v11();
        else
            error("No preset found with index \"" .. v10 .. "\"");
            return;
        end;
    end
}));
