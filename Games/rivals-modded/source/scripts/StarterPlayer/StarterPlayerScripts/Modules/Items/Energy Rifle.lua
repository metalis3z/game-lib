-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._ImpactMarker(p4, p5) -- Line: 29
    -- upvalues: Gun (copy)
    local v6 = {
        NoTween = true,
        Color = Color3.fromRGB(0, 0, 0)
    };

    return Gun._ImpactMarker(p4, p5, v6);
end;

function u1._Tracers(p7, p8) -- Line: 38
    -- upvalues: Utility (copy), WrapController (copy), Gun (copy)
    local u9 = {};
    local v22 = {
        MaxLength = (1 / 0),
        MaxLengthFirstPerson = (1 / 0),
        NoDistanceDelay = true,
        UpdateSpeed = 5,

        PlayFlyBySound = function(p10, p11, p12) -- Line: 45, Name: PlayFlyBySound
            -- upvalues: Utility (ref)
            Utility:CreateSound("rbxassetid://14767954026", 1 * p11, 1.4 + 0.2 * math.random(), p10, true, 10, p12, p12);
            Utility:CreateSound("rbxassetid://17640978498", 0.15 * p11, 1.25 + 0.25 * math.random(), p10, true, 10, p12, p12);
        end,

        Template = p7.ViewModel:GetTracerTemplate(),

        InitCallback = function(p13, p14) -- Line: 50, Name: InitCallback
            -- upvalues: u9 (copy)
            for _, descendant in pairs(p13:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Width1 = p14 == 1 and 0 or descendant.Width1;
                    u9[descendant] = {
                        IsBeam = true,
                        Width0 = descendant.Width0,
                        Width1 = descendant.Width1
                    };
                elseif descendant:IsA("Light") then
                    u9[descendant] = {
                        IsLight = true,
                        Brightness = descendant.Brightness
                    };
                end;
            end;
        end,

        CustomUpdate = function(p15, p16, p17, p18, p19, p20) -- Line: 60, Name: CustomUpdate
            -- upvalues: u9 (copy)
            p17.WorldPosition = p19;
            p16.WorldPosition = p20;
            local v21 = 1 - p18 ^ 3;

            for i, v in pairs(u9) do
                if v.IsBeam then
                    i.Width0 = v.Width0 * v21;
                    i.Width1 = v.Width1 * v21;
                elseif v.IsLight then
                    i.Brightness = v.Brightness * v21;
                end;
            end;
        end
    };
    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v22.Template), p7:GetWrap(), true);

    return Gun._Tracers(p7, p8, v22);
end;

function u1._Init(p23) -- Line: 83
end;

return u1;