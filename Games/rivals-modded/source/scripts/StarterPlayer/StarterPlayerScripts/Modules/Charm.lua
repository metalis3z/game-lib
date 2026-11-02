-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Charms = Players.LocalPlayer.PlayerScripts.Assets.Charms;
local CFrame_Angles_ret = CFrame.Angles(0.7853981633974483, 0, 0);
local u1 = {
    X = Vector3.new(1, 0, 0),
    Y = Vector3.new(0, 1, 0),
    Z = Vector3.new(0, 0, 1)
};
local u2 = { 6.283185307179586, -6.283185307179586 };
local u3 = {};
u3.__index = u3;

function u3.new(p4, p5, p6) -- Line: 15
    -- upvalues: u3 (copy), Charms (copy), Spring (copy)
    local v7 = setmetatable({}, u3);
    v7.ClientViewModel = p4;
    v7.EquippedData = p5;
    v7.Name = v7.EquippedData.Name;
    v7.Model = Charms[v7.Name]:Clone();
    v7._original_scale = v7.Model:GetScale();
    v7._charm_pivot_attachment = p6;
    v7._pivot_attachment = v7.Model:FindFirstChild("_pivot_attachment", true);
    v7._pivot_charm_scale = v7._charm_pivot_attachment:GetAttribute("CharmScale") or 1;
    v7._orientation_spring = Spring.new(Vector3.new(0, 0, 0), 0.25, 10);
    v7._no_physics = v7._charm_pivot_attachment:GetAttribute("NoPhysics");
    v7._hide_until = 0;
    v7:_Init();

    return v7;
end;

function u3.SetParent(p8, p9) -- Line: 40
    p8.Model.Parent = p9;
end;

function u3.ScaleTo(p10, p11) -- Line: 44
    p10.Model:ScaleTo(p10._original_scale * p10._pivot_charm_scale * p11);
end;

function u3.SetHidden(p12, p13) -- Line: 48
    local v14 = p13 and 1 or 0;

    for _, descendant in pairs(p12.Model:GetDescendants()) do
        if descendant:IsA("BasePart") or (descendant:IsA("Texture") or (descendant:IsA("Beam") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Decal"))))) then
            descendant.LocalTransparencyModifier = v14;
        end;
    end;
end;

function u3.Update(p15, p16, p17) -- Line: 58
    -- upvalues: CFrame_Angles_ret (copy), u1 (copy), u2 (copy)
    if p17 or p15._no_physics then
        p15.Model:PivotTo(p15._charm_pivot_attachment.WorldCFrame);

        return;
    end;

    local Vector3_new_ret = Vector3.new(p15._charm_pivot_attachment.WorldCFrame.LookVector.X, -1, p15._charm_pivot_attachment.WorldCFrame.LookVector.Z);
    local v18 = CFrame.new(Vector3.new(0, 0, 0), Vector3_new_ret) * CFrame_Angles_ret;
    local v19 = p15.ClientViewModel and CFrame.Angles(0, 0, -p15.ClientViewModel.CurrentSwayValue.Y * 5) or CFrame.identity;
    local v20 = p15._charm_pivot_attachment.WorldCFrame.Rotation:ToObjectSpace(v18 * v19);
    p15._orientation_spring.Target = Vector3.new(v20:ToOrientation());

    for i, v in pairs(u1) do
        local v21 = v;
        local v22 = i;

        for _, v2 in pairs(u2) do
            if math.abs(p15._orientation_spring.Value[v22] - (p15._orientation_spring.Target[v22] + v2)) < math.abs(p15._orientation_spring.Value[v22] - p15._orientation_spring.Target[v22]) then
                local _orientation_spring = p15._orientation_spring;
                _orientation_spring.Value = _orientation_spring.Value - v21 * v2;
            end;
        end;
    end;

    local Value = p15._orientation_spring.Value;
    local v23 = p15._charm_pivot_attachment.WorldCFrame * CFrame.fromOrientation(Value.X, Value.Y, Value.Z);
    p15.Model:PivotTo(v23);
end;

function u3.Destroy(p24) -- Line: 84
    p24.Model:Destroy();
end;

function u3._SetupSeasonRankCharm(p25) -- Line: 92
    -- upvalues: SeasonLibrary (copy)
    if #p25.Name < 8 or string.sub(p25.Name, 1, 7) ~= "Season " then
        return;
    end;

    local string_sub_ret = string.sub(p25.Name, 8);
    local v26 = tonumber(string_sub_ret);

    if not v26 then
        return;
    end;

    local v27;

    if p25.EquippedData.Metadata then
        v27 = p25.EquippedData.Metadata.SeasonELO or nil;
    else
        v27 = nil;
    end;

    local v28;

    if p25.EquippedData.Metadata then
        v28 = p25.EquippedData.Metadata.SeasonLeaderboardRank or nil;
    else
        v28 = nil;
    end;

    SeasonLibrary:FormatSeasonRankCharm(p25.Model, SeasonLibrary.SeasonsByVersion[v26].Name, v27, v28);
end;

function u3._Setup(p29) -- Line: 110
    assert(p29._pivot_attachment ~= nil, p29.Name);

    if p29._no_physics and p29.Model:FindFirstChild("Hook") then
        p29.Model.Hook:Destroy();
    end;

    p29.Model.WorldPivot = p29._no_physics and p29.Model.Primary.CFrame or p29._pivot_attachment.WorldCFrame;
    p29.Model.PrimaryPart = nil;

    for _, descendant in pairs(p29.Model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CastShadow = false;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
            descendant.Anchored = true;
        end;
    end;

    if p29.Model:FindFirstChild("Hook") and p29.Model.Hook:FindFirstChild("Ring") then
        p29.Model.Hook.Ring.Material = Enum.Material.Glass;
    end;

    if p29._pivot_charm_scale ~= 1 then
        p29:ScaleTo(1);
    end;
end;

function u3._Init(p30) -- Line: 142
    p30:_Setup();
    task.defer(p30._SetupSeasonRankCharm, p30);
end;

return u3;