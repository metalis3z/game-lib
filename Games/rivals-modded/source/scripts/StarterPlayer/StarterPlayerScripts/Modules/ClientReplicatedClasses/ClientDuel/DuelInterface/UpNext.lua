-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local EliminatedEffect = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.EliminatedEffect);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("UpNext");
    v3.Container = v3.Frame:WaitForChild("Container"):WaitForChild("SpectateBuffer"):WaitForChild("Container");
    v3.Background = v3.Container:WaitForChild("Background");
    v3.Title = v3.Container:WaitForChild("Title");
    v3:_Init();

    return v3;
end;

function u1.Update(p4) -- Line: 29
    -- upvalues: EliminatedEffect (copy), Pages (copy), DuelLibrary (copy)
    local v5 = not (p4.DuelInterface.Scoreboard:IsOpen() or p4.DuelInterface.Voting:IsOpen() or (EliminatedEffect:IsVisible() or Pages.PageSystem.CurrentPage)) and p4.DuelInterface.ClientDuel:Get("Status") == "RoundStarted";
    local v6 = p4.DuelInterface.ClientDuel.LocalDueler and p4.DuelInterface.ClientDuel.LocalDueler:GetStaggeredSpawnsTurn();

    if v6 then
        v6 = v6 <= 1;
    end;

    local v7 = p4.DuelInterface.ClientDuel:Get("PlaySourceName");

    if v7 then
        if DuelLibrary.PlaySources[v7].DuelLogic == "Zombie Tower" then
            v7 = p4.DuelInterface.ClientDuel.LocalDueler and p4.DuelInterface.ClientDuel.LocalDueler.ClientFighter and not p4.DuelInterface.ClientDuel.LocalDueler.ClientFighter:IsAlive();
        else
            v7 = false;
        end;
    end;

    p4.Frame.Visible = v5 and (v6 or v7);
    p4.Title.Text = v6 and "You\'re up next!" or (v7 and "Waiting to be revived by a Revive Drop" or "");
end;

function u1.Destroy(p8) -- Line: 45
end;

function u1._UpdateBackground(p9) -- Line: 53
    p9.Background.Size = UDim2.new(0, p9.Title.TextBounds.X + p9.Container.AbsoluteSize.Y * 0.6, 1, 0);
end;

function u1._Init(u10) -- Line: 57
    u10.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 58
        -- upvalues: u10 (copy)
        u10:Update();
    end);
    u10.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 62
        -- upvalues: u10 (copy)
        u10:Update();
    end);
    u10.Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 66
        -- upvalues: u10 (copy)
        u10:_UpdateBackground();
    end);
    u10.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 70
        -- upvalues: u10 (copy)
        u10:_UpdateBackground();
    end);
    u10:_UpdateBackground();
end;

return u1;