-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local MarketplaceService = game:GetService("MarketplaceService");
local TextService = game:GetService("TextService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
local DraggableList = require(Modules.Elements.DraggableList);
local Cache = require(Modules.Services.Cache);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local SetLayeredClothingOrder = Remotes:WaitForChild("SetLayeredClothingOrder");
local SetMakeupOrder = Remotes:WaitForChild("SetMakeupOrder");
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local u1 = {};
local u2 = "clothing";
local u3 = nil;
local u4 = false;
local u5 = false;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);

local function setLayeredClothingOrder(p10) -- Line: 31
    -- upvalues: SetLayeredClothingOrder (copy)
    local v11 = {};

    for _, v in p10 do
        v11[tostring(v.AssetId)] = v.Order;
    end;

    SetLayeredClothingOrder:FireServer(v11);
end;

local function setMakeupOrder(p12) -- Line: 39
    -- upvalues: SetMakeupOrder (copy)
    local v13 = {};

    for _, v in p12 do
        v13[tostring(v.AssetId)] = v.Order;
    end;

    SetMakeupOrder:FireServer(v13);
end;

function u1.Setup(p14, p15, p16) -- Line: 47
    -- upvalues: u7 (ref), u8 (ref), u5 (ref), u3 (ref), DraggableList (copy), setLayeredClothingOrder (copy), u2 (ref), CatalogUtilities (copy), Remotes (copy), u1 (copy)
    if not (p14 and p15) then
        warn("[ClothingAdjustmentModule] Setup missing button or container");

        return;
    end;

    u7 = p14;
    u8 = p15:FindFirstChild("dropdown") or p15;
    u5 = false;
    u8.Visible = false;
    u8.GroupTransparency = 1;
    local v17 = p16 or (u8:FindFirstChild("wrapper") or u8);
    u3 = DraggableList.new(v17, {});
    u3.OnOrderChange = setLayeredClothingOrder;
    u2 = "clothing";

    function u3.OnItemCreated(p18, u19) -- Line: 68
        -- upvalues: CatalogUtilities (ref), Remotes (ref)
        local u20 = script:FindFirstChild("unequip"):Clone();
        u20.Visible = false;
        u20.Parent = p18;
        u20.MouseEnter:Connect(function() -- Line: 72
            -- upvalues: u20 (copy)
            u20.ImageTransparency = 0.15;
        end);
        u20.MouseLeave:Connect(function() -- Line: 75
            -- upvalues: u20 (copy)
            u20.ImageTransparency = 0.82;
        end);
        u20.Activated:Connect(function() -- Line: 78
            -- upvalues: u19 (copy), CatalogUtilities (ref), Remotes (ref)
            local v21;

            if u19.AssetType then
                v21 = CatalogUtilities.GetAssetTypeName(u19.AssetType);
            else
                v21 = nil;
            end;

            local _, _ = Remotes.TakeOffItem:InvokeServer(u19.AssetId or u19.Id, "Asset", v21);
        end);
    end;

    function u3.OnHover(p22, p23, p24) -- Line: 86
        local unequip = p22:FindFirstChild("unequip");

        if unequip then
            unequip.Visible = p24;
        end;
    end;

    p14.Activated:Connect(function() -- Line: 93
        -- upvalues: u1 (ref), u5 (ref)
        u1.SetVisible(not u5);
    end);
end;

function u1.SetVisible(p25) -- Line: 98
    -- upvalues: u4 (ref), u5 (ref), u8 (ref), u7 (ref), TweenService (copy), u9 (copy), u6 (ref), OutsideClickDetector (copy), u1 (copy), ThemeController (copy)
    if u4 or u5 == p25 then
        return;
    end;

    if not u8 then
        return;
    end;

    local Parent = u7.Parent;
    u4 = true;
    u5 = p25;

    if p25 then
        u8.Visible = true;
        TweenService:Create(u8, u9, {
            GroupTransparency = 0
        }):Play();
        TweenService:Create(Parent.back.UIStroke, u9, {
            Transparency = 0
        }):Play();
        TweenService:Create(Parent.back.WhiteRing, u9, {
            Transparency = 0
        }):Play();

        if u6 then
            u6:Disconnect();
        end;

        u6 = OutsideClickDetector(u8, function() -- Line: 115
            -- upvalues: u1 (ref)
            u1.SetVisible(false);
        end, {
            include = { u7 }
        });
    else
        TweenService:Create(u8, u9, {
            GroupTransparency = 1
        }):Play();
        TweenService:Create(Parent.back.UIStroke, u9, {
            Transparency = 1
        }):Play();
        TweenService:Create(Parent.back.WhiteRing, u9, {
            Transparency = 1
        }):Play();
        TweenService:Create(Parent.back, u9, {
            BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(229, 229, 229))
        }):Play();
        TweenService:Create(Parent.label, u9, {
            TextColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39))
        }):Play();
        TweenService:Create(Parent.image, u9, {
            ImageColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39))
        }):Play();

        if u6 then
            u6:Disconnect();
            u6 = nil;
        end;
    end;

    task.delay(u9.Time, function() -- Line: 134
        -- upvalues: u5 (ref), u8 (ref), u4 (ref)
        if not u5 then
            u8.Visible = false;
        end;

        u4 = false;
    end);
end;

local function relayoutChip(p26) -- Line: 145
    -- upvalues: TextService (copy)
    local label = p26:FindFirstChild("label");
    local image = p26:FindFirstChild("image");

    if not (label and image) then
        return;
    end;

    local Y = p26.AbsoluteSize.Y;
    local X = p26.AbsoluteSize.X;

    if Y <= 0 or X <= 0 then
        return;
    end;

    local v27 = 0.14 * Y;
    local v28 = 0.16 * Y;
    local X2 = image.AbsoluteSize.X;
    local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
    GetTextBoundsParams.Text = label.Text;
    GetTextBoundsParams.Font = label.FontFace;
    GetTextBoundsParams.Size = label.AbsoluteSize.Y;
    GetTextBoundsParams.Width = 10000;
    local success, result = pcall(TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams);

    if not success then
        return;
    end;

    local v29 = result.X + 0.04 * Y;
    local v30 = v27 + X2 + v28 + v29 + 0.2 * Y;
    image.Position = UDim2.new(v27 / v30, 0, 0.5, 0);
    image.Size = UDim2.new(X2 / v30, 0, image.Size.Y.Scale, 0);
    label.Position = UDim2.new((v27 + X2 + v28) / v30, 0, 0.5, 0);
    label.Size = UDim2.new(v29 / v30, 0, label.Size.Y.Scale, 0);
    local v31 = p26:FindFirstChildOfClass("UIAspectRatioConstraint");

    if v31 then
        v31.AspectRatio = v30 / Y;
    end;

    local dropdown = p26:FindFirstChild("dropdown");

    if dropdown then
        local v32 = X / v30;
        dropdown.Position = UDim2.new(dropdown.Position.X.Scale * v32, dropdown.Position.X.Offset, dropdown.Position.Y.Scale, dropdown.Position.Y.Offset);
        dropdown.Size = UDim2.new(dropdown.Size.X.Scale * v32, dropdown.Size.X.Offset, dropdown.Size.Y.Scale, dropdown.Size.Y.Offset);
    end;
end;

function u1.SetMode(p33) -- Line: 184
    -- upvalues: u2 (ref), u3 (ref), setMakeupOrder (copy), setLayeredClothingOrder (copy), u7 (ref), relayoutChip (copy)
    u2 = p33;

    if u3 then
        if p33 == "makeup" then
            u3.OnOrderChange = setMakeupOrder;
        else
            u3.OnOrderChange = setLayeredClothingOrder;
        end;
    end;

    local v34 = u7 and u7.Parent;

    if v34 then
        local label = v34:FindFirstChild("label");

        if label then
            label.Text = p33 == "makeup" and "Makeup" or "Clothing";
        end;

        local image = v34:FindFirstChild("image");

        if image then
            image.Image = p33 == "makeup" and "rbxassetid://101776970443845" or "rbxassetid://92188853908953";
        end;

        relayoutChip(v34);
    end;
end;

function u1.UpdateList(u35) -- Line: 209
    -- upvalues: u3 (ref), Cache (copy), MarketplaceService (copy), u8 (ref)
    if not u3 then
        return;
    end;

    task.spawn(function() -- Line: 213
        -- upvalues: u35 (copy), Cache (ref), MarketplaceService (ref), u8 (ref), u3 (ref)
        for _, v in u35 do
            local v37 = Cache.GetOrFetch("AssetProductInfo", tostring(v.AssetId), 600, function() -- Line: 215
                -- upvalues: MarketplaceService (ref), v (copy)
                local v36 = 0;

                while true do
                    v36 = v36 + 1;
                    local success, result = pcall(MarketplaceService.GetProductInfo, MarketplaceService, v.AssetId, Enum.InfoType.Asset);

                    if not success then
                        task.wait(v36 * 1);
                    end;

                    if success == true or v36 >= 3 then
                        if success then
                            return result;
                        end;

                        return nil;
                    end;
                end;
            end);
            v.AssetName = v37 and (v37.Name or "Clothing Item") or "Clothing Item";
        end;

        if u8:FindFirstChild("noLayeredClothingEquipped") then
            u8.noLayeredClothingEquipped.Visible = #u35 == 0;
        end;

        u3:Update(u35);
    end);
end;

return u1;