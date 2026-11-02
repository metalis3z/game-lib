-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy), Spring (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3._smoke_cloud_spring = Spring.new(0, 1, 20);
    v3._smoke_cloud_cover = Instance.new("Part");
    v3._smoke_cloud_dof = Instance.new("DepthOfFieldEffect");
    v3._smoke_cloud_cc = Instance.new("ColorCorrectionEffect");
    v3._smoke_clouds_entered = {};
    v3:_Init();

    return v3;
end;

function u1.Hide(p4) -- Line: 31
    p4._smoke_cloud_cover.Parent = nil;
    p4._smoke_cloud_dof.Parent = nil;
    p4._smoke_cloud_cc.Parent = nil;
end;

function u1.Update(p5, p6, p7) -- Line: 37
    -- upvalues: Lighting (copy), ReplicatedStorage (copy)
    local v8 = p5:_GetSmokeCloud();
    p5._smoke_cloud_spring.Target = v8 and 1 or 0;
    p5._smoke_cloud_spring.Speed = v8 and 100 or 20;
    p5._smoke_cloud_cover.Transparency = 1 + -0.989 * p5._smoke_cloud_spring.Value;
    p5._smoke_cloud_cover.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.25);
    p5._smoke_cloud_cover.Parent = workspace;
    p5._smoke_cloud_dof.FarIntensity = p5._smoke_cloud_spring.Value;
    p5._smoke_cloud_dof.Parent = p5._smoke_cloud_spring.Value > 0.001 and Lighting or nil;
    p5._smoke_cloud_cc.Contrast = 0 + -1 * p5._smoke_cloud_spring.Value;
    p5._smoke_cloud_cc.TintColor = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(99, 99, 99), p5._smoke_cloud_spring.Value);
    p5._smoke_cloud_cc.Parent = Lighting;

    if v8 and not p5._smoke_clouds_entered[v8] then
        p5._smoke_clouds_entered[v8] = true;
        ReplicatedStorage.Remotes.Replication.Fighter.WasSmoked:FireServer(v8:GetAttribute("ObjectID"));
    end;
end;

function u1.Clear(p9) -- Line: 60
    p9._smoke_clouds_entered = {};
end;

function u1.Destroy(p10) -- Line: 64
    p10._smoke_cloud_cover:Destroy();
    p10._smoke_cloud_dof:Destroy();
    p10._smoke_cloud_cc:Destroy();
    p10:Clear();
end;

function u1._GetSmokeCloud(p11) -- Line: 76
    -- upvalues: GameplayUtility (copy)
    for _, v in pairs({ workspace.CurrentCamera.CFrame.Position, p11.FighterInterface.ClientFighter.Entity and p11.FighterInterface.ClientFighter.Entity.RootPart.Position or nil }) do
        local v12 = GameplayUtility:GetSmokeCloudsInSphere(v)[1];

        if v12 then
            return v12;
        end;
    end;
end;

function u1._Setup(p13) -- Line: 88
    p13._smoke_cloud_cover.Color = Color3.fromRGB(72, 75, 79);
    p13._smoke_cloud_cover.Anchored = true;
    p13._smoke_cloud_cover.CanCollide = false;
    p13._smoke_cloud_cover.CastShadow = false;
    p13._smoke_cloud_cover.CanQuery = false;
    p13._smoke_cloud_cover.CanTouch = false;
    p13._smoke_cloud_cover.Size = Vector3.new(10, 10, 0);
    p13._smoke_cloud_cover.Material = Enum.Material.Neon;
    p13._smoke_cloud_cover.Transparency = 1;
    p13._smoke_cloud_dof.FarIntensity = 0;
    p13._smoke_cloud_dof.FocusDistance = 0;
    p13._smoke_cloud_dof.InFocusRadius = 1.75;
    p13._smoke_cloud_dof.NearIntensity = 0;
end;

function u1._Init(p14) -- Line: 105
    p14:_Setup();
end;

return u1;