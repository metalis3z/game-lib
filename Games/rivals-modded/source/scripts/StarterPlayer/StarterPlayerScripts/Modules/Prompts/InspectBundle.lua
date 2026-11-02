-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local BundleSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BundleSlot"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: Prompt (copy), u1 (copy), MonetizationLibrary (copy), BundleSlot (copy)
    local v3 = Prompt.new(script.Name);
    local v4 = setmetatable(v3, u1);
    v4.Container = v4.PromptFrame:WaitForChild("Container");
    v4.ButtonsFrame = v4.PromptFrame:WaitForChild("Buttons");
    v4.ButtonsContainer = v4.ButtonsFrame:WaitForChild("Container");
    v4.CloseButton = v4.ButtonsContainer:WaitForChild("Close");
    v4.BuyButton = v4.ButtonsContainer:WaitForChild("Buy");
    v4.BuyButtonOwnedFrame = v4.BuyButton:WaitForChild("Owned");
    v4.BuyButtonReadyFrame = v4.BuyButton:WaitForChild("Ready");
    v4.BuyButtonReadyText = v4.BuyButtonReadyFrame:WaitForChild("Title");
    v4.BuyButtonReadyBubbleFrame = v4.BuyButtonReadyFrame:WaitForChild("Bubble");
    v4.BuyButtonReadyBubbleText = v4.BuyButtonReadyBubbleFrame:WaitForChild("Title");
    v4.Name = p2;
    v4.Info = MonetizationLibrary.Bundles[v4.Name];
    v4._bundle_slot = BundleSlot.new(v4.Name);
    v4:_Init();

    return v4;
end;

function u1.Destroy(p5) -- Line: 41
    -- upvalues: Prompt (copy)
    p5._bundle_slot:Destroy();
    Prompt.Destroy(p5);
end;

function u1._Update(p6) -- Line: 50
    if p6._bundle_slot:IsAlreadyOwned() then
        p6.BuyButton.Visible = true;
        p6.BuyButtonReadyFrame.Visible = false;
        p6.BuyButtonOwnedFrame.Visible = true;

        return;
    end;

    if p6._bundle_slot:IsAvailableToPurchase() then
        p6.BuyButton.Visible = true;
        p6.BuyButtonReadyFrame.Visible = true;
        p6.BuyButtonOwnedFrame.Visible = false;

        return;
    end;

    p6.BuyButton.Visible = false;
    p6.BuyButtonReadyFrame.Visible = false;
    p6.BuyButtonOwnedFrame.Visible = false;
end;

function u1._Setup(p7) -- Line: 66
    -- upvalues: MonetizationController (copy)
    p7.BuyButtonReadyBubbleText.RichText = true;
    p7.BuyButtonReadyBubbleText.Text = p7.Info.BubbleText or "";
    p7.BuyButtonReadyBubbleFrame.Visible = p7.BuyButtonReadyBubbleText.Text ~= "";
    MonetizationController:SetRobuxText(p7.BuyButtonReadyText, p7._bundle_slot:GetAssetIDForRobuxText(), p7._bundle_slot:GetInfoTypeForRobuxText());
    p7._bundle_slot:HideRobuxButton();
    p7._bundle_slot:SetAlwaysSpotlighted(true);
    p7._bundle_slot:SetSpotlightingInputsEnabled(false);
    p7._bundle_slot:SetParent(p7.Container);
    p7._bundle_slot:StartLoops();
end;

function u1._Init(u8) -- Line: 79
    -- upvalues: ButtonEffect (copy)
    u8.CloseButton.MouseButton1Click:Connect(function() -- Line: 80
        -- upvalues: u8 (copy)
        u8:CloseRequest();
    end);
    u8.BuyButton.MouseButton1Click:Connect(function() -- Line: 84
        -- upvalues: u8 (copy)
        u8._bundle_slot:PurchaseRequest();
    end);
    u8._bundle_slot.Tapped:Connect(function() -- Line: 88
        -- upvalues: u8 (copy)
        u8._bundle_slot:PurchaseRequest();
    end);
    u8._bundle_slot.AvailabilityChanged:Connect(function() -- Line: 92
        -- upvalues: u8 (copy)
        u8:_Update();
    end);
    u8._bundle_slot.OwnedChanged:Connect(function() -- Line: 96
        -- upvalues: u8 (copy)
        u8:_Update();
    end);
    u8:_Setup();
    u8:_Update();
    ButtonEffect:Add(u8.BuyButton);
    ButtonEffect:Add(u8.CloseButton);
end;

return u1;