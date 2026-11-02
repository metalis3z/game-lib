-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local AvatarEditorService = game:GetService("AvatarEditorService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local Modules = require(script.Parent.Parent.Parent.Modules);
local SliderController = require(Modules.Elements.SliderController);
local ToggleSwitchController = require(Modules.Elements.ToggleSwitchController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local Events = script.Parent.Parent.Parent.Events;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = nil;

local function isPrivateServer() -- Line: 19
    -- upvalues: u2 (ref), Remotes (copy)
    if u2 == nil then
        local success, result = pcall(function() -- Line: 21
            -- upvalues: Remotes (ref)
            return Remotes:WaitForChild("IsPrivateServer"):InvokeServer();
        end);

        if success then
            success = result == true;
        end;

        u2 = success;
    end;

    return u2;
end;

local u3 = {
    Yaw = 3.9269908169872414,
    Pitch = -0.3490658503988659,
    Distance = 7.5,
    PanOffset = Vector2.new(0, 0)
};
local u4 = {
    Position = {
        Min = -0.25,
        Max = 0.25
    },
    Scale = {
        Min = 0.8,
        Max = 1.2
    },
    Rotation = {
        Min = -180,
        Max = 180
    }
};
local u5 = {
    Position = {
        Min = -20,
        Max = 20
    },
    Scale = {
        Min = 0.05,
        Max = 15
    },
    Rotation = {
        Min = -360,
        Max = 360
    }
};
local v6 = {
    Enabled = false,
    BlocksHidden = true,
    _isToggling = false,
    _isRefreshing = false,
    RobloxBounds = true,
    ShowSliders = false,
    UniformScaling = true,
    IsDraggingGizmo = false,
    CurrentType = "position",
    AdjustmentCache = {},
    NewAdjustments = {},
    OutOfBounds = {},
    SelectedItems = {},
    AxisSliders = {},
    Connections = {},
    Objects = {},
    SetSlidersVisibleEvent = Instance.new("BindableEvent"),
    RobloxBoundsSwitches = {},
    ShowSlidersSwitches = {}
};
local u7 = nil;

local function stickyClamp(p8, p9, p10, p11, p12, p13) -- Line: 82
    if p10 < p8 then
        if not p13[p12] and p11 > p8 - p10 then
            return p10;
        end;

        p13[p12] = true;

        return p8;
    end;

    if p8 >= p9 then
        p13[p12] = false;

        return p8;
    end;

    if not p13[p12] and p11 > p9 - p8 then
        return p9;
    end;

    p13[p12] = true;

    return p8;
end;

local function setupSliderCircle(u14, p15) -- Line: 100
    -- upvalues: TweenService (copy), u1 (copy)
    local u16 = nil;
    table.insert(p15, u14.SliderButton.MouseEnter:Connect(function() -- Line: 102
        -- upvalues: u16 (ref), u14 (copy), TweenService (ref), u1 (ref)
        if u16 then
            u16:Destroy();
        end;

        u16 = Instance.new("Frame");
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = u16;
        u16.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        u16.Size = UDim2.fromScale(1, 1);
        u16.Position = UDim2.fromScale(0.5, 0.5);
        u16.AnchorPoint = Vector2.new(0.5, 0.5);
        u16.BackgroundTransparency = 1;
        u16.Name = "hoverCircle";
        u16.Parent = u14.Circle;
        TweenService:Create(u16, u1, {
            BackgroundTransparency = 0.8,
            Size = UDim2.fromScale(2, 2)
        }):Play();
    end));
    table.insert(p15, u14.SliderButton.MouseLeave:Connect(function() -- Line: 118
        -- upvalues: u16 (ref), TweenService (ref), u1 (ref)
        if u16 then
            TweenService:Create(u16, u1, {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1)
            }):Play();
            game.Debris:AddItem(u16, u1.Time);
        end;
    end));
    table.insert(p15, u14.SliderButton.MouseButton1Down:Connect(function() -- Line: 126
        -- upvalues: u16 (ref), TweenService (ref), u1 (ref)
        if u16 then
            TweenService:Create(u16, u1, {
                Size = UDim2.fromScale(2.5, 2.5)
            }):Play();
        end;
    end));
    table.insert(p15, u14.SliderButton.MouseButton1Up:Connect(function() -- Line: 132
        -- upvalues: u16 (ref), TweenService (ref), u1 (ref)
        if u16 then
            TweenService:Create(u16, u1, {
                Size = UDim2.fromScale(2, 2)
            }):Play();
        end;
    end));
end;

function v6.Init(p17, p18) -- Line: 139
    p17.Config = p18;
end;

function v6.UpdateGizmoFaces(p19) -- Line: 143
    if not p19.MoveGizmo then
        return;
    end;

    if p19.CurrentType == "scale" and p19.UniformScaling then
        p19.MoveGizmo.Faces = Faces.new(Enum.NormalId.Top);

        return;
    end;

    p19.MoveGizmo.Faces = Faces.new(Enum.NormalId.Top, Enum.NormalId.Bottom, Enum.NormalId.Left, Enum.NormalId.Right, Enum.NormalId.Front, Enum.NormalId.Back);
end;

function v6.CheckOutOfBounds(p20, p21) -- Line: 152
    -- upvalues: u4 (copy), Events (copy)
    local v22 = p20.AdjustmentCache[p21];

    if not v22 then
        return;
    end;

    local v23 = false;

    if p20.RobloxBounds and p20.AvatarRules then
        local v24 = p20.SelectedItems[tostring(p21)];

        if v24 then
            local v25 = v24.AccessoryType == Enum.AccessoryType.Hat and "Hat" or v24.AccessoryType.Name .. "Accessory";
            local v26 = p20.AvatarRules.AccessoryRefinementLowerBounds and p20.AvatarRules.AccessoryRefinementLowerBounds[v25];
            local v27 = p20.AvatarRules.AccessoryRefinementUpperBounds and p20.AvatarRules.AccessoryRefinementUpperBounds[v25];

            for _, v in { "Position", "Rotation", "Scale" } do
                local v28 = v22[v];

                if v28 then
                    for _, v2 in { "X", "Y", "Z" } do
                        local v29 = v2 .. v;
                        local v30 = math.floor(v28[v2] * 100) / 100;
                        local Min = u4[v].Min;
                        local Max = u4[v].Max;

                        if v26 and v26[v] then
                            Min = v26[v][v29] or Min;
                        end;

                        if v27 and v27[v] then
                            Max = v27[v][v29] or Max;
                        end;

                        if v30 < Min or Max < v30 then
                            v23 = true;
                            break;
                        end;
                    end;
                end;

                if v23 then
                    break;
                end;
            end;
        end;
    end;

    local v31 = p20.OutOfBounds[p21] == true;
    p20.OutOfBounds[p21] = v23 and true or nil;

    if v23 and not v31 then
        if (p20.LastBoundsWarning or 0) < tick() - 8 then
            p20.LastBoundsWarning = tick();
            Events.Notify:Fire("⚠️ This accessory is past the Roblox bounds.");
        end;

        local v32 = p20.Config.ItemsContainer:FindFirstChild((tostring(p21)));

        if v32 and not v32:FindFirstChild("outOfBounds") then
            local v33 = p20.Config.OutOfBoundsTemplate:Clone();
            v33.Parent = v32;
            Events.AddTooltipToObject:Fire(v33, "This accessory is outside the allowed limit.");
        end;

        local v34 = p20.SelectedItems[tostring(p21)];

        if v34 then
            v34 = v34:FindFirstChild("Handle");
        end;

        if v34 and not v34:FindFirstChild("outOfBoundsHighlight") then
            local Highlight = Instance.new("Highlight");
            Highlight.Name = "outOfBoundsHighlight";
            Highlight.FillColor = Color3.fromRGB(255, 0, 0);
            Highlight.FillTransparency = 0.5;
            Highlight.OutlineTransparency = 1;
            Highlight.Parent = v34;
        end;
    elseif not v23 and v31 then
        local v35 = p20.Config.ItemsContainer:FindFirstChild((tostring(p21)));

        if v35 and v35:FindFirstChild("outOfBounds") then
            v35.outOfBounds:Destroy();
        end;

        local v36 = p20.SelectedItems[tostring(p21)];

        if v36 then
            v36 = v36:FindFirstChild("Handle");
        end;

        if v36 and v36:FindFirstChild("outOfBoundsHighlight") then
            v36.outOfBoundsHighlight:Destroy();
        end;
    end;
end;

function v6.SyncToDescription(p37) -- Line: 223
    local v38 = p37.Config.GetPrimarySelectedId();
    local v39;

    if v38 then
        v39 = p37.AdjustmentCache[v38];
    else
        v39 = v38;
    end;

    local v40 = p37.Character and p37.Character:FindFirstChildOfClass("Humanoid");

    if v40 and v39 then
        local v41 = v40:GetAppliedDescription();
        local v42 = v41:GetAccessories(true);

        for i, v in v42 do
            if tostring(v.AssetId) == v38 then
                v42[i] = v39;
                break;
            end;
        end;

        v41:SetAccessories(v42, true);
        v40:ApplyDescription(v41);
    end;
end;

function v6.RefreshUIFromCache(p43) -- Line: 241
    local v44 = p43.Config.GetPrimarySelectedId();

    if v44 then
        v44 = p43.AdjustmentCache[v44];
    end;

    if not v44 then
        return;
    end;

    p43._isRefreshing = true;

    for _, v in p43.AxisSliders do
        local v45 = v44[v.Mode][v.Axis];
        v.Instance:SetValue(v45, false, true, true);
        local v46 = p43.Config.TransformSection.properties[v.Mode:lower()]:FindFirstChild(v.Axis:lower());

        if v46 then
            local input = v46.value.input;
            local v47 = tonumber(string.format("%.3f", v45)) + 0;
            input.Text = tostring(v47);
        end;
    end;

    p43._isRefreshing = false;
end;

function v6.OnCharacterLoaded(p48) -- Line: 258
    if not p48.PreloadedCharacter then
        return;
    end;

    p48.Character = p48.PreloadedCharacter;
    p48.Character.Parent = workspace;

    if p48.Map then
        local v49 = p48.Character:FindFirstChildOfClass("Humanoid");
        local HumanoidRootPart = p48.Character:FindFirstChild("HumanoidRootPart");
        p48.Character:PivotTo(p48.Map.CFrames.Character.Value * CFrame.new(0, HumanoidRootPart.Size.Y / 2 + (v49.RigType == Enum.HumanoidRigType.R6 and 3.5 or v49.HipHeight), 0));
    end;

    p48:UpdateSelection();

    for i, _ in p48.AdjustmentCache do
        p48:CheckOutOfBounds(i);
    end;
end;

function v6.UpdateSelection(p50) -- Line: 277
    -- upvalues: HumanoidDescriptionController (copy), AvatarEditorService (copy), Events (copy)
    if not p50.Character then
        return;
    end;

    local v51 = HumanoidDescriptionController.GetCurrentDescription():GetAccessories(true);
    local v52 = p50.Config.GetSelectedItems();
    local v53 = p50.Config.GetPrimarySelectedId();
    local v54 = {};

    for _, v in v51 do
        v54[tostring(v.AssetId)] = v;
    end;

    for _, child in p50.Character:GetChildren() do
        if child:IsA("Accessory") then
            local v55 = nil;
            local v56 = child:GetAttribute("AVMAssetId");

            if v56 then
                if typeof(v52[v56]) ~= "Instance" then
                    v56 = v55;
                end;
            else
                v56 = v55;
            end;

            local Handle = child:FindFirstChild("Handle");

            if Handle then
                local SelectionHighlight = Handle:FindFirstChild("SelectionHighlight");

                if v56 then
                    local v57 = v54[v56];

                    if p50.AvatarRules and p50.AvatarRules.AccessoryRefinementTypes then
                        local v58 = false;

                        for _, v in p50.AvatarRules.AccessoryRefinementTypes do
                            if AvatarEditorService:GetAccessoryType(Enum.AvatarAssetType:FromValue(v)) == v57.AccessoryType then
                                v58 = true;
                                break;
                            end;
                        end;

                        if not v58 then
                            Events.Notify:Fire("⚠️ \'<b>" .. tostring(v57.AccessoryType.Name) .. "</b>\' adjustments can\'t save to Roblox, but they will work on your outfits in Avatar Maker.", 7);
                        end;
                    end;

                    p50.SelectedItems[v56] = child;

                    if v56 == v53 then
                        p50.CurrentHandleInstance = Handle;

                        if p50.GizmoProxy then
                            p50.MoveGizmo.Adornee = p50.GizmoProxy;
                            p50.RotateGizmo.Adornee = p50.GizmoProxy;
                        end;
                    end;

                    if not p50.AdjustmentCache[v56] then
                        p50.AdjustmentCache[v56] = v57;
                    end;

                    if not SelectionHighlight then
                        local Highlight = Instance.new("Highlight");
                        Highlight.Name = "SelectionHighlight";
                        Highlight.FillTransparency = 1;
                        Highlight.OutlineTransparency = 0.5;
                        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
                        Highlight.Adornee = Handle;
                        Highlight.Parent = Handle;
                    end;
                else
                    if SelectionHighlight then
                        SelectionHighlight:Destroy();
                    end;

                    for i, v in p50.SelectedItems do
                        if v == child then
                            p50.SelectedItems[i] = nil;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if not p50.IsDraggingGizmo then
        p50:RefreshSliderBounds();
    end;
end;

function v6.RefreshSliderBounds(p59) -- Line: 352
    -- upvalues: u5 (copy), u4 (copy)
    local v60 = p59.Config.GetPrimarySelectedId();
    local v61;

    if v60 then
        v61 = p59.SelectedItems[tostring(v60)];
    else
        v61 = v60;
    end;

    if not v61 then
        return;
    end;

    local v62 = v61.AccessoryType == Enum.AccessoryType.Hat and "Hat" or v61.AccessoryType.Name .. "Accessory";
    local v63 = p59.AdjustmentCache[v60];
    p59._isRefreshing = true;

    for _, v in p59.AxisSliders do
        local v64 = u5[v.Mode];
        local Min = v64.Min;
        local Max = v64.Max;

        if p59.RobloxBounds and p59.AvatarRules then
            local AccessoryRefinementLowerBounds = p59.AvatarRules.AccessoryRefinementLowerBounds;
            local AccessoryRefinementUpperBounds = p59.AvatarRules.AccessoryRefinementUpperBounds;
            Min = u4[v.Mode].Min;
            Max = u4[v.Mode].Max;

            if AccessoryRefinementLowerBounds and (AccessoryRefinementLowerBounds[v62] and AccessoryRefinementLowerBounds[v62][v.Mode]) then
                Min = AccessoryRefinementLowerBounds[v62][v.Mode][v.Axis .. v.Mode] or Min;
            end;

            if AccessoryRefinementUpperBounds and (AccessoryRefinementUpperBounds[v62] and AccessoryRefinementUpperBounds[v62][v.Mode]) then
                Max = AccessoryRefinementUpperBounds[v62][v.Mode][v.Axis .. v.Mode] or Max;
            end;
        end;

        if v63 then
            local v65 = v63[v.Mode][v.Axis];
            v.Instance:SetValue(v65, false, true, true);
            local v66 = p59.Config.TransformSection.properties[v.Mode:lower()]:FindFirstChild(v.Axis:lower());

            if v66 then
                local input = v66.value.input;
                local v67 = tonumber(string.format("%.3f", v65)) + 0;
                input.Text = tostring(v67);
            end;
        end;

        v.Instance.Increment = 0.00001;
        v.Instance:SetBounds(Min, Max);
    end;

    p59._isRefreshing = false;
end;

function v6.OnTransformUpdate(p68, p69, p70, p71) -- Line: 389
    local v72 = p68.Config.GetPrimarySelectedId();

    if p68._isRefreshing or not (v72 and p68.AdjustmentCache[v72]) then
        return;
    end;

    local v73 = p68.AdjustmentCache[v72];

    if typeof(p71) == "Vector3" then
        v73[p69] = p71;
    elseif p69 == "Scale" and p68.UniformScaling then
        v73.Scale = Vector3.new(p71, p71, p71);
    else
        local v74 = v73[p69] or Vector3.new();
        local v75;

        if p70 == "X" then
            v75 = p71;
        else
            v75 = v74.X;
        end;

        local v76;

        if p70 == "Y" then
            v76 = p71;
        else
            v76 = v74.Y;
        end;

        if p70 ~= "Z" then
            p71 = v74.Z;
        end;

        v73[p69] = Vector3.new(v75, v76, p71);
    end;

    p68.NewAdjustments[v72] = v73;
    p68:CheckOutOfBounds(v72);
    p68:RefreshUIFromCache();
    p68:SyncToDescription();
end;

function v6.SetupAxisSlider(u77, p78, u79, u80) -- Line: 407
    -- upvalues: SliderController (copy), setupSliderCircle (copy)
    local u81 = SliderController.new({
        MinValue = -1,
        MaxValue = 1,
        NoPercentageSign = true,
        Increment = 0.00001,
        SliderButton = p78.slider
    });
    setupSliderCircle(u81, u77.Connections);
    local v82 = {
        Instance = u81,
        Mode = u79,
        Axis = u80:upper()
    };
    local input = p78:WaitForChild("value"):WaitForChild("input");
    table.insert(u77.Connections, u81.OnValueUpdated:Connect(function(p83) -- Line: 419
        -- upvalues: u77 (copy), u79 (copy), u81 (copy), input (copy), u80 (copy)
        if u77._isRefreshing then
            return;
        end;

        local input2 = u77.Config.TransformSection.properties[u79:lower()].options.increment.value.input;
        local v84 = tonumber(input2:GetAttribute("value")) or 0.001;
        local v85 = math.round(p83 / v84) * v84;
        local v86 = math.abs(p83) < math.max(v84, 0.009) and 0 or v85;
        u81:SetValue(v86, false, true, true);
        local v87 = tonumber(string.format("%.3f", v86)) + 0;
        input.Text = tostring(v87);
        u77:OnTransformUpdate(u79, u80, v86);
    end));
    table.insert(u77.Connections, input.FocusLost:Connect(function() -- Line: 430
        -- upvalues: input (copy), u77 (copy), u79 (copy), u80 (copy), u81 (copy)
        local v88 = tonumber(input.Text);

        if v88 then
            u77:OnTransformUpdate(u79, u80, v88);

            return;
        end;

        local v89 = tonumber(string.format("%.3f", u81.Value)) + 0;
        input.Text = tostring(v89);
    end));
    table.insert(u77.Objects, u81);
    table.insert(u77.AxisSliders, v82);
end;

function v6.SetupPropertyContainer(u90, p91, u92) -- Line: 443
    -- upvalues: ToggleSwitchController (copy), u2 (ref), Remotes (copy), Events (copy)
    for _, child in p91:GetChildren() do
        if child.Name == "x" or (child.Name == "y" or child.Name == "z") then
            u90:SetupAxisSlider(child, u92, child.Name:upper());
        end;
    end;

    local increment = p91.options:FindFirstChild("increment");

    if increment then
        local input = increment:WaitForChild("value"):WaitForChild("input");
        local u93 = u92 == "Rotation" and "0.001" or "0.01";

        local function setIncrement() -- Line: 455
            -- upvalues: input (copy), u92 (copy), u93 (ref), u90 (copy)
            local v94 = tonumber(input.Text);
            local v95 = (u92 == "Position" or u92 == "Scale") and " studs" or (u92 == "Rotation" and "°" or "");

            if not v94 then
                input.Text = u93 .. v95;

                return;
            end;

            local v96 = math.max(v94, 0.0001);
            u93 = tostring(v96);
            input:SetAttribute("value", v96);
            input.Text = u93 .. v95;
            u90:RefreshSliderBounds();
        end;

        input.Text = u93;
        setIncrement();
        table.insert(u90.Connections, input.FocusLost:Connect(setIncrement));
    end;

    if u92 == "Scale" then
        local v97 = ToggleSwitchController.new({
            State = true,
            Button = p91.options.uniformScaling.switch
        });
        table.insert(u90.Connections, v97.OnStateUpdated:Connect(function(p98) -- Line: 478
            -- upvalues: u90 (copy)
            u90.UniformScaling = p98;
            u90:UpdateGizmoFaces();
        end));
        table.insert(u90.Objects, v97);
    end;

    local u99 = ToggleSwitchController.new({
        Button = p91.options.robloxBounds.switch,
        State = u90.RobloxBounds
    });
    table.insert(u90.RobloxBoundsSwitches, u99);
    table.insert(u90.Connections, u99.OnStateUpdated:Connect(function(p100) -- Line: 487
        -- upvalues: u2 (ref), Remotes (ref), Events (ref), u90 (copy), u99 (copy)
        if p100 == false then
            if u2 == nil then
                local success, result = pcall(function() -- Line: 21
                    -- upvalues: Remotes (ref)
                    return Remotes:WaitForChild("IsPrivateServer"):InvokeServer();
                end);

                if success then
                    success = result == true;
                end;

                u2 = success;
            end;

            if not u2 then
                Events.Notify:Fire("⚠️You can only disable Roblox Bounds in a <b>private server</b>.");

                for _, v in u90.RobloxBoundsSwitches do
                    v:UpdateState(true, false, true);
                end;

                return;
            end;
        end;

        u90.RobloxBounds = p100;
        u90:CheckOutOfBounds(u90.Config.GetPrimarySelectedId());
        u90:RefreshSliderBounds();

        for _, v in u90.RobloxBoundsSwitches do
            if v ~= u99 then
                v:UpdateState(p100, true, true);
            end;
        end;
    end));
    table.insert(u90.Objects, u99);
    local u101 = ToggleSwitchController.new({
        Button = p91.options.showSliders.switch,
        State = u90.ShowSliders
    });
    table.insert(u90.ShowSlidersSwitches, u101);
    table.insert(u90.Connections, u101.OnStateUpdated:Connect(function(p102) -- Line: 506
        -- upvalues: u90 (copy), u101 (copy)
        u90.ShowSliders = p102;
        u90.SetSlidersVisibleEvent:Fire(p102);

        for _, v in u90.ShowSlidersSwitches do
            if v ~= u101 then
                v:UpdateState(p102, true, true);
            end;
        end;
    end));
    table.insert(u90.Objects, u101);
end;

function v6.ApplyBlockVisibility(p103) -- Line: 516
    if not p103._blockInstances then
        return;
    end;

    local v104 = p103.BlocksHidden == true;

    for _, v in p103._blockInstances do
        if v.inst and v.inst.Parent then
            v.inst.Transparency = v104 and 1 or v.orig;
        end;
    end;
end;

function v6.SetBlocksHidden(p105, p106) -- Line: 526
    p105.BlocksHidden = p106 == true;
    p105:ApplyBlockVisibility();
end;

function v6.Toggle(u107, p108, p109) -- Line: 531
    -- upvalues: ReplicatedStorage (copy), Events (copy), LocalPlayer (copy), u3 (copy), UserInputService (copy), u7 (ref), RunService (copy), u4 (copy)
    if u107.Enabled == p108 then
        return;
    end;

    for _, v in u107.Connections do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect();
        end;
    end;

    table.clear(u107.Connections);

    for _, v in u107.Objects do
        if typeof(v) == "Instance" then
            pcall(v.Destroy, v);
        elseif type(v) == "table" and v.Cleanup then
            pcall(v.Cleanup, v);
        end;
    end;

    table.clear(u107.Objects);
    u107.Enabled = p108;

    if not p108 then
        table.clear(u107.AdjustmentCache);
        table.clear(u107.OutOfBounds);
        table.clear(u107.NewAdjustments);
        table.clear(u107.RobloxBoundsSwitches);
        table.clear(u107.ShowSlidersSwitches);

        for _, child in u107.Config.ItemsContainer:GetChildren() do
            local outOfBounds = child:FindFirstChild("outOfBounds");

            if outOfBounds then
                outOfBounds:Destroy();
            end;
        end;

        if u107.Character then
            for _, child in u107.Character:GetChildren() do
                local Handle = child:FindFirstChild("Handle");
                local v110 = Handle and Handle:FindFirstChild("outOfBoundsHighlight");

                if v110 then
                    v110:Destroy();
                end;
            end;
        end;

        if u107.Map then
            u107.Map:Destroy();
        end;

        u107.Map = nil;
        u107._blockInstances = nil;

        if u107.Character then
            u107.Character.Parent = nil;
        end;

        if u107.Camera then
            u107.Camera:Destroy();
        end;

        if u107._controlModule then
            u107._controlModule:Enable();
            u107._controlModule = nil;
        end;

        local Camera = Instance.new("Camera");
        Camera.CameraType = Enum.CameraType.Custom;

        if LocalPlayer.Character then
            Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
        end;

        Camera.Parent = workspace;
        workspace.CurrentCamera = Camera;

        return;
    end;

    local AccessoryAdjustmentMap = ReplicatedStorage:WaitForChild("Assets"):FindFirstChild("AccessoryAdjustmentMap");

    if not AccessoryAdjustmentMap then
        Events.Notify:Fire("⚠️ An error occured: noMap");
        u107.Enabled = false;

        return;
    end;

    u107.SelectedItems = {};
    u107.AxisSliders = {};
    u107.NewAdjustments = {};
    u107.RobloxBoundsSwitches = {};
    u107.ShowSlidersSwitches = {};
    u107._isToggling = false;
    local v111 = AccessoryAdjustmentMap:Clone();
    u107.Map = v111;
    v111.Parent = workspace;
    u107._blockInstances = {};

    for _, v in { "LargerShapes", "Clouds" } do
        local v112 = v111:FindFirstChild(v);

        if v112 and v112:IsA("BasePart") then
            table.insert(u107._blockInstances, {
                inst = v112,
                orig = v112.Transparency
            });

            for _, descendant in v112:GetDescendants() do
                if descendant:IsA("Texture") or descendant:IsA("Decal") then
                    table.insert(u107._blockInstances, {
                        inst = descendant,
                        orig = descendant.Transparency
                    });
                end;
            end;
        end;
    end;

    local success, result = pcall(function() -- Line: 580
        -- upvalues: Events (ref)
        return Events.GetSetting:Invoke({ "Miscellaneous", "HideBlocksInTransformMode" });
    end);
    u107.BlocksHidden = (not success or result == nil) and true or result == true;
    u107:ApplyBlockVisibility();
    u107.GizmoProxy = Instance.new("Part");
    u107.GizmoProxy.Name = "GizmoProxy";
    u107.GizmoProxy.Size = Vector3.new(1, 1, 1);
    u107.GizmoProxy.Transparency = 1;
    u107.GizmoProxy.Anchored = true;
    u107.GizmoProxy.CanCollide = false;
    u107.GizmoProxy.Parent = v111;
    u107.MoveGizmo = Instance.new("Handles");
    u107.MoveGizmo.Style = Enum.HandlesStyle.Movement;
    u107.MoveGizmo.Color3 = Color3.fromRGB(38, 255, 0);
    u107.MoveGizmo.Parent = u107.Config.ScreenGui;
    u107.MoveGizmo.Visible = false;
    table.insert(u107.Objects, u107.MoveGizmo);
    u107.RotateGizmo = Instance.new("ArcHandles");
    u107.RotateGizmo.Parent = u107.Config.ScreenGui;
    u107.RotateGizmo.Visible = false;
    table.insert(u107.Objects, u107.RotateGizmo);
    u107.Camera = Instance.new("Camera");
    u107.Camera.CameraType = Enum.CameraType.Scriptable;
    u107.Camera.Parent = workspace;
    workspace.CurrentCamera = u107.Camera;
    local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");

    if PlayerModule then
        local v113 = require(PlayerModule):GetControls();
        v113:Disable();
        u107._controlModule = v113;
    end;

    local Pitch = u3.Pitch;
    local Distance = u3.Distance;
    local PanOffset = u3.PanOffset;
    u107.TargetYaw = u3.Yaw;
    u107.TargetPitch = Pitch;
    u107.TargetDistance = Distance;
    u107.TargetPanOffset = PanOffset;
    local TargetPitch = u107.TargetPitch;
    local TargetDistance = u107.TargetDistance;
    local TargetPanOffset = u107.TargetPanOffset;
    u107.CurrentYaw = u107.TargetYaw;
    u107.CurrentPitch = TargetPitch;
    u107.CurrentDistance = TargetDistance;
    u107.CurrentPanOffset = TargetPanOffset;
    local u114 = false;
    local u115 = false;
    local u116 = nil;
    local u117 = nil;
    local u118 = nil;
    local u119 = nil;
    local u120 = nil;
    local u121 = nil;
    table.insert(u107.Connections, UserInputService.InputBegan:Connect(function(p122, p123) -- Line: 632
        -- upvalues: u114 (ref), u116 (ref), u115 (ref), u117 (ref), u119 (ref), u118 (ref), u120 (ref), u121 (ref)
        if p123 then
            return;
        end;

        local UserInputType = p122.UserInputType;

        if UserInputType == Enum.UserInputType.MouseButton2 then
            u114 = true;
            u116 = p122.Position;

            return;
        end;

        if UserInputType ~= Enum.UserInputType.MouseButton3 then
            if UserInputType == Enum.UserInputType.Touch then
                if not u117 then
                    u117 = p122;
                    u119 = p122.Position;

                    return;
                end;

                if not u118 then
                    u118 = p122;
                    u120 = (u117.Position - u118.Position).Magnitude;
                    u121 = (u117.Position + u118.Position) * 0.5;
                end;
            end;

            return;
        end;

        u115 = true;
        u116 = p122.Position;
    end));
    table.insert(u107.Connections, UserInputService.InputEnded:Connect(function(p124) -- Line: 654
        -- upvalues: u7 (ref), u107 (copy), u114 (ref), u115 (ref), u118 (ref), u120 (ref), u121 (ref), u117 (ref), u119 (ref)
        local UserInputType = p124.UserInputType;

        if UserInputType == Enum.UserInputType.MouseButton1 then
            u7 = nil;
            u107.IsDraggingGizmo = false;
            u107:SyncToDescription();

            return;
        end;

        if UserInputType == Enum.UserInputType.MouseButton2 then
            u114 = false;

            return;
        end;

        if UserInputType == Enum.UserInputType.MouseButton3 then
            u115 = false;

            return;
        end;

        if UserInputType == Enum.UserInputType.Touch then
            if u118 and p124 == u118 then
                u118 = nil;
                u120 = nil;
                u121 = nil;
            end;

            if u117 and p124 == u117 then
                if u118 then
                    u117 = u118;
                    u118 = nil;
                    u119 = u117.Position;
                    u120 = nil;
                    u121 = nil;

                    return;
                end;

                u117 = nil;
                u119 = nil;
                u7 = nil;
                u107.IsDraggingGizmo = false;
                u107:SyncToDescription();
            end;
        end;
    end));
    table.insert(u107.Connections, UserInputService.InputChanged:Connect(function(p125) -- Line: 689
        -- upvalues: u114 (ref), u115 (ref), u116 (ref), u107 (copy), UserInputService (ref), LocalPlayer (ref), u117 (ref), u118 (ref), u119 (ref), u121 (ref), u120 (ref)
        local UserInputType = p125.UserInputType;

        if UserInputType == Enum.UserInputType.MouseMovement then
            if not (u114 or u115) then
                return;
            end;

            if not u116 then
                u116 = p125.Position;

                return;
            end;

            local v126 = p125.Position - u116;
            u116 = p125.Position;

            if u114 and not u107.IsDraggingGizmo then
                local v127 = u107;
                v127.TargetYaw = v127.TargetYaw - v126.X * 0.01;
                u107.TargetPitch = math.clamp(u107.TargetPitch - v126.Y * 0.01, -1.3962634015954636, 1.3962634015954636);

                return;
            end;

            if u115 then
                u107.TargetPanOffset = Vector2.new(math.clamp(u107.TargetPanOffset.X - v126.X * 0.005, -1.75, 1.75), (math.clamp(u107.TargetPanOffset.Y + v126.Y * 0.005, -1.75, 1.75)));
            end;
        elseif UserInputType == Enum.UserInputType.MouseWheel then
            local v128 = UserInputService:GetMouseLocation();
            local v129 = false;

            for _, v in LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(v128.X, v128.Y) do
                if v:IsA("ScrollingFrame") or v:IsDescendantOf(u107.Config.ItemsContainer) then
                    v129 = true;
                    break;
                end;
            end;

            if not v129 then
                u107.TargetDistance = math.clamp(u107.TargetDistance - p125.Position.Z * 0.5, 1.5, 27);
            end;
        elseif UserInputType == Enum.UserInputType.Touch then
            if u117 and (p125 == u117 and not u118) then
                if u107.IsDraggingGizmo then
                    return;
                end;

                local Position = p125.Position;

                if not u119 then
                    u119 = Position;

                    return;
                end;

                local v130 = Position - u119;
                u119 = Position;
                local v131 = u107;
                v131.TargetYaw = v131.TargetYaw - v130.X * 0.01;
                u107.TargetPitch = math.clamp(u107.TargetPitch - v130.Y * 0.01, -1.3962634015954636, 1.3962634015954636);

                return;
            end;

            if u117 and (u118 and (p125 == u117 or p125 == u118)) then
                local Position = u117.Position;
                local Position2 = u118.Position;
                local v132 = (Position + Position2) * 0.5;
                local Magnitude = (Position - Position2).Magnitude;

                if u121 then
                    local v133 = v132 - u121;
                    u107.TargetPanOffset = Vector2.new(math.clamp(u107.TargetPanOffset.X - v133.X * 0.005, -1.75, 1.75), (math.clamp(u107.TargetPanOffset.Y + v133.Y * 0.005, -1.75, 1.75)));
                end;

                if u120 then
                    u107.TargetDistance = math.clamp(u107.TargetDistance - (Magnitude - u120) * 0.02, 1.5, 27);
                end;

                u121 = v132;
                u120 = Magnitude;
            end;
        end;
    end));
    table.insert(u107.Connections, UserInputService.InputChanged:Connect(function(p134) -- Line: 757
        -- upvalues: u107 (copy)
        if p134.UserInputType == Enum.UserInputType.Gamepad1 and p134.KeyCode == Enum.KeyCode.Thumbstick2 then
            local v135 = math.abs(p134.Position.X) <= 0.15 and 0 or p134.Position.X;
            local v136 = math.abs(p134.Position.Y) <= 0.15 and 0 or p134.Position.Y;
            local v137 = u107;
            v137.TargetYaw = v137.TargetYaw - v135 * 0.01 * 5;
            u107.TargetPitch = math.clamp(u107.TargetPitch + v136 * 0.01 * 5, -1.3962634015954636, 1.3962634015954636);
        end;
    end));
    table.insert(u107.Connections, UserInputService.InputBegan:Connect(function(p138, p139) -- Line: 767
        -- upvalues: u107 (copy)
        if p139 then
            return;
        end;

        if p138.KeyCode == Enum.KeyCode.ButtonR1 then
            u107.TargetDistance = math.clamp(u107.TargetDistance - 0.5, 1.5, 27);

            return;
        end;

        if p138.KeyCode == Enum.KeyCode.ButtonL1 then
            u107.TargetDistance = math.clamp(u107.TargetDistance + 0.5, 1.5, 27);
        end;
    end));
    table.insert(u107.Connections, RunService.RenderStepped:Connect(function(p140) -- Line: 776
        -- upvalues: u107 (copy)
        if not u107.Character then
            return;
        end;

        local HumanoidRootPart = u107.Character:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        local v141 = math.clamp(p140 * 25, 0, 1);
        local TargetPitch2 = u107.TargetPitch;
        u107.CurrentYaw = u107.TargetYaw;
        u107.CurrentPitch = TargetPitch2;
        u107.CurrentDistance = u107.CurrentDistance + (u107.TargetDistance - u107.CurrentDistance) * v141;
        u107.CurrentPanOffset = u107.CurrentPanOffset:Lerp(u107.TargetPanOffset, v141);
        u107.Camera.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, HumanoidRootPart.Size.Y / 2, 0)) * CFrame.Angles(0, u107.CurrentYaw, 0) * CFrame.Angles(u107.CurrentPitch, 0, 0) * CFrame.new(u107.CurrentPanOffset.X, u107.CurrentPanOffset.Y, u107.CurrentDistance);

        if u107.CurrentHandleInstance and u107.GizmoProxy then
            u107.GizmoProxy.CFrame = u107.CurrentHandleInstance.CFrame;
        end;
    end));

    if u107.PreloadedCharacter then
        u107:OnCharacterLoaded();
    end;

    u107:SetupPropertyContainer(u107.Config.TransformSection.properties.position, "Position");
    u107:SetupPropertyContainer(u107.Config.TransformSection.properties.rotation, "Rotation");
    u107:SetupPropertyContainer(u107.Config.TransformSection.properties.scale, "Scale");

    for _, child in u107.Config.TransformSection.properties.modes:GetChildren() do
        if child:IsA("TextButton") then
            table.insert(u107.Connections, child.Activated:Connect(function() -- Line: 800
                -- upvalues: u107 (copy), child (copy)
                if u107.Config.OnRequestSubMode then
                    u107.Config.OnRequestSubMode(child.Name);
                end;
            end));
        end;
    end;

    table.insert(u107.Connections, u107.Config.TransformSection.bottomActions.cancel.Activated:Connect(function() -- Line: 808
        -- upvalues: u107 (copy)
        if u107._isToggling then
            return;
        end;

        u107._isToggling = true;

        if u107.Config.OnRequestToggle then
            u107.Config.OnRequestToggle(false);
        end;

        u107._isToggling = false;
    end));
    table.insert(u107.Connections, u107.Config.TransformSection.bottomActions.apply.Activated:Connect(function() -- Line: 816
        -- upvalues: u107 (copy)
        if u107._isToggling then
            return;
        end;

        u107._isToggling = true;

        if u107.Config.OnRequestToggle then
            u107.Config.OnRequestToggle(false, true);
        end;

        u107._isToggling = false;
    end));
    table.insert(u107.Connections, u107.MoveGizmo.MouseButton1Down:Connect(function(p142) -- Line: 825
        -- upvalues: u118 (ref), u107 (copy), u7 (ref)
        if u118 then
            return;
        end;

        local v143 = u107.Config.GetPrimarySelectedId();

        if not (v143 and u107.MoveGizmo.Adornee) then
            return;
        end;

        u107.IsDraggingGizmo = true;
        local v144 = u107.AdjustmentCache[v143];
        u7 = {
            Position = v144.Position,
            Rotation = v144.Rotation,
            Scale = v144.Scale,
            BaseCFrame = u107.MoveGizmo.Adornee.CFrame.Rotation,
            IsFree = {
                X = false,
                Y = false,
                Z = false
            }
        };
    end));
    table.insert(u107.Connections, u107.MoveGizmo.MouseDrag:Connect(function(p145, p146) -- Line: 834
        -- upvalues: u7 (ref), u118 (ref), u107 (copy), u4 (ref)
        if not u7 or u118 then
            return;
        end;

        local v147 = u107.Config.GetPrimarySelectedId();
        local v148 = u107.SelectedItems[tostring(v147)];

        if not v148 then
            return;
        end;

        local v149 = v148 and v148.AccessoryType == Enum.AccessoryType.Hat and "Hat" or v148.AccessoryType.Name .. "Accessory";

        if u107.CurrentType ~= "position" then
            if u107.CurrentType == "scale" then
                local v150 = p146 * 0.5;
                local v151 = tonumber(u107.Config.TransformSection.properties.scale.options.increment.value.input:GetAttribute("value")) or 0.01;

                if u107.UniformScaling then
                    local v152 = math.round((u7.Scale.X + v150) / v151) * v151;
                    local v153 = u107.AvatarRules.AccessoryRefinementLowerBounds and u107.AvatarRules.AccessoryRefinementLowerBounds[v149] and u107.AvatarRules.AccessoryRefinementLowerBounds[v149].Scale.XScale or u4.Scale.Min;
                    local v154 = u107.AvatarRules.AccessoryRefinementUpperBounds and (u107.AvatarRules.AccessoryRefinementUpperBounds[v149] and u107.AvatarRules.AccessoryRefinementUpperBounds[v149].Scale.XScale) or u4.Scale.Max;

                    if u107.RobloxBounds then
                        local IsFree = u7.IsFree;

                        if v154 < v152 then
                            if IsFree.X or v152 - v154 >= 0.1 then
                                IsFree.X = true;
                            else
                                v152 = v154;
                            end;
                        elseif v152 < v153 then
                            if IsFree.X or v153 - v152 >= 0.1 then
                                IsFree.X = true;
                            else
                                v152 = v153;
                            end;
                        else
                            IsFree.X = false;
                        end;
                    end;

                    u107:OnTransformUpdate("Scale", "X", v152);

                    return;
                end;

                local v155 = (p145 == Enum.NormalId.Right or p145 == Enum.NormalId.Left) and "X" or ((p145 == Enum.NormalId.Top or p145 == Enum.NormalId.Bottom) and "Y" or "Z");
                local v156 = math.round((u7.Scale[v155] + v150) / v151) * v151;
                local v157 = u107.AvatarRules.AccessoryRefinementLowerBounds and u107.AvatarRules.AccessoryRefinementLowerBounds[v149] and u107.AvatarRules.AccessoryRefinementLowerBounds[v149].Scale[v155 .. "Scale"] or u4.Scale.Min;
                local v158 = u107.AvatarRules.AccessoryRefinementUpperBounds and u107.AvatarRules.AccessoryRefinementUpperBounds[v149] and u107.AvatarRules.AccessoryRefinementUpperBounds[v149].Scale[v155 .. "Scale"] or u4.Scale.Max;

                if u107.RobloxBounds then
                    local IsFree = u7.IsFree;

                    if v158 < v156 then
                        if IsFree[v155] or v156 - v158 >= 0.1 then
                            IsFree[v155] = true;
                        else
                            v156 = v158;
                        end;
                    elseif v156 < v157 then
                        if IsFree[v155] or v157 - v156 >= 0.1 then
                            IsFree[v155] = true;
                        else
                            v156 = v157;
                        end;
                    else
                        IsFree[v155] = false;
                    end;
                end;

                u107:OnTransformUpdate("Scale", v155, v156);
            end;

            return;
        end;

        local v159 = tonumber(u107.Config.TransformSection.properties.position.options.increment.value.input:GetAttribute("value")) or 0.001;
        local v160 = math.round(p146 * 1 / v159) * v159;
        local v161 = u7.BaseCFrame:VectorToWorldSpace(Vector3.FromNormalId(p145) * v160);
        local v162 = u7.Position + v161;

        if u107.RobloxBounds and u107.AvatarRules then
            local v163 = ({
                [Enum.NormalId.Right] = "X",
                [Enum.NormalId.Left] = "X",
                [Enum.NormalId.Top] = "Y",
                [Enum.NormalId.Bottom] = "Y",
                [Enum.NormalId.Front] = "Z",
                [Enum.NormalId.Back] = "Z"
            })[p145];
            local v164 = u107.AvatarRules.AccessoryRefinementLowerBounds and u107.AvatarRules.AccessoryRefinementLowerBounds[v149] and u107.AvatarRules.AccessoryRefinementLowerBounds[v149].Position[v163 .. "Position"] or u4.Position.Min;
            local v165 = u107.AvatarRules.AccessoryRefinementUpperBounds and u107.AvatarRules.AccessoryRefinementUpperBounds[v149] and u107.AvatarRules.AccessoryRefinementUpperBounds[v149].Position[v163 .. "Position"] or u4.Position.Max;
            local v166 = v162[v163];
            local IsFree = u7.IsFree;

            if v165 < v166 then
                if IsFree[v163] or v166 - v165 >= 0.1 then
                    IsFree[v163] = true;
                else
                    v166 = v165;
                end;
            elseif v166 < v164 then
                if IsFree[v163] or v164 - v166 >= 0.1 then
                    IsFree[v163] = true;
                else
                    v166 = v164;
                end;
            else
                IsFree[v163] = false;
            end;

            local v167;

            if v163 == "X" then
                v167 = v166;
            else
                v167 = v162.X;
            end;

            local v168;

            if v163 == "Y" then
                v168 = v166;
            else
                v168 = v162.Y;
            end;

            if v163 ~= "Z" then
                v166 = v162.Z;
            end;

            v162 = Vector3.new(v167, v168, v166);
        end;

        u107:OnTransformUpdate("Position", nil, v162);
    end));
    table.insert(u107.Connections, u107.RotateGizmo.MouseButton1Down:Connect(function() -- Line: 877
        -- upvalues: u118 (ref), u107 (copy), u7 (ref)
        if u118 then
            return;
        end;

        local v169 = u107.Config.GetPrimarySelectedId();

        if v169 then
            v169 = u107.AdjustmentCache[v169];
        end;

        if not v169 then
            return;
        end;

        u107.IsDraggingGizmo = true;
        u7 = {
            Rotation = v169.Rotation,
            IsFree = {
                X = false,
                Y = false,
                Z = false
            }
        };
    end));
    table.insert(u107.Connections, u107.RotateGizmo.MouseDrag:Connect(function(p170, p171) -- Line: 886
        -- upvalues: u7 (ref), u118 (ref), u107 (copy)
        if not u7 or u118 then
            return;
        end;

        local v172 = tonumber(u107.Config.TransformSection.properties.rotation.options.increment.value.input:GetAttribute("value")) or 1;
        local v173 = Vector3.FromAxis(p170);
        local v174 = u107.CurrentHandleInstance and u107.CurrentHandleInstance:FindFirstChildWhichIsA("Attachment", true);

        if v174 then
            if p170 == Enum.Axis.X then
                v173 = v173 * math.sign(v174.Axis.X);
            elseif p170 == Enum.Axis.Y then
                v173 = v173 * math.sign(v174.SecondaryAxis.Y);
            elseif p170 == Enum.Axis.Z then
                local Z = v174.Axis:Cross(v174.SecondaryAxis).Z;
                v173 = v173 * math.sign(Z);
            end;
        end;

        local v175, v176, v177 = (CFrame.fromOrientation(math.rad(u7.Rotation.X), math.rad(u7.Rotation.Y), (math.rad(u7.Rotation.Z))) * CFrame.fromAxisAngle(v173, p171 * 1)):ToOrientation();
        local v178 = math.deg(v175) / v172;
        local v179 = math.round(v178) * v172;
        local v180 = math.deg(v176) / v172;
        local v181 = math.round(v180) * v172;
        local v182 = math.deg(v177) / v172;
        local v183 = math.round(v182) * v172;
        u107:OnTransformUpdate("Rotation", nil, (Vector3.new(v179, v181, v183)));
    end));

    if u107.Config.OnRequestSubMode then
        u107.Config.OnRequestSubMode("position");
    end;
end;

return v6;