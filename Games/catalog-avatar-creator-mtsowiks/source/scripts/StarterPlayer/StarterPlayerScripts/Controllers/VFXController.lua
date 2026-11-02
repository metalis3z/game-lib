-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Assets = ReplicatedStorage:WaitForChild("Assets");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent:WaitForChild("Events");
local Modules = require(script.Parent.Parent.Modules);
local SettingsController = require(Modules.Controllers.SettingsController);
local u1 = {};
local u2 = {
    LikeEffect = { "Miscellaneous", "EnableLikeVFX" },
    WindEffect = { "Miscellaneous", "EnableOutfitUpdateVFX" }
};

function u1.PlayEffect(p3, p4) -- Line: 17
    -- upvalues: u2 (copy), SettingsController (copy), Assets (copy)
    if not (p3 and p4) then
        return;
    end;

    local v5 = u2[p4];

    if v5 and SettingsController.GetSetting(v5) == false then
        return;
    end;

    local v6 = Assets:FindFirstChild(p4);

    if v6 then
        local u7 = v6:Clone();

        if u7:IsA("BasePart") then
            if p3:IsA("BasePart") then
                u7.CFrame = p3.CFrame;
            elseif p3:IsA("Model") then
                u7:PivotTo(p3:GetPivot());
            elseif p3:IsA("Attachment") then
                u7.CFrame = p3.WorldCFrame;
            end;

            u7.Anchored = true;
            u7.CanCollide = false;
            u7.CanQuery = false;
            u7.CanTouch = false;
            u7.Parent = workspace;
        elseif u7:IsA("Attachment") then
            if p3:IsA("BasePart") then
                u7.Parent = p3;
            elseif p3:IsA("Model") then
                u7.Parent = p3.PrimaryPart or p3:FindFirstChildWhichIsA("BasePart");
            else
                u7.Parent = p3;
            end;
        else
            u7.Parent = p3;
        end;

        local v8 = {};

        if u7:IsA("ParticleEmitter") then
            table.insert(v8, u7);
        end;

        for _, descendant in u7:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                table.insert(v8, descendant);
            end;
        end;

        for _, v in v8 do
            v.Enabled = false;
        end;

        local v9 = 0;

        for _, v in v8 do
            local u10 = v:GetAttribute("EmitCount") or 0;
            local u11 = v:GetAttribute("EmitDelay") or 0;
            local u12 = v:GetAttribute("EmitDuration") or 0;
            local Max = v.Lifetime.Max;
            local v13 = u11 + math.max(u12, 0) + Max;

            if v9 >= v13 then
                v13 = v9;
            end;

            task.spawn(function() -- Line: 99
                -- upvalues: u11 (copy), u12 (copy), v (copy), u10 (copy)
                if u11 > 0 then
                    task.wait(u11);
                end;

                if u12 > 0 then
                    v.Enabled = true;
                    task.wait(u12);
                    v.Enabled = false;
                end;

                if u10 > 0 then
                    v:Emit(u10);
                end;
            end);
            v9 = v13;
        end;

        task.delay(v9 + 1, function() -- Line: 118
            -- upvalues: u7 (copy)
            if u7 and u7.Parent then
                u7:Destroy();
            end;
        end);

        return u7;
    end;

    warn("[VFXController] Effect not found:", p4);
end;

Remotes:WaitForChild("PlayEffect").OnClientEvent:Connect(function(p14, p15) -- Line: 128
    -- upvalues: u1 (copy)
    u1.PlayEffect(p14, p15);
end);
Events:WaitForChild("PlayEffect").Event:Connect(function(p16, p17) -- Line: 133
    -- upvalues: u1 (copy)
    u1.PlayEffect(p16, p17);
end);

return u1;