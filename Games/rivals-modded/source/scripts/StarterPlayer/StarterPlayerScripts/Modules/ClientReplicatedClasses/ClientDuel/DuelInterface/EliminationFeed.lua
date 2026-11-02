-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local Inset = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Inset);
local EliminationFeedSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EliminationFeedSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 17
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("EliminationFeed");
    v3.List = v3.Frame:WaitForChild("List");
    v3._destroyed = false;
    v3._connections = {};
    v3:_Init();

    return v3;
end;

function u1.PlayRaw(u4, p5) -- Line: 36
    -- upvalues: DuelLibrary (copy), ItemLibrary (copy), EliminationFeedSlot (copy), BetterDebris (copy), Players (copy)
    local u6 = p5 or {};
    u6.State = u6.State or "Default";
    u6.VictimText = u6.VictimText or "???";
    u6.VictimTeamColor = u6.VictimTeamColor or DuelLibrary.EMPTY_TEAM_COLOR;
    u6.EliminatorText = u6.EliminatorText or "???";
    u6.EliminatorTeamColor = u6.EliminatorTeamColor or DuelLibrary.EMPTY_TEAM_COLOR;
    u6.ViewModelName = u6.ViewModelName or nil;
    u6.IsCritical = u6.IsCritical or false;
    u6.IsBlinded = u6.IsBlinded or false;
    u6.IsNoscope = u6.IsNoscope or false;
    local v7 = u6.ViewModelName and ItemLibrary.ViewModels[u6.ViewModelName];
    local v8 = v7 and (v7.EliminationFeedImage or "rbxassetid://91284037292220") or "rbxassetid://91284037292220";
    local v9 = v7 and v7.EliminationFeedImageScale or 1.5;
    local u10 = EliminationFeedSlot:Clone();
    u10.Container.Container.Eliminator.TextLabel.Text = u6.EliminatorText or "";
    u10.Container.Container.Eliminator.Visible = u10.Container.Container.Eliminator.TextLabel.Text ~= "";
    u10.Container.Container.Victim.TextLabel.Text = u6.VictimText or "???";
    u10.Container.Container.Weapon.ImageLabel.Image = v8;
    u10.Container.Container.Weapon.Size = UDim2.new(v9, 0, 1, 0);
    u10.Container.Container.Critical.Visible = u6.IsCritical;
    u10.Container.Container.Blinded.Visible = u6.IsBlinded;
    u10.Container.Container.Noscope.Visible = u6.IsNoscope;
    u10.Container.Background.Outline.Visible = u6.State == "LocalElimination";
    u10.Container.Background.Background.ImageColor3 = u6.State == "LocalDeath" and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255);
    u10.Parent = u4.List;
    BetterDebris:AddItem(u10, 10);
    local ImageLabel = u10.Container.Container.Weapon.ImageLabel;
    local u11 = false;

    local function update() -- Line: 71
        -- upvalues: u4 (copy), u11 (ref), u10 (copy), ImageLabel (copy), u6 (copy)
        if u4._destroyed then
            return;
        end;

        if u11 then
            return;
        end;

        u11 = true;
        task.defer(function() -- Line: 82
            -- upvalues: u4 (ref), u11 (ref), u10 (ref), ImageLabel (ref), u6 (ref)
            if u4._destroyed then
                return;
            end;

            u11 = false;
            u10.Container.Container.Eliminator.Size = UDim2.new(0, u10.Container.Container.Eliminator.TextLabel.TextBounds.X, 0.625, 0);
            u10.Container.Container.Victim.Size = UDim2.new(0, u10.Container.Container.Victim.TextLabel.TextBounds.X, 0.625, 0);
            u10.Size = UDim2.new(0, u10.Container.Container.Layout.AbsoluteContentSize.X, u10.Size.Y.Scale, 0);
            local math_clamp_ret = math.clamp((ImageLabel.AbsolutePosition.X + ImageLabel.AbsoluteSize.X / 2 - u10.AbsolutePosition.X) / u10.AbsoluteSize.X, 0.001, 0.999);
            u10.Container.Background.Background.UIGradient.Color = u6.State == "LocalDeath" and ColorSequence.new(Color3.fromRGB(255, 255, 255)) or ColorSequence.new({ ColorSequenceKeypoint.new(0, u6.EliminatorTeamColor), ColorSequenceKeypoint.new(math_clamp_ret, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, u6.VictimTeamColor) });
            u10.Container.Background.Background.UIGradient.Transparency = u6.State == "LocalDeath" and NumberSequence.new(0) or NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(math_clamp_ret, 0.25), NumberSequenceKeypoint.new(1, 0) });
        end);
    end;

    u10:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
    ImageLabel:GetPropertyChangedSignal("AbsolutePosition"):Connect(update);
    ImageLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
    u10.Container.Container.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update);
    u10.Container.Container.Eliminator.TextLabel:GetPropertyChangedSignal("TextBounds"):Connect(update);
    u10.Container.Container.Victim.TextLabel:GetPropertyChangedSignal("TextBounds"):Connect(update);

    if not (u4._destroyed or u11) then
        u11 = true;
        task.defer(function() -- Line: 82
            -- upvalues: u4 (copy), u11 (ref), u10 (copy), ImageLabel (copy), u6 (copy)
            if u4._destroyed then
                return;
            end;

            u11 = false;
            u10.Container.Container.Eliminator.Size = UDim2.new(0, u10.Container.Container.Eliminator.TextLabel.TextBounds.X, 0.625, 0);
            u10.Container.Container.Victim.Size = UDim2.new(0, u10.Container.Container.Victim.TextLabel.TextBounds.X, 0.625, 0);
            u10.Size = UDim2.new(0, u10.Container.Container.Layout.AbsoluteContentSize.X, u10.Size.Y.Scale, 0);
            local math_clamp_ret = math.clamp((ImageLabel.AbsolutePosition.X + ImageLabel.AbsoluteSize.X / 2 - u10.AbsolutePosition.X) / u10.AbsoluteSize.X, 0.001, 0.999);
            u10.Container.Background.Background.UIGradient.Color = u6.State == "LocalDeath" and ColorSequence.new(Color3.fromRGB(255, 255, 255)) or ColorSequence.new({ ColorSequenceKeypoint.new(0, u6.EliminatorTeamColor), ColorSequenceKeypoint.new(math_clamp_ret, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, u6.VictimTeamColor) });
            u10.Container.Background.Background.UIGradient.Transparency = u6.State == "LocalDeath" and NumberSequence.new(0) or NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(math_clamp_ret, 0.25), NumberSequenceKeypoint.new(1, 0) });
        end);
    end;

    if u10:IsDescendantOf(Players.LocalPlayer) then
        u10.Container.Position = UDim2.new(1, 20, 0, 0);
        u10.Container:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 0.25, true);
    end;

    task.delay(7, pcall, u10.Container.TweenPosition, u10.Container, UDim2.new(1, 20, 0, 0), "In", "Quint", 0.25, true, function() -- Line: 124
        -- upvalues: u4 (copy), u10 (copy)
        if u4._destroyed then
            return;
        end;

        u10:TweenSize(UDim2.new(), "Out", "Quint", 0.25, true, function() -- Line: 129
            -- upvalues: u4 (ref), u10 (ref)
            if u4._destroyed then
                return;
            end;

            u10:Destroy();
        end);
    end);
end;

function u1.Play(p12, p13, p14, p15, p16, p17, p18, p19) -- Line: 139
    -- upvalues: Players (copy), ComplianceController (copy), DuelLibrary (copy)
    local v20 = {
        State = p13 == Players.LocalPlayer and "LocalDeath" or ((p14 == Players.LocalPlayer or p15 == Players.LocalPlayer) and "LocalElimination" or "Default")
    };
    local v21;

    if p13 then
        v21 = ComplianceController:GetName(p13);
    else
        v21 = p13;
    end;

    v20.VictimText = v21;
    v20.VictimTeamColor = DuelLibrary:GetTeamColor(p13:GetAttribute("TeamID"));
    v20.EliminatorText = (p14 and p14 ~= p13 and (ComplianceController:GetName(p14) or "") or "") .. (p15 and (p15 ~= p14 and p15 ~= p13) and (" + " .. ComplianceController:GetName(p15) or "") or "");
    v20.EliminatorTeamColor = DuelLibrary:GetTeamColor(p14:GetAttribute("TeamID"));
    v20.ViewModelName = p16;
    v20.IsCritical = p17;
    v20.IsBlinded = p18;
    v20.IsNoscope = p19;
    p12:PlayRaw(v20);
end;

function u1.Update(p22) -- Line: 154
    local Frame = p22.Frame;
    local v23 = not p22.DuelInterface:IsPageOpen() and not p22.DuelInterface.FinalResults:IsActive();
    Frame.Visible = v23;
end;

function u1.UpdatePosition(p24) -- Line: 158
    -- upvalues: Inset (copy)
    p24.Frame.Position = UDim2.new(1, 0, 0, Inset.MainFrame.AbsoluteSize.Y);
end;

function u1.Destroy(p25) -- Line: 162
    p25._destroyed = true;

    for _, v in pairs(p25._connections) do
        v:Disconnect();
    end;

    p25._connections = {};
end;

function u1._Debug(p26) -- Line: 176
end;

function u1._UpdatePosition(p27) -- Line: 203
end;

function u1._Init(u28) -- Line: 206
    u28.DuelInterface.FinalResults.Activated:Connect(function() -- Line: 207
        -- upvalues: u28 (copy)
        u28:Update();
    end);
    u28:UpdatePosition();
    task.defer(u28._Debug, u28);
end;

return u1;