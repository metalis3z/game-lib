-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local LootLibrary = require(ReplicatedStorage.Modules.LootLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Right = p2;
    v3.Frame = v3.Right.Container:WaitForChild("Level");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.BarFrame = v3.Container:WaitForChild("Bar");
    v3.BarFrameGoal = v3.BarFrame:WaitForChild("Goal");
    v3.BarFrameLevel = v3.BarFrame:WaitForChild("Level");
    v3.BarFrameProgress = v3.BarFrame:WaitForChild("Progress");
    v3.BarFrameContainer = v3.BarFrame:WaitForChild("Container");
    v3.BarFrameContainerBar = v3.BarFrameContainer:WaitForChild("Bar");
    v3.ComponentsFrame = v3.Container:WaitForChild("Components");
    v3.ComponentsLayout = v3.ComponentsFrame:WaitForChild("Layout");
    v3.NextRewardFrame = v3.ComponentsFrame:WaitForChild("NextReward");
    v3.NextRewardTitle = v3.NextRewardFrame:WaitForChild("Title");
    v3.NextRewardContainer = v3.NextRewardFrame:WaitForChild("Container");
    v3.LevelUpFrame = v3.ComponentsFrame:WaitForChild("LevelUp");
    v3.LevelUpDescription = v3.LevelUpFrame:WaitForChild("Description");
    v3.LevelUpButton = v3.LevelUpFrame:WaitForChild("Button");
    v3.LevelUpButtonPrice = v3.LevelUpButton:WaitForChild("Price");
    v3._cleanup = {};
    v3._double_clicked = false;
    v3:_Init();

    return v3;
end;

function u1.OnStateChanged(p4) -- Line: 49
    p4:_SetDoubleClicked(false);
    p4:_UpdateInformation();
end;

function u1._SetDoubleClicked(p5, p6) -- Line: 58
    p5._double_clicked = p6;
    p5.LevelUpDescription.Text = p6 and "Are you sure?" or "Level up now!";
end;

function u1._GetInformation(p7) -- Line: 63
    -- upvalues: PlayerDataController (copy), LootLibrary (copy)
    if p7.Right.Interface.Equipment:IsCareerPageOpen() then
        local v8 = PlayerDataController:Get("Level");
        local v9 = PlayerDataController:Get("XP");
        local CareerLevelsRewardData = LootLibrary:GetCareerLevelsRewardData();
        local v10 = (v8 + 1) / LootLibrary:GetCareerLevelsRewardMilestone();

        return v8, v9, CareerLevelsRewardData, math.ceil(v10) * LootLibrary:GetCareerLevelsRewardMilestone();
    end;

    local WeaponData = PlayerDataController:GetWeaponData((p7.Right.Interface.Equipment:GetSelectedWeapon()));

    if WeaponData then
        local Level = WeaponData.Level;
        local XP = WeaponData.XP;
        local NextWeaponLevelReward, v11 = LootLibrary:GetNextWeaponLevelReward(Level, WeaponData.Name);

        return Level, XP, NextWeaponLevelReward, v11;
    end;
end;

function u1._UpdateInformation(p12) -- Line: 87
    -- upvalues: LootLibrary (copy), CosmeticLibrary (copy), ComplianceController (copy), Utility (copy), RewardSlot (copy)
    for _, v in pairs(p12._cleanup) do
        v:Destroy();
    end;

    p12._cleanup = {};
    local v13, v14, v15, v16 = p12:_GetInformation();
    local v17 = v13 ~= nil;
    p12.Frame.Visible = v17;

    if not v17 then
        return;
    end;

    local v18 = p12.Right.Interface.Equipment:IsCareerPageOpen();
    local XPRequiredToLevelUp = LootLibrary:GetXPRequiredToLevelUp(v13);
    local v19;

    if v15 then
        if v16 then
            if v13 == v16 - 1 then
                v19 = CosmeticLibrary.Rewards[v15.Name];

                if v19 then
                    if CosmeticLibrary.Rewards[v15.Name].Type == "Lootbox" then
                        v19 = ComplianceController:ArePaidRandomItemsRestricted();
                    else
                        v19 = false;
                    end;
                end;
            else
                v19 = false;
            end;
        else
            v19 = v16;
        end;
    else
        v19 = v15;
    end;

    p12.BarFrameGoal.Text = XPRequiredToLevelUp <= v14 and "" or Utility:PrettyNumber(XPRequiredToLevelUp);
    p12.BarFrameProgress.Text = XPRequiredToLevelUp <= v14 and "" or Utility:PrettyNumber(v14);
    p12.BarFrameLevel.Text = XPRequiredToLevelUp <= v14 and "MAX" or Utility:PrettyNumber(v13);
    p12.BarFrameContainer.Size = UDim2.new(math.clamp(v14 / XPRequiredToLevelUp, 0, 1), 0, 1, 0);
    local v20 = not v18;

    if v20 then
        if v14 < XPRequiredToLevelUp then
            v20 = not v19;
        else
            v20 = false;
        end;
    end;

    p12.LevelUpFrame.Visible = v20;
    p12.LevelUpButtonPrice.Text = LootLibrary:GetCostToLevelUp(v13, v14);
    p12.NextRewardFrame.Visible = v15 ~= nil;
    p12.NextRewardTitle.Text = not v16 and "" or "Reward at Level " .. Utility:PrettyNumber(v16);

    if v15 then
        local v21 = RewardSlot.new(v15);
        v21:SetParent(p12.NextRewardContainer);
        table.insert(p12._cleanup, v21);
    end;
end;

function u1._Update(p22) -- Line: 124
    p22.Frame.Size = UDim2.new(1, 0, 0, (p22.ComponentsFrame.AbsolutePosition.Y - p22.Frame.AbsolutePosition.Y) * (p22.ComponentsLayout.AbsoluteContentSize.Y > 0 and 1.25 or 1) + p22.ComponentsLayout.AbsoluteContentSize.Y);
end;

function u1._Init(u23) -- Line: 130
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u23.ComponentsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 131
        -- upvalues: u23 (copy)
        u23:_Update();
    end);
    u23.LevelUpButton.MouseButton1Click:Connect(function() -- Line: 135
        -- upvalues: u23 (copy)
        if u23._double_clicked then
            u23.Right.Interface.Equipment:LevelUpWeapon();

            return;
        end;

        u23:_SetDoubleClicked(true);
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 144
        -- upvalues: u23 (copy)
        u23:_UpdateInformation();
    end);
    PlayerDataController:GetDataChangedSignal("Level"):Connect(function() -- Line: 148
        -- upvalues: u23 (copy)
        u23:_UpdateInformation();
    end);
    u23:_Update();
    ButtonEffect:Add(u23.LevelUpButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
end;

return u1;