-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Modules);
local RunService = game:GetService("RunService");
game:GetService("AvatarEditorService");
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local CommunityOutfitsController = require(script.Parent.CommunityOutfitsController);
local LocalPlayer = Players.LocalPlayer;
local Outfits = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Outfits");
local container = Outfits:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local buttons = wrapper:WaitForChild("buttons");
local showcaseOutfit = script:WaitForChild("showcaseOutfit");
local u1 = {
    Connections = {},
    Objects = {}
};
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;

local function getSetting(p2) -- Line: 29
    -- upvalues: Events (copy)
    if not Events.GetSetting:GetAttribute("bound") then
        Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
    end;

    return Events.GetSetting:Invoke(p2);
end;

local u3 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u4 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u5 = TweenService:Create(container, u3, {
    GroupTransparency = 0
});
local u6 = TweenService:Create(container, u3, {
    GroupTransparency = 1
});
local u7 = {};

local function clearConnections() -- Line: 45
    -- upvalues: u7 (copy)
    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);
end;

local u8 = { 10916243, 2678001507, 339310190, 556349, 409640380, 92714340, 1848960, 9954703, 13151032, 164279327, 2657540898 };

local function clearShowcase() -- Line: 54
    -- upvalues: u1 (copy), buttons (copy)
    for _, v in u1.Connections do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect();
        elseif type(v) == "table" and v.Disconnect then
            v:Disconnect();
        end;
    end;

    table.clear(u1.Connections);

    for _, v in u1.Objects do
        if v.Destroy then
            v:Destroy();
        end;
    end;

    table.clear(u1.Objects);

    for _, child in buttons:GetChildren() do
        if child:IsA("TextButton") then
            local itemsWrapper = child:FindFirstChild("itemsWrapper");

            if itemsWrapper then
                local items = itemsWrapper:FindFirstChild("items");

                if items then
                    for _, child2 in items:GetChildren() do
                        if child2:IsA("ViewportFrame") or child2:IsA("ImageLabel") then
                            child2:Destroy();
                        end;
                    end;

                    items.Position = UDim2.new(0, 0, items.Position.Y.Scale, items.Position.Y.Offset);
                end;

                for _, child2 in itemsWrapper:GetChildren() do
                    if child2:IsA("ViewportFrame") or child2:IsA("ImageLabel") then
                        child2:Destroy();
                    end;
                end;
            end;
        end;
    end;
end;

local u9 = {
    IsOpen = false
};

for i = #u8, 2, -1 do
    local v10 = math.random(1, i);
    local v11 = u8[i];
    u8[i] = u8[v10];
    u8[v10] = v11;
end;

local function getTopicPreviews() -- Line: 128
    -- upvalues: Remotes (copy)
    local v12, v13 = Remotes.CommunityOutfitsAction:InvokeServer("GetTopicPreviews");

    return v12 and v13 and v13 or {};
end;

local u17 = {
    {
        name = "outfitLoader",
        descriptionMode = "avatarThumbnail"
    },
    {
        name = "savedOutfits",
        descriptionMode = "serialized",

        fetcher = function() -- Line: 111, Name: getSavedOutfitItems
            -- upvalues: Remotes (copy)
            local v14;

            while true do
                local v15;
                v15, v14 = Remotes.SavedOutfitAction:InvokeServer({
                    Action = "Get"
                });

                if v15 and v14 then
                    break;
                end;

                task.wait(1);
            end;

            local v16 = {};

            for _, v in v14.Outfits do
                table.insert(v16, v);
            end;

            return v16;
        end
    }
};
local u18 = {};
task.spawn(function() -- Line: 144, Name: preloadShowcaseData
    -- upvalues: u17 (copy), u18 (copy), u8 (copy), HumanoidDescriptionController (copy)
    for _, v in u17 do
        if v.descriptionMode == "avatarThumbnail" then
            u18[v.name] = u8;
        else
            task.spawn(function() -- Line: 149
                -- upvalues: v (copy), u18 (ref), HumanoidDescriptionController (ref)
                local v19 = v.fetcher();

                if #v19 == 0 then
                    u18[v.name] = {
                        mode = "player"
                    };

                    return;
                end;

                local v20 = math.min(#v19, 5);
                local v21 = table.clone(v19);
                local v22 = {};

                for _ = 1, v20 do
                    if #v21 == 0 then
                        break;
                    end;

                    local v23 = math.random(1, #v21);
                    local v24 = table.remove(v21, v23);

                    if v24.HumanoidDescription then
                        local v25, v26, v27 = HumanoidDescriptionController.DeserializeHumanoidDescription(v24.HumanoidDescription);

                        if v25 then
                            table.insert(v22, {
                                description = v25,
                                rigType = v26,
                                accessoryAdjustments = v27
                            });
                        end;
                    end;
                end;

                u18[v.name] = v22;
            end);
        end;
    end;
end);
local showcaseOutfitImage = script:WaitForChild("showcaseOutfitImage");
local topicButton = script:WaitForChild("topicButton");
local u28 = {
    Trending = {
        rotation = 45,
        color1 = Color3.fromRGB(255, 122, 60),
        color2 = Color3.fromRGB(255, 59, 122)
    },
    Girl = {
        rotation = 45,
        color1 = Color3.fromRGB(255, 143, 203),
        color2 = Color3.fromRGB(185, 103, 255)
    },
    Boy = {
        rotation = 45,
        color1 = Color3.fromRGB(61, 125, 255),
        color2 = Color3.fromRGB(0, 194, 255)
    },
    vkei = {
        rotation = 70,
        color1 = Color3.fromRGB(160, 20, 60),
        color2 = Color3.fromRGB(20, 0, 30)
    },
    Emo = {
        rotation = 70,
        color1 = Color3.fromRGB(45, 36, 56),
        color2 = Color3.fromRGB(107, 63, 191),
        color3 = Color3.fromRGB(29, 19, 32)
    },
    scene = {
        rotation = 70,
        color1 = Color3.fromRGB(255, 20, 147),
        color2 = Color3.fromRGB(57, 255, 20)
    },
    Preppy = {
        rotation = 45,
        lightBg = true,
        color1 = Color3.fromRGB(255, 182, 193),
        color2 = Color3.fromRGB(255, 255, 255)
    },
    Anime = {
        rotation = 45,
        color1 = Color3.fromRGB(255, 140, 0),
        color2 = Color3.fromRGB(0, 48, 128)
    },
    Y2K = {
        rotation = 45,
        color1 = Color3.fromRGB(255, 105, 180),
        color2 = Color3.fromRGB(0, 200, 240)
    }
};
local u29 = {
    rotation = 45,
    color1 = Color3.fromRGB(43, 45, 51),
    color2 = Color3.fromRGB(28, 30, 35)
};
local u30 = { "Trending", "Girl", "Boy", "vkei", "Emo", "scene", "Preppy", "Anime", "Y2K" };
local u31 = nil;
local u32 = 0;
local u33 = 0;
task.spawn(function() -- Line: 207
    -- upvalues: u31 (ref), Remotes (copy), u32 (ref)
    local v34, v35 = Remotes.CommunityOutfitsAction:InvokeServer("GetTopicPreviews");
    u31 = v34 and v35 and v35 or {};
    u32 = os.time();
end);

local function setupShowcase() -- Line: 212
    -- upvalues: clearShowcase (copy), u17 (copy), buttons (copy), u18 (copy), showcaseOutfitImage (copy), Events (copy), TweenService (copy), u1 (copy), RunService (copy), showcaseOutfit (copy), AvatarPreviewController (copy), LocalPlayer (copy)
    clearShowcase();

    for _, v in u17 do
        local v36 = buttons:FindFirstChild(v.name);

        if v36 then
            local u37 = v36:FindFirstChild("itemsWrapper") and v36.itemsWrapper:FindFirstChild("items");

            if u37 then
                local u38 = u18[v.name];

                if u38 then
                    if v.descriptionMode == "avatarThumbnail" then
                        if #u38 ~= 0 then
                            for i, v2 in u38 do
                                local v39 = showcaseOutfitImage:Clone();
                                v39.Image = "rbxthumb://type=Avatar&id=" .. v2 .. "&w=352&h=352";
                                v39.LayoutOrder = i;
                                v39.Parent = u37;
                                local v40 = v39:Clone();
                                v40.LayoutOrder = #u38 + i;
                                v40.Parent = u37;
                            end;

                            local v41 = { "Interface", "FrontPageScrollStyle" };

                            if not Events.GetSetting:GetAttribute("bound") then
                                Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
                            end;

                            if (Events.GetSetting:Invoke(v41) or "Continuous") == "Step" then
                                local X = v36.itemsWrapper.AbsoluteSize.X;
                                local Y = v36.itemsWrapper.AbsoluteSize.Y;

                                if X > 0 and Y > 0 then
                                    local v42 = math.floor(X / (Y * 0.8));
                                    local v43 = X / math.max(1, v42);

                                    for _, child in u37:GetChildren() do
                                        if child:IsA("ImageLabel") or child:IsA("ViewportFrame") then
                                            local v44 = child:FindFirstChildOfClass("UIAspectRatioConstraint");

                                            if v44 then
                                                v44:Destroy();
                                            end;

                                            child.Size = UDim2.new(0, v43, 1, 0);

                                            if child:IsA("ImageLabel") then
                                                child.ScaleType = Enum.ScaleType.Fit;
                                            end;
                                        end;
                                    end;
                                end;

                                local u50 = task.spawn(function() -- Line: 260
                                    -- upvalues: u37 (copy), TweenService (ref)
                                    local v45 = 0;

                                    while true do
                                        local v46;

                                        repeat
                                            task.wait(4);
                                            v46 = u37.AbsoluteSize.X;
                                        until v46 > 0;

                                        local v47 = v46 / 2;
                                        local v48 = u37:FindFirstChildWhichIsA("GuiObject");

                                        if v48 then
                                            v45 = v45 + v48.AbsoluteSize.X;
                                            local v49 = TweenService:Create(u37, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                                                Position = UDim2.new(0, -v45, u37.Position.Y.Scale, u37.Position.Y.Offset)
                                            });
                                            v49:Play();
                                            v49.Completed:Wait();

                                            if v47 <= v45 then
                                                v45 = v45 - v47;
                                                u37.Position = UDim2.new(0, -v45, u37.Position.Y.Scale, u37.Position.Y.Offset);
                                            end;
                                        end;
                                    end;
                                end);
                                table.insert(u1.Connections, {
                                    Disconnect = function() -- Line: 284, Name: Disconnect
                                        -- upvalues: u50 (copy)
                                        task.cancel(u50);
                                    end
                                });
                            else
                                local u51 = 0;
                                table.insert(u1.Connections, RunService.Heartbeat:Connect(function(p52) -- Line: 288
                                    -- upvalues: u37 (copy), u51 (ref)
                                    local X = u37.AbsoluteSize.X;

                                    if X <= 0 then
                                        return;
                                    end;

                                    local v53 = X / 2;
                                    u51 = u51 + 0.015 * workspace.CurrentCamera.ViewportSize.X * p52;

                                    if v53 <= u51 then
                                        u51 = u51 - v53;
                                    end;

                                    u37.Position = UDim2.new(0, -u51, u37.Position.Y.Scale, u37.Position.Y.Offset);
                                end));
                            end;
                        end;
                    elseif u38.mode == "player" then
                        local u54 = showcaseOutfit:Clone();
                        u54.AnchorPoint = Vector2.new(0.5, 0.5);
                        u54.Position = UDim2.fromScale(0.5, 0.5);
                        u54.ImageTransparency = 1;
                        u54.Parent = v36.itemsWrapper;
                        local u55 = AvatarPreviewController.new(u54, nil, {
                            UpdateOnDescriptionApplied = true,
                            Distance = 2,
                            IsOutfitPreview = true,
                            IsMarqueePreview = true,
                            FitOutfit = true,
                            UseLiveAdjustments = true,
                            Target = LocalPlayer
                        });
                        table.insert(u1.Objects, u55);
                        local u56 = task.spawn(function() -- Line: 322
                            -- upvalues: u55 (copy), u54 (copy)
                            u55:GetRig();
                            u54.ImageTransparency = 0;
                        end);
                        table.insert(u1.Connections, {
                            Disconnect = function() -- Line: 326, Name: Disconnect
                                -- upvalues: u56 (copy)
                                task.cancel(u56);
                            end
                        });
                    elseif #u38 ~= 0 then
                        if #u38 == 1 then
                            local v57 = u38[1];
                            local u58 = showcaseOutfit:Clone();
                            u58.AnchorPoint = Vector2.new(0.5, 0.5);
                            u58.Position = UDim2.fromScale(0.5, 0.5);
                            u58.ImageTransparency = 1;
                            u58.Parent = v36.itemsWrapper;
                            local u59 = AvatarPreviewController.new(u58, v57.description, {
                                Distance = 2,
                                IsOutfitPreview = true,
                                IsMarqueePreview = true,
                                FitOutfit = true,
                                RigType = v57.rigType,
                                AccessoryAdjustments = v57.accessoryAdjustments
                            });
                            table.insert(u1.Objects, u59);
                            local u60 = task.spawn(function() -- Line: 352
                                -- upvalues: u59 (copy), u58 (copy)
                                u59:GetRig();
                                u58.ImageTransparency = 0;
                            end);
                            table.insert(u1.Connections, {
                                Disconnect = function() -- Line: 356, Name: Disconnect
                                    -- upvalues: u60 (copy)
                                    task.cancel(u60);
                                end
                            });
                        else
                            local u61 = {};
                            local u62 = {};

                            for i, v2 in u38 do
                                local v63 = showcaseOutfit:Clone();
                                v63.ImageTransparency = 1;
                                v63.LayoutOrder = i;
                                v63.Parent = u37;
                                local v64 = AvatarPreviewController.new(v63, v2.description, {
                                    Distance = 2,
                                    IsOutfitPreview = true,
                                    IsMarqueePreview = true,
                                    FitOutfit = true,
                                    RigType = v2.rigType,
                                    AccessoryAdjustments = v2.accessoryAdjustments
                                });
                                table.insert(u1.Objects, v64);
                                table.insert(u61, v63);
                                table.insert(u62, v64);
                            end;

                            local u66 = task.spawn(function() -- Line: 383
                                -- upvalues: u62 (copy), u61 (copy), u38 (copy), u37 (copy)
                                for _, v2 in u62 do
                                    v2:GetRig();
                                end;

                                for _, v2 in u62 do
                                    v2:ResetRotation(true);
                                end;

                                for i, v2 in u61 do
                                    local v65 = v2:Clone();
                                    v65.LayoutOrder = #u38 + i;
                                    v65.Parent = u37;
                                end;

                                for _, child in u37:GetChildren() do
                                    if child:IsA("ViewportFrame") then
                                        child.ImageTransparency = 0;
                                    end;
                                end;
                            end);
                            table.insert(u1.Connections, {
                                Disconnect = function() -- Line: 410, Name: Disconnect
                                    -- upvalues: u66 (copy)
                                    task.cancel(u66);
                                end
                            });
                            local v67 = { "Interface", "FrontPageScrollStyle" };

                            if not Events.GetSetting:GetAttribute("bound") then
                                Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
                            end;

                            if (Events.GetSetting:Invoke(v67) or "Continuous") == "Step" then
                                local X = v36.itemsWrapper.AbsoluteSize.X;
                                local Y = v36.itemsWrapper.AbsoluteSize.Y;

                                if X > 0 and Y > 0 then
                                    local v68 = math.floor(X / (Y * 0.8));
                                    local v69 = X / math.max(1, v68);

                                    for _, child in u37:GetChildren() do
                                        if child:IsA("ImageLabel") or child:IsA("ViewportFrame") then
                                            local v70 = child:FindFirstChildOfClass("UIAspectRatioConstraint");

                                            if v70 then
                                                v70:Destroy();
                                            end;

                                            child.Size = UDim2.new(0, v69, 1, 0);

                                            if child:IsA("ImageLabel") then
                                                child.ScaleType = Enum.ScaleType.Fit;
                                            end;
                                        end;
                                    end;
                                end;

                                local u76 = task.spawn(function() -- Line: 433
                                    -- upvalues: u37 (copy), TweenService (ref)
                                    local v71 = 0;

                                    while true do
                                        local v72;

                                        repeat
                                            task.wait(4);
                                            v72 = u37.AbsoluteSize.X;
                                        until v72 > 0;

                                        local v73 = v72 / 2;
                                        local v74 = u37:FindFirstChildWhichIsA("GuiObject");

                                        if v74 then
                                            v71 = v71 + v74.AbsoluteSize.X;
                                            local v75 = TweenService:Create(u37, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                                                Position = UDim2.new(0, -v71, u37.Position.Y.Scale, u37.Position.Y.Offset)
                                            });
                                            v75:Play();
                                            v75.Completed:Wait();

                                            if v73 <= v71 then
                                                v71 = v71 - v73;
                                                u37.Position = UDim2.new(0, -v71, u37.Position.Y.Scale, u37.Position.Y.Offset);
                                            end;
                                        end;
                                    end;
                                end);
                                table.insert(u1.Connections, {
                                    Disconnect = function() -- Line: 457, Name: Disconnect
                                        -- upvalues: u76 (copy)
                                        task.cancel(u76);
                                    end
                                });
                            else
                                local u77 = 0;
                                table.insert(u1.Connections, RunService.Heartbeat:Connect(function(p78) -- Line: 461
                                    -- upvalues: u37 (copy), u77 (ref)
                                    local X = u37.AbsoluteSize.X;

                                    if X <= 0 then
                                        return;
                                    end;

                                    local v79 = X / 2;
                                    u77 = u77 + 0.015 * workspace.CurrentCamera.ViewportSize.X * p78;

                                    if v79 <= u77 then
                                        u77 = u77 - v79;
                                    end;

                                    u37.Position = UDim2.new(0, -u77, u37.Position.Y.Scale, u37.Position.Y.Offset);
                                end));
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

local function setupTopicTiles() -- Line: 478
    -- upvalues: u33 (ref), buttons (copy), u31 (ref), u32 (ref), Remotes (copy), u30 (copy), u28 (copy), u29 (copy), topicButton (copy), u7 (copy), TweenService (copy), u3 (copy), u9 (copy), Events (copy), showcaseOutfit (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), u1 (copy), u4 (copy), CommunityOutfitsController (copy)
    u33 = u33 + 1;
    local u80 = u33;
    local communityOutfits = buttons:FindFirstChild("communityOutfits");

    if not communityOutfits then
        return;
    end;

    local scrollWrapper = communityOutfits:FindFirstChild("scrollWrapper");

    if scrollWrapper then
        scrollWrapper = scrollWrapper:FindFirstChild("itemsWrapper");
    end;

    if not scrollWrapper then
        return;
    end;

    for _, child in scrollWrapper:GetChildren() do
        if child:IsA("TextButton") then
            child:Destroy();
        end;
    end;

    local v81 = u31;

    if not v81 or os.time() - u32 > 300 then
        local v82, v83 = Remotes.CommunityOutfitsAction:InvokeServer("GetTopicPreviews");
        v81 = v82 and v83 and v83 or {};

        if u33 ~= u80 then
            return;
        end;

        u31 = v81;
        u32 = os.time();
    end;

    local v84 = {};

    for _, v in ipairs(u30) do
        if v81 and v81[v] then
            table.insert(v84, v);
        end;
    end;

    local v85 = {};

    for i, v in ipairs(v84) do
        local v86 = u28[v] or u29;
        local u87 = topicButton:Clone();
        u87.Name = "topic_" .. v;
        u87.LayoutOrder = i;
        u87.Visible = true;
        local topicLabel = u87:FindFirstChild("topicLabel");

        if topicLabel then
            topicLabel.Text = v;

            if v86.lightBg then
                topicLabel.TextColor3 = Color3.fromRGB(27, 27, 34);
            end;
        end;

        local v88 = u87:FindFirstChildOfClass("UIGradient");

        if v88 then
            if v86.color3 then
                v88.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v86.color1), ColorSequenceKeypoint.new(0.6, v86.color2), ColorSequenceKeypoint.new(1, v86.color3) });
            else
                v88.Color = ColorSequence.new(v86.color1, v86.color2);
            end;

            v88.Rotation = v86.rotation;
        end;

        local u89 = Color3.fromRGB(221, 221, 221);
        local u90 = Color3.fromRGB(255, 255, 255);
        local u91 = Color3.fromRGB(180, 180, 180);
        table.insert(u7, u87.MouseEnter:Connect(function() -- Line: 554
            -- upvalues: TweenService (ref), u87 (copy), u3 (ref), u90 (copy)
            TweenService:Create(u87, u3, {
                BackgroundColor3 = u90
            }):Play();
        end));
        table.insert(u7, u87.MouseLeave:Connect(function() -- Line: 557
            -- upvalues: TweenService (ref), u87 (copy), u3 (ref), u89 (copy)
            TweenService:Create(u87, u3, {
                BackgroundColor3 = u89
            }):Play();
        end));
        table.insert(u7, u87.MouseButton1Down:Connect(function() -- Line: 560
            -- upvalues: TweenService (ref), u87 (copy), u3 (ref), u91 (copy)
            TweenService:Create(u87, u3, {
                BackgroundColor3 = u91
            }):Play();
        end));
        table.insert(u7, u87.MouseButton1Up:Connect(function() -- Line: 563
            -- upvalues: TweenService (ref), u87 (copy), u3 (ref), u90 (copy)
            TweenService:Create(u87, u3, {
                BackgroundColor3 = u90
            }):Play();
        end));
        table.insert(u7, u87.Activated:Connect(function() -- Line: 569
            -- upvalues: u9 (ref), Events (ref), v (copy)
            u9.Close();
            Events.DisplayCommunityOutfits:Fire(false, v);
        end));
        u87.Parent = scrollWrapper;
        table.insert(v85, {
            btn = u87,
            topicName = v
        });
    end;

    for _, v in v85 do
        local u92;

        if v81 then
            u92 = v81[v.topicName];
        else
            u92 = v81;
        end;

        if u92 and u92.HumanoidDescription then
            task.spawn(function() -- Line: 582
                -- upvalues: u33 (ref), u80 (copy), v (copy), showcaseOutfit (ref), HumanoidDescriptionController (ref), u92 (copy), AvatarPreviewController (ref), u1 (ref), TweenService (ref), u4 (ref)
                if u33 ~= u80 then
                    return;
                end;

                if not v.btn or v.btn.Parent == nil then
                    return;
                end;

                local preview = v.btn:FindFirstChild("preview");

                if not preview then
                    return;
                end;

                local v93 = showcaseOutfit:Clone();
                v93.ImageTransparency = 1;
                v93.Parent = preview;

                if u33 ~= u80 then
                    v93:Destroy();

                    return;
                end;

                local v94, v95, v96 = HumanoidDescriptionController.DeserializeHumanoidDescription(u92.HumanoidDescription);

                if not v94 then
                    return;
                end;

                if u33 ~= u80 then
                    v93:Destroy();

                    return;
                end;

                local v97 = AvatarPreviewController.new(v93, v94, {
                    Distance = 2,
                    IsOutfitPreview = true,
                    IsMarqueePreview = true,
                    FitOutfit = true,
                    RigType = u92.RigType or v95,
                    AccessoryAdjustments = v96
                });
                table.insert(u1.Objects, v97);

                if u33 ~= u80 then
                    if v97.Destroy then
                        v97:Destroy();
                    end;

                    v93:Destroy();

                    return;
                end;

                v97:GetRig();

                if u33 ~= u80 then
                    return;
                end;

                TweenService:Create(v93, u4, {
                    ImageTransparency = 0
                }):Play();
            end);
        end;
    end;

    if CommunityOutfitsController._hasLoaded then
        local u98 = topicButton:Clone();
        u98.Name = "continueBrowsing";
        u98.LayoutOrder = -1;
        u98.Visible = true;
        local topicLabel = u98:FindFirstChild("topicLabel");

        if topicLabel then
            topicLabel.Text = "Continue";
        end;

        local v99 = u98:FindFirstChildOfClass("UIGradient");

        if v99 then
            v99.Color = ColorSequence.new(Color3.fromRGB(132, 132, 138), Color3.fromRGB(104, 104, 110));
            v99.Rotation = 45;
        end;

        local u100 = Color3.fromRGB(221, 221, 221);
        local u101 = Color3.fromRGB(255, 255, 255);
        local u102 = Color3.fromRGB(180, 180, 180);
        table.insert(u7, u98.MouseEnter:Connect(function() -- Line: 645
            -- upvalues: TweenService (ref), u98 (copy), u3 (ref), u101 (copy)
            TweenService:Create(u98, u3, {
                BackgroundColor3 = u101
            }):Play();
        end));
        table.insert(u7, u98.MouseLeave:Connect(function() -- Line: 648
            -- upvalues: TweenService (ref), u98 (copy), u3 (ref), u100 (copy)
            TweenService:Create(u98, u3, {
                BackgroundColor3 = u100
            }):Play();
        end));
        table.insert(u7, u98.MouseButton1Down:Connect(function() -- Line: 651
            -- upvalues: TweenService (ref), u98 (copy), u3 (ref), u102 (copy)
            TweenService:Create(u98, u3, {
                BackgroundColor3 = u102
            }):Play();
        end));
        table.insert(u7, u98.MouseButton1Up:Connect(function() -- Line: 654
            -- upvalues: TweenService (ref), u98 (copy), u3 (ref), u101 (copy)
            TweenService:Create(u98, u3, {
                BackgroundColor3 = u101
            }):Play();
        end));
        table.insert(u7, u98.Activated:Connect(function() -- Line: 658
            -- upvalues: u9 (ref), Events (ref)
            u9.Close();
            Events.DisplayCommunityOutfits:Fire();
        end));
        u98.Parent = scrollWrapper;
        local u103 = CommunityOutfitsController.GetContinueBrowsingOutfit();

        if u103 and u103.HumanoidDescription then
            task.spawn(function() -- Line: 667
                -- upvalues: u33 (ref), u80 (copy), u98 (copy), showcaseOutfit (ref), HumanoidDescriptionController (ref), u103 (copy), AvatarPreviewController (ref), u1 (ref), TweenService (ref), u4 (ref)
                if u33 ~= u80 then
                    return;
                end;

                if u98.Parent == nil then
                    return;
                end;

                local preview = u98:FindFirstChild("preview");

                if not preview then
                    return;
                end;

                local v104 = showcaseOutfit:Clone();
                v104.ImageTransparency = 1;
                v104.Parent = preview;

                if u33 ~= u80 then
                    v104:Destroy();

                    return;
                end;

                local v105, v106, v107 = HumanoidDescriptionController.DeserializeHumanoidDescription(u103.HumanoidDescription);

                if not v105 then
                    return;
                end;

                if u33 ~= u80 then
                    v104:Destroy();

                    return;
                end;

                local v108 = AvatarPreviewController.new(v104, v105, {
                    Distance = 2,
                    IsOutfitPreview = true,
                    IsMarqueePreview = true,
                    FitOutfit = true,
                    RigType = u103.RigType or v106,
                    AccessoryAdjustments = v107
                });
                table.insert(u1.Objects, v108);

                if u33 ~= u80 then
                    if v108.Destroy then
                        v108:Destroy();
                    end;

                    v104:Destroy();

                    return;
                end;

                v108:GetRig();

                if u33 ~= u80 then
                    return;
                end;

                TweenService:Create(v104, u4, {
                    ImageTransparency = 0
                }):Play();
            end);
        end;
    end;
end;

function u9.Close() -- Line: 708
    -- upvalues: u9 (copy), u7 (copy), clearShowcase (copy), Events (copy), u6 (copy), Outfits (copy)
    if not u9.IsOpen then
        return;
    end;

    u9.IsOpen = false;

    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);
    clearShowcase();
    Events.InterfaceAction:Fire("Remove", script.Name);
    u6:Play();
    u6.Completed:Once(function() -- Line: 717
        -- upvalues: u9 (ref), Outfits (ref)
        if u9.IsOpen ~= true then
            Outfits.Enabled = false;
        end;
    end);
end;

function u9.Open(p109) -- Line: 724
    -- upvalues: u9 (copy), Events (copy), Outfits (copy), container (copy), u5 (copy), u7 (copy), wrapper (copy), TweenService (copy), u3 (copy), buttons (copy), setupShowcase (copy), setupTopicTiles (copy)
    if u9.IsOpen then
        if p109 then
            u9.Close();
        end;

        return;
    end;

    u9.IsOpen = true;
    Events.InterfaceAction:Fire("Add", script.Name, u9.Close);
    Outfits.Enabled = true;
    container.GroupTransparency = 1;
    u5:Play();
    table.insert(u7, wrapper.closeButton.Activated:Connect(u9.Close));

    local function setupSelectionButton(u110) -- Line: 741
        -- upvalues: u7 (ref), TweenService (ref), u3 (ref), u9 (ref), Events (ref)
        local Name = u110.Name;
        table.insert(u7, u110.MouseEnter:Connect(function() -- Line: 743
            -- upvalues: TweenService (ref), u110 (copy), u3 (ref)
            TweenService:Create(u110.UIStroke, u3, {
                Transparency = 0
            }):Play();
        end));
        table.insert(u7, u110.MouseLeave:Connect(function() -- Line: 747
            -- upvalues: TweenService (ref), u110 (copy), u3 (ref)
            TweenService:Create(u110.UIStroke, u3, {
                Transparency = 0.5
            }):Play();
        end));
        table.insert(u7, u110.MouseButton1Down:Connect(function() -- Line: 751
            -- upvalues: TweenService (ref), u110 (copy), u3 (ref)
            TweenService:Create(u110.UIStroke, u3, {
                Transparency = 1
            }):Play();
        end));
        table.insert(u7, u110.Activated:Connect(function() -- Line: 759
            -- upvalues: TweenService (ref), u110 (copy), u3 (ref), u9 (ref), Name (copy), Events (ref)
            TweenService:Create(u110.UIStroke, u3, {
                Transparency = 0.5
            }):Play();
            u9.Close();

            if Name == "outfitLoader" then
                Events.DisplayOutfitLoader:Fire();

                return;
            end;

            if Name == "savedOutfits" then
                Events.DisplaySavedOutfits:Fire();

                return;
            end;

            if Name == "communityOutfits" then
                Events.DisplayCommunityOutfits:Fire();
            end;
        end));
    end;

    setupSelectionButton(buttons.communityOutfits);
    setupSelectionButton(buttons.savedOutfits);
    setupSelectionButton(buttons.outfitLoader);
    task.spawn(setupShowcase);
    task.spawn(setupTopicTiles);
end;

Events.DisplayOutfits.Event:Connect(u9.Open);

return u9;