-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local MushroomCloud = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("MushroomCloud");

local function get_rotation(p1) -- Line: 17
    -- upvalues: Utility (copy)
    local Unit = (p1 - workspace.CurrentCamera.CFrame.Position).Unit;
    local v2 = p1 - Unit;
    local v3 = p1 + Unit * 8;
    local v4 = Utility:Raycast(v2, v3, (v2 - v3).Magnitude);

    if v4.Normal then
        return CFrame.new(Vector3.new(0, 0, 0), v4.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
    end;

    return CFrame.identity;
end;

return function(p5, p6, p7, p8, p9, p10, p11) -- Line: 26
    -- upvalues: CONSTANTS (copy), Utility (copy), CameraController (copy), get_rotation (copy), MushroomCloud (copy), BetterDebris (copy)
    local v12 = 5 * (p7 or 1);
    local v13 = p9 or 64;
    local Magnitude = (workspace.CurrentCamera.CFrame.Position - p5).Magnitude;

    if CONSTANTS.RENDER_DISTANCE < Magnitude then
        return;
    end;

    Utility:CreateSound("rbxassetid://13455969017", 0.5, 0.9 + 0.2 * math.random(), p5, true, 10, p10, p11);
    Utility:CreateSound("rbxassetid://17641561917", 1.5, 0.9 + 0.2 * math.random(), p5, true, 10, p10, p11);

    if Magnitude <= v13 then
        local math_max_ret = math.max(0, 1 - Magnitude / v13);
        CameraController:ShakeOnce(math_max_ret * 50, math_max_ret * 10 / v12, 0.1 / v12, 0.4 / v12, Vector3.new(0.25, 0.25, 0), Vector3.new(0, 0, 0));
    end;

    local u14 = p6 / 40;
    local CFrame_new_ret = CFrame.new(p5);
    local v15;

    if p8 then
        v15 = get_rotation(p5);
    else
        v15 = CFrame.identity;
    end;

    local u16 = CFrame_new_ret * v15;
    local u17 = -5 * u14;
    local u18 = MushroomCloud:Clone();
    u18.Parent = workspace;
    u18:SetPrimaryPartCFrame(u16);
    BetterDebris:AddItem(u18, 25 / v12);
    u18.Fire.PointLight.Range = p6 * 3;
    Utility:PlayParticles(u18.Fire);

    local function shake(p19) -- Line: 56
        local v20 = math.random() - 0.5;
        local v21 = math.random() - 0.5;
        local v22 = math.random() - 0.5;

        return Vector3.new(v20, v21, v22) * 0.25 * (p19 or 1);
    end;

    local u23 = (math.random(1, 2) - 1.5) * 2;

    local function spin() -- Line: 62
        -- upvalues: u23 (copy)
        return CFrame.Angles(0, tick() * 0.25 * u23 % 6.283185307179586, 0);
    end;

    Utility:RenderstepForLoop(0, 100, 0.5 * v12, function(p24) -- Line: 66
        -- upvalues: u18 (copy), u14 (copy), u16 (copy), u17 (copy), u23 (copy)
        local v25 = 1 - (1 - p24 / 100) ^ 5;
        local v26 = v25 * 3;
        local v27 = 1 + (1 - v25);
        u18.Cloud.Size = Vector3.new(14.711, 14.091, 13.818) * v26 * u14;
        u18.Fire.Size = Vector3.new(14.007, 14.026, 13.543) * v26 * u14;
        u18.Ring.Size = Vector3.new(14.9445, 2.697, 14.778) * (p24 / 100 * 3) * u14;
        local Cloud = u18.Cloud;
        local v28 = u16 * CFrame.new(0, u18.Cloud.Size.Y / 2 + u17, 0) * CFrame.Angles(0, tick() * 0.25 * u23 % 6.283185307179586, 0);
        local v29 = math.random() - 0.5;
        local v30 = math.random() - 0.5;
        local v31 = math.random() - 0.5;
        Cloud.CFrame = v28 + Vector3.new(v29, v30, v31) * 0.25 * (v27 or 1);
        local Fire = u18.Fire;
        local CFrame2 = u18.Cloud.CFrame;
        local v32 = math.random() - 0.5;
        local v33 = math.random() - 0.5;
        local v34 = math.random() - 0.5;
        Fire.CFrame = CFrame2 + Vector3.new(v32, v33, v34) * 0.25 * (v27 or 1);
        local Ring = u18.Ring;
        local v35 = u18.Cloud.CFrame * CFrame.new(0, -1.815, 0);
        local v36 = math.random() - 0.5;
        local v37 = math.random() - 0.5;
        local v38 = math.random() - 0.5;
        Ring.CFrame = v35 + Vector3.new(v36, v37, v38) * 0.25 * (v27 or 1);
    end);
    Utility:RenderstepForLoop(0, 100, 0.5 * v12, function(p39) -- Line: 82
        -- upvalues: u18 (copy), u14 (copy), u16 (copy), u17 (copy), u23 (copy)
        local v40 = p39 / 100;
        u18.Fire.Transparency = v40;
        u18.Ring.Transparency = v40 / 2;
        u18.Ring.Size = Vector3.new(14.9445, 2.697, 14.778) * ((1 + v40 / 2) * 3) * u14;
        local Cloud = u18.Cloud;
        local v41 = u16 * CFrame.new(0, u18.Cloud.Size.Y / 2 + u17, 0) * CFrame.Angles(0, tick() * 0.25 * u23 % 6.283185307179586, 0);
        local v42 = math.random() - 0.5;
        local v43 = math.random() - 0.5;
        local v44 = math.random() - 0.5;
        Cloud.CFrame = v41 + Vector3.new(v42, v43, v44) * 0.25 * 1;
        local Fire = u18.Fire;
        local CFrame2 = u18.Cloud.CFrame;
        local v45 = math.random() - 0.5;
        local v46 = math.random() - 0.5;
        local v47 = math.random() - 0.5;
        Fire.CFrame = CFrame2 + Vector3.new(v45, v46, v47) * 0.25 * 1;
        local Ring = u18.Ring;
        local v48 = u18.Cloud.CFrame * CFrame.new(0, -1.815, 0);
        local v49 = math.random() - 0.5;
        local v50 = math.random() - 0.5;
        local v51 = math.random() - 0.5;
        Ring.CFrame = v48 + Vector3.new(v49, v50, v51) * 0.25 * 1;
    end);
    Utility:RenderstepForLoop(0, 100, 1 * v12, function(p52) -- Line: 95
        -- upvalues: u18 (copy), u14 (copy), u16 (copy), u17 (copy), u23 (copy)
        local v53 = p52 / 100;
        u18.Cloud.Transparency = v53;
        u18.Ring.Transparency = 0.5 + v53 / 2;
        u18.Ring.Size = Vector3.new(14.9445, 2.697, 14.778) * ((1.5 + v53 / 2) * 3) * u14;
        local Cloud = u18.Cloud;
        local v54 = u16 * CFrame.new(0, u18.Cloud.Size.Y / 2 + u17, 0) * CFrame.Angles(0, tick() * 0.25 * u23 % 6.283185307179586, 0);
        local v55 = math.random() - 0.5;
        local v56 = math.random() - 0.5;
        local v57 = math.random() - 0.5;
        Cloud.CFrame = v54 + Vector3.new(v55, v56, v57) * 0.25 * 1;
        local Ring = u18.Ring;
        local v58 = u18.Cloud.CFrame * CFrame.new(0, -1.815, 0);
        local v59 = math.random() - 0.5;
        local v60 = math.random() - 0.5;
        local v61 = math.random() - 0.5;
        Ring.CFrame = v58 + Vector3.new(v59, v60, v61) * 0.25 * 1;
    end);
    u18:Destroy();
end;