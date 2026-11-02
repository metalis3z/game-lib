-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GroupService = game:GetService("GroupService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local BaseContractSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseContractSlot"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 17
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy), BaseContractSlot (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.Container = v3.PageFrame:WaitForChild("Container");
    v3.VerifyButton = v3.Container:WaitForChild("Verify");
    v3.VerifyButtonReadyFrame = v3.VerifyButton:WaitForChild("Ready");
    v3.VerifyButtonCountdownFrame = v3.VerifyButton:WaitForChild("Countdown");
    v3.VerifyButtonCountdownText = v3.VerifyButtonCountdownFrame:WaitForChild("Title");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3._verify_countdown_hash = 0;
    v3._contract_slot = BaseContractSlot.new();
    v3:_Init();

    return v3;
end;

function u1._UpdateClaimed(p4) -- Line: 48
    -- upvalues: PlayerDataController (copy)
    local v5 = PlayerDataController:Get("ClaimedGroupReward");
    p4.VerifyButton.Visible = not v5;
    p4._contract_slot:SetProgress(v5 and 2 or 0);
end;

function u1._Countdown(u6) -- Line: 55
    u6._verify_countdown_hash = u6._verify_countdown_hash + 1;
    local _verify_countdown_hash = u6._verify_countdown_hash;
    u6.VerifyButtonCountdownFrame.Visible = true;
    u6.VerifyButtonReadyFrame.Visible = false;
    task.spawn(function() -- Line: 62
        -- upvalues: u6 (copy), _verify_countdown_hash (copy)
        for i = 15, 1, -1 do
            u6.VerifyButtonCountdownText.Text = i;
            wait(1);

            if _verify_countdown_hash ~= u6._verify_countdown_hash then
                return;
            end;

            local _ = i;
        end;

        u6.VerifyButtonCountdownFrame.Visible = false;
        u6.VerifyButtonReadyFrame.Visible = true;
    end);
end;

function u1._Setup(p7) -- Line: 78
    p7._contract_slot:SetTitle("Free Rewards");
    p7._contract_slot:SetImage("rbxassetid://84811629597038", UDim2.new(1.25, 0, 1, 0));
    p7._contract_slot:SetScale(1.25);
    p7._contract_slot:SetRequiresPreviousMilestoneCompleted(false);
    p7._contract_slot:SetDescription("Like the game (RIVALS) 👍 and join the group (Nosniy Games) 💜 to claim!");
    p7._contract_slot:AddMilestone(2, {
        Name = "RIVALS",
        Weapon = "IsUniversal"
    });
    p7._contract_slot:AddMilestone(2, {
        Name = "Nosniy Games",
        Weapon = "IsUniversal"
    });
    p7._contract_slot:AddMilestone(2, {
        Name = "Key",
        Quantity = 3
    });
    p7._contract_slot.Frame.Parent = p7.Container;
end;

function u1._Init(u8) -- Line: 90
    -- upvalues: GroupService (copy), CONSTANTS (copy), ReplicatedStorage (copy), PlayerDataController (copy), ButtonEffect (copy)
    u8.CloseButton.MouseButton1Click:Connect(function() -- Line: 91
        -- upvalues: u8 (copy)
        u8:CloseRequest();
    end);
    u8.VerifyButton.MouseButton1Click:Connect(function() -- Line: 95
        -- upvalues: u8 (copy), GroupService (ref), CONSTANTS (ref), ReplicatedStorage (ref)
        if not u8.VerifyButtonReadyFrame.Visible then
            return;
        end;

        u8:_Countdown();
        local success, result = pcall(GroupService.PromptJoinAsync, GroupService, CONSTANTS.GROUP_ID);

        if not success then
            warn("Failed to prompt group join, error:", result);
        end;

        if ReplicatedStorage.Remotes.Data.ClaimGroupReward:InvokeServer() then
            ReplicatedStorage.Remotes.Data.ClaimLikeReward:FireServer();

            return;
        end;

        u8.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to verify, make sure to like the game AND join the group!");
    end);
    PlayerDataController:GetDataChangedSignal("ClaimedGroupReward"):Connect(function() -- Line: 117
        -- upvalues: u8 (copy)
        u8:_UpdateClaimed();
    end);
    u8:_Setup();
    u8:_UpdateClaimed();
    ButtonEffect:Add(u8.CloseButton);
    ButtonEffect:Add(u8.VerifyButton);
end;

return u1._new();