-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemButton = require(script.Parent.Parent.Elements:WaitForChild("ItemButton"));
local PlayEmote = require(script.Parent.Parent.Utilities:WaitForChild("PlayEmote"));
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local LocalPlayer = Players.LocalPlayer;
local Pose = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Pose");
local Events = script.Parent.Parent.Events;
Pose.Enabled = false;
local u1 = {
    IsOpen = false,
    IsUIOpen = false
};
local u2 = {};
local u3 = {};
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = {};
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = false;
local u18 = nil;
local u19 = nil;
local u20 = "rotate";

local function getControlModule() -- Line: 50
    -- upvalues: u19 (ref), LocalPlayer (copy)
    if u19 then
        return u19;
    end;

    local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");

    if PlayerModule then
        u19 = require(PlayerModule):GetControls();
    end;

    return u19;
end;

local function freezeDuringDrag(p21) -- Line: 59
    -- upvalues: u18 (ref), u19 (ref), LocalPlayer (copy)
    local CurrentCamera = workspace.CurrentCamera;

    if p21 then
        if u18 == nil and CurrentCamera then
            u18 = CurrentCamera.CameraType;
            CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        end;

        local v22;

        if u19 then
            v22 = u19;
        else
            local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");

            if PlayerModule then
                u19 = require(PlayerModule):GetControls();
            end;

            v22 = u19;
        end;

        if v22 then
            v22:Disable();
        end;
    elseif u18 ~= nil then
        if CurrentCamera then
            CurrentCamera.CameraType = u18;
        end;

        u18 = nil;
        local v23;

        if u19 then
            v23 = u19;
        else
            local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");

            if PlayerModule then
                u19 = require(PlayerModule):GetControls();
            end;

            v23 = u19;
        end;

        if v23 then
            v23:Enable();
        end;
    end;
end;

local u24 = false;
local u25 = {};
local u26 = {};
local u27 = {};
u1.IsPosed = false;

local function bindEmoteTracking() -- Line: 82
    -- upvalues: u27 (copy), u5 (ref), u6 (ref), u25 (copy), u24 (ref), u26 (copy)
    if #u27 > 0 then
        return;
    end;

    if not (u5 and u6) then
        return;
    end;

    local u28 = u5;
    table.insert(u27, u6.AnimationPlayed:Connect(function(u29) -- Line: 86
        -- upvalues: u25 (ref), u24 (ref), u26 (ref)
        local Priority = u29.Priority;

        if Priority == Enum.AnimationPriority.Action or (Priority == Enum.AnimationPriority.Action2 or (Priority == Enum.AnimationPriority.Action3 or Priority == Enum.AnimationPriority.Action4)) then
            u25[u29] = true;
            u24 = true;
            u26[u29] = u29.Stopped:Connect(function() -- Line: 94
                -- upvalues: u25 (ref), u29 (copy), u26 (ref), u24 (ref)
                u25[u29] = nil;
                local v30 = u26[u29];

                if v30 then
                    v30:Disconnect();
                    u26[u29] = nil;
                end;

                if next(u25) == nil then
                    u24 = false;
                end;
            end);
        end;
    end));
    local v31 = u28:GetPropertyChangedSignal("MoveDirection");
    table.insert(u27, v31:Connect(function() -- Line: 107
        -- upvalues: u28 (copy), u25 (ref)
        if u28.MoveDirection.Magnitude > 0 then
            for i in u25 do
                if i.IsPlaying then
                    i:Stop();
                end;
            end;
        end;
    end));
end;

local function unbindEmoteTracking() -- Line: 118
    -- upvalues: u27 (copy), u26 (copy), u25 (copy), u24 (ref)
    for _, v in u27 do
        v:Disconnect();
    end;

    table.clear(u27);

    for _, v in u26 do
        v:Disconnect();
    end;

    table.clear(u26);
    table.clear(u25);
    u24 = false;
end;

local function setIsPosed(p32) -- Line: 131
    -- upvalues: u1 (copy), bindEmoteTracking (copy), unbindEmoteTracking (copy)
    if u1.IsPosed == p32 then
        return;
    end;

    u1.IsPosed = p32;

    if p32 then
        bindEmoteTracking();

        return;
    end;

    unbindEmoteTracking();
end;

local bodySelector = Pose:WaitForChild("bodySelector");
local r6 = bodySelector:WaitForChild("r6");
local r15 = bodySelector:WaitForChild("r15");
local buttons = bodySelector:WaitForChild("buttons");
local modes = buttons:WaitForChild("modes");
local actions = buttons:WaitForChild("actions");
local u33 = nil;
local container = Pose:WaitForChild("container");
local toggleSavedPoses = Pose:WaitForChild("toggleSavedPoses");
local exit = Pose:WaitForChild("exit");
local wrapper = container:WaitForChild("wrapper");
local u34 = wrapper:FindFirstChildWhichIsA("UIListLayout");
local poses = wrapper:WaitForChild("poses");
local u35 = poses:WaitForChild("itemOnlyName"):Clone();
local saveNewPoseContainer = wrapper:WaitForChild("saveNewPoseContainer");
local searchContainer = wrapper:WaitForChild("searchContainer");
local searchInput = searchContainer.wrapper:WaitForChild("searchInput");
local clear = searchContainer:WaitForChild("clear");
local u36 = false;
local R6 = script:WaitForChild("R6");
local R15 = script:WaitForChild("R15");
local u37 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
poses.itemOnlyName.Visible = false;

local function setSavedPosesOpen(p38, p39) -- Line: 173
    -- upvalues: u36 (ref), container (copy), toggleSavedPoses (copy)
    if u36 == p38 and not p39 then
        return;
    end;

    u36 = p38;
    container.Visible = p38;
    toggleSavedPoses.Visible = not p38;
end;

local function updateWrapperOverflow() -- Line: 180
    -- upvalues: u34 (copy), exit (copy), wrapper (copy)
    local Y = u34.AbsoluteContentSize.Y;
    local v40 = exit.AbsolutePosition.Y - wrapper.AbsolutePosition.Y - 8;

    if v40 <= 0 then
        return;
    end;

    if v40 < Y then
        wrapper.Size = UDim2.new(wrapper.Size.X.Scale, wrapper.Size.X.Offset, 0, v40);
        wrapper.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        wrapper.ScrollingDirection = Enum.ScrollingDirection.Y;
        wrapper.ClipsDescendants = true;
        wrapper.ScrollingEnabled = true;
        game:GetService("CollectionService"):RemoveTag(wrapper, "AutomaticSizeFix");
        game:GetService("CollectionService"):AddTag(wrapper, "ScrollingFrameAutomaticSizeFix");

        return;
    end;

    wrapper.Size = UDim2.new(wrapper.Size.X.Scale, wrapper.Size.X.Offset, 0, Y);
    wrapper.AutomaticCanvasSize = Enum.AutomaticSize.None;
    wrapper.CanvasSize = UDim2.new(0, 0, 0, 0);
    wrapper.ClipsDescendants = false;
    wrapper.ScrollingEnabled = false;
    wrapper.CanvasPosition = Vector2.new(0, 0);
    game:GetService("CollectionService"):RemoveTag(wrapper, "ScrollingFrameAutomaticSizeFix");
    game:GetService("CollectionService"):AddTag(wrapper, "AutomaticSizeFix");
end;

local function serializeCurrentPose() -- Line: 210
    -- upvalues: u5 (ref), u8 (copy), u9 (copy), u10 (copy)
    local v41 = u5 and u5.RigType == Enum.HumanoidRigType.R15 and "R15" or "R6";
    local v42 = {};

    for i, _ in u8 do
        if i and i.Parent then
            local v43 = u9[i] or CFrame.new();
            local v44 = u10[i] or Vector3.new(0, 0, 0);
            v42[i.Name] = {
                R = { v43:GetComponents() },
                P = { v44.X, v44.Y, v44.Z }
            };
        end;
    end;

    return v41, v42;
end;

local function sendPoseToServer() -- Line: 226
    -- upvalues: u4 (ref), u8 (copy), u10 (copy), u9 (copy), Remotes (copy)
    if not u4 then
        return;
    end;

    local v45 = {};

    for i, v in u8 do
        if i and i.Parent then
            local Position = (v * i.C1:Inverse()).Position;
            local v46 = CFrame.new(Position) * i.C1;
            v45[i.Name] = v46 * CFrame.new(u10[i] or Vector3.new(0, 0, 0)) * (u9[i] or CFrame.new());
        end;
    end;

    Remotes.PoseAnimatorAction:FireServer("ApplyPose", v45);
end;

local function sendOriginalsToServer() -- Line: 241
    -- upvalues: u4 (ref), u8 (copy), Remotes (copy)
    if not u4 then
        return;
    end;

    local v47 = {};

    for i, v in u8 do
        if i and i.Parent then
            v47[i.Name] = v;
        end;
    end;

    Remotes.PoseAnimatorAction:FireServer("ResetPose", v47);
end;

local function applyPoseToRig(p48, p49) -- Line: 252
    local v50 = {};

    for _, descendant in p48:GetDescendants() do
        if descendant:IsA("Motor6D") and (descendant.Part0 and descendant.Part1) then
            if not v50[descendant.Part0] then
                v50[descendant.Part0] = {};
            end;

            table.insert(v50[descendant.Part0], descendant);
        end;
    end;

    local HumanoidRootPart = p48:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v51 = { HumanoidRootPart };

    while #v51 > 0 do
        local v52 = table.remove(v51, 1);
        local v53 = v50[v52];

        if v53 then
            for _, v in v53 do
                local C0 = v.C0;
                local v54 = p49[v.Name];

                if v54 then
                    local v55 = CFrame.new(unpack(v54.R));
                    local v56 = Vector3.new(unpack(v54.P));
                    local Position = (C0 * v.C1:Inverse()).Position;
                    C0 = CFrame.new(Position) * v.C1 * CFrame.new(v56) * v55;
                end;

                v.Part1.CFrame = v52.CFrame * C0 * v.C1:Inverse();
                table.insert(v51, v.Part1);
            end;
        end;
    end;
end;

local function createPosePreview(p57, p58, p59) -- Line: 298
    -- upvalues: R15 (copy), R6 (copy), applyPoseToRig (copy)
    local v60;

    if p58 == "R15" then
        v60 = R15;
    else
        v60 = R6;
    end;

    local v61 = v60:Clone();
    local Animate = v61:FindFirstChild("Animate");

    if Animate then
        Animate:Destroy();
    end;

    local Animator = v61:FindFirstChild("Animator", true);

    if Animator then
        Animator:Destroy();
    end;

    applyPoseToRig(v61, p59);
    v61.Parent = p57;
    local HumanoidRootPart = v61:FindFirstChild("HumanoidRootPart");
    local v62 = not HumanoidRootPart and Vector3.new(0, 0, 0) or HumanoidRootPart.Position;
    local Camera = Instance.new("Camera");
    Camera.CFrame = CFrame.new(v62 + Vector3.new(0, 0, -5), v62);
    Camera.Parent = p57;
    p57.CurrentCamera = Camera;
end;

local function filterPoseItems(p63) -- Line: 321
    -- upvalues: poses (copy), u35 (copy)
    local v64 = string.lower(p63);

    for _, child in poses:GetChildren() do
        if child:IsA("Frame") and child ~= u35 then
            if v64 == "" then
                child.Visible = true;
            else
                local name = child:FindFirstChild("name");
                child.Visible = string.find(string.lower(name and name.Text or ""), v64, 1, true) ~= nil;
            end;
        end;
    end;
end;

local function clearPoseItems() -- Line: 336
    -- upvalues: poses (copy), u35 (copy)
    for _, child in poses:GetChildren() do
        if child:IsA("Frame") and child ~= u35 then
            child:Destroy();
        end;
    end;
end;

local function populateSavedPoses(p65) -- Line: 344
    -- upvalues: clearPoseItems (copy), u35 (copy), createPosePreview (copy), u4 (ref), u5 (ref), Events (copy), u8 (copy), u9 (copy), u10 (copy), sendPoseToServer (copy), Remotes (copy), serializeCurrentPose (copy), u2 (copy), ItemButton (copy), poses (copy), updateWrapperOverflow (copy)
    clearPoseItems();

    if not p65 then
        return;
    end;

    local v66 = {};

    for _, v in p65 do
        table.insert(v66, v);
    end;

    table.sort(v66, function(p67, p68) -- Line: 354
        return (p67.Created or 0) > (p68.Created or 0);
    end);

    for i, v in v66 do
        local u69 = u35:Clone();
        u69.Name = v.Id;
        u69.LayoutOrder = i;
        u69.Visible = true;
        u69.name.Text = v.Name;
        local skeleton = u69:FindFirstChild("skeleton");

        if skeleton then
            for _, child in skeleton:GetChildren() do
                child.Visible = false;
            end;
        end;

        local viewport = u69.preview.viewport;
        viewport.Visible = true;
        createPosePreview(viewport, v.RigType, v.Joints);
        local viewItem = u69:FindFirstChild("viewItem");

        if viewItem then
            local u79 = {
                ItemButtonType = "Pose",
                PoseDetails = v,

                OnApply = function(p70) -- Line: 384, Name: OnApply
                    -- upvalues: u4 (ref), u5 (ref), Events (ref), u8 (ref), u9 (ref), u10 (ref), sendPoseToServer (ref)
                    if not (u4 and u5) then
                        return;
                    end;

                    local v71 = u5.RigType == Enum.HumanoidRigType.R15 and "R15" or "R6";

                    if p70.RigType ~= v71 then
                        Events.Notify:Fire("❌ This is an " .. p70.RigType .. " pose and your rig type is " .. v71 .. ". You can change it in Adjust Body -> Rig Type.");

                        return;
                    end;

                    for i2, _ in u8 do
                        if i2 and (i2.Parent and p70.Joints[i2.Name]) then
                            local v72 = p70.Joints[i2.Name];
                            u9[i2] = CFrame.new(unpack(v72.R));
                            u10[i2] = Vector3.new(unpack(v72.P));
                        else
                            u9[i2] = CFrame.new();
                            u10[i2] = Vector3.new(0, 0, 0);
                        end;
                    end;

                    task.defer(sendPoseToServer);
                end,

                OnDelete = function(u73) -- Line: 403, Name: OnDelete
                    -- upvalues: Events (ref), Remotes (ref)
                    if not Events.PromptConfirmationDialog:Invoke({
                        Title = "Delete Pose",
                        Description = "Are you sure you want to delete pose \'<b>" .. u73.Name .. "</b>\'?\n\n<b>You cannot undo this action.</b>"
                    }) then
                        return;
                    end;

                    task.spawn(function() -- Line: 409
                        -- upvalues: Remotes (ref), u73 (copy), Events (ref)
                        if Remotes.SavedPoseAction:InvokeServer({
                            Action = "Delete",
                            Id = u73.Id
                        }) then
                            Events.Notify:Fire("✅ Successfully deleted pose \'<b>" .. u73.Name .. "</b>\'.");

                            return;
                        end;

                        Events.Notify:Fire("❌ Failed to delete pose.");
                    end);
                end,

                OnUpdate = function(u74) -- Line: 418, Name: OnUpdate
                    -- upvalues: Events (ref), serializeCurrentPose (ref), Remotes (ref)
                    if not Events.PromptConfirmationDialog:Invoke({
                        Title = "Update Pose",
                        Description = "Are you sure you want to overwrite pose \'<b>" .. u74.Name .. "</b>\' with your current pose?\n\n<b>You cannot undo this action.</b>"
                    }) then
                        return;
                    end;

                    local u75, u76 = serializeCurrentPose();
                    task.spawn(function() -- Line: 425
                        -- upvalues: Remotes (ref), u74 (copy), u75 (copy), u76 (copy), Events (ref)
                        if Remotes.SavedPoseAction:InvokeServer({
                            Action = "Update",
                            Id = u74.Id,
                            RigType = u75,
                            Joints = u76
                        }) then
                            Events.Notify:Fire("✅ Successfully updated pose \'<b>" .. u74.Name .. "</b>\'.");

                            return;
                        end;

                        Events.Notify:Fire("❌ Failed to update pose.");
                    end);
                end,

                OnRename = function(u77) -- Line: 434, Name: OnRename
                    -- upvalues: Events (ref), Remotes (ref)
                    local u78 = Events.PromptInputDialog:Invoke({
                        Title = "Rename Pose",
                        Description = "Enter a new name for your pose.",
                        NoText = "Cancel",
                        YesText = "Rename",
                        PlaceholderText = "Name",
                        DefaultText = u77.Name
                    });

                    if u78 == false then
                        return;
                    end;

                    task.spawn(function() -- Line: 444
                        -- upvalues: Remotes (ref), u77 (copy), u78 (copy), Events (ref)
                        if Remotes.SavedPoseAction:InvokeServer({
                            Action = "Rename",
                            Id = u77.Id,
                            Name = u78
                        }) then
                            Events.Notify:Fire("✅ Successfully renamed pose.");

                            return;
                        end;

                        Events.Notify:Fire("❌ Failed to rename pose.");
                    end);
                end
            };
            table.insert(u2, viewItem.Activated:Connect(function() -- Line: 455
                -- upvalues: ItemButton (ref), u69 (copy), v (copy), u79 (copy)
                ItemButton.ShowContextButtons(u69, v, u79);
            end));
        end;

        u69.Parent = poses;
    end;

    updateWrapperOverflow();
end;

local function cleanup() -- Line: 468
    -- upvalues: u2 (copy), u3 (copy), wrapper (copy)
    for _, v in u2 do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect();
        end;
    end;

    table.clear(u2);

    for _, v in u3 do
        if typeof(v) == "Instance" then
            pcall(v.Destroy, v);
        end;
    end;

    table.clear(u3);
    wrapper.AutomaticCanvasSize = Enum.AutomaticSize.None;
    wrapper.CanvasSize = UDim2.new(0, 0, 0, 0);
    wrapper.CanvasPosition = Vector2.new(0, 0);
    wrapper.Size = UDim2.new(wrapper.Size.X.Scale, wrapper.Size.X.Offset, 0, 0);
    game:GetService("CollectionService"):RemoveTag(wrapper, "AutomaticSizeFix");
    game:GetService("CollectionService"):RemoveTag(wrapper, "ScrollingFrameAutomaticSizeFix");
    wrapper.ClipsDescendants = false;
    wrapper.ScrollingEnabled = false;
end;

local function buildMotorMap() -- Line: 496
    -- upvalues: u7 (copy), u4 (ref), u8 (copy), u9 (copy), u10 (copy)
    table.clear(u7);

    if not u4 then
        return;
    end;

    for _, descendant in u4:GetDescendants() do
        if (descendant:IsA("Motor6D") or descendant:IsA("AnimationConstraint")) and descendant.Part1 then
            u7[descendant.Part1] = descendant;

            if not u8[descendant] then
                u8[descendant] = descendant.C0;
            end;

            if not u9[descendant] then
                u9[descendant] = CFrame.new();
            end;

            if not u10[descendant] then
                u10[descendant] = Vector3.new(0, 0, 0);
            end;
        end;
    end;
end;

local function poseDesiredC0(p80) -- Line: 519
    -- upvalues: u8 (copy), u10 (copy), u9 (copy)
    local Position = (u8[p80] * p80.C1:Inverse()).Position;

    return CFrame.new(Position) * p80.C1 * CFrame.new(u10[p80] or Vector3.new(0, 0, 0)) * (u9[p80] or CFrame.new());
end;

local function applyPose(p81) -- Line: 528
    -- upvalues: u8 (copy), poseDesiredC0 (copy)
    local v82 = u8[p81];

    if not v82 then
        return;
    end;

    local v83 = poseDesiredC0(p81);

    if p81:IsA("AnimationConstraint") then
        p81.Transform = v82:Inverse() * v83;

        return;
    end;

    p81.C0 = v83;
end;

RunService.PreSimulation:Connect(function() -- Line: 550
    -- upvalues: u1 (copy), u8 (copy), poseDesiredC0 (copy)
    if not u1.IsPosed then
        return;
    end;

    for i, v in u8 do
        if i and i.Parent then
            if i:IsA("AnimationConstraint") then
                i.Transform = v:Inverse() * poseDesiredC0(i) * i.Transform;
            else
                i.C0 = poseDesiredC0(i);
            end;
        end;
    end;
end);

local function updateBodyDiagram(p84) -- Line: 567
    -- upvalues: u33 (ref)
    if not u33 then
        return;
    end;

    for _, child in u33:GetChildren() do
        if child:IsA("Frame") then
            local v85 = child.Name == p84;
            local selected = child:FindFirstChild("selected");

            if selected then
                selected.Enabled = v85;
            end;

            for _, child2 in child:GetChildren() do
                if child2:IsA("UIStroke") and child2.Name ~= "selected" then
                    child2.Enabled = not v85;
                end;
            end;

            child.ZIndex = v85 and 3 or 1;
        end;
    end;
end;

local function selectPart(p86) -- Line: 588
    -- upvalues: u7 (copy), u11 (ref), u12 (ref), u15 (ref), u16 (ref), u20 (ref), u13 (ref), u14 (ref), Pose (copy), actions (copy), updateBodyDiagram (copy)
    local v87 = u7[p86];

    if not v87 then
        return;
    end;

    u11 = v87;
    u12 = p86;

    if u15 then
        u15.Adornee = p86;
    end;

    if u16 then
        u16.CFrame = p86.CFrame;
    end;

    if u20 == "rotate" and u13 then
        u13.Adornee = u16;
    end;

    if u20 == "move" and u14 then
        u14.Adornee = u16;
    end;

    Pose.selectedLabel.Text = p86.Name;
    Pose.selectedLabel.Visible = true;
    actions.resetJoint.Visible = true;
    updateBodyDiagram(p86.Name);
end;

local function deselectPart() -- Line: 614
    -- upvalues: u11 (ref), u12 (ref), u15 (ref), u13 (ref), u14 (ref), u17 (ref), Pose (copy), actions (copy), updateBodyDiagram (copy)
    u11 = nil;
    u12 = nil;

    if u15 then
        u15.Adornee = nil;
    end;

    if u13 then
        u13.Adornee = nil;
    end;

    if u14 then
        u14.Adornee = nil;
    end;

    u17 = false;
    Pose.selectedLabel.Visible = false;
    actions.resetJoint.Visible = false;
    updateBodyDiagram(nil);
end;

local function setMode(p88) -- Line: 636
    -- upvalues: u20 (ref), modes (copy), TweenService (copy), u37 (copy), u12 (ref), u13 (ref), u16 (ref), u14 (ref)
    u20 = p88;

    for _, child in modes:GetChildren() do
        if child:IsA("TextButton") then
            local v89;

            if child.Name == "rotation" and p88 == "rotate" then
                v89 = true;
            elseif child.Name == "position" then
                v89 = p88 == "move";
            else
                v89 = false;
            end;

            TweenService:Create(child, u37, {
                BackgroundTransparency = v89 and 0.8 or 0.925
            }):Play();
        end;
    end;

    local v90 = u12 ~= nil;

    if u13 then
        local v91;

        if p88 == "rotate" and v90 then
            v91 = u16;
        else
            v91 = nil;
        end;

        u13.Adornee = v91;
    end;

    if u14 then
        local v92;

        if p88 == "move" and v90 then
            v92 = u16;
        else
            v92 = nil;
        end;

        u14.Adornee = v92;
    end;
end;

local function setupGizmos() -- Line: 655
    -- upvalues: u16 (ref), u3 (copy), u13 (ref), Pose (copy), u14 (ref), u15 (ref), u2 (copy), RunService (copy), u12 (ref), u11 (ref), u17 (ref), u18 (ref), u19 (ref), LocalPlayer (copy), u9 (copy), u8 (copy), poseDesiredC0 (copy), u10 (copy), modes (copy), setMode (copy), UserInputService (copy), sendPoseToServer (copy)
    u16 = Instance.new("Part");
    u16.Name = "PoseGizmoProxy";
    u16.Size = Vector3.new(1, 1, 1);
    u16.Transparency = 1;
    u16.Anchored = true;
    u16.CanCollide = false;
    u16.CanQuery = false;
    u16.Parent = workspace;
    table.insert(u3, u16);
    u13 = Instance.new("ArcHandles");
    u13.Color3 = Color3.fromRGB(0, 170, 255);
    u13.Parent = Pose;
    table.insert(u3, u13);
    u14 = Instance.new("Handles");
    u14.Style = Enum.HandlesStyle.Movement;
    u14.Color3 = Color3.fromRGB(38, 255, 0);
    u14.Parent = Pose;
    table.insert(u3, u14);
    u15 = Instance.new("SelectionBox");
    u15.Color3 = Color3.fromRGB(0, 170, 255);
    u15.LineThickness = 0.02;
    u15.SurfaceTransparency = 0.85;
    u15.SurfaceColor3 = Color3.fromRGB(0, 170, 255);
    u15.Parent = Pose;
    table.insert(u3, u15);
    table.insert(u2, RunService.PreSimulation:Connect(function() -- Line: 688
        -- upvalues: u12 (ref), u16 (ref)
        if u12 and u16 then
            u16.CFrame = u12.CFrame;
        end;
    end));
    local u93 = CFrame.new();
    table.insert(u2, u13.MouseButton1Down:Connect(function() -- Line: 698
        -- upvalues: u11 (ref), u17 (ref), u18 (ref), u19 (ref), LocalPlayer (ref), u93 (ref), u9 (ref)
        if not u11 then
            return;
        end;

        u17 = true;
        local CurrentCamera = workspace.CurrentCamera;

        if u18 == nil and CurrentCamera then
            u18 = CurrentCamera.CameraType;
            CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        end;

        local v94;

        if u19 then
            v94 = u19;
        else
            local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");

            if PlayerModule then
                u19 = require(PlayerModule):GetControls();
            end;

            v94 = u19;
        end;

        if v94 then
            v94:Disable();
        end;

        u93 = u9[u11] or CFrame.new();
    end));
    table.insert(u2, u13.MouseDrag:Connect(function(p95, p96) -- Line: 705
        -- upvalues: u11 (ref), u9 (ref), u93 (ref), u8 (ref), poseDesiredC0 (ref)
        if not u11 then
            return;
        end;

        local v97 = Vector3.FromAxis(p95);
        local v98 = u11.C1:Inverse():VectorToWorldSpace(v97);
        u9[u11] = u93 * CFrame.fromAxisAngle(v98, p96);
        local v99 = u11;
        local v100 = u8[v99];

        if not v100 then
            return;
        end;

        local v101 = poseDesiredC0(v99);

        if v99:IsA("AnimationConstraint") then
            v99.Transform = v100:Inverse() * v101;

            return;
        end;

        v99.C0 = v101;
    end));
    local u102 = Vector3.new(0, 0, 0);
    local u103 = CFrame.new();
    local u104 = CFrame.new();
    table.insert(u2, u14.MouseButton1Down:Connect(function(p105) -- Line: 720
        -- upvalues: u11 (ref), u17 (ref), u18 (ref), u19 (ref), LocalPlayer (ref), u102 (ref), u10 (ref), u103 (ref), u16 (ref), u8 (ref), u104 (ref)
        if not u11 then
            return;
        end;

        u17 = true;
        local CurrentCamera = workspace.CurrentCamera;

        if u18 == nil and CurrentCamera then
            u18 = CurrentCamera.CameraType;
            CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        end;

        local v106;

        if u19 then
            v106 = u19;
        else
            local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");

            if PlayerModule then
                u19 = require(PlayerModule):GetControls();
            end;

            v106 = u19;
        end;

        if v106 then
            v106:Disable();
        end;

        u102 = u10[u11] or Vector3.new(0, 0, 0);
        u103 = u16.CFrame.Rotation;
        local v107 = u8[u11];

        if v107 then
            local Position = (v107 * u11.C1:Inverse()).Position;
            local v108 = CFrame.new(Position) * u11.C1;
            u104 = (u11.Part0.CFrame * v108).Rotation;
        end;
    end));
    table.insert(u2, u14.MouseDrag:Connect(function(p109, p110) -- Line: 736
        -- upvalues: u11 (ref), u103 (ref), u104 (ref), u10 (ref), u102 (ref), u8 (ref), poseDesiredC0 (ref)
        if not u11 then
            return;
        end;

        u10[u11] = u102 + u104:VectorToObjectSpace((u103:VectorToWorldSpace(Vector3.FromNormalId(p109)))) * p110;
        local v111 = u11;
        local v112 = u8[v111];

        if not v112 then
            return;
        end;

        local v113 = poseDesiredC0(v111);

        if v111:IsA("AnimationConstraint") then
            v111.Transform = v112:Inverse() * v113;

            return;
        end;

        v111.C0 = v113;
    end));
    table.insert(u2, modes.rotation.Activated:Connect(function() -- Line: 748
        -- upvalues: setMode (ref)
        setMode("rotate");
    end));
    table.insert(u2, modes.position.Activated:Connect(function() -- Line: 751
        -- upvalues: setMode (ref)
        setMode("move");
    end));
    table.insert(u2, UserInputService.InputEnded:Connect(function(p114) -- Line: 757
        -- upvalues: u17 (ref), sendPoseToServer (ref), u18 (ref), u19 (ref), LocalPlayer (ref)
        if p114.UserInputType == Enum.UserInputType.MouseButton1 or p114.UserInputType == Enum.UserInputType.Touch then
            if u17 then
                u17 = false;
                sendPoseToServer();
            else
                u17 = false;
            end;

            local CurrentCamera = workspace.CurrentCamera;

            if u18 ~= nil then
                if CurrentCamera then
                    CurrentCamera.CameraType = u18;
                end;

                u18 = nil;
                local v115;

                if u19 then
                    v115 = u19;
                else
                    local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");

                    if PlayerModule then
                        u19 = require(PlayerModule):GetControls();
                    end;

                    v115 = u19;
                end;

                if v115 then
                    v115:Enable();
                end;
            end;
        end;
    end));
end;

local function setupClickDetection() -- Line: 773
    -- upvalues: u2 (copy), UserInputService (copy), u17 (ref), u7 (copy), selectPart (copy), u11 (ref), u12 (ref), u15 (ref), u13 (ref), u14 (ref), Pose (copy), actions (copy), updateBodyDiagram (copy)
    local CurrentCamera = workspace.CurrentCamera;
    table.insert(u2, UserInputService.InputBegan:Connect(function(u116, p117) -- Line: 776
        -- upvalues: u17 (ref), CurrentCamera (copy), u7 (ref), selectPart (ref), u11 (ref), u12 (ref), u15 (ref), u13 (ref), u14 (ref), Pose (ref), actions (ref), updateBodyDiagram (ref)
        if p117 then
            return;
        end;

        if u116.UserInputType ~= Enum.UserInputType.MouseButton1 and u116.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        task.defer(function() -- Line: 784
            -- upvalues: u17 (ref), u116 (copy), CurrentCamera (ref), u7 (ref), selectPart (ref), u11 (ref), u12 (ref), u15 (ref), u13 (ref), u14 (ref), Pose (ref), actions (ref), updateBodyDiagram (ref)
            if u17 then
                return;
            end;

            local Position = u116.Position;
            local v118 = CurrentCamera:ViewportPointToRay(Position.X, Position.Y);
            local v119 = RaycastParams.new();
            v119.FilterType = Enum.RaycastFilterType.Include;
            local v120 = {};

            for i, _ in u7 do
                table.insert(v120, i);
            end;

            v119.FilterDescendantsInstances = v120;
            local v121 = workspace:Raycast(v118.Origin, v118.Direction * 100, v119);

            if v121 and (v121.Instance and u7[v121.Instance]) then
                selectPart(v121.Instance);

                return;
            end;

            u11 = nil;
            u12 = nil;

            if u15 then
                u15.Adornee = nil;
            end;

            if u13 then
                u13.Adornee = nil;
            end;

            if u14 then
                u14.Adornee = nil;
            end;

            u17 = false;
            Pose.selectedLabel.Visible = false;
            actions.resetJoint.Visible = false;
            updateBodyDiagram(nil);
        end);
    end));
end;

local function setupBodySelector() -- Line: 813
    -- upvalues: u33 (ref), u2 (copy), u4 (ref), u7 (copy), selectPart (copy)
    if not u33 then
        return;
    end;

    for _, child in u33:GetChildren() do
        if child:IsA("Frame") then
            local button = child:FindFirstChild("button");

            if button then
                table.insert(u2, button.Activated:Connect(function() -- Line: 821
                    -- upvalues: u4 (ref), child (copy), u7 (ref), selectPart (ref)
                    if not u4 then
                        return;
                    end;

                    local v122 = u4:FindFirstChild(child.Name);

                    if v122 and u7[v122] then
                        selectPart(v122);
                    end;
                end));
            end;
        end;
    end;
end;

function u1.Open(p123) -- Line: 833
    -- upvalues: u1 (copy), u4 (ref), LocalPlayer (copy), u5 (ref), u6 (ref), PlayEmote (copy), bindEmoteTracking (copy), u20 (ref), buildMotorMap (copy), u8 (copy), u2 (copy), u24 (ref), Events (copy), r6 (copy), r15 (copy), u33 (ref), Pose (copy), setupGizmos (copy), UserInputService (copy), u17 (ref), u7 (copy), selectPart (copy), u11 (ref), u12 (ref), u15 (ref), u13 (ref), u14 (ref), actions (copy), updateBodyDiagram (copy), setupBodySelector (copy), setMode (copy), sendPoseToServer (copy), u36 (ref), container (copy), toggleSavedPoses (copy), wrapper (copy), updateWrapperOverflow (copy), u34 (copy), exit (copy), searchInput (copy), clear (copy), filterPoseItems (copy), saveNewPoseContainer (copy), serializeCurrentPose (copy), Remotes (copy), populateSavedPoses (copy), u9 (copy), u10 (copy), poseDesiredC0 (copy)
    local v124 = p123 or {};

    if not v124.SkipUI and u1.IsUIOpen then
        return;
    end;

    if v124.SkipUI and u1.IsOpen then
        return;
    end;

    if not u1.IsOpen then
        u4 = LocalPlayer.Character;

        if not u4 then
            return;
        end;

        u5 = u4:FindFirstChildOfClass("Humanoid");

        if not u5 then
            return;
        end;

        if not u4:FindFirstChild("HumanoidRootPart") then
            return;
        end;

        u1.IsOpen = true;
        u6 = u5:FindFirstChildOfClass("Animator");
        local Animate = u4:FindFirstChild("Animate");

        if Animate then
            Animate.Enabled = false;
        end;

        if u6 then
            for _, v in u6:GetPlayingAnimationTracks() do
                v:Stop(0);
                v:Destroy();
            end;

            PlayEmote.DirectAnimator = u6;
        end;

        if u1.IsPosed ~= true then
            u1.IsPosed = true;
            bindEmoteTracking();
        end;

        u20 = "rotate";
        buildMotorMap();

        for i, _ in u8 do
            if i and (i.Parent and i:IsA("Motor6D")) then
                i.Transform = CFrame.new();
                i.CurrentAngle = 0;
                i.DesiredAngle = 0;
                i.MaxVelocity = 0;
                local v125 = i:GetPropertyChangedSignal("Transform");
                table.insert(u2, v125:Connect(function() -- Line: 886
                    -- upvalues: u24 (ref), i (copy)
                    if not u24 then
                        i.Transform = CFrame.new();
                    end;
                end));
                local v126 = i:GetPropertyChangedSignal("CurrentAngle");
                table.insert(u2, v126:Connect(function() -- Line: 891
                    -- upvalues: u24 (ref), i (copy)
                    if not u24 then
                        i.CurrentAngle = 0;
                    end;
                end));
                local v127 = i:GetPropertyChangedSignal("DesiredAngle");
                table.insert(u2, v127:Connect(function() -- Line: 896
                    -- upvalues: u24 (ref), i (copy)
                    if not u24 then
                        i.DesiredAngle = 0;
                    end;
                end));
            end;
        end;

        table.insert(u2, u5.Died:Connect(function() -- Line: 906
            -- upvalues: u1 (ref)
            u1.Close();
        end));
    end;

    if v124.SkipUI then
        return;
    end;

    u1.IsUIOpen = true;
    Events.InterfaceAction:Fire("Add", "PoseModeController", u1.Close);
    Events.SetButtonsVisible:Fire({}, nil);
    local v128 = u5.RigType == Enum.HumanoidRigType.R15;
    r6.Visible = not v128;
    r15.Visible = v128;
    local v129;

    if v128 then
        v129 = r15;
    else
        v129 = r6;
    end;

    u33 = v129;
    Pose.Enabled = true;
    setupGizmos();
    local CurrentCamera = workspace.CurrentCamera;
    table.insert(u2, UserInputService.InputBegan:Connect(function(u130, p131) -- Line: 776
        -- upvalues: u17 (ref), CurrentCamera (copy), u7 (ref), selectPart (ref), u11 (ref), u12 (ref), u15 (ref), u13 (ref), u14 (ref), Pose (ref), actions (ref), updateBodyDiagram (ref)
        if p131 then
            return;
        end;

        if u130.UserInputType ~= Enum.UserInputType.MouseButton1 and u130.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        task.defer(function() -- Line: 784
            -- upvalues: u17 (ref), u130 (copy), CurrentCamera (ref), u7 (ref), selectPart (ref), u11 (ref), u12 (ref), u15 (ref), u13 (ref), u14 (ref), Pose (ref), actions (ref), updateBodyDiagram (ref)
            if u17 then
                return;
            end;

            local Position = u130.Position;
            local v132 = CurrentCamera:ViewportPointToRay(Position.X, Position.Y);
            local v133 = RaycastParams.new();
            v133.FilterType = Enum.RaycastFilterType.Include;
            local v134 = {};

            for i, _ in u7 do
                table.insert(v134, i);
            end;

            v133.FilterDescendantsInstances = v134;
            local v135 = workspace:Raycast(v132.Origin, v132.Direction * 100, v133);

            if v135 and (v135.Instance and u7[v135.Instance]) then
                selectPart(v135.Instance);

                return;
            end;

            u11 = nil;
            u12 = nil;

            if u15 then
                u15.Adornee = nil;
            end;

            if u13 then
                u13.Adornee = nil;
            end;

            if u14 then
                u14.Adornee = nil;
            end;

            u17 = false;
            Pose.selectedLabel.Visible = false;
            actions.resetJoint.Visible = false;
            updateBodyDiagram(nil);
        end);
    end));
    setupBodySelector();
    setMode("rotate");
    task.defer(sendPoseToServer);
    local _ = u36 == false;
    u36 = false;
    container.Visible = false;
    toggleSavedPoses.Visible = true;
    table.insert(u2, toggleSavedPoses.button.Activated:Connect(function() -- Line: 942
        -- upvalues: u36 (ref), container (ref), toggleSavedPoses (ref)
        if u36 == true then
            return;
        end;

        u36 = true;
        container.Visible = true;
        toggleSavedPoses.Visible = false;
    end));
    table.insert(u2, wrapper.header.closeButton.Activated:Connect(function() -- Line: 945
        -- upvalues: u36 (ref), container (ref), toggleSavedPoses (ref)
        if u36 == false then
            return;
        end;

        u36 = false;
        container.Visible = false;
        toggleSavedPoses.Visible = true;
    end));
    updateWrapperOverflow();
    local v136 = u34:GetPropertyChangedSignal("AbsoluteContentSize");
    table.insert(u2, v136:Connect(updateWrapperOverflow));
    local v137 = exit:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(u2, v137:Connect(updateWrapperOverflow));
    searchInput.Text = "";
    clear.Visible = false;
    local v138 = searchInput:GetPropertyChangedSignal("Text");
    table.insert(u2, v138:Connect(function() -- Line: 955
        -- upvalues: clear (ref), searchInput (ref), filterPoseItems (ref)
        clear.Visible = searchInput.Text ~= "";

        if searchInput.Text == "" then
            filterPoseItems("");
        end;
    end));
    table.insert(u2, searchInput.FocusLost:Connect(function(p139) -- Line: 961
        -- upvalues: filterPoseItems (ref), searchInput (ref)
        if p139 then
            filterPoseItems(searchInput.Text);
        end;
    end));
    table.insert(u2, clear.Activated:Connect(function() -- Line: 966
        -- upvalues: searchInput (ref)
        searchInput.Text = "";
        searchInput:CaptureFocus();
    end));
    table.insert(u2, saveNewPoseContainer.button.Activated:Connect(function() -- Line: 972
        -- upvalues: Events (ref), serializeCurrentPose (ref), Remotes (ref)
        local u140 = Events.PromptInputDialog:Invoke({
            Title = "New Pose",
            Description = "What would you like to name your new pose?",
            NoText = "Cancel",
            YesText = "Save",
            PlaceholderText = "Name",
            DefaultText = "New Pose"
        });

        if u140 == false then
            return;
        end;

        local u141, u142 = serializeCurrentPose();
        task.spawn(function() -- Line: 984
            -- upvalues: Remotes (ref), u140 (copy), u141 (copy), u142 (copy), Events (ref)
            local v143, _ = Remotes.SavedPoseAction:InvokeServer({
                Action = "Create",
                Name = u140,
                RigType = u141,
                Joints = u142
            });

            if v143 then
                Events.Notify:Fire("✅ Successfully saved pose \'<b>" .. u140 .. "</b>\'!");

                return;
            end;

            Events.Notify:Fire("❌ Failed to save pose.");
        end);
    end));
    table.insert(u2, Remotes.SavedPosesUpdated.OnClientEvent:Connect(function(p144) -- Line: 1000
        -- upvalues: populateSavedPoses (ref)
        populateSavedPoses(p144);
    end));
    task.spawn(function() -- Line: 1005
        -- upvalues: Remotes (ref), populateSavedPoses (ref)
        local v145, v146 = Remotes.SavedPoseAction:InvokeServer({
            Action = "Get"
        });

        if v145 and v146 then
            populateSavedPoses(v146);
        end;
    end);
    table.insert(u2, Pose.exit.Activated:Connect(function() -- Line: 1013
        -- upvalues: u1 (ref)
        u1.Close();
    end));
    table.insert(u2, actions.resetAll.Activated:Connect(function() -- Line: 1018
        -- upvalues: u8 (ref), u9 (ref), u10 (ref), buildMotorMap (ref), sendPoseToServer (ref)
        for i, v in u8 do
            if i and i.Parent then
                if i:IsA("AnimationConstraint") then
                    i.Transform = CFrame.identity;
                else
                    i.C0 = v;
                end;
            end;
        end;

        table.clear(u9);
        table.clear(u10);
        table.clear(u8);
        buildMotorMap();
        task.defer(sendPoseToServer);
    end));
    table.insert(u2, actions.resetJoint.Activated:Connect(function() -- Line: 1044
        -- upvalues: u11 (ref), u8 (ref), u9 (ref), u10 (ref), poseDesiredC0 (ref), sendPoseToServer (ref)
        if not u11 then
            return;
        end;

        if u8[u11] and u11.Parent then
            u9[u11] = CFrame.new();
            u10[u11] = Vector3.new(0, 0, 0);
            local v147 = u11;
            local v148 = u8[v147];

            if v148 then
                local v149 = poseDesiredC0(v147);

                if v147:IsA("AnimationConstraint") then
                    v147.Transform = v148:Inverse() * v149;
                else
                    v147.C0 = v149;
                end;
            end;

            task.defer(sendPoseToServer);
        end;
    end));
end;

function u1.Close(p150) -- Line: 1056
    -- upvalues: u1 (copy), u8 (copy), u9 (copy), u10 (copy), poseDesiredC0 (copy), Events (copy), PlayEmote (copy), unbindEmoteTracking (copy), sendOriginalsToServer (copy), Pose (copy), u11 (ref), u12 (ref), u15 (ref), u13 (ref), u14 (ref), u17 (ref), actions (copy), updateBodyDiagram (copy), r6 (copy), r15 (copy), u33 (ref), cleanup (copy), u7 (copy), u4 (ref), u5 (ref), u6 (ref), u16 (ref), u20 (ref), u18 (ref), u19 (ref), LocalPlayer (copy), u24 (ref)
    if not u1.IsOpen then
        return;
    end;

    u1.IsOpen = false;
    u1.IsUIOpen = false;
    local v151 = false;

    for i, _ in u8 do
        local v152 = u9[i];
        local v153 = u10[i];

        if v152 and v152 ~= CFrame.new() or v153 and v153 ~= Vector3.new(0, 0, 0) then
            v151 = true;
            break;
        end;
    end;

    if v151 then
        for i, _ in u8 do
            if i and i.Parent then
                local v154 = u8[i];

                if v154 then
                    local v155 = poseDesiredC0(i);

                    if i:IsA("AnimationConstraint") then
                        i.Transform = v154:Inverse() * v155;
                    else
                        i.C0 = v155;
                    end;
                end;
            end;
        end;
    else
        local v156;

        if p150 then
            v156 = false;
        else
            v156 = not Events.PromptConfirmationDialog:Invoke({
                Title = "Reset pose?",
                Description = "You didn\'t adjust any joints. Reset to your normal animations, or keep stiff pose?",
                YesText = "Unpose",
                NoText = "Keep stiff"
            });
        end;

        if v156 then
            for i, _ in u8 do
                if i and i.Parent then
                    local v157 = u8[i];

                    if v157 then
                        local v158 = poseDesiredC0(i);

                        if i:IsA("AnimationConstraint") then
                            i.Transform = v157:Inverse() * v158;
                        else
                            i.C0 = v158;
                        end;
                    end;
                end;
            end;
        else
            for i, v in u8 do
                if i and i.Parent then
                    if i:IsA("AnimationConstraint") then
                        i.Transform = CFrame.identity;
                    else
                        i.C0 = v;
                        i.MaxVelocity = 0.1;
                    end;
                end;
            end;

            table.clear(u9);
            table.clear(u10);
            table.clear(u8);
            PlayEmote.DirectAnimator = nil;

            if u1.IsPosed ~= false then
                u1.IsPosed = false;
                unbindEmoteTracking();
            end;

            sendOriginalsToServer();
        end;
    end;

    Pose.Enabled = false;
    u11 = nil;
    u12 = nil;

    if u15 then
        u15.Adornee = nil;
    end;

    if u13 then
        u13.Adornee = nil;
    end;

    if u14 then
        u14.Adornee = nil;
    end;

    u17 = false;
    Pose.selectedLabel.Visible = false;
    actions.resetJoint.Visible = false;
    updateBodyDiagram(nil);
    r6.Visible = false;
    r15.Visible = false;
    u33 = nil;
    cleanup();
    table.clear(u7);
    u4 = nil;
    u5 = nil;
    u6 = nil;
    u13 = nil;
    u14 = nil;
    u15 = nil;
    u16 = nil;
    u20 = "rotate";
    u17 = false;
    local CurrentCamera = workspace.CurrentCamera;

    if u18 ~= nil then
        if CurrentCamera then
            CurrentCamera.CameraType = u18;
        end;

        u18 = nil;
        local v159;

        if u19 then
            v159 = u19;
        else
            local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");

            if PlayerModule then
                u19 = require(PlayerModule):GetControls();
            end;

            v159 = u19;
        end;

        if v159 then
            v159:Enable();
        end;
    end;

    u24 = false;
    currentEmoteTrack = nil;

    if emoteTrackConnection then
        emoteTrackConnection:Disconnect();
        emoteTrackConnection = nil;
    end;

    u11 = nil;
    u12 = nil;
    Events.InterfaceAction:Fire("Remove", "PoseModeController");
    Events.SetButtonsVisible:Fire({ "All" }, nil);
end;

Events.DisplayPose.Event:Connect(function() -- Line: 1163
    -- upvalues: u1 (copy)
    if u1.IsUIOpen then
        u1.Close();

        return;
    end;

    u1.Open();
end);
LocalPlayer.CharacterAdded:Connect(function() -- Line: 1174
    -- upvalues: u8 (copy), u9 (copy), u10 (copy), PlayEmote (copy), u1 (copy), unbindEmoteTracking (copy)
    table.clear(u8);
    table.clear(u9);
    table.clear(u10);
    PlayEmote.DirectAnimator = nil;

    if u1.IsPosed ~= false then
        u1.IsPosed = false;
        unbindEmoteTracking();
    end;

    if u1.IsOpen then
        u1.Close(true);
    end;
end);
Events.ApplyEmoteKeyframe.Event:Connect(function(p160) -- Line: 1185
    -- upvalues: Remotes (copy), KeyframeSequenceProvider (copy), u1 (copy), bindEmoteTracking (copy), u8 (copy), u9 (copy), u10 (copy), poseDesiredC0 (copy), sendPoseToServer (copy)
    if typeof(p160) ~= "number" then
        return;
    end;

    local v161, u162 = Remotes.GetEmote:InvokeServer(p160);

    if not v161 or (typeof(u162) ~= "table" or not u162.EmoteId) then
        warn("[PoseModeController] ApplyEmoteKeyframe: GetEmote failed for", p160);

        return;
    end;

    local success, result = pcall(function() -- Line: 1194
        -- upvalues: KeyframeSequenceProvider (ref), u162 (copy)
        return KeyframeSequenceProvider:GetKeyframeSequenceAsync(u162.EmoteId);
    end);

    if not (success and result) then
        warn("[PoseModeController] ApplyEmoteKeyframe: GetKeyframeSequenceAsync failed:", result);

        return;
    end;

    local u163 = result:GetKeyframes();

    if #u163 == 0 then
        warn("[PoseModeController] ApplyEmoteKeyframe: no keyframes");

        return;
    end;

    table.sort(u163, function(p164, p165) -- Line: 1211
        return p164.Time < p165.Time;
    end);
    local u166 = 0;

    for i = 1, #u163 - 1 do
        local v167 = u163[i + 1].Time - u163[i].Time;

        if u166 < v167 then
            u166 = v167;
        end;
    end;

    local function holdOf(p168) -- Line: 1219
        -- upvalues: u163 (copy), u166 (ref)
        if p168 < #u163 then
            return u163[p168 + 1].Time - u163[p168].Time;
        end;

        return u166;
    end;

    local v169 = u166 * 0.9;
    local v170 = u163[1];

    local function expressiveness(p171) -- Line: 1226
        local v172 = { p171 };
        local v173 = 0;

        while #v172 > 0 do
            for _, child in table.remove(v172):GetChildren() do
                if child:IsA("Pose") then
                    local _, v174 = child.CFrame:ToAxisAngle();
                    v173 = v173 + math.abs(v174);
                    table.insert(v172, child);
                end;
            end;
        end;

        return v173;
    end;

    local v175 = (-1 / 0);

    for i = 1, #u163 do
        local v176;

        if u166 == 0 then
            v176 = expressiveness(u163[i]);

            if v175 < v176 then
                v170 = u163[i];
                v175 = v176;
            end;
        else
            local v177;

            if i < #u163 then
                v177 = u163[i + 1].Time - u163[i].Time;
            else
                v177 = u166;
            end;

            if v169 <= v177 then
                v176 = expressiveness(u163[i]);

                if v175 < v176 then
                    v170 = u163[i];
                    v175 = v176;
                end;
            end;
        end;
    end;

    local u178 = {};

    local function walkPoses(p179) -- Line: 1256
        -- upvalues: u178 (copy), walkPoses (copy)
        for _, child in p179:GetChildren() do
            if child:IsA("Pose") then
                u178[child.Name] = child.CFrame;
                walkPoses(child);
            end;
        end;
    end;

    walkPoses(v170);

    if not u1.IsOpen then
        u1.Open({
            SkipUI = true
        });
    end;

    if u1.IsPosed ~= true then
        u1.IsPosed = true;
        bindEmoteTracking();
    end;

    for i, v in u8 do
        if i and i.Parent then
            u9[i] = CFrame.new();
            u10[i] = Vector3.new(0, 0, 0);

            if i:IsA("AnimationConstraint") then
                i.Transform = CFrame.identity;
            else
                i.C0 = v;
            end;
        end;
    end;

    for i, v in u8 do
        if i and (i.Parent and i.Part1) then
            local v180 = u178[i.Part1.Name];

            if v180 then
                local Position = (v * i.C1:Inverse()).Position;
                local v181 = (CFrame.new(Position) * i.C1):Inverse() * v * v180;
                u10[i] = v181.Position;
                u9[i] = v181.Rotation;
                local v182 = u8[i];

                if v182 then
                    local v183 = poseDesiredC0(i);

                    if i:IsA("AnimationConstraint") then
                        i.Transform = v182:Inverse() * v183;
                    else
                        i.C0 = v183;
                    end;
                end;
            end;
        end;
    end;

    sendPoseToServer();
end);
local u184 = {};

local function clearRemotePose(p185) -- Line: 1311
    -- upvalues: u184 (copy)
    local v186 = u184[p185];

    if v186 then
        v186:Disconnect();
        u184[p185] = nil;
    end;
end;

Remotes.PoseAnimatorAction.OnClientEvent:Connect(function(p187, u188, u189) -- Line: 1319
    -- upvalues: u184 (copy), RunService (copy)
    if p187 ~= "LockPose" then
        if p187 == "UnlockPose" then
            if not u188 then
                return;
            end;

            local v190 = u184[u188];

            if v190 then
                v190:Disconnect();
                u184[u188] = nil;
            end;

            local Character = u188.Character;

            if Character then
                for _, descendant in Character:GetDescendants() do
                    if descendant:IsA("AnimationConstraint") then
                        descendant.Transform = CFrame.identity;
                    end;
                end;
            end;
        end;

        return;
    end;

    if not u188 or typeof(u189) ~= "table" then
        return;
    end;

    local v191 = u184[u188];

    if v191 then
        v191:Disconnect();
        u184[u188] = nil;
    end;

    local u192 = nil;
    local u193 = {};
    u184[u188] = RunService.PreSimulation:Connect(function() -- Line: 1329
        -- upvalues: u188 (copy), u192 (ref), u193 (copy), u189 (copy)
        local Character = u188.Character;

        if not Character then
            return;
        end;

        if u192 ~= Character then
            u192 = Character;
            table.clear(u193);

            for _, descendant in Character:GetDescendants() do
                if (descendant:IsA("AnimationConstraint") or descendant:IsA("Motor6D")) and descendant.Part1 then
                    table.insert(u193, descendant);
                end;
            end;
        end;

        for _, v in u193 do
            local v194 = u189[v.Name];

            if v194 and v.Parent then
                if v:IsA("AnimationConstraint") then
                    v.Transform = v.C0:Inverse() * v194 * v.Transform;
                else
                    v.C0 = v194;
                end;
            end;
        end;
    end);
end);
Players.PlayerRemoving:Connect(function(p195) -- Line: 1370
    -- upvalues: u184 (copy)
    local v196 = u184[p195];

    if v196 then
        v196:Disconnect();
        u184[p195] = nil;
    end;
end);

return u1;