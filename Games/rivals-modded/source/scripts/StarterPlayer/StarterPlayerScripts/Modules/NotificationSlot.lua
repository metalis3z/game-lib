-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local BountyLibrary = require(ReplicatedStorage.Modules.BountyLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local NotificationSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("NotificationSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5, p6) -- Line: 15
    -- upvalues: u1 (copy), NotificationSlot (copy)
    local v7 = setmetatable({}, u1);
    v7.Frame = NotificationSlot:Clone();
    v7._creation_time = p6 or tick();
    v7._title = p2 or "";
    v7._description = p3 or "";
    v7._first_icon = p4;
    v7._second_icon = p5;
    local v8;

    if typeof(v7._first_icon) == "table" then
        v8 = v7._first_icon;
    else
        v8 = false;
    end;

    v7._first_reward_info = v8;
    local v9;

    if typeof(v7._second_icon) == "table" then
        v9 = v7._second_icon;
    else
        v9 = false;
    end;

    v7._second_reward_info = v9;
    v7._cleanup = {};
    v7:_Init();

    return v7;
end;

function u1.SetParent(p10, p11) -- Line: 38
    p10.Frame.Parent = p11;
end;

function u1.PlaySound(p12, p13) -- Line: 42
    -- upvalues: Utility (copy), BountyLibrary (copy), CosmeticLibrary (copy)
    if p13 then
        Utility:CreateSound(p13, 1.5, 1, script, true, 5);

        return;
    end;

    if p12._second_reward_info and BountyLibrary.Rewards[p12._second_reward_info.Name] then
        Utility:CreateSound("rbxassetid://17770244373", 1.5, 1, script, true, 5);

        return;
    end;

    if p12._second_reward_info and (CosmeticLibrary.Rewards[p12._second_reward_info.Name] and CosmeticLibrary.Rewards[p12._second_reward_info.Name].Type == "Weapon") then
        Utility:CreateSound("rbxassetid://17769583566", 1.5, 1, script, true, 5);

        return;
    end;

    if p12._second_reward_info and CosmeticLibrary.Rewards[p12._second_reward_info.Name] then
        Utility:CreateSound("rbxassetid://17769583339", 1.5, 1, script, true, 5);

        return;
    end;

    if p12._second_reward_info and p12._second_reward_info.Weapon == "IsUniversal" then
        Utility:CreateSound("rbxassetid://17769583566", 1.5, 1, script, true, 5);

        return;
    end;

    if p12._second_reward_info then
        Utility:CreateSound("rbxassetid://17769583804", 1.5, 1, script, true, 5);

        return;
    end;

    Utility:CreateSound("rbxassetid://17769893181", 1.5, 1, script, true, 5);
end;

function u1.PlayGlow(u14) -- Line: 60
    -- upvalues: Utility (copy)
    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 1, function(p15) -- Line: 61
        -- upvalues: u14 (copy)
        u14.Frame.Visuals.Glow.ImageTransparency = p15 / 100;
    end);
end;

function u1.PlaySize(u16, p17, p18) -- Line: 68
    -- upvalues: Players (copy), Utility (copy)
    local u19 = p17 or 1;
    u16.Frame.Size = UDim2.new(1.1 * u19, 0, 1.1 * u19, 0);
    u16.Frame:TweenSize(UDim2.new(1 * u19, 0, 1 * u19, 0), "Out", "Back", 0.25, true);

    if p18 then
        task.delay(p18, function() -- Line: 75
            -- upvalues: Players (ref), u16 (copy), u19 (copy), Utility (ref)
            local Inset = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Inset);
            u16.Frame.Visuals.ClipsDescendants = true;
            u16.Frame:TweenSize(UDim2.new(0.13333333333333333 * u19, 0, 1 * u19, 0), "In", "Quint", 0.5, true, function() -- Line: 79
                -- upvalues: Inset (copy), Utility (ref), u16 (ref), u19 (ref)
                local NotificationGoal = Inset.MainBar:GetNotificationGoal();
                Utility:RenderstepForLoop(0, 100, 7.5, function(p20) -- Line: 82
                    -- upvalues: NotificationGoal (copy), u16 (ref), u19 (ref)
                    local v21 = p20 / 100;
                    local v22 = NotificationGoal.Frame.AbsolutePosition + NotificationGoal.Frame.AbsoluteSize / 2 - (u16.Frame.AbsolutePosition + u16.Frame.AbsoluteSize / 2);
                    u16.Frame.Size = UDim2.new(0.13333333333333333 * (1 - v21) * u19, 0, 1 * (1 - v21) * u19, 0);
                    u16.Frame.Visuals.Position = UDim2.new(0.5, v22.X * v21, 0.5, v22.Y * v21);
                end);
                NotificationGoal:PlayJiggleEffect();
                u16:Destroy();
            end);
        end);
    end;
end;

function u1.UpdateAge(p23) -- Line: 98
    -- upvalues: Utility (copy)
    local v24 = tick() - p23._creation_time;
    local math_floor_ret = math.floor(v24);
    p23.Frame.Visuals.Container.Age.Visible = true;
    p23.Frame.Visuals.Container.Age.Title.Text = math_floor_ret < 1 and "just now" or Utility:TimeFormat2(math_floor_ret, true) .. " ago";
end;

function u1.Destroy(p25) -- Line: 105
    for _, v in pairs(p25._cleanup) do
        v:Destroy();
    end;

    p25._cleanup = {};
    p25.Frame:Destroy();
end;

function u1._Setup(p26) -- Line: 119
    -- upvalues: UILibrary (copy), CosmeticLibrary (copy), RewardSlot (copy)
    p26.Frame.Visuals.Container.Title.Text = p26._title or "";
    p26.Frame.Visuals.Container.Description.Text = p26._description or "";
    p26.Frame.Visuals.Container.FirstIcon.Image = typeof(p26._first_icon) == "string" and (p26._first_icon or "") or "";
    p26.Frame.Visuals.Container.SecondIcon.Image = typeof(p26._second_icon) == "string" and (p26._second_icon or "") or "";
    p26.Frame.Visuals.Background.BackgroundColor3 = UILibrary.BUTTON_BACKGROUND_COLOR;
    p26.Frame.Visuals.Background.BackgroundTransparency = UILibrary.BUTTON_BACKGROUND_TRANSPARENCY;

    if p26._first_reward_info then
        if CosmeticLibrary.Cosmetics[p26._first_reward_info.Name] then
            p26._first_reward_info.Quantity = nil;
        end;

        local v27 = RewardSlot.new(p26._first_reward_info);
        v27:SetParent(p26.Frame.Visuals.Container.FirstReward);
        table.insert(p26._cleanup, v27);
    end;

    if p26._second_reward_info then
        if CosmeticLibrary.Cosmetics[p26._second_reward_info.Name] then
            p26._second_reward_info.Quantity = nil;
        end;

        local v28 = RewardSlot.new(p26._second_reward_info);
        v28:SetParent(p26.Frame.Visuals.Container.SecondReward);
        table.insert(p26._cleanup, v28);
    end;
end;

function u1._Init(p29) -- Line: 148
    p29:_Setup();
end;

return u1;