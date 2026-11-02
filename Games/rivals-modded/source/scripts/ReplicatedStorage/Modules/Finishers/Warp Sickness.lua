-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 23
    p4:_AnchorModel(0);
    wait(1);
    p4:_AnchorModel(0, false);
    p4:_Ragdoll();
    p4:_AnchorModel();
end;

function u1.PlayClient(p5, ...) -- Line: 31
    -- upvalues: RunService (copy)
    local u6 = {};

    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") and v.Transparency < 0.99 then
            u6[v] = v.CFrame;

            if v.Name == "Head" then
                v.Transparency = 1;
            else
                v:SetAttribute("WrapGroup", 1);
                v:SetAttribute("IgnoreObject", true);
                v:AddTag("Wrappable");
            end;
        elseif v:IsA("Texture") or v:IsA("Decal") then
            v:Destroy();
        end;
    end;

    local v7 = p5._is_humanoid and p5._subject.Parent or p5._subject;
    v7:SetAttribute("WrapName", "Encroached");
    v7:AddTag("WrapThis");
    local u8 = tick();
    local v14 = RunService.RenderStepped:Connect(function(p9) -- Line: 57
        -- upvalues: u8 (copy), u6 (copy)
        local v10 = 5 * (1 - (tick() - u8) / 1) ^ 4;

        for i, v in pairs(u6) do
            local v11 = math.random() - 0.5;
            local v12 = math.random() - 0.5;
            local v13 = math.random() - 0.5;
            i.CFrame = v + Vector3.new(v11, v12, v13) * v10;
        end;
    end);
    table.insert(p5._connections, v14);
    p5:CreateSound("rbxassetid://118282338053058", 1.75, 1 + 0.1 * math.random(), nil, true, 5);
    wait(1);
    v14:Disconnect();

    for i, v in pairs(u6) do
        i.CFrame = v;
    end;

    p5:_AnchorModel(0, false);
end;

function u1._Init(p15) -- Line: 85
end;

return u1;