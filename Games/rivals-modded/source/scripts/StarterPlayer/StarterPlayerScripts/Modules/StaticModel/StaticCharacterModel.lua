-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local StaticModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel);
local u1 = setmetatable({}, StaticModel);
u1.__index = u1;

function u1.new(p2) -- Line: 9
    -- upvalues: StaticModel (copy), FighterController (copy), u1 (copy)
    local v3 = StaticModel.new(FighterController:GenerateCharacterModel(p2).Template:Clone());
    local v4 = setmetatable(v3, u1);
    v4.UserID = p2;
    v4:_Init();

    return v4;
end;

function u1._SetupCharacterModel(p5) -- Line: 29
    -- upvalues: FighterController (copy)
    local v6 = FighterController:GenerateCharacterModel(p5.UserID, true);

    if p5._destroyed or not v6 then
        return;
    end;

    local u7 = v6.Template:Clone();
    u7.HumanoidRootPart.Anchored = true;
    u7.PrimaryPart = nil;
    u7.WorldPivot = u7.HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
    u7:PivotTo(p5.Model:GetPivot());
    u7:ScaleTo(u7:GetScale() * p5.Model:GetScale() / p5._original_scale);
    u7.Parent = p5.Model.Parent;
    task.defer(pcall, function() -- Line: 44
        -- upvalues: u7 (copy)
        if u7:FindFirstChild("Animate") then
            u7.Animate:Destroy();
        end;

        for _, v in pairs(u7.Humanoid:GetPlayingAnimationTracks()) do
            v:Stop();
        end;

        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://507766388";
        u7.Humanoid:LoadAnimation(Animation):Play();
    end);
    p5.Model:Destroy();
    p5.Model = u7;
    p5._original_scale = u7:GetScale();
end;

function u1._Setup(p8) -- Line: 63
    p8.Model.PrimaryPart = p8.Model:FindFirstChild("HumanoidRootPart");
end;

function u1._Init(p9) -- Line: 67
    p9:_Setup();
    task.spawn(p9._SetupCharacterModel, p9);
end;

return u1;