-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local EmoteViewportFrame = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("EmoteViewportFrame"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local script_Parent = require(script.Parent);
local ShopBigSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ShopBigSlot");
local u1 = setmetatable({}, script_Parent);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: script_Parent (copy), u1 (copy), ShopBigSlot (copy)
    local v2 = script_Parent.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Frame = ShopBigSlot:Clone();
    v3._emote_viewport_frame = nil;
    v3:_Init();

    return v3;
end;

function u1.OnClick(p4, p5) -- Line: 30
    p4.Frame.Button.MouseButton1Click:Connect(p5);
end;

function u1.SetDescription(p6, p7) -- Line: 34
    p6.Frame.Button.Description.Text = p7;
end;

function u1.Destroy(p8) -- Line: 38
    if p8._emote_viewport_frame then
        p8._emote_viewport_frame:Destroy();
    end;

    p8.Frame:Destroy();
end;

function u1._Setup(p9) -- Line: 50
    -- upvalues: CosmeticLibrary (copy), ButtonEffect (copy), EmoteViewportFrame (copy)
    local v10 = CosmeticLibrary.Cosmetics[p9.FirstRewardData.Name];
    p9.Frame.Button.Background.BackgroundColor3 = CosmeticLibrary.Rarities[v10.Rarity].Color;
    p9.Frame.Button.Background.UIStroke.Color = p9.Frame.Button.Background.BackgroundColor3;
    p9.Frame.Button.Icon.Image = v10.ImageHighResolution or "";
    p9.Frame.Button.Title.Text = p9.FirstRewardData.Name;
    p9.Frame.Button.Weapon.Text = v10.Rarity .. " " .. (v10.ItemName or "???") .. " " .. v10.Type;

    if not (p9.IsOwned or p9.IsLocked) then
        ButtonEffect:Add(p9.Frame.Button, nil, {
            HoverRatio = 1.03,
            ReleaseRatio = 1.03
        });
    end;

    if v10.Type == "Emote" then
        p9._emote_viewport_frame = EmoteViewportFrame.new(p9.FirstRewardData.Name);
        p9._emote_viewport_frame:SetParent(p9.Frame.Button);
        p9._emote_viewport_frame.Frame.ZIndex = 9;
        p9._emote_viewport_frame.Frame.Position = UDim2.new(0.5, 0, 1, 0);
        p9._emote_viewport_frame.EmoteGlow.Position = UDim2.new(0.5, 0, 0.85, 0);
        p9._emote_viewport_frame.EmoteGlow.Position = UDim2.new(0.5, 0, 0.85, 0);
    end;
end;

function u1._Init(p11) -- Line: 73
    p11:_Setup();
    p11:_SetupBuyButton(p11.Frame.Button.Buy, p11.Frame.Button.Owned);
    p11:SetDescription("");
end;

return u1;