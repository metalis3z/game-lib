-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.EnumLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local ViewModels = Players.LocalPlayer.PlayerScripts.Modules.ViewModels;
local PaintballSplatGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PaintballSplatGui");
local u1 = { "rbxassetid://17098901439", "rbxassetid://17098901515", "rbxassetid://16833617681" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 17
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.FighterInterface = p3;
    v4._splat_guis = {};
    v4:_Init();

    return v4;
end;

function u2.Create(u5, p6, p7, p8, p9) -- Line: 33
    -- upvalues: ViewModels (copy), PaintballSplatGui (copy), u1 (copy), Players (copy), Utility (copy)
    if not u5.FighterInterface:IsActive() then
        return;
    end;

    if p8 then
        p8 = ViewModels:FindFirstChild(p8, true);
    end;

    if p8 then
        p8 = require(p8);
    end;

    for i = 1, p9 and 20 or 1 do
        local v10 = 0.125 + 0.5 * math.random();
        local v11 = p9 and Color3.fromHSV(math.random(), 0.75, 1) or (p8 and p8:GetPaintballColor() or (p7 or Color3.fromHSV(tick() * 2 % 1, 0.75, 1)));
        local v12;

        if p9 then
            v12 = UDim2.new(v10 * 0.25 + (1 - v10 * 0.5) * math.random(), 0, v10 * 0.25 + (1 - v10 * 0.5) * math.random(), 0);
        else
            v12 = u5:_GetScreenPosition(p6);
        end;

        local u13 = PaintballSplatGui:Clone();
        u13.Splat.Size = UDim2.new(v10, 0, v10, 0);
        u13.Splat.Position = v12;
        u13.Splat.ImageColor3 = v11;
        u13.Splat.Image = u1[math.random(#u1)];
        u13.Splat.Rotation = 360 * math.random();
        u13.Parent = u5.FighterInterface:IsActive() and Players.LocalPlayer.PlayerGui or nil;
        table.insert(u5._splat_guis, u13);
        local Splat = u13.Splat;
        task.delay(2.5, function() -- Line: 61
            -- upvalues: Splat (copy), Utility (ref), u13 (copy), u5 (copy)
            local ImageTransparency = Splat.ImageTransparency;
            Utility:RenderstepForLoop(0, 100, 4, function(p14) -- Line: 64
                -- upvalues: Splat (ref), ImageTransparency (copy)
                Splat.ImageTransparency = ImageTransparency + (1 - ImageTransparency) * (1 - (1 - p14 / 100) ^ 5);
            end);
            u13:Destroy();
            local table_find_ret = table.find(u5._splat_guis, u13);

            if table_find_ret then
                table.remove(u5._splat_guis, table_find_ret);
            end;
        end);

        if u13:IsDescendantOf(Players.LocalPlayer) then
            u13.Splat:TweenSize(UDim2.new(v10 * 0.5, 0, v10 * 0.5, 0), "In", "Quint", 3, true);
        end;

        u5.FighterInterface:CreateSound("rbxassetid://16835701807", 0.75, 1 + 0.4 * math.random(), script, true, 10);
        local v15;

        if p9 then
            wait(0.03 * math.random());
            v15 = i;
        else
            v15 = i;
        end;
    end;
end;

function u2.Destroy(p16) -- Line: 91
    for _, v in pairs(p16._splat_guis) do
        v:Destroy();
    end;

    p16._splat_guis = {};
end;

function u2._GetScreenPosition(p17, p18) -- Line: 103
    -- upvalues: UILibrary (copy)
    local v19, v20;

    if p18 then
        v19, v20 = workspace.CurrentCamera:WorldToScreenPoint(p18);
    else
        v20 = nil;
        v19 = nil;
    end;

    if v20 then
        local v21 = UILibrary:ScreenPointToPosition(v19, p17.FighterInterface.Frame.AbsolutePosition);

        return UDim2.new(0, math.clamp(v21.X, p17.FighterInterface.Frame.AbsoluteSize.X * 0.125, p17.FighterInterface.Frame.AbsoluteSize.X * 0.875), 0, (math.clamp(v21.Y, p17.FighterInterface.Frame.AbsoluteSize.Y * 0.125, p17.FighterInterface.Frame.AbsoluteSize.Y * 0.875)));
    end;

    local v22 = Vector2.new(p17.FighterInterface.Frame.AbsoluteSize.X, p17.FighterInterface.Frame.AbsoluteSize.Y) * (0.8 + 0.4 * math.random()) * 0.5;
    local v23 = math.random() * 3.141592653589793 * 2;

    return UDim2.new(0.5, math.cos(v23) * v22.X, 0.5, math.sin(v23) * v22.Y);
end;

function u2._Init(u24) -- Line: 126
    -- upvalues: Players (copy)
    u24.FighterInterface.ActiveChanged:Connect(function() -- Line: 127
        -- upvalues: u24 (copy), Players (ref)
        for _, v in pairs(u24._splat_guis) do
            v.Parent = u24.FighterInterface:IsActive() and Players.LocalPlayer.PlayerGui or nil;
        end;
    end);
end;

return u2;