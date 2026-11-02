-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local UDim2_new_ret = UDim2.new(0.5, 0, 0.125, 30);
local UDim2_new_ret2 = UDim2.new(0.175, 58, 0.07, 20);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("Top"):WaitForChild("RoundResult");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.OutlineFrame = v3.Container:WaitForChild("Outline");
    v3.OutlineUIStroke = v3.OutlineFrame:WaitForChild("UIStroke");
    v3.ShineFrame = v3.Container:WaitForChild("Shine"):WaitForChild("Frame");
    v3.Background = v3.Container:WaitForChild("Background");
    v3.BackgroundTitle = v3.Background:WaitForChild("Title");
    v3.BackgroundStatus = v3.Background:WaitForChild("Status");
    v3.Background2 = v3.Container:WaitForChild("Background2");
    v3._destroyed = false;
    v3._round_result_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.Play(u4, p5) -- Line: 39
    -- upvalues: UDim2_new_ret2 (copy), UDim2_new_ret (copy), DuelLibrary (copy), Utility (copy)
    u4._round_result_hash = u4._round_result_hash + 1;
    local _round_result_hash = u4._round_result_hash;
    local v6 = p5 == nil and "Tie" or (u4.DuelInterface.ClientDuel.LocalDueler and (u4.DuelInterface.ClientDuel.LocalDueler and p5 == u4.DuelInterface.ClientDuel.LocalDueler:Get("TeamID") and "Win" or "Lose") or "Win");
    u4.Frame.Size = UDim2_new_ret2;
    u4.Frame.Position = UDim2_new_ret;
    u4.OutlineFrame.Size = UDim2.new(1, 0, 1, 0);
    u4.OutlineUIStroke.Thickness = 0;
    u4.ShineFrame.Position = UDim2.new(-0.5, 0, 0.5, 0);
    u4.BackgroundTitle.TextTransparency = 0;
    u4.BackgroundStatus.TextTransparency = 0;
    u4.BackgroundTitle.Text = (u4.DuelInterface.ClientDuel.LocalDueler or not p5) and "ROUND" or DuelLibrary.TeamsByID[p5].TeamName;
    local v7;

    if u4.DuelInterface.ClientDuel.LocalDueler then
        v7 = v6 == "Win" and "WON" or (v6 == "Lose" and "LOST" or "DRAW");
    else
        v7 = p5 and "WON" or "DRAW";
    end;

    u4.BackgroundStatus.Text = v7;
    local Background2 = u4.Background2;
    local v8;

    if u4.DuelInterface.ClientDuel.LocalDueler then
        v8 = v6 == "Win" and Color3.fromRGB(67, 214, 59) or (v6 == "Lose" and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(150, 150, 150));
    else
        v8 = DuelLibrary:GetTeamColor(p5);
    end;

    Background2.ImageColor3 = v8;
    u4.Background2.ImageTransparency = 0;
    u4.Frame.Visible = true;
    u4.DuelInterface:CreateSound(v6 == "Win" and "rbxassetid://16810041280" or (v6 == "Lose" and "rbxassetid://16810321565" or "rbxassetid://16810087814"), 1.5, 1, script, true, 5);

    if v6 ~= "Win" then
        if v6 ~= "Lose" then
            if v6 == "Tie" then
                Utility:RenderstepForLoop(0, 100, 2, function(p9) -- Line: 191
                    -- upvalues: u4 (copy), _round_result_hash (copy)
                    if u4._round_result_hash ~= _round_result_hash then
                        return true;
                    end;

                    local v10 = 1 - (1 - p9 / 100) ^ 4;
                    u4.BackgroundTitle.TextTransparency = 1 - v10;
                    u4.BackgroundStatus.TextTransparency = 1 - v10;
                    u4.Background2.ImageTransparency = 1 - v10;
                end);
                wait(3);

                if u4._round_result_hash ~= _round_result_hash then
                    return;
                end;

                Utility:RenderstepForLoop(0, 100, 2, function(p11) -- Line: 209
                    -- upvalues: u4 (copy), _round_result_hash (copy)
                    if u4._round_result_hash ~= _round_result_hash then
                        return true;
                    end;

                    local v12 = (p11 / 100) ^ 4;
                    u4.BackgroundTitle.TextTransparency = v12;
                    u4.BackgroundStatus.TextTransparency = v12;
                    u4.Background2.ImageTransparency = v12;
                end);

                if u4._round_result_hash ~= _round_result_hash then
                    return;
                end;

                u4.Frame.Visible = false;
            end;

            return;
        end;

        Utility:RenderstepForLoop(0, 100, 2, function(p13) -- Line: 153
            -- upvalues: u4 (copy), _round_result_hash (copy), UDim2_new_ret (ref)
            if u4._round_result_hash ~= _round_result_hash then
                return true;
            end;

            local v14 = 1 - (1 - p13 / 100) ^ 2;
            local v15 = 20 * (1 - (p13 / 100) ^ 2);
            u4.Frame.Position = UDim2_new_ret + UDim2.new(0, v15 * math.random(), -0.025 * (1 - v14), 30 + v15 * 0.25 * math.random());
            u4.BackgroundTitle.TextTransparency = 1 - v14;
            u4.BackgroundStatus.TextTransparency = 1 - v14;
            u4.Background2.ImageTransparency = 1 - v14;
        end);
        wait(3);

        if u4._round_result_hash ~= _round_result_hash then
            return;
        end;

        Utility:RenderstepForLoop(0, 100, 1, function(p16) -- Line: 173
            -- upvalues: u4 (copy), _round_result_hash (copy)
            if u4._round_result_hash ~= _round_result_hash then
                return true;
            end;

            local v17 = (p16 / 100) ^ 4;
            u4.BackgroundTitle.TextTransparency = v17;
            u4.BackgroundStatus.TextTransparency = v17;
            u4.Background2.ImageTransparency = v17;
        end);

        if u4._round_result_hash ~= _round_result_hash then
            return;
        end;

        u4.Frame.Visible = false;

        return;
    end;

    u4.Frame.Size = UDim2.new();
    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 4, function(p18) -- Line: 65
        -- upvalues: u4 (copy), _round_result_hash (copy), UDim2_new_ret (ref)
        if u4._round_result_hash ~= _round_result_hash then
            return true;
        end;

        u4.Frame.Position = UDim2_new_ret + UDim2.new(0, 0, 0.15 * (1 - (1 + 2.70158 * (p18 / 100 - 1) ^ 3 + 1.70158 * (p18 / 100 - 1) ^ 2)), 0);
    end);
    Utility:RenderstepForLoop(0, 100, 4, function(p19) -- Line: 75
        -- upvalues: u4 (copy), _round_result_hash (copy), UDim2_new_ret2 (ref)
        if u4._round_result_hash ~= _round_result_hash then
            return true;
        end;

        local v20 = p19 / 100;
        u4.Frame.Size = UDim2.new(UDim2_new_ret2.X.Scale * v20, UDim2_new_ret2.X.Offset * v20, UDim2_new_ret2.Y.Scale * v20, UDim2_new_ret2.Y.Offset * v20);
    end);

    if u4._round_result_hash ~= _round_result_hash then
        return;
    end;

    Utility:RenderstepForLoop(0, 100, 5, function(p21) -- Line: 89
        -- upvalues: u4 (copy), _round_result_hash (copy)
        if u4._round_result_hash ~= _round_result_hash then
            return true;
        end;

        u4.OutlineUIStroke.Thickness = 12 * (1 - (1 - p21 / 100) ^ 4);
    end);

    if u4._round_result_hash ~= _round_result_hash then
        return;
    end;

    Utility:RenderstepForLoop(0, 100, 2, function(p22) -- Line: 103
        -- upvalues: u4 (copy), _round_result_hash (copy)
        if u4._round_result_hash ~= _round_result_hash then
            return true;
        end;

        local v23 = 1 - (1 - p22 / 100) ^ 4;
        local v24 = 12 * (1 - v23);
        u4.OutlineUIStroke.Thickness = v24 < 0.5 and 0 or v24;
        u4.OutlineFrame.Size = UDim2.new(1, 12 * v23 * 1.5, 1, 12 * v23 * 1.5);
    end);

    if u4._round_result_hash ~= _round_result_hash then
        return;
    end;

    Utility:RenderstepForLoop(0, 100, 2, function(p25) -- Line: 119
        -- upvalues: u4 (copy), _round_result_hash (copy)
        if u4._round_result_hash ~= _round_result_hash then
            return true;
        end;

        u4.ShineFrame.Position = UDim2.new(-0.5 + 2 * (1 - (1 - p25 / 100) ^ 2), 0, 0.5, 0);
    end);
    wait(2);

    if u4._round_result_hash ~= _round_result_hash then
        return;
    end;

    Utility:RenderstepForLoop(0, 100, 2, function(p26) -- Line: 135
        -- upvalues: u4 (copy), _round_result_hash (copy)
        if u4._round_result_hash ~= _round_result_hash then
            return true;
        end;

        local v27 = (p26 / 100) ^ 4;
        u4.BackgroundTitle.TextTransparency = v27;
        u4.BackgroundStatus.TextTransparency = v27;
        u4.Background2.ImageTransparency = v27;
    end);

    if u4._round_result_hash ~= _round_result_hash then
        return;
    end;

    u4.Frame.Visible = false;
end;

function u1.UpdateVisibility(p28) -- Line: 229
    local Container = p28.Container;
    local v29 = not (p28.DuelInterface:IsPageOpen() or p28.DuelInterface.Scoreboard:IsOpen()) and not p28.DuelInterface.Voting:IsOpen();
    Container.Visible = v29;
end;

function u1.Destroy(p30) -- Line: 233
    p30._destroyed = true;
    p30._round_result_hash = p30._round_result_hash + 1;
end;

function u1._Init(u31) -- Line: 242
    u31.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 243
        -- upvalues: u31 (copy)
        u31:UpdateVisibility();
    end);
    u31.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 247
        -- upvalues: u31 (copy)
        u31:UpdateVisibility();
    end);
end;

return u1;