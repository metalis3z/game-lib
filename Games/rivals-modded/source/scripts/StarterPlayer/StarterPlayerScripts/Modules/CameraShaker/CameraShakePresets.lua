-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CameraShakeInstance = require(script.Parent.CameraShakeInstance);
local u13 = {
    Bump = function() -- Line: 26, Name: Bump
        -- upvalues: CameraShakeInstance (copy)
        local v1 = CameraShakeInstance.new(2.5, 4, 0.1, 0.75);
        v1.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v1.RotationInfluence = Vector3.new(1, 1, 1);

        return v1;
    end,

    Explosion = function() -- Line: 36, Name: Explosion
        -- upvalues: CameraShakeInstance (copy)
        local v2 = CameraShakeInstance.new(5, 10, 0, 1.5);
        v2.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v2.RotationInfluence = Vector3.new(4, 1, 1);

        return v2;
    end,

    Earthquake = function() -- Line: 46, Name: Earthquake
        -- upvalues: CameraShakeInstance (copy)
        local v3 = CameraShakeInstance.new(0.6, 3.5, 2, 10);
        v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v3.RotationInfluence = Vector3.new(1, 1, 4);

        return v3;
    end,

    BadTrip = function() -- Line: 56, Name: BadTrip
        -- upvalues: CameraShakeInstance (copy)
        local v4 = CameraShakeInstance.new(10, 0.15, 5, 10);
        v4.PositionInfluence = Vector3.new(0, 0, 0.15);
        v4.RotationInfluence = Vector3.new(2, 1, 4);

        return v4;
    end,

    HandheldCamera = function() -- Line: 66, Name: HandheldCamera
        -- upvalues: CameraShakeInstance (copy)
        local v5 = CameraShakeInstance.new(1, 0.25, 5, 10);
        v5.PositionInfluence = Vector3.new(0, 0, 0);
        v5.RotationInfluence = Vector3.new(1, 0.5, 0.5);

        return v5;
    end,

    Vibration = function() -- Line: 76, Name: Vibration
        -- upvalues: CameraShakeInstance (copy)
        local v6 = CameraShakeInstance.new(0.4, 20, 2, 2);
        v6.PositionInfluence = Vector3.new(0, 0.15, 0);
        v6.RotationInfluence = Vector3.new(1.25, 0, 4);

        return v6;
    end,

    RoughDriving = function() -- Line: 86, Name: RoughDriving
        -- upvalues: CameraShakeInstance (copy)
        local v7 = CameraShakeInstance.new(1, 2, 1, 1);
        v7.PositionInfluence = Vector3.new(0, 0, 0);
        v7.RotationInfluence = Vector3.new(1, 1, 1);

        return v7;
    end,

    Recoil = function() -- Line: 94, Name: Recoil
        -- upvalues: CameraShakeInstance (copy)
        local v8 = CameraShakeInstance.new(2, 6, 0.05, 0.4);
        v8.PositionInfluence = Vector3.new(0, 0, 0);
        v8.RotationInfluence = Vector3.new(1, 1, 2);

        return v8;
    end,

    ChainsawHold = function() -- Line: 102, Name: ChainsawHold
        -- upvalues: CameraShakeInstance (copy)
        local v9 = CameraShakeInstance.new(3, 6, 0.1, 0.1);
        v9.PositionInfluence = Vector3.new(0.5, 0.5, 0.5);
        v9.RotationInfluence = Vector3.new(0.5, 0.5, 0.5);

        return v9;
    end,

    BattleAxeSpin = function() -- Line: 110, Name: BattleAxeSpin
        -- upvalues: CameraShakeInstance (copy)
        local v10 = CameraShakeInstance.new(5, 10, 0, 0.25);
        v10.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v10.RotationInfluence = Vector3.new(4, 1, 1);

        return v10;
    end,

    SpearThrow = function() -- Line: 118, Name: SpearThrow
        -- upvalues: CameraShakeInstance (copy)
        local v11 = CameraShakeInstance.new(4, 6, 0.05, 0.4);
        v11.PositionInfluence = Vector3.new(0, 0, 0);
        v11.RotationInfluence = Vector3.new(1, 1, 2);

        return v11;
    end,

    GrapplerPull = function() -- Line: 126, Name: GrapplerPull
        -- upvalues: CameraShakeInstance (copy)
        local v12 = CameraShakeInstance.new(3, 6, 0.05, 0.4);
        v12.PositionInfluence = Vector3.new(0, 0, 0);
        v12.RotationInfluence = Vector3.new(1, 1, 2);

        return v12;
    end
};

return setmetatable({}, {
    __index = function(p14, p15) -- Line: 136, Name: __index
        -- upvalues: u13 (copy)
        local v16 = u13[p15];

        if type(v16) == "function" then
            return v16();
        end;

        error("No preset found with index \"" .. p15 .. "\"");
    end
});