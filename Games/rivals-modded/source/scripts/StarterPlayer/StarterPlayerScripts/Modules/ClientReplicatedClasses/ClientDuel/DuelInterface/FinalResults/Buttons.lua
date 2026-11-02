-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local PartyController = require(Players.LocalPlayer.PlayerScripts.Controllers.PartyController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local u1 = {
    HoverRatio = UDim2.new(0, 10, 0, 10),
    ReleaseRatio = UDim2.new(0, 10, 0, 10)
};
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 15
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.FinalResults = p3;
    v4.Frame = v4.FinalResults.Frame:WaitForChild("Buttons");
    v4.BottomRightFrame = v4.Frame:WaitForChild("BottomRight");
    v4.BottomRightContainer = v4.BottomRightFrame:WaitForChild("Container");
    v4.ContinueFrame = v4.BottomRightContainer:WaitForChild("Continue");
    v4.ContinueButton = v4.ContinueFrame:WaitForChild("Button");
    v4.PlayAgainFrame = v4.BottomRightContainer:WaitForChild("PlayAgain");
    v4.PlayAgainButton = v4.PlayAgainFrame:WaitForChild("Button");
    v4.LeaveFrame = v4.BottomRightContainer:WaitForChild("Leave");
    v4.LeaveButton = v4.LeaveFrame:WaitForChild("Button");
    v4.LeaveButtonTitle = v4.LeaveButton:WaitForChild("Title");
    v4.LeaveButtonTitleStroke = v4.LeaveButtonTitle:WaitForChild("UIStroke");
    v4.LeaveButtonShine = v4.LeaveButton:WaitForChild("Shine");
    v4.LeaveButtonOutlineUIStroke = v4.LeaveButton:WaitForChild("Outline"):WaitForChild("UIStroke");
    v4.RematchFrame = v4.BottomRightContainer:WaitForChild("Rematch");
    v4.RematchButton = v4.RematchFrame:WaitForChild("Button");
    v4.RematchButtonTitle = v4.RematchButton:WaitForChild("Title");
    v4.RematchButtonTitleStroke = v4.RematchButtonTitle:WaitForChild("UIStroke");
    v4.RematchButtonCount = v4.RematchButton:WaitForChild("Count");
    v4.RematchButtonCountStroke = v4.RematchButtonCount:WaitForChild("UIStroke");
    v4.RematchButtonShine = v4.RematchButton:WaitForChild("Shine");
    v4.RematchButtonOutlineUIStroke = v4.RematchButton:WaitForChild("Outline"):WaitForChild("UIStroke");
    v4.BottomLeftFrame = v4.Frame:WaitForChild("BottomLeft");
    v4.BottomLeftContainer = v4.BottomLeftFrame:WaitForChild("Container");
    v4.BackFrame = v4.BottomLeftContainer:WaitForChild("Back");
    v4.BackButton = v4.BackFrame:WaitForChild("Button");
    v4._destroyed = false;
    v4:_Init();

    return v4;
end;

function u2.LeaveRequest(p5) -- Line: 56
    -- upvalues: ReplicatedStorage (copy), SpectateController (copy)
    if not p5.FinalResults.Winners:IsFinished() then
        p5.FinalResults.Winners:Skip();

        return;
    end;

    if p5.FinalResults.DuelInterface.ClientDuel.LocalDueler then
        ReplicatedStorage.Remotes.Duels.LeaveDuel:FireServer();

        return;
    end;

    SpectateController:Exit();
end;

function u2.Rematch(p6) -- Line: 69
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Duels.Rematch:FireServer();
end;

function u2.PlayAgain(p7) -- Line: 73
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Matchmaking.PlayAgain:FireServer();
end;

function u2.Continue(p8) -- Line: 77
    p8.FinalResults:SetPage("Summary");
end;

function u2.Update(p9) -- Line: 81
    p9:_UpdateRematchButton();
end;

function u2.Destroy(p10) -- Line: 85
    p10._destroyed = true;
end;

function u2._UpdateRematchButton(p11) -- Line: 93
    local v12 = p11.FinalResults.DuelInterface.ClientDuel:Get("RematchCount");
    local v13 = p11.FinalResults.DuelInterface.ClientDuel:Get("RematchGoal");
    local v14 = p11.FinalResults.DuelInterface.ClientDuel:Get("RematchSuccess");
    local v15;

    if v14 then
        v15 = v14;
    elseif v12 then
        if v13 then
            v15 = p11.FinalResults.DuelInterface.ClientDuel:Get("RematchAvailable");
        else
            v15 = v13;
        end;
    else
        v15 = v12;
    end;

    local v16 = v15 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    local v17 = v15 and 0 or 0.75;
    p11.RematchButtonOutlineUIStroke.Color = v16;
    p11.RematchButtonShine.ImageColor3 = v16;
    p11.RematchButtonTitle.TextColor3 = v16;
    p11.RematchButtonCount.TextColor3 = v16;
    p11.RematchButtonOutlineUIStroke.Transparency = v17;
    p11.RematchButtonShine.ImageTransparency = v17;
    p11.RematchButtonTitle.TextTransparency = v17;
    p11.RematchButtonCount.TextTransparency = v17;
    p11.RematchButtonCount.Text = v14 and "• • •" or (v15 and v12 .. " / " .. v13 or "Unavailable");
    p11.RematchButtonCount.FontFace = v15 and Font.fromId(12187365977, Enum.FontWeight.Heavy) or Font.fromId(12187365977, Enum.FontWeight.Medium);
    p11.RematchButtonTitleStroke.Enabled = v15;
    p11.RematchButtonCountStroke.Enabled = v15;
end;

function u2._UpdateButtonStates(p18) -- Line: 119
    -- upvalues: CONSTANTS (copy), PartyController (copy)
    local v19 = p18.FinalResults:IsActive();
    local v20 = p18.FinalResults.Winners:IsFinished();
    local CurrentPage = p18.FinalResults.CurrentPage;
    local v21 = p18.FinalResults.DuelInterface.ClientDuel.LocalDueler ~= nil;
    local ContinueFrame = p18.ContinueFrame;
    local v22;

    if v19 then
        if v20 then
            if CurrentPage == "Winners" then
                v22 = p18.FinalResults.Summary:HasDetailsReady();
            else
                v22 = false;
            end;
        else
            v22 = v20;
        end;
    else
        v22 = v19;
    end;

    ContinueFrame.Visible = v22;
    local v23 = v21 and not p18.ContinueFrame.Visible;

    if v23 then
        if v19 then
            v23 = v20;
        else
            v23 = v19;
        end;
    end;

    p18.RematchFrame.Visible = v23;
    local PlayAgainFrame = p18.PlayAgainFrame;
    local v24 = v21 and (not p18.ContinueFrame.Visible and (v19 and (v20 and CONSTANTS.IS_MATCHMAKING_SERVER))) and PartyController:IsPartyLeader();
    PlayAgainFrame.Visible = v24;
    p18.LeaveFrame.Visible = not p18.ContinueFrame.Visible and v19;

    if v19 then
        if v20 then
            v19 = CurrentPage == "Summary";
        else
            v19 = v20;
        end;
    end;

    p18.BackButton.Visible = v19;
    local v25 = v20 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    local v26 = v20 and 0 or 0.75;
    p18.LeaveButtonTitle.Text = v20 and "Leave" or "Skip";
    p18.LeaveButtonTitle.TextColor3 = v25;
    p18.LeaveButtonShine.ImageColor3 = v25;
    p18.LeaveButtonOutlineUIStroke.Color = v25;
    p18.LeaveButtonTitle.TextTransparency = v26;
    p18.LeaveButtonShine.ImageTransparency = v26;
    p18.LeaveButtonOutlineUIStroke.Transparency = v26;
    p18.LeaveButtonTitleStroke.Enabled = v20;
end;

function u2._Init(u27) -- Line: 145
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy), u1 (copy)
    u27.LeaveButton.MouseButton1Click:Connect(function() -- Line: 146
        -- upvalues: u27 (copy)
        u27:LeaveRequest();
    end);
    u27.PlayAgainButton.MouseButton1Click:Connect(function() -- Line: 150
        -- upvalues: u27 (copy)
        u27:PlayAgain();
    end);
    u27.RematchButton.MouseButton1Click:Connect(function() -- Line: 154
        -- upvalues: u27 (copy)
        u27:Rematch();
    end);
    u27.ContinueButton.MouseButton1Click:Connect(function() -- Line: 158
        -- upvalues: u27 (copy)
        u27:Continue();
    end);
    u27.BackButton.MouseButton1Click:Connect(function() -- Line: 162
        -- upvalues: u27 (copy)
        u27.FinalResults:SetPage("Winners");
    end);
    u27.FinalResults.Activated:Connect(function() -- Line: 166
        -- upvalues: u27 (copy)
        u27:_UpdateButtonStates();
    end);
    u27.FinalResults.Winners.Finished:Connect(function() -- Line: 170
        -- upvalues: PlayerDataController (ref), u27 (copy)
        if PlayerDataController:GetSetting("Hide HUD") then
            u27:LeaveRequest();
        end;

        u27:_UpdateButtonStates();
    end);
    u27.FinalResults.PageChanged:Connect(function() -- Line: 178
        -- upvalues: u27 (copy)
        u27:_UpdateButtonStates();
    end);
    task.defer(u27._UpdateButtonStates, u27);
    task.defer(u27._UpdateRematchButton, u27);
    ButtonEffect:Add(u27.ContinueButton, nil, u1);
    ButtonEffect:Add(u27.LeaveButton, nil, u1);
    ButtonEffect:Add(u27.PlayAgainButton, nil, u1);
    ButtonEffect:Add(u27.RematchButton, nil, u1);
    ButtonEffect:Add(u27.BackButton, nil, u1);
end;

return u2;