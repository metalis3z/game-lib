-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SoundLibrary = require(ReplicatedStorage.Modules.SoundLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local EliminationSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EliminationSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 18
    -- upvalues: u1 (copy), UILibrary (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3.Frame = v3.FighterInterface.Frame:WaitForChild("EliminationSlots");
    v3._destroyed = false;
    v3._connections = {};
    v3._reference_frame = UILibrary:GetTo("MainFrame", "BottomStack", "EliminationSlots");
    v3._elimination_queue = {};
    v3._elimination_queue_playing = false;
    v3._elimination_chain = 0;
    v3:_Init();

    return v3;
end;

function u1.SetVisible(p4, p5) -- Line: 40
    p4.Frame.Visible = p5;
end;

function u1.Refresh(p6) -- Line: 44
    p6.Frame.Position = UDim2.new(0.5, 0, 0, p6._reference_frame.AbsolutePosition.Y);
end;

function u1.Clear(p7) -- Line: 48
    p7._elimination_chain = 0;
end;

function u1.Create(u8, ...) -- Line: 52
    -- upvalues: Players (copy), SoundLibrary (copy), DuelLibrary (copy), ComplianceController (copy), EliminationSlot (copy), BetterDebris (copy), Utility (copy)
    if not u8.FighterInterface:IsActive() then
        return;
    end;

    table.insert(u8._elimination_queue, { ... });

    if u8._elimination_queue_playing then
        return;
    end;

    u8._elimination_queue_playing = true;

    while #u8._elimination_queue > 0 do
        local table_unpack_ret, v9 = table.unpack(table.remove(u8._elimination_queue, 1));

        if table_unpack_ret ~= Players.LocalPlayer then
            u8._elimination_chain = u8._elimination_chain + 1;
            local math_clamp_ret = math.clamp(u8._elimination_chain - 3, 0, 10);
            u8.FighterInterface:CreateSound(SoundLibrary.EliminationSounds[math.min(u8._elimination_chain, 3)], math_clamp_ret * 0.25 + 2, math_clamp_ret * 0.1 + 1, script, true, 10);
            local TeamColor = DuelLibrary:GetTeamColor(u8.FighterInterface.ClientFighter:Get("TeamID"));
            local string_format_ret = string.format("%s,%s,%s", string.format("%.0f", TeamColor.R * 255), string.format("%.0f", TeamColor.G * 255), string.format("%.0f", TeamColor.B * 255));
            local Name = ComplianceController:GetName(u8.FighterInterface.ClientFighter.Player);
            local v10 = not u8.FighterInterface.ClientFighter.IsLocalPlayer and string.format("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"3\" transparency=\"0\"><font color=\"rgb(%s)\"><font weight=\"800\">%s</font></font></stroke>  ", string_format_ret, Name);
            local v11 = v9 and "Assist" or "Eliminated";
            local TeamColor2 = DuelLibrary:GetTeamColor(table_unpack_ret:GetAttribute("TeamID"));
            local string_format_ret2 = string.format("%s,%s,%s", string.format("%.0f", TeamColor2.R * 255), string.format("%.0f", TeamColor2.G * 255), string.format("%.0f", TeamColor2.B * 255));
            local Name2 = ComplianceController:GetName(table_unpack_ret);
            local string_format = string.format;

            if v10 then
                v11 = string.lower(v11) or v11;
            end;

            local v12 = string_format("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"1\" transparency=\"0.75\"><font weight=\"500\">%s  </font></stroke><stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"3\" transparency=\"0\"><font color=\"rgb(%s)\"><font weight=\"800\">%s</font></font></stroke>", v11, string_format_ret2, Name2);
            local u13 = EliminationSlot:Clone();
            u13.LayoutOrder = u8._elimination_chain;
            u13.TextLabel.Text = (v10 or "") .. v12;
            u13.Size = UDim2.new(1, 0, 0, 0);
            u13.Parent = u8.Frame;
            BetterDebris:AddItem(u13, 5);
            u13:TweenSize(UDim2.new(1, 0, v10 and 0.75 or 1, 6), "Out", "Back", 0.25, true, function() -- Line: 95
                -- upvalues: u8 (copy), u13 (copy), Players (ref), Utility (ref)
                wait(3);

                if u8._destroyed or not u13:IsDescendantOf(Players.LocalPlayer) then
                    return;
                end;

                u13:TweenSize(UDim2.new(1, 0, 0, 0), "In", "Quint", 0.5, true);
                Utility:RenderstepForLoop(0, 100, 10, function(p14) -- Line: 104
                    -- upvalues: u13 (ref)
                    u13.GroupTransparency = p14 / 100;
                end);
                u13:Destroy();

                if #u8.Frame:GetChildren() == 1 then
                    u8:Clear();
                end;
            end);
            wait(0.04);
        end;
    end;

    u8._elimination_queue_playing = false;
end;

function u1.Destroy(p15) -- Line: 121
    p15._destroyed = true;

    for _, v in pairs(p15._connections) do
        v:Disconnect();
    end;

    p15._connections = {};
end;

function u1._Init(u16) -- Line: 135
    local _connections = u16._connections;
    local PropertyChangedSignal = u16._reference_frame:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(_connections, PropertyChangedSignal:Connect(function() -- Line: 136
        -- upvalues: u16 (copy)
        u16:Refresh();
    end));
end;

return u1;