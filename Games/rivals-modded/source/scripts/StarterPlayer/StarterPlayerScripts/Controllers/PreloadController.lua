-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ContentProvider = game:GetService("ContentProvider");
local u1 = {
    FinalResultsCamera = "rbxassetid://18110142424",
    FinalResultsPlayer1 = "rbxassetid://18110150396",
    FinalResultsPlayer2 = "rbxassetid://18110151901",
    FinalResultsPlayer3 = "rbxassetid://18110154615",
    FinalResultsPlayer4 = "rbxassetid://18110156683",
    FinalResultsPlayer5 = "rbxassetid://18110158144",
    SlidingStartForward = "rbxassetid://17702562791",
    SlidingStartRightward = "rbxassetid://18887331786",
    SlidingStartBackward = "rbxassetid://18887315202",
    SlidingStartLeftward = "rbxassetid://18887335228",
    SlidingLoopForward = "rbxassetid://17702566891",
    SlidingLoopRightward = "rbxassetid://18887328608",
    SlidingLoopBackward = "rbxassetid://18887323938",
    SlidingLoopLeftward = "rbxassetid://18887339224",
    SlidingJump = "rbxassetid://17704241464",
    SlidingJumpFall = "rbxassetid://17704252963",
    WeaponUnlockIdle = "rbxassetid://17652443406",
    WeaponUnlockPlay = "rbxassetid://17652360108",
    LobbyPortalFalling = "rbxassetid://111331261961557",
    ZombieSpawn = "rbxassetid://81895123077452"
};
local AnimationOverrides = require(game:GetService("ReplicatedStorage").Modules.AnimationOverrides);
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 33
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._preloaded_animations_by_name = {};
    v3._preloaded_animations_by_animation_id = {};
    v3:_Init();

    return v3;
end;

function u2.GetPreloadedAnimationID(p4, p5) -- Line: 48
    -- upvalues: u1 (copy)
    return AnimationOverrides.Get(p5, u1[p5]);
end;

function u2.GetPreloadedAnimation(p6, p7) -- Line: 52
    return p6._preloaded_animations_by_name[p7];
end;

function u2._PreloadAnimations(u8) -- Line: 60
    -- upvalues: u1 (copy), ContentProvider (copy)
    local u9 = {};

    for i, v in pairs(u1) do
        local Animation = Instance.new("Animation");
        v = AnimationOverrides.Get(i, v);
        Animation.AnimationId = v;
        u8._preloaded_animations_by_name[i] = Animation;
        u8._preloaded_animations_by_animation_id[v] = Animation;
        table.insert(u9, Animation);
    end;

    -- Ids the place can't use (another creator's) fail every time: retrying them forever only
    -- floods the output, so give up after a few rounds.
    local attempts = 0;
    while #u9 > 0 and attempts < 3 do
        attempts = attempts + 1;
        local v10 = u9;
        u9 = {};
        ContentProvider:PreloadAsync(v10, function(p11, p12) -- Line: 75
            -- upvalues: u9 (ref), u8 (copy)
            if p12 ~= Enum.AssetFetchStatus.Success then
                table.insert(u9, u8._preloaded_animations_by_animation_id[p11]);
            end;
        end);
        wait(1);
    end;
end;

function u2._Init(p13) -- Line: 85
    task.defer(p13._PreloadAnimations, p13);
end;

return u2._new();