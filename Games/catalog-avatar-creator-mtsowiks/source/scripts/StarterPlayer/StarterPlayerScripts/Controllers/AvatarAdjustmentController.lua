-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("AvatarEditorService");
local Modules = require(script.Parent.Parent.Modules);
local LocalPlayer = Players.LocalPlayer;
local AccessoryAdjustment = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("AccessoryAdjustment");
local container = AccessoryAdjustment:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local itemsSection = container:WaitForChild("itemsSection");
local items = itemsSection:WaitForChild("items");
local adjustmentSection = wrapper:WaitForChild("adjustmentSection");
local properties = adjustmentSection:WaitForChild("properties");
local transform = AccessoryAdjustment:WaitForChild("transform");
local wrapper2 = transform:WaitForChild("wrapper");
local transformSection = wrapper2:WaitForChild("transformSection");
local Events = script.Parent.Parent.Events;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
ReplicatedStorage:WaitForChild("Assets");
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local ItemButton = require(Modules.Elements.ItemButton);
local SliderController = require(Modules.Elements.SliderController);
local ToggleSwitchController = require(Modules.Elements.ToggleSwitchController);
local ParseTextToColor = require(Modules.Utilities.ParseTextToColor);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local TransformModeController = require(script.TransformModeController);
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(container, u1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(container, u1, {
    GroupTransparency = 1
});
local u4 = {
    IsOpen = false
};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = nil;
local u10 = false;
local u11 = false;
local u12 = false;
local u13 = nil;
local u14 = nil;

local function isPrivateServer() -- Line: 60
    -- upvalues: u14 (ref), Remotes (copy)
    if u14 == nil then
        local success, result = pcall(function() -- Line: 62
            -- upvalues: Remotes (ref)
            return Remotes:WaitForChild("IsPrivateServer"):InvokeServer();
        end);

        if success then
            success = result == true;
        end;

        u14 = success;
    end;

    return u14;
end;

local u15 = false;

local function parseTextureId(p16) -- Line: 70
    if typeof(p16) ~= "string" then
        return nil;
    end;

    local v17 = string.match(p16, "^%s*(.-)%s*$") or "";

    if v17 == "" then
        return "";
    end;

    local v18 = string.match(v17, "^rbxassetid://(%d+)$");

    if v18 then
        return v18;
    end;

    if string.match(v17, "^%d+$") then
        return v17;
    end;

    local v19 = nil;

    for i in string.gmatch(v17, "%d+") do
        if v19 == nil or #i > #v19 then
            v19 = i;
        end;
    end;

    if v19 and #v19 >= 4 then
        return v19;
    end;

    return nil;
end;

local function displayTextureId(p20) -- Line: 85
    return (typeof(p20) ~= "string" or p20 == "") and "" or (string.match(p20, "%d+") or p20);
end;

local function buildTextureContentId(p21) -- Line: 90
    return "rbxthumb://type=Asset&id=" .. p21 .. "&w=700&h=700";
end;

local function clearConnections() -- Line: 94
    -- upvalues: u6 (copy)
    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);
end;

local function applySelectionMarkers() -- Line: 101
    -- upvalues: u8 (copy), items (copy)
    for i, v in u8 do
        local v22 = items:FindFirstChild((tostring(i)));

        if v22 and not v22.preview:FindFirstChild("selectedStroke") then
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Name = "selectedStroke";
            UIStroke.Color = Color3.fromRGB(255, 255, 255);
            UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
            UIStroke.Thickness = 0.02;
            UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Center;
            UIStroke.Parent = v22.preview;
        end;

        if typeof(v) == "Instance" then
            local Handle = v:FindFirstChild("Handle");

            if Handle and not Handle:FindFirstChild("SelectionHighlight") then
                local Highlight = Instance.new("Highlight");
                Highlight.Name = "SelectionHighlight";
                Highlight.FillTransparency = 1;
                Highlight.OutlineTransparency = 0.5;
                Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
                Highlight.Adornee = Handle;
                Highlight.Parent = Handle;
            end;
        end;
    end;
end;

local function removeSelectionMarkers() -- Line: 133
    -- upvalues: u8 (copy), items (copy)
    for i, v in u8 do
        if typeof(v) == "Instance" then
            local Handle = v:FindFirstChild("Handle");
            local v23;

            if Handle then
                v23 = Handle:FindFirstChild("SelectionHighlight");
            else
                v23 = v:FindFirstChild("SelectionHighlight");
            end;

            if v23 then
                v23:Destroy();
            end;
        end;

        local v24 = items:FindFirstChild((tostring(i)));

        if v24 then
            local selectedStroke = v24.preview:FindFirstChild("selectedStroke");

            if selectedStroke then
                selectedStroke:Destroy();
            end;
        end;
    end;
end;

local function setTransformMenuVisible(p25) -- Line: 149
    -- upvalues: transform (copy), TweenService (copy), u1 (copy)
    if p25 then
        transform.GroupTransparency = 1;
        transform.Visible = true;
        TweenService:Create(transform, u1, {
            GroupTransparency = 0
        }):Play();

        return;
    end;

    local v26 = TweenService:Create(transform, u1, {
        GroupTransparency = 1
    });
    v26:Play();
    v26.Completed:Once(function() -- Line: 157
        -- upvalues: transform (ref)
        transform.Visible = false;
    end);
end;

local function cleanup() -- Line: 163
    -- upvalues: u5 (copy), u7 (copy), TransformModeController (copy), TweenService (copy), transform (copy), u1 (copy), u12 (ref), u10 (ref), itemsSection (copy), u6 (copy)
    for _, v in u5 do
        if v then
            pcall(task.cancel, v);
        end;
    end;

    table.clear(u5);

    for _, v in u7 do
        if v then
            pcall(v.Destroy, v);
        end;
    end;

    table.clear(u7);

    if TransformModeController.Enabled then
        TransformModeController:Toggle(false);
        local v27 = TweenService:Create(transform, u1, {
            GroupTransparency = 1
        });
        v27:Play();
        v27.Completed:Once(function() -- Line: 157
            -- upvalues: transform (ref)
            transform.Visible = false;
        end);
    end;

    if TransformModeController.PreloadedCharacter then
        TransformModeController.PreloadedCharacter:Destroy();
        TransformModeController.PreloadedCharacter = nil;
    end;

    u12 = false;
    u10 = false;
    itemsSection.multipleSelect.label.TextTransparency = 0.21;
    itemsSection.multipleSelect.icon.ImageTransparency = 0.21;
    itemsSection.multipleSelect.icon.Image = "rbxassetid://114418625473231";

    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);
end;

local function setupSliderCircle(u28, p29) -- Line: 194
    -- upvalues: TweenService (copy), u1 (copy)
    local u30 = nil;
    table.insert(p29, u28.SliderButton.MouseEnter:Connect(function() -- Line: 196
        -- upvalues: u30 (ref), u28 (copy), TweenService (ref), u1 (ref)
        if u30 then
            u30:Destroy();
        end;

        u30 = Instance.new("Frame");
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = u30;
        u30.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        u30.Size = UDim2.fromScale(1, 1);
        u30.Position = UDim2.fromScale(0.5, 0.5);
        u30.AnchorPoint = Vector2.new(0.5, 0.5);
        u30.BackgroundTransparency = 1;
        u30.Name = "hoverCircle";
        u30.Parent = u28.Circle;
        TweenService:Create(u30, u1, {
            BackgroundTransparency = 0.8,
            Size = UDim2.fromScale(2, 2)
        }):Play();
    end));
    table.insert(p29, u28.SliderButton.MouseLeave:Connect(function() -- Line: 212
        -- upvalues: u30 (ref), TweenService (ref), u1 (ref)
        if u30 then
            TweenService:Create(u30, u1, {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1)
            }):Play();
            game.Debris:AddItem(u30, u1.Time);
        end;
    end));
    table.insert(p29, u28.SliderButton.MouseButton1Down:Connect(function() -- Line: 220
        -- upvalues: u30 (ref), TweenService (ref), u1 (ref)
        if u30 then
            TweenService:Create(u30, u1, {
                Size = UDim2.fromScale(2.5, 2.5)
            }):Play();
        end;
    end));
    table.insert(p29, u28.SliderButton.MouseButton1Up:Connect(function() -- Line: 224
        -- upvalues: u30 (ref), TweenService (ref), u1 (ref)
        if u30 then
            TweenService:Create(u30, u1, {
                Size = UDim2.fromScale(2, 2)
            }):Play();
        end;
    end));
end;

local function setMainContainerMinimized(p31) -- Line: 229
    -- upvalues: u11 (ref), adjustmentSection (copy), wrapper (copy), TweenService (copy), itemsSection (copy)
    if u11 == p31 then
        return;
    end;

    u11 = p31;

    if p31 then
        adjustmentSection.Visible = false;
        wrapper.title.Visible = false;
        wrapper.closeButton.Visible = false;
        TweenService:Create(wrapper, TweenInfo.new(0.11666666666666665, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = UDim2.fromScale(0.31, 1)
        }):Play();
        TweenService:Create(wrapper.UICorner, TweenInfo.new(0.15666666666666665, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            CornerRadius = UDim.new(0.14, 0)
        }):Play();
        TweenService:Create(itemsSection, TweenInfo.new(0.11666666666666665, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Position = UDim2.fromScale(0.982, 0.5),
            Size = UDim2.fromScale(0.276, 0.975)
        }):Play();

        return;
    end;

    TweenService:Create(itemsSection, TweenInfo.new(0.11666666666666665, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Position = UDim2.fromScale(0.982, 0.529),
        Size = UDim2.fromScale(0.276, 0.912)
    }):Play();
    TweenService:Create(wrapper, TweenInfo.new(0.11666666666666665, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Size = UDim2.fromScale(1, 1)
    }):Play();
    TweenService:Create(wrapper.UICorner, TweenInfo.new(0.11666666666666665, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        CornerRadius = UDim.new(0.04, 0)
    }):Play();
    adjustmentSection.Visible = true;
    wrapper.title.Visible = true;
    wrapper.closeButton.Visible = true;
end;

local function setSlidersVisible(p32) -- Line: 252
    -- upvalues: transformSection (copy), wrapper2 (copy)
    if p32 then
        transformSection.properties.Position = UDim2.fromScale(0, 0.014);
        transformSection.bottomActions.Position = UDim2.fromScale(0.5, 0.986);
        wrapper2.UICorner.CornerRadius = UDim.new(0.04, 0);
        wrapper2.Size = UDim2.fromScale(1, 1);
    else
        transformSection.properties.Position = UDim2.fromScale(0, 0.045);
        transformSection.bottomActions.Position = UDim2.fromScale(0.5, 0.955);
        wrapper2.UICorner.CornerRadius = UDim.new(0.08, 0);
        wrapper2.Size = UDim2.fromScale(1, 0.467);
    end;

    for _, child in transformSection.properties:GetChildren() do
        if table.find({ "position", "rotation", "scale" }, child.Name) then
            for _, child2 in child:GetChildren() do
                if string.len(child2.Name) == 1 then
                    child2.Visible = p32;
                end;
            end;
        end;
    end;
end;

local function toggleTransformMode(p33, p34) -- Line: 274
    -- upvalues: TransformModeController (copy), u12 (ref), itemsSection (copy), items (copy), u9 (ref), u8 (copy), u13 (ref), setMainContainerMinimized (copy), setSlidersVisible (copy), transform (copy), TweenService (copy), u1 (copy), Events (copy), adjustmentSection (copy), Remotes (copy)
    if TransformModeController.Enabled == p33 then
        return;
    end;

    if p33 then
        u12 = false;
        itemsSection.multipleSelect.label.TextTransparency = 0.21;
        itemsSection.multipleSelect.icon.ImageTransparency = 0.21;
        itemsSection.multipleSelect.icon.Image = "rbxassetid://114418625473231";
        local v35 = items:FindFirstChild((tostring(u9)));

        if not v35 or v35:GetAttribute("IsLayered") == true then
            for i, _ in u8 do
                local v36 = items:FindFirstChild((tostring(i)));

                if v36 and v36:GetAttribute("IsLayered") == false then
                    u9 = tostring(i);
                    break;
                end;
            end;
        end;

        for i, _ in u8 do
            if i ~= u9 then
                u13(i);
            end;
        end;

        setMainContainerMinimized(true);
        setSlidersVisible(TransformModeController.ShowSliders);
        transform.GroupTransparency = 1;
        transform.Visible = true;
        TweenService:Create(transform, u1, {
            GroupTransparency = 0
        }):Play();
        Events.SetButtonsVisible:Fire({});
        adjustmentSection.Visible = false;
    else
        if p34 == true then
            local NewAdjustments = TransformModeController.NewAdjustments;

            if next(NewAdjustments) then
                local v37, v38 = Remotes.AccessoryAdjustmentAction:InvokeServer({
                    Action = "ApplyTransformAdjustment",
                    Adjustments = NewAdjustments
                });

                if v37 then
                    Events.Notify:Fire("✅ Successfully saved your transform adjustments!");
                elseif v38 == "noAdjustments" then
                    Events.Notify:Fire("❌ No changes were made.");
                else
                    Events.Notify:Fire("❌ Something went wrong.");
                    Events.Notify:Fire("Debug: " .. tostring(v38));
                end;
            end;
        end;

        Events.SetButtonsVisible:Fire("All", { "emotes" });
        setMainContainerMinimized(false);
        local v39 = TweenService:Create(transform, u1, {
            GroupTransparency = 1
        });
        v39:Play();
        v39.Completed:Once(function() -- Line: 157
            -- upvalues: transform (ref)
            transform.Visible = false;
        end);
    end;

    TransformModeController:Toggle(p33, p34);

    for _, child in items:GetChildren() do
        if child:GetAttribute("isItem") and child:GetAttribute("IsLayered") then
            child.Visible = not p33;
        end;
    end;

    if p33 then
        TransformModeController:RefreshSliderBounds();
    end;
end;

local function updateUI() -- Line: 343
    -- upvalues: u8 (copy), items (copy), u10 (ref), adjustmentSection (copy)
    local v40 = false;
    local v41 = true;

    for i, _ in u8 do
        v41 = false;
        local v42 = items:FindFirstChild((tostring(i)));

        if v42 and v42:GetAttribute("IsLayered") == false then
            v40 = true;
        end;
    end;

    u10 = v40;
    adjustmentSection.noItemsSelected.Visible = v41;
    adjustmentSection.actions.Visible = not v41;
    adjustmentSection.properties.Visible = not v41;
    adjustmentSection.actions.transform.Visible = v40;
end;

u13 = function(u43) -- Line: 358
    -- upvalues: u8 (copy), u9 (ref), TweenService (copy), u1 (copy), Debris (copy), items (copy), u12 (ref), u13 (ref), HumanoidDescriptionController (copy), Remotes (copy), u4 (copy), TransformModeController (copy), Events (copy), updateUI (copy)
    local v44 = u8[tostring(u43)];

    if v44 then
        u8[tostring(u43)] = nil;

        if u9 == tostring(u43) then
            u9 = nil;

            for i, _ in u8 do
                u9 = i;
                break;
            end;
        end;

        if typeof(v44) == "Instance" then
            local Handle = v44:FindFirstChild("Handle");
            local v45;

            if Handle then
                v45 = Handle:FindFirstChild("SelectionHighlight");
            else
                v45 = v44:FindFirstChild("SelectionHighlight");
            end;

            if v45 then
                v45.Name = "oldSelectionHighlight";
                TweenService:Create(v45, u1, {
                    OutlineTransparency = 1
                }):Play();
                Debris:AddItem(v45, u1.Time);
            end;
        end;

        local v46 = items:FindFirstChild((tostring(u43)));
        local v47 = v46 and v46.preview:FindFirstChild("selectedStroke");

        if v47 then
            v47.Name = "oldSelectedStroke";
            TweenService:Create(v47, u1, {
                Transparency = 1
            }):Play();
            Debris:AddItem(v47, u1.Time);
        end;
    else
        if not u12 then
            for i, _ in u8 do
                u13(i);
            end;
        end;

        u8[tostring(u43)] = true;

        if not u9 then
            u9 = tostring(u43);
        end;

        local v48 = items:FindFirstChild((tostring(u43)));

        if v48 then
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Name = "selectedStroke";
            UIStroke.Color = Color3.fromRGB(255, 255, 255);
            UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
            UIStroke.Thickness = 0.02;
            UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Center;
            UIStroke.Transparency = 1;
            UIStroke.Parent = v48.preview;
            TweenService:Create(UIStroke, u1, {
                Transparency = 0
            }):Play();
        end;

        task.spawn(function() -- Line: 400
            -- upvalues: HumanoidDescriptionController (ref), u43 (copy), Remotes (ref), u8 (ref), TweenService (ref), u1 (ref), u9 (ref), u4 (ref), TransformModeController (ref), u13 (ref), Events (ref)
            local v49 = nil;

            for _, child in HumanoidDescriptionController.GetHumanoidParentedDescription():GetChildren() do
                if child:IsA("AccessoryDescription") and child.AssetId == tonumber(u43) then
                    v49 = child;
                    break;
                end;
            end;

            local v50 = Remotes.AccessoryAdjustmentAction:InvokeServer({
                Action = "GetInstanceFromDescription",
                AccessoryDescription = v49
            });

            if v50 then
                if u8[tostring(u43)] == true then
                    u8[tostring(u43)] = v50;
                    local Handle = v50:FindFirstChild("Handle");

                    if Handle then
                        local Highlight = Instance.new("Highlight");
                        Highlight.Name = "SelectionHighlight";
                        Highlight.FillTransparency = 1;
                        Highlight.OutlineTransparency = 1;
                        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
                        Highlight.Adornee = Handle;
                        Highlight.Parent = Handle;
                        TweenService:Create(Highlight, u1, {
                            OutlineTransparency = 0.5
                        }):Play();
                    end;

                    if u9 == tostring(u43) and u4.LoadAttributes then
                        u4.LoadAttributes(v50);
                    end;

                    if TransformModeController.Enabled then
                        TransformModeController:UpdateSelection();
                    end;
                end;
            elseif u8[tostring(u43)] ~= nil then
                u13(u43);
                Events.Notify:Fire("❌ Couldn\'t find accessory on character.");
            end;
        end);
    end;

    if TransformModeController.Enabled then
        TransformModeController:UpdateSelection();
    end;

    updateUI();
end;

local function update(p51) -- Line: 432
    -- upvalues: items (copy), u8 (copy), u13 (ref), ItemButton (copy), TransformModeController (copy), CatalogUtilities (copy), updateUI (copy)
    local v52 = {};

    for _, v in p51:GetAccessories(true) do
        v52[tostring(v.AssetId)] = v;
    end;

    for _, child in items:GetChildren() do
        if child:GetAttribute("isItem") and not v52[child.Name] then
            if u8[child.Name] then
                u13(child.Name);
            end;

            child:Destroy();
        end;
    end;

    for i, v in v52 do
        if items:FindFirstChild(i) == nil then
            local v53 = ItemButton.new({
                OnlyIcon = true,
                ItemDetails = {
                    ItemType = "Asset",
                    IsLackingDetails = true,
                    AssetId = i
                },

                CustomCallback = function() -- Line: 442, Name: CustomCallback
                    -- upvalues: TransformModeController (ref), u8 (ref), v (copy), u13 (ref)
                    if TransformModeController.Enabled and u8[tostring(v.AssetId)] then
                        return;
                    end;

                    u13(v.AssetId);
                end
            });
            local v54 = CatalogUtilities.GetLayoutOrderFromAssetType(v.AccessoryType);
            v53.LayoutOrder = v54 == 40 and 30 or (v54 == 30 and 40 or v54);
            v53.Parent = items;
            v53:SetAttribute("IsLayered", v.IsLayered);
        end;
    end;

    updateUI();
end;

function u4.Open(p55) -- Line: 459
    -- upvalues: u4 (copy), Events (copy), AccessoryAdjustment (copy), u2 (copy), TransformModeController (copy), items (copy), transformSection (copy), u9 (ref), u8 (copy), toggleTransformMode (copy), TweenService (copy), u1 (copy), CatalogUtilities (copy), HumanoidDescriptionController (copy), Players (copy), u5 (copy), u6 (copy), wrapper (copy), itemsSection (copy), u12 (ref), u13 (ref), setSlidersVisible (copy), ToggleSwitchController (copy), properties (copy), SliderController (copy), adjustmentSection (copy), LocalPlayer (copy), Remotes (copy), setupSliderCircle (copy), u7 (copy), ParseTextToColor (copy), parseTextureId (copy), u14 (ref), u15 (ref), update (copy), applySelectionMarkers (copy)
    if u4.IsOpen then
        if p55 then
            u4.Close();
        end;

        return;
    end;

    Events.InterfaceAction:Fire("Add", script.Name, u4.Close);
    Events.SetButtonsVisible:Fire("All", { "emotes" });
    u4.IsOpen = true;
    AccessoryAdjustment.Enabled = true;
    u2:Play();
    TransformModeController:Init({
        ItemsContainer = items,
        ScreenGui = AccessoryAdjustment,
        TransformSection = transformSection,
        OutOfBoundsTemplate = script.outOfBounds,

        GetPrimarySelectedId = function() -- Line: 480, Name: GetPrimarySelectedId
            -- upvalues: u9 (ref)
            return u9;
        end,

        GetSelectedItems = function() -- Line: 481, Name: GetSelectedItems
            -- upvalues: u8 (ref)
            return u8;
        end,

        OnRequestToggle = toggleTransformMode,

        OnRequestSubMode = function(p56) -- Line: 483, Name: OnRequestSubMode
            -- upvalues: transformSection (ref), TransformModeController (ref), TweenService (ref), u1 (ref)
            local properties2 = transformSection.properties;
            local modes = properties2.modes;
            TransformModeController.CurrentType = p56;

            for _, child in modes:GetChildren() do
                if child:IsA("TextButton") then
                    TweenService:Create(child, u1, {
                        BackgroundTransparency = child.Name == p56 and 0.8 or 0.925
                    }):Play();
                    local v57 = properties2:FindFirstChild(child.Name);

                    if v57 then
                        v57.Visible = child.Name == p56;
                    end;
                end;
            end;

            TransformModeController.MoveGizmo.Visible = p56 == "position" and true or p56 == "scale";

            if TransformModeController.MoveGizmo.Visible then
                local v58;

                if p56 == "position" then
                    v58 = Enum.HandlesStyle.Movement;
                else
                    v58 = Enum.HandlesStyle.Resize;
                end;

                TransformModeController.MoveGizmo.Style = v58;
            end;

            TransformModeController.RotateGizmo.Visible = p56 == "rotation";
            TransformModeController:UpdateGizmoFaces();
        end
    });
    task.spawn(function() -- Line: 504
        -- upvalues: CatalogUtilities (ref), TransformModeController (ref)
        while not CatalogUtilities.AvatarRules do
            task.wait(0.1);
        end;

        TransformModeController.AvatarRules = CatalogUtilities.AvatarRules;
    end);
    local v59 = HumanoidDescriptionController.GetHumanoid();
    local u60;

    if v59 then
        u60 = v59.RigType;
    else
        u60 = Enum.HumanoidRigType.R15;
    end;

    local u61 = HumanoidDescriptionController.GetCurrentDescription();
    local v67 = task.spawn(function() -- Line: 512
        -- upvalues: Players (ref), u61 (copy), u60 (copy), TransformModeController (ref)
        local success, result = pcall(function() -- Line: 513
            -- upvalues: Players (ref), u61 (ref), u60 (ref)
            return Players:CreateHumanoidModelFromDescription(u61, u60);
        end);

        if success then
            local v62 = false;
            local v63 = result:FindFirstChildWhichIsA("Humanoid");

            if v63 then
                v63 = v63:FindFirstChildOfClass("HumanoidDescription");
            end;

            if v63 then
                for _, child in v63:GetChildren() do
                    if child:IsA("AccessoryDescription") then
                        local success2, result2 = pcall(function() -- Line: 525
                            -- upvalues: child (copy)
                            return child:GetAppliedInstance();
                        end);

                        if success2 and (result2 and result2:IsA("Accessory")) then
                            result2:SetAttribute("AVMAssetId", (tostring(child.AssetId)));
                            v62 = true;
                        end;
                    end;
                end;
            end;

            if not v62 then
                local v64 = u61:GetAccessories(true);
                local v65 = 0;

                for _, child in result:GetChildren() do
                    if child:IsA("Accessory") then
                        v65 = v65 + 1;
                        local v66 = v64[v65];

                        if v66 then
                            child:SetAttribute("AVMAssetId", (tostring(v66.AssetId)));
                        end;
                    end;
                end;
            end;

            TransformModeController.PreloadedCharacter = result;

            if TransformModeController.Enabled then
                TransformModeController:OnCharacterLoaded();
            end;
        end;
    end);
    table.insert(u5, v67);
    table.insert(u6, wrapper.closeButton.Activated:Connect(u4.Close));
    table.insert(u6, itemsSection.multipleSelect.Activated:Connect(function() -- Line: 558
        -- upvalues: TransformModeController (ref), Events (ref), u12 (ref), itemsSection (ref), u8 (ref), u13 (ref)
        if TransformModeController.Enabled then
            Events.Notify:Fire("⚠️ Multiple Select is not available in Transform Mode.");

            return;
        end;

        u12 = not u12;
        local v68 = u12 and 0 or 0.21;
        itemsSection.multipleSelect.label.TextTransparency = v68;
        itemsSection.multipleSelect.icon.ImageTransparency = v68;
        itemsSection.multipleSelect.icon.Image = u12 and "rbxassetid://101671902685469" or "rbxassetid://114418625473231";

        if not u12 then
            local v69 = false;

            for i, _ in u8 do
                if v69 then
                    u13(i);
                else
                    v69 = true;
                end;
            end;
        end;
    end));
    table.insert(u6, itemsSection.multipleSelect.MouseEnter:Connect(function() -- Line: 578
        -- upvalues: TweenService (ref), itemsSection (ref), u1 (ref)
        TweenService:Create(itemsSection.multipleSelect, u1, {
            BackgroundTransparency = 0.975
        }):Play();
    end));
    table.insert(u6, itemsSection.multipleSelect.MouseLeave:Connect(function() -- Line: 582
        -- upvalues: TweenService (ref), itemsSection (ref), u1 (ref)
        TweenService:Create(itemsSection.multipleSelect, u1, {
            BackgroundTransparency = 1
        }):Play();
    end));
    table.insert(u6, TransformModeController.SetSlidersVisibleEvent.Event:Connect(setSlidersVisible));
    local u70 = ToggleSwitchController.new({
        Button = properties.neon.switch,
        Circle = properties.neon.switch.circle
    });
    local u71 = ToggleSwitchController.new({
        Button = properties.useCustomColor.switch,
        Circle = properties.useCustomColor.switch.circle
    });
    local u72 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        SliderButton = properties.transparency.slider,
        ValueBox = properties.transparency.value.input
    });
    local u73 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        SliderButton = properties.reflectance.slider,
        ValueBox = properties.reflectance.value.input
    });
    local input = properties.customTexture.value.input;
    local u74 = nil;
    local u75 = nil;
    local circle = properties.colorSliders.hue.slider.circle;
    local circle2 = properties.colorSliders.saturationAndValue.slider.circle;

    local function updateCustomColor(p76, p77, p78) -- Line: 598
        -- upvalues: adjustmentSection (ref), u74 (ref), u75 (ref), circle (copy), circle2 (copy), properties (ref), u71 (copy), u4 (ref)
        if adjustmentSection.Visible == false or not (u74 and u75) then
            return;
        end;

        local v79 = Color3.fromHSV(u74.Value / 100, 1, 1);

        if p76 == nil then
            local v80 = u75.Value / 100;

            if v80 <= 0.5 then
                p76 = Color3.new(1, 1, 1):Lerp(v79, v80 * 2);
            else
                p76 = v79:Lerp(Color3.new(0, 0, 0), (v80 - 0.5) * 2);
            end;
        else
            local v81, _, _ = p76:ToHSV();
            u74:SetValue(v81 * 100, true, true);
            v79 = Color3.fromHSV(v81, 1, 1);
        end;

        circle.BackgroundColor3 = v79;
        circle2.BackgroundColor3 = p76;
        u75.Line.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, v79), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) });
        properties.currentColor.color.BackgroundColor3 = p76;
        properties.currentColor.value.input.Text = "#" .. string.upper(p76:ToHex());

        if p77 then
            if u71.State == false then
                u71:UpdateState(true);
            end;

            u4.ApplyChanges({
                Action = "Color",
                Color = p76
            }, p78);
        end;
    end;

    u74 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        Instant = true,
        SliderButton = properties.colorSliders.hue.slider,

        OnThumbUpdated = function(p82, p83) -- Line: 626, Name: OnThumbUpdated
            -- upvalues: circle (copy), u75 (ref), circle2 (copy), updateCustomColor (copy)
            local v84 = Color3.fromHSV(p82 / 100, 1, 1);
            circle.BackgroundColor3 = v84;

            if u75 then
                u75.Line.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, v84), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) });
                local v85 = u75.Value / 100;
                local v86;

                if v85 <= 0.5 then
                    v86 = Color3.new(1, 1, 1):Lerp(v84, v85 * 2);
                else
                    v86 = v84:Lerp(Color3.new(0, 0, 0), (v85 - 0.5) * 2);
                end;

                circle2.BackgroundColor3 = v86;
            end;

            if not p83 then
                updateCustomColor(nil, true, false);
            end;
        end
    });
    u75 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        Instant = true,
        SliderButton = properties.colorSliders.saturationAndValue.slider,

        OnThumbUpdated = function(p87, p88) -- Line: 640, Name: OnThumbUpdated
            -- upvalues: u74 (ref), circle2 (copy), updateCustomColor (copy)
            local v89 = p87 / 100;
            local v90 = Color3.fromHSV(u74.Value / 100, 1, 1);
            local v91;

            if v89 <= 0.5 then
                v91 = Color3.new(1, 1, 1):Lerp(v90, v89 * 2);
            else
                v91 = v90:Lerp(Color3.new(0, 0, 0), (v89 - 0.5) * 2);
            end;

            circle2.BackgroundColor3 = v91;

            if not p88 then
                updateCustomColor(nil, true, false);
            end;
        end
    });

    function u4.LoadAttributes(p92) -- Line: 648
        -- upvalues: u71 (copy), u70 (copy), u74 (ref), u75 (ref), u72 (copy), u73 (copy), input (copy), updateCustomColor (copy)
        local v93 = p92:GetAttribute("Adjustment_UseColor");
        local v94 = p92:GetAttribute("Adjustment_Neon");
        local v95 = p92:GetAttribute("Adjustment_Hue");
        local v96 = p92:GetAttribute("Adjustment_SaturationValue");
        local v97 = p92:GetAttribute("Adjustment_Transparency");
        local v98 = p92:GetAttribute("Adjustment_Reflectance");

        if v93 == nil then
            v93 = false;
        end;

        u71:UpdateState(v93, true);

        if v94 == nil then
            v94 = false;
        end;

        u70:UpdateState(v94, true);
        u74:SetValue(v95 == nil and 0 or v95, true, true, true);
        u75:SetValue(v96 == nil and 50 or v96, true, true, true);
        u72:SetValue(v97 == nil and 0 or v97, true, true);
        u73:SetValue(v98 == nil and 0 or v98, true, true);
        local v99 = p92:GetAttribute("Adjustment_CustomTextureId");
        input.Text = (typeof(v99) ~= "string" or v99 == "") and "" or (string.match(v99, "%d+") or v99);
        updateCustomColor(nil, false, false);
        local v100 = p92:GetAttribute("Adjustment_Color");

        if typeof(v100) == "Color3" and u71.State then
            updateCustomColor(v100, false, false);
        end;
    end;

    function u4.ApplyChanges(u101, p102) -- Line: 675
        -- upvalues: u8 (ref), LocalPlayer (ref), u71 (copy), u74 (ref), u75 (ref), u70 (copy), Remotes (ref), properties (ref), u13 (ref), Events (ref)
        local v103 = nil;

        for i, v in u8 do
            if v and typeof(v) == "Instance" then
                if LocalPlayer.Character and v:IsDescendantOf(LocalPlayer.Character) then
                    local Handle = v:FindFirstChild("Handle");

                    if Handle then
                        if u101.Action == "Color" then
                            v:SetAttribute("Adjustment_UseColor", u71.State);
                            v:SetAttribute("Adjustment_Hue", u74.Value);
                            v:SetAttribute("Adjustment_SaturationValue", u75.Value);
                            local v104 = Handle:FindFirstChildWhichIsA("SurfaceAppearance");
                            local v105 = v:GetAttribute("Adjustment_CustomTextureId");

                            if u71.State then
                                if v104 then
                                    v104.Color = u101.Color;
                                else
                                    local v106 = Handle:FindFirstChildWhichIsA("SpecialMesh");
                                    local v107 = v106 or Handle;
                                    local v108 = v106 and "TextureId" or "TextureID";

                                    if Handle:IsA("MeshPart") or v106 then
                                        if v105 and v105 ~= "" then
                                            local v109 = "rbxthumb://type=Asset&id=" .. v105 .. "&w=700&h=700";

                                            if v107[v108] ~= v109 then
                                                if not Handle:GetAttribute("originalTextureID") then
                                                    local v110 = v107[v108];

                                                    if v110 ~= "" then
                                                        Handle:SetAttribute("originalTextureID", v110);
                                                    end;
                                                end;

                                                v107[v108] = v109;
                                            end;
                                        else
                                            local v111 = v107[v108];

                                            if v111 ~= "" then
                                                Handle:SetAttribute("originalTextureID", v111);
                                                v107[v108] = "";
                                            end;
                                        end;
                                    end;
                                end;

                                local v112;

                                if u70.State then
                                    v112 = Enum.Material.Neon;
                                else
                                    v112 = Enum.Material.SmoothPlastic;
                                end;

                                Handle.Material = v112;
                                Handle.Color = u101.Color;
                            else
                                if v104 then
                                    v104.Color = Color3.fromRGB(255, 255, 255);
                                end;

                                if v105 and v105 ~= "" then
                                    local v113 = Handle:FindFirstChildWhichIsA("SpecialMesh");
                                    local v114 = v113 or Handle;
                                    local v115 = v113 and "TextureId" or "TextureID";

                                    if Handle:IsA("MeshPart") or v113 then
                                        v114[v115] = "rbxthumb://type=Asset&id=" .. v105 .. "&w=700&h=700";
                                    end;
                                elseif Handle:GetAttribute("originalTextureID") then
                                    local v116 = Handle:FindFirstChildWhichIsA("SpecialMesh");
                                    (v116 or Handle)[v116 and "TextureId" or "TextureID"] = Handle:GetAttribute("originalTextureID");
                                    Handle:SetAttribute("originalTextureID", nil);
                                end;

                                Handle.Material = Enum.Material.Plastic;
                                Handle.Color = Color3.fromRGB(255, 255, 255);
                            end;
                        elseif u101.Action == "CustomTexture" then
                            local v117 = typeof(u101.AssetId) ~= "string" and "" or u101.AssetId;
                            local v118;

                            if v117 == "" then
                                v118 = nil;
                            else
                                v118 = v117;
                            end;

                            v:SetAttribute("Adjustment_CustomTextureId", v118);

                            if not Handle:FindFirstChildWhichIsA("SurfaceAppearance") then
                                local v119 = Handle:FindFirstChildWhichIsA("SpecialMesh");
                                local v120 = v119 or Handle;
                                local v121 = v119 and "TextureId" or "TextureID";

                                if Handle:IsA("MeshPart") or v119 then
                                    if v117 == "" then
                                        if u71.State then
                                            v120[v121] = "";
                                        else
                                            local v122 = Handle:GetAttribute("originalTextureID");

                                            if v122 then
                                                v120[v121] = v122;
                                                Handle:SetAttribute("originalTextureID", nil);
                                            end;
                                        end;
                                    else
                                        if not Handle:GetAttribute("originalTextureID") then
                                            local v123 = v120[v121];

                                            if v123 ~= "" then
                                                Handle:SetAttribute("originalTextureID", v123);
                                            end;
                                        end;

                                        v120[v121] = "rbxthumb://type=Asset&id=" .. v117 .. "&w=700&h=700";
                                    end;
                                end;
                            end;
                        elseif u101.Action == "Neon" then
                            v:SetAttribute("Adjustment_Neon", u101.IsEnabled);
                            local v124;

                            if u101.IsEnabled then
                                v124 = Enum.Material.Neon;
                            elseif u71.State then
                                v124 = Enum.Material.SmoothPlastic;
                            else
                                v124 = Enum.Material.Plastic;
                            end;

                            Handle.Material = v124;
                        elseif u101.Action == "Transparency" then
                            v:SetAttribute("Adjustment_Transparency", u101.Value);
                            Handle.Transparency = u101.Value / 100;
                        elseif u101.Action == "Reflectance" then
                            v:SetAttribute("Adjustment_Reflectance", u101.Value);
                            Handle.Reflectance = u101.Value / 100;
                        end;

                        if p102 then
                            task.spawn(function() -- Line: 779
                                -- upvalues: Remotes (ref), v (copy), u101 (copy), properties (ref), u71 (ref), u70 (ref)
                                Remotes.AccessoryAdjustmentAction:InvokeServer({
                                    Action = "ApplyPropertyAdjustment",
                                    Accessory = v,
                                    ActionType = u101.Action,
                                    Color = properties.currentColor.color.BackgroundColor3,
                                    UseColorEnabled = u71.State,
                                    IsEnabled = u70.State,
                                    Value = u101.Value,
                                    AssetId = u101.AssetId,
                                    CustomTextureId = v:GetAttribute("Adjustment_CustomTextureId")
                                });
                            end);
                        end;
                    end;
                else
                    v103 = v103 or {};
                    table.insert(v103, i);
                end;
            end;
        end;

        if v103 then
            for _, v in v103 do
                if u8[v] then
                    u13(v);
                end;
            end;

            Events.Notify:Fire("❌ Your avatar updated. Please re-select your accessories.");
        end;
    end;

    local function setupPropSlider(p125, u126) -- Line: 803
        -- upvalues: u6 (ref), u4 (ref), setupSliderCircle (ref), u7 (ref)
        table.insert(u6, p125.OnValueUpdated:Connect(function(p127) -- Line: 804
            -- upvalues: u4 (ref), u126 (copy)
            u4.ApplyChanges({
                Action = u126,
                Value = p127
            }, false);
        end));
        table.insert(u6, p125.OnInputEnded:Connect(function(p128) -- Line: 805
            -- upvalues: u4 (ref), u126 (copy)
            u4.ApplyChanges({
                Action = u126,
                Value = p128
            }, true);
        end));
        setupSliderCircle(p125, u6);
        table.insert(u7, p125);
    end;

    setupPropSlider(u73, "Reflectance");
    setupPropSlider(u72, "Transparency");
    table.insert(u6, u74.OnInputEnded:Connect(function() -- Line: 812
        -- upvalues: updateCustomColor (copy)
        updateCustomColor(nil, true, true);
    end));
    table.insert(u6, u75.OnInputEnded:Connect(function() -- Line: 813
        -- upvalues: updateCustomColor (copy)
        updateCustomColor(nil, true, true);
    end));
    table.insert(u6, properties.currentColor.value.input.FocusLost:Connect(function() -- Line: 814
        -- upvalues: ParseTextToColor (ref), properties (ref), updateCustomColor (copy)
        local v129 = ParseTextToColor(properties.currentColor.value.input.Text);

        if v129 then
            updateCustomColor(v129, true, true);

            return;
        end;

        properties.currentColor.value.input.Text = "#" .. string.upper(properties.currentColor.color.BackgroundColor3:ToHex());
    end));
    table.insert(u6, input.FocusLost:Connect(function() -- Line: 820
        -- upvalues: parseTextureId (ref), input (copy), u9 (ref), u8 (ref), u4 (ref), u14 (ref), Remotes (ref), u15 (ref), Events (ref)
        local v130 = parseTextureId(input.Text);

        if v130 == nil then
            local v131 = nil;

            if u9 then
                local v132 = u8[u9];

                if typeof(v132) == "Instance" then
                    v131 = v132:GetAttribute("Adjustment_CustomTextureId");
                end;
            end;

            input.Text = (typeof(v131) ~= "string" or v131 == "") and "" or (string.match(v131, "%d+") or v131);

            return;
        end;

        input.Text = (typeof(v130) ~= "string" or v130 == "") and "" or (string.match(v130, "%d+") or v130);
        u4.ApplyChanges({
            Action = "CustomTexture",
            AssetId = v130
        }, true);

        if v130 ~= "" then
            if u14 == nil then
                local success, result = pcall(function() -- Line: 62
                    -- upvalues: Remotes (ref)
                    return Remotes:WaitForChild("IsPrivateServer"):InvokeServer();
                end);

                if success then
                    success = result == true;
                end;

                u14 = success;
            end;

            if not (u14 or u15) then
                u15 = true;
                Events.Notify:Fire(
                    "⚠️ Custom textures only appear on your screen in public servers. Use a private server to share with others.",
                    7
                );
            end;
        end;
    end));
    table.insert(u6, u71.OnStateUpdated:Connect(function() -- Line: 841
        -- upvalues: u4 (ref), properties (ref)
        u4.ApplyChanges({
            Action = "Color",
            Color = properties.currentColor.color.BackgroundColor3
        }, true);
    end));
    table.insert(u6, u70.OnStateUpdated:Connect(function(p133) -- Line: 842
        -- upvalues: u71 (copy), u4 (ref)
        if not u71.State and p133 then
            u71:UpdateState(true);
        end;

        u4.ApplyChanges({
            Action = "Neon",
            IsEnabled = p133
        }, true);
    end));
    table.insert(u6, adjustmentSection.actions.reset.Activated:Connect(function() -- Line: 847
        -- upvalues: u71 (copy), u70 (copy), u74 (ref), u75 (ref), u72 (copy), u73 (copy), updateCustomColor (copy), input (copy), u4 (ref), u8 (ref), Remotes (ref)
        u71:UpdateState(false, true, true);
        u70:UpdateState(false, true, true);
        u74:SetValue(0, true, true, true);
        u75:SetValue(50, true, true, true);
        u72:SetValue(0, true, true);
        u73:SetValue(0, true, true);
        updateCustomColor(nil, false, false);
        input.Text = "";
        u4.ApplyChanges({
            Action = "CustomTexture",
            AssetId = ""
        }, false);
        u4.ApplyChanges({
            Action = "Color",
            Color = Color3.fromRGB(255, 255, 255)
        }, false);
        u4.ApplyChanges({
            Action = "Neon",
            IsEnabled = false
        }, false);
        u4.ApplyChanges({
            Action = "Transparency",
            Value = 0
        }, false);
        u4.ApplyChanges({
            Action = "Reflectance",
            Value = 0
        }, false);

        for _, v in u8 do
            if typeof(v) == "Instance" then
                task.spawn(function() -- Line: 866
                    -- upvalues: Remotes (ref), v (copy)
                    Remotes.AccessoryAdjustmentAction:InvokeServer({
                        Action = "ResetAdjustments",
                        Accessory = v
                    });
                end);
            end;
        end;

        local u134 = {};

        for i, _ in u8 do
            u134[tostring(i)] = {
                Position = Vector3.new(0, 0, 0),
                Scale = Vector3.new(1, 1, 1),
                Rotation = Vector3.new(0, 0, 0)
            };
        end;

        if next(u134) then
            task.spawn(function() -- Line: 885
                -- upvalues: Remotes (ref), u134 (copy)
                Remotes.AccessoryAdjustmentAction:InvokeServer({
                    Action = "ApplyTransformAdjustment",
                    Adjustments = u134
                });
            end);
        end;
    end));
    table.insert(u7, u74);
    table.insert(u7, u75);
    table.insert(u7, u70);
    table.insert(u7, u71);
    table.insert(u6, adjustmentSection.actions.transform.Activated:Connect(function() -- Line: 895
        -- upvalues: toggleTransformMode (ref)
        toggleTransformMode(true);
    end));
    update(HumanoidDescriptionController.GetCurrentDescription());

    if u9 and typeof(u8[u9]) == "Instance" then
        u4.LoadAttributes(u8[u9]);
    end;

    applySelectionMarkers();
end;

function u4.Close(p135) -- Line: 903
    -- upvalues: u4 (copy), removeSelectionMarkers (copy), Events (copy), cleanup (copy), u3 (copy), AccessoryAdjustment (copy)
    if not u4.IsOpen then
        return;
    end;

    u4.IsOpen = false;
    removeSelectionMarkers();
    Events.InterfaceAction:Fire("Remove", script.Name);

    if p135 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;

    cleanup();
    u3:Play();
    u3.Completed:Once(function() -- Line: 913
        -- upvalues: u4 (ref), AccessoryAdjustment (ref)
        if not u4.IsOpen then
            AccessoryAdjustment.Enabled = false;
        end;
    end);
end;

HumanoidDescriptionController.OnHumanoidDescriptionUpdated:Connect(update);
Events.DisplayAccessoryAdjustment.Event:Connect(u4.Open);

return u4;