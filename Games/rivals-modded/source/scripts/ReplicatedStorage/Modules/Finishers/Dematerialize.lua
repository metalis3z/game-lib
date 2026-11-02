-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 25
    p4:_AnchorModel(0);
    wait(2.8);
    p4:_HideBody();
end;

function u1.PlayClient(p5) -- Line: 33
    -- upvalues: RunService (copy)
    local RootPart = p5._subject.RootPart;
    local u6 = {};

    local function register(p7) -- Line: 37
        -- upvalues: u6 (copy)
        u6[p7] = {
            Exponent = 1 + 4 * math.random(),
            OriginalTransparency = p7.Transparency
        };
    end;

    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") and v.Transparency <= 0.99 then
            u6[v] = {
                Exponent = 1 + 4 * math.random(),
                OriginalTransparency = v.Transparency
            };

            if v.Parent == RootPart.Parent then
                local SelectionBox = Instance.new("SelectionBox");
                SelectionBox.Adornee = v;
                SelectionBox.Color = BrickColor.new("Toothpaste");
                SelectionBox.Parent = v;
                u6[SelectionBox] = {
                    Exponent = 1 + 4 * math.random(),
                    OriginalTransparency = SelectionBox.Transparency
                };
            end;
        end;
    end;

    local u8 = tick();

    local function set(p9) -- Line: 59
        -- upvalues: u6 (copy)
        for i, v in pairs(u6) do
            i.Transparency = v.OriginalTransparency + (1 - v.OriginalTransparency) * p9 ^ v.Exponent;
        end;
    end;

    local v11 = RunService.RenderStepped:Connect(function() -- Line: 65
        -- upvalues: set (copy), u8 (copy)
        local v10 = (tick() - (u8 + 1.8)) / 1;
        set((math.clamp(v10, 0, 1)));
    end);
    table.insert(p5._connections, v11);
    p5:CreateSound("rbxassetid://130113415", 1, 1, RootPart, true, 5);
    wait(2.8);
    v11:Disconnect();
    set(1);
    p5:_HideBody();
end;

function u1._Init(p12) -- Line: 85
end;

return u1;