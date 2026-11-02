-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local PrimeSparkle = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PrimeSparkle");
local u1 = {
    [Enum.TextXAlignment.Left] = 0,
    [Enum.TextXAlignment.Right] = 1,
    [Enum.TextYAlignment.Top] = 0,
    [Enum.TextYAlignment.Bottom] = 1
};
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 23
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._objects = {};
    v3:_Init();

    return v3;
end;

function u2.Update(p4, p5) -- Line: 37
    -- upvalues: Utility (copy), u1 (copy), PrimeSparkle (copy), Color3_fromRGB_ret (copy), Players (copy)
    for i, v in pairs(p4._objects) do
        if Utility:IsUIElementVisible(i) then
            if tick() > v.Cooldown then
                v.Cooldown = tick() + 0.5;
                local v6 = v.IsTextLabel and i.TextBounds.X or i.AbsoluteSize.X;
                local v7 = v.IsTextLabel and i.TextBounds.Y or i.AbsoluteSize.Y;
                local v8 = v.IsTextLabel and (u1[i.TextXAlignment] or 0.5) or 0.5;
                local v9 = v.IsTextLabel and (u1[i.TextYAlignment] or 0.5) or 0.5;
                local v10 = (0.375 + 0.25 * math.random()) * 1;

                if v6 > 0 then
                    local v11 = PrimeSparkle:Clone();
                    v11.ImageTransparency = v.IsTextLabel and i.TextTransparency or (v.IsImageLabel and (i.ImageTransparency or 0) or 0);
                    v11.ImageColor3 = Color3_fromRGB_ret;
                    v11.Size = UDim2.new(v10, 0, v10, 0);
                    v11.Position = UDim2.new(v8, (math.random() - v8) * v6, v9, (math.random() - v9) * v7);
                    v11.Rotation = math.random() * 360;
                    v11.Parent = i;

                    if v11:IsDescendantOf(Players) then
                        v11:TweenSize(UDim2.new(), "In", "Back", 2, true);
                    end;

                    table.insert(v.Particles, {
                        Age = 0,
                        Particle = v11
                    });
                end;
            end;

            local v12 = v;

            for i2 = #v.Particles, 1, -1 do
                local v13 = v12.Particles[i2];
                v13.Age = v13.Age + p5;
                local v14;

                if v13.Age >= 2 then
                    v13.Particle:Destroy();
                    table.remove(v12.Particles, i2);
                    v14 = i2;
                else
                    v13.Particle.Rotation = v13.Age * 180 * 1;
                    v14 = i2;
                end;
            end;
        end;
    end;
end;

function u2._ObjectRemoved(p15, p16) -- Line: 89
    if not p15._objects[p16] then
        return;
    end;

    for _, v in pairs(p15._objects[p16].Particles) do
        v.Particle:Destroy();
    end;

    p15._objects[p16] = nil;
end;

function u2._ObjectAdded(p17, p18) -- Line: 101
    p17:_ObjectRemoved(p18);
    p17._objects[p18] = {
        Cooldown = 0,
        IsTextLabel = p18:IsA("TextLabel"),
        IsImageLabel = p18:IsA("ImageLabel"),
        Particles = {}
    };
end;

function u2._Init(u19) -- Line: 112
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceRemovedSignal("UISparkleEffect"):Connect(function(p20) -- Line: 113
        -- upvalues: u19 (copy)
        u19:_ObjectRemoved(p20);
    end);
    CollectionService:GetInstanceAddedSignal("UISparkleEffect"):Connect(function(p21) -- Line: 117
        -- upvalues: u19 (copy)
        u19:_ObjectAdded(p21);
    end);

    for _, v in pairs(CollectionService:GetTagged("UISparkleEffect")) do
        task.spawn(u19._ObjectAdded, u19, v);
    end;
end;

return u2._new();