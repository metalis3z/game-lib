-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local JumpPads = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("JumpPads");
local u1 = {
    Default = { "rbxassetid://85163949920258", 1 },
    Trampoline = { "rbxassetid://75001064846226", 1 },
    ["Bounce House"] = { "rbxassetid://139519788113881", 1 },
    ["Shady Chicken Sandwich"] = { "rbxassetid://99488347318534", 1.25 },
    ["Spider Web"] = { "rbxassetid://88449856112147", 1.25 },
    ["Jolly Man"] = { "rbxassetid://111488886881644", 1.5 },
    ["Flamingo Floatie"] = { "rbxassetid://139519788113881", 1 }
};
local u2 = {
    Default = { "rbxassetid://17835965985", 1 },
    Trampoline = { "rbxassetid://79142560912255", 1 },
    ["Bounce House"] = { "rbxassetid://18963214636", 1 },
    ["Shady Chicken Sandwich"] = { "rbxassetid://138205332923098", 1.25 },
    ["Spider Web"] = { "rbxassetid://128812513158754", 1.25 },
    ["Flamingo Floatie"] = { "rbxassetid://130086876465618", 1 }
};
local u3 = {};
u3.__index = u3;

function u3._new() -- Line: 33
    -- upvalues: u3 (copy)
    local v4 = setmetatable({}, u3);
    v4:_Init();

    return v4;
end;

function u3.CreateJumpPadVisual(p5, p6, p7) -- Line: 45
    -- upvalues: JumpPads (copy)
    local v8 = (JumpPads:FindFirstChild(p6 or "Default") or JumpPads.Default):Clone();
    v8:ScaleTo(v8:GetScale() * p7.X / 10);

    for _, descendant in pairs(v8:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
        end;
    end;

    return v8;
end;

function u3._ObjectAdded(p9, u10) -- Line: 66
    -- upvalues: u2 (copy), u1 (copy), Utility (copy), FighterController (copy), WrapController (copy), RunService (copy)
    local function get_cframe() -- Line: 67
        -- upvalues: u10 (copy)
        return u10:GetPivot() * CFrame.new(0, 0, u10.Size.Z / 2);
    end;

    local Attribute = u10:GetAttribute("ViewModelName");
    local Attribute2 = u10:GetAttribute("ObjectID");
    local v11 = u2[Attribute] or u2.Default;
    local v12 = u1[Attribute] or u1.Default;
    u10:SetAttribute("SoundID", v11[1]);
    u10:SetAttribute("SoundVolume", v11[2]);
    Utility:CreateSound(v12[1], v12[2], 1.25, u10, true, 5);
    local v13 = p9:CreateJumpPadVisual(Attribute, u10.Size);
    v13.Parent = u10;
    local Wrap = FighterController:GetWrap(Attribute2);

    if Wrap then
        WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v13), Wrap, true);
    end;

    local v14 = v13:GetScale() * 1.25;
    local Scale = v13:GetScale();
    local CFrame_Angles_ret = CFrame.Angles(0, 0, 0.17453292519943295 * (math.random() - 0.5));
    local v15 = tick();

    while tick() < v15 + 0.25 do
        local v16 = 1 - (1 - (tick() - v15) / 0.25) ^ 3;
        v13:ScaleTo(v14 + (Scale - v14) * v16);
        v13:PivotTo(u10:GetPivot() * CFrame.new(0, 0, u10.Size.Z / 2) * CFrame_Angles_ret:Lerp(CFrame.identity, v16));
        RunService.RenderStepped:Wait();
    end;

    v13:ScaleTo(Scale);
    v13:PivotTo(u10:GetPivot() * CFrame.new(0, 0, u10.Size.Z / 2));

    for _, descendant in pairs(v13:GetDescendants()) do
        if descendant:IsA("BasePart") then
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = u10;
            WeldConstraint.Part1 = descendant;
            WeldConstraint.Parent = descendant;
            descendant.Anchored = false;
        end;
    end;
end;

function u3._Init(u17) -- Line: 120
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("JumpPadHitbox"):Connect(function(p18) -- Line: 121
        -- upvalues: u17 (copy)
        u17:_ObjectAdded(p18);
    end);

    for _, v in pairs(CollectionService:GetTagged("JumpPadHitbox")) do
        task.defer(u17._ObjectAdded, u17, v);
    end;
end;

return u3._new();