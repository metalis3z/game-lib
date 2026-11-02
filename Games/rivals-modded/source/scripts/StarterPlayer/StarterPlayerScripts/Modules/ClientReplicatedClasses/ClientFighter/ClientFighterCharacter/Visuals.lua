-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local BlindedGui = Players.LocalPlayer.PlayerScripts.UserInterface.BlindedGui;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientFighterCharacter = p2;
    v3._destroyed = false;
    v3._red_figure_highlight = nil;
    v3:_Init();

    return v3;
end;

function u1.SetRedFigureMode(p4, p5, p6) -- Line: 30
    if not p5 or p4._red_figure_highlight then
        if not p5 and p4._red_figure_highlight then
            p4._red_figure_highlight:Destroy();
            p4._red_figure_highlight = nil;
        end;

        return;
    end;

    p4._red_figure_highlight = Instance.new("Highlight");
    p4._red_figure_highlight.FillColor = Color3.fromRGB(255, 0, 0);
    p4._red_figure_highlight.FillTransparency = 0.25;
    p4._red_figure_highlight.OutlineColor = Color3.fromRGB(255, 112, 112);
    p4._red_figure_highlight.OutlineTransparency = 0;
    local v7;

    if p6 then
        v7 = Enum.HighlightDepthMode.AlwaysOnTop;
    else
        v7 = Enum.HighlightDepthMode.Occluded;
    end;

    p4._red_figure_highlight.DepthMode = v7;
    p4._red_figure_highlight.Adornee = p4.ClientFighterCharacter.Model;
    p4._red_figure_highlight.Parent = p4.ClientFighterCharacter.Model;
end;

function u1.BlindedEffect(p8, p9) -- Line: 46
    -- upvalues: BlindedGui (copy), BetterDebris (copy), RunService (copy)
    local v10 = tick();
    local v11 = BlindedGui:Clone();
    v11.Parent = p8.ClientFighterCharacter.Model:FindFirstChild("Head") or p8.ClientFighterCharacter.RootPart;
    BetterDebris:AddItem(v11, p9);
    local ImageLabel = v11.ImageLabel;

    while not p8._destroyed and tick() < v10 + p9 do
        local v12 = (tick() - v10) / p9;
        ImageLabel.ImageTransparency = math.min(1, v12) ^ 5;
        RunService.RenderStepped:Wait();
    end;

    v11:Destroy();
end;

function u1.HurtEffect(p13, ...) -- Line: 63
    -- upvalues: CameraController (copy)
    local v14 = (...)[utf8.char(0)] / p13.ClientFighterCharacter.Humanoid.MaxHealth;

    if p13.ClientFighterCharacter.ClientFighter.FighterInterface then
        task.spawn(p13.ClientFighterCharacter.ClientFighter.FighterInterface.HurtEffect, p13.ClientFighterCharacter.ClientFighter.FighterInterface, ...);
    end;

    for i in pairs(p13.ClientFighterCharacter.ClientFighter:GetEquippedItems()) do
        local ViewModel = i.ViewModel;
        local v15 = math.random() - 0.5;
        local v16 = math.random() - 0.5;
        local v17 = math.random() - 0.5;
        ViewModel:ApplyRecoil(Vector3.new(v15, v16, v17) * 1.5 * v14);
    end;

    if p13.ClientFighterCharacter.ClientFighter:Get("IsSpectating") then
        CameraController:ShakeOnce(60 * v14, 10, 0, 0.4, Vector3.new(0.25, 0.25, 0), Vector3.new(0, 0, 0));
    end;
end;

function u1.Update(p18, p19, p20) -- Line: 81
end;

function u1.Destroy(p21) -- Line: 85
    p21._destroyed = true;
end;

function u1._Init(u22) -- Line: 93
    u22.ClientFighterCharacter.HealthChanged:Connect(function() -- Line: 94
        -- upvalues: u22 (copy)
        u22:SetRedFigureMode(false);
    end);
end;

return u1;