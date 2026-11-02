-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {
    [Enum.TextXAlignment.Left] = 0,
    [Enum.TextXAlignment.Right] = 1,
    [Enum.TextYAlignment.Top] = 0,
    [Enum.TextYAlignment.Bottom] = 1
};
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local Color = ItemLibrary.Statuses.Contraband.Color;
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 27
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._objects = {};
    v3:_Init();

    return v3;
end;

function u2.Update(p4, p5) -- Line: 41
    -- upvalues: Utility (copy), u1 (copy), Color (copy), Color3_fromRGB_ret (copy)
    for i, v in pairs(p4._objects) do
        if Utility:IsUIElementVisible(i) then
            if v.IsTextLabel then
                local v6 = Vector2.new(math.min(5, i.AbsoluteSize.X), (math.min(5, i.AbsoluteSize.Y))) * Vector2.new(math.random() - 0.5, math.random() - 0.5);
                local math_abs_ret = math.abs(v6.X);
                local math_abs_ret2 = math.abs(v6.Y);
                local math_min_ret = math.min(math_abs_ret, math_abs_ret2);
                local OriginalPosition = v.OriginalPosition;
                local UDim2_new = UDim2.new;
                local math_abs_ret3 = math.abs(v6.X);
                local v7 = math.min(math_abs_ret3, math_min_ret) * math.sign(v6.X);
                local math_abs_ret4 = math.abs(v6.Y);
                i.Position = OriginalPosition + UDim2_new(0, v7, 0, math.min(math_abs_ret4, math_min_ret) * math.sign(v6.Y));
            end;

            if tick() > v.Cooldown then
                v.Cooldown = tick() + 0.1;
                local v8 = v.IsTextLabel and i.TextBounds.X or i.AbsoluteSize.X;
                local v9 = v.IsTextLabel and i.TextBounds.Y or i.AbsoluteSize.Y;
                local v10 = v.IsTextLabel and (u1[i.TextXAlignment] or 0.5) or 0.5;
                local v11 = v.IsTextLabel and (u1[i.TextYAlignment] or 0.5) or 0.5;
                local v12 = (0.375 + 0.25 * math.random()) * 0.375;
                local v13 = (0.375 + 0.25 * math.random()) * 0.375;

                if v8 > 0 then
                    local Frame = Instance.new("Frame");
                    Frame.BorderSizePixel = 0;
                    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
                    Frame.BackgroundColor3 = Color:Lerp(Color3_fromRGB_ret, math.random());
                    Frame.Size = UDim2.new(v12, 0, v13, 0);
                    Frame.Position = UDim2.new(v10, (math.random() - v10) * v8, v11, (math.random() - v11) * v9);
                    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
                    UIAspectRatioConstraint.AspectRatio = 1 + 2 * math.random();
                    UIAspectRatioConstraint.Parent = Frame;
                    Frame.Parent = i;
                    local Particles = v.Particles;
                    local v14 = {
                        Age = 0,
                        Particle = Frame,
                        OriginalPosition = Frame.Position
                    };
                    local v15 = math.random() - 0.5;
                    v14.Direction = math.sign(v15);
                    table.insert(Particles, v14);
                end;
            end;

            local v16 = v;

            for i2 = #v.Particles, 1, -1 do
                local v17 = v16.Particles[i2];
                v17.Age = v17.Age + p5;
                local v18;

                if v17.Age >= 0.5 then
                    v17.Particle:Destroy();
                    table.remove(v16.Particles, i2);
                    v18 = i2;
                else
                    v17.Particle.Position = v17.OriginalPosition + UDim2.new(0, v17.Age * 10 * v17.Direction, 0, 0);

                    if v16.IsTextLabel then
                        v18 = i2;
                    else
                        local v19 = v17.Particle.AbsoluteSize * Vector2.new(math.random() - 0.5, math.random() - 0.5) * 0.25;
                        local Particle = v17.Particle;
                        Particle.Position = Particle.Position + UDim2.new(0, v19.X, 0, v19.Y);
                        v18 = i2;
                    end;
                end;
            end;
        end;
    end;
end;

function u2._ObjectRemoved(p20, p21) -- Line: 109
    if not p20._objects[p21] then
        return;
    end;

    for _, v in pairs(p20._objects[p21].Particles) do
        v.Particle:Destroy();
    end;

    p20._objects[p21] = nil;
end;

function u2._ObjectAdded(p22, p23) -- Line: 121
    p22:_ObjectRemoved(p23);
    p22._objects[p23] = {
        Cooldown = 0,
        IsTextLabel = p23:IsA("TextLabel"),
        OriginalPosition = p23.Position,
        Particles = {}
    };
end;

function u2._Init(u24) -- Line: 132
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceRemovedSignal("UIGlitchEffect"):Connect(function(p25) -- Line: 133
        -- upvalues: u24 (copy)
        u24:_ObjectRemoved(p25);
    end);
    CollectionService:GetInstanceAddedSignal("UIGlitchEffect"):Connect(function(p26) -- Line: 137
        -- upvalues: u24 (copy)
        u24:_ObjectAdded(p26);
    end);

    for _, v in pairs(CollectionService:GetTagged("UIGlitchEffect")) do
        task.spawn(u24._ObjectAdded, u24, v);
    end;
end;

return u2._new();