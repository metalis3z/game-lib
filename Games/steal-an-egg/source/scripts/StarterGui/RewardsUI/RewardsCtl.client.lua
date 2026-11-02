-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Frame = script.Parent:WaitForChild("Frame");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u1 = Color3.fromRGB(120, 235, 150);
local u2 = Color3.fromRGB(255, 150, 140);
local UIScale = Frame:WaitForChild("UIScale");
local List = Frame:WaitForChild("List");
local Verify = Frame:WaitForChild("Verify");
local Avatar = Frame:WaitForChild("Avatar");
local Handle = Frame:WaitForChild("Handle");
local Badge = Frame:WaitForChild("Badge");
local u3 = UserInputService.TouchEnabled and 1.1 or 1;
UIScale.Scale = u3;
local u4 = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local u5 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local u6 = nil;
local u7 = nil;

local function hideHud() -- Line: 59
    -- upvalues: u7 (ref), PlayerGui (copy)
    if u7 then
        return;
    end;

    u7 = {};
    local Menu = PlayerGui:FindFirstChild("Menu");

    if Menu then
        Menu = Menu:FindFirstChild("Frame");
    end;

    if Menu and Menu.Visible then
        Menu.Visible = false;
        u7.rail = Menu;
    end;

    local AdminPanelUI = PlayerGui:FindFirstChild("AdminPanelUI");

    if AdminPanelUI then
        AdminPanelUI = AdminPanelUI:FindFirstChild("RightFrame");
    end;

    if AdminPanelUI and AdminPanelUI.Visible then
        AdminPanelUI.Visible = false;
        u7.topbar = AdminPanelUI;
    end;
end;

local function restoreHud() -- Line: 76
    -- upvalues: u7 (ref)
    if not u7 then
        return;
    end;

    if u7.rail and u7.rail.Parent then
        u7.rail.Visible = true;
    end;

    if u7.topbar and u7.topbar.Parent then
        u7.topbar.Visible = true;
    end;

    u7 = nil;
end;

local function open() -- Line: 84
    -- upvalues: Frame (copy), u6 (ref), hideHud (copy), UIScale (copy), TweenService (copy), u4 (copy), u3 (copy)
    Frame:SetAttribute("RewardsOpen", true);

    if u6 then
        u6:Cancel();
        u6 = nil;
    end;

    hideHud();
    UIScale.Scale = 0;
    Frame.Visible = true;
    u6 = TweenService:Create(UIScale, u4, {
        Scale = u3
    });
    u6:Play();
end;

local function close() -- Line: 94
    -- upvalues: Frame (copy), u6 (ref), u7 (ref), TweenService (copy), UIScale (copy), u5 (copy), u3 (copy)
    if not Frame:GetAttribute("RewardsOpen") then
        return;
    end;

    Frame:SetAttribute("RewardsOpen", false);

    if u6 then
        u6:Cancel();
        u6 = nil;
    end;

    if u7 then
        if u7.rail and u7.rail.Parent then
            u7.rail.Visible = true;
        end;

        if u7.topbar and u7.topbar.Parent then
            u7.topbar.Visible = true;
        end;

        u7 = nil;
    end;

    u6 = TweenService:Create(UIScale, u5, {
        Scale = 0
    });
    u6.Completed:Once(function(p8) -- Line: 102
        -- upvalues: Frame (ref), UIScale (ref), u3 (ref)
        if p8 == Enum.PlaybackState.Completed and not Frame:GetAttribute("RewardsOpen") then
            Frame.Visible = false;
            UIScale.Scale = u3;
        end;
    end);
    u6:Play();
end;

Frame.Visible = false;
Frame:SetAttribute("RewardsOpen", false);

local function click(p9, u10) -- Line: 121
    if not p9 then
        return;
    end;

    local u11 = 0;

    local function go() -- Line: 124
        -- upvalues: u11 (ref), u10 (copy)
        if os.clock() - u11 < 0.15 then
            return;
        end;

        u11 = os.clock();
        u10();
    end;

    p9.MouseButton1Click:Connect(go);
    p9.Activated:Connect(go);
end;

local function hover(u12) -- Line: 136
    -- upvalues: TweenService (copy)
    if not u12 then
        return;
    end;

    u12:SetAttribute("Static", true);
    local u13 = u12:FindFirstChildOfClass("UIScale");

    if not u13 then
        u13 = Instance.new("UIScale");
        u13.Name = "HoverScale";
        u13.Parent = u12;
    end;

    local Scale = u13.Scale;
    u12.MouseEnter:Connect(function() -- Line: 146
        -- upvalues: TweenService (ref), u13 (ref), Scale (copy)
        TweenService:Create(u13, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {
            Scale = Scale * 1.05
        }):Play();
    end);
    u12.MouseLeave:Connect(function() -- Line: 149
        -- upvalues: TweenService (ref), u13 (ref), Scale (copy)
        TweenService:Create(u13, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {
            Scale = Scale
        }):Play();
    end);
    u12:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 152
        -- upvalues: u12 (copy), u13 (ref), Scale (copy)
        if not u12.Visible then
            u13.Scale = Scale;
        end;
    end);
end;

local function placeHandle() -- Line: 164
    -- upvalues: Frame (copy), Handle (copy), Badge (copy)
    local X = Frame.AbsoluteSize.X;

    if X <= 0 then
        return;
    end;

    local X2 = Handle.TextBounds.X;
    local X3 = Badge.AbsoluteSize.X;
    local v14 = X3 * 0.22;
    local v15 = 0.175 * X - (X2 + v14 + X3) / 2;
    Handle.AnchorPoint = Vector2.new(0, 0.5);
    Handle.TextXAlignment = Enum.TextXAlignment.Left;
    Handle.Position = UDim2.new(0, v15, 0.635, 0);
    Badge.Position = UDim2.new(0, v15 + X2 + v14, 0.635, 0);
end;

placeHandle();
Handle:GetPropertyChangedSignal("TextBounds"):Connect(placeHandle);
Badge:GetPropertyChangedSignal("AbsoluteSize"):Connect(placeHandle);
Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(placeHandle);
local Follow = List:WaitForChild("Follow");
local Desc = Follow:WaitForChild("Desc");
local Badge2 = Follow:FindFirstChild("Badge");

local function trailBadge() -- Line: 191
    -- upvalues: Badge2 (copy), Follow (copy), Desc (copy)
    if not Badge2 then
        return;
    end;

    local X = Follow.AbsoluteSize.X;

    if X <= 0 then
        return;
    end;

    Badge2.Position = UDim2.new(0, Desc.Position.X.Scale * X + Desc.TextBounds.X + Follow.AbsoluteSize.Y * 0.12, 0.5, 0);
end;

if Badge2 then
    if Badge2 then
        local X = Follow.AbsoluteSize.X;

        if X > 0 then
            Badge2.Position = UDim2.new(0, Desc.Position.X.Scale * X + Desc.TextBounds.X + Follow.AbsoluteSize.Y * 0.12, 0.5, 0);
        end;
    end;

    Desc:GetPropertyChangedSignal("TextBounds"):Connect(trailBadge);
    Follow:GetPropertyChangedSignal("AbsoluteSize"):Connect(trailBadge);
end;

local function rowStatus(p16) -- Line: 207
    -- upvalues: List (copy)
    local v17 = List:FindFirstChild(p16);

    if v17 then
        v17 = v17:FindFirstChild("Status");
    end;

    return v17;
end;

local function setRow(p18, p19, p20) -- Line: 212
    -- upvalues: List (copy)
    local v21 = List:FindFirstChild(p18);

    if v21 then
        v21 = v21:FindFirstChild("Status");
    end;

    if v21 then
        v21.Text = p19;
        v21.TextColor3 = p20;
    end;
end;

local Popup = Frame:WaitForChild("Popup");
local UIScale2 = Popup:WaitForChild("UIScale");
local Text = Popup:WaitForChild("Text");
local u22 = 0;

local function say(p23) -- Line: 226
    -- upvalues: u22 (ref), Text (copy), Popup (copy), UIScale2 (copy), TweenService (copy)
    u22 = u22 + 1;
    local u24 = u22;
    Text.Text = p23;
    Popup.Visible = true;
    UIScale2.Scale = 0;
    TweenService:Create(UIScale2, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    task.delay(3.5, function() -- Line: 234
        -- upvalues: u24 (copy), u22 (ref), TweenService (ref), UIScale2 (ref), Popup (ref)
        if u24 ~= u22 then
            return;
        end;

        local v25 = TweenService:Create(UIScale2, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Scale = 0
        });
        v25.Completed:Once(function() -- Line: 238
            -- upvalues: u24 (ref), u22 (ref), Popup (ref)
            if u24 == u22 then
                Popup.Visible = false;
            end;
        end);
        v25:Play();
    end);
end;

Popup.Visible = false;
local u26 = nil;
local u27 = false;

local function check(u28) -- Line: 255
    -- upvalues: u27 (ref), Verify (copy), Network (copy), say (copy), u26 (ref), Avatar (copy), Handle (copy), placeHandle (copy), List (copy), Badge2 (copy), Follow (copy), Desc (copy), u1 (copy), u2 (copy)
    if u27 then
        return;
    end;

    u27 = true;

    if u28 then
        Verify.Text = "Checking...";
    end;

    local success, result = pcall(function() -- Line: 262
        -- upvalues: Network (ref), u28 (copy)
        return Network:Invoke("RewardsVerify", u28 == true);
    end);
    u27 = false;

    if not success or type(result) ~= "table" then
        Verify.Text = "Verify";

        if u28 then
            say("Couldn\'t check right now — try again in a moment.");
        end;

        return;
    end;

    u26 = result.GroupId or u26;

    if result.OwnerUserId and Avatar.Image == "" then
        Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420"):format(result.OwnerUserId);
    end;

    if result.OwnerName and result.OwnerName ~= "" then
        Handle.Text = "@" .. result.OwnerName;
        placeHandle();
        local Follow2 = List:FindFirstChild("Follow");

        if Follow2 then
            Follow2 = Follow2:FindFirstChild("Desc");
        end;

        if Follow2 then
            Follow2.Text = ("Follow <b>@%s</b>"):format(result.OwnerName);
        end;
    end;

    if Badge2 then
        local X = Follow.AbsoluteSize.X;

        if X > 0 then
            Badge2.Position = UDim2.new(0, Desc.Position.X.Scale * X + Desc.TextBounds.X + Follow.AbsoluteSize.Y * 0.12, 0.5, 0);
        end;
    end;

    local Group = List:FindFirstChild("Group");

    if Group then
        Group = Group:FindFirstChild("Join");
    end;

    if result.Claimed then
        local v29 = u1;
        local Group2 = List:FindFirstChild("Group");

        if Group2 then
            Group2 = Group2:FindFirstChild("Status");
        end;

        if Group2 then
            Group2.Text = "✓ joined";
            Group2.TextColor3 = v29;
        end;

        if Group then
            Group.Visible = false;
        end;

        Verify.Text = "Claimed ✓";
        Verify.BackgroundColor3 = Color3.fromRGB(74, 176, 52);
        Verify.AutoButtonColor = false;

        if u28 and not result.AlreadyClaimed then
            say("Claimed! -1 min off every Admin Panel cooldown.");
        end;
    else
        local v30 = u2;
        local Group2 = List:FindFirstChild("Group");

        if Group2 then
            Group2 = Group2:FindFirstChild("Status");
        end;

        if Group2 then
            Group2.Text = "not yet";
            Group2.TextColor3 = v30;
        end;

        if Group then
            Group.Visible = true;
        end;

        Verify.Text = "Verify";
        Verify.BackgroundColor3 = Color3.fromRGB(124, 226, 84);

        if u28 then
            if result.Throttled then
                say("Slow down — try again in a few seconds.");

                return;
            end;

            say("You must follow the user, join group and like the game!");
        end;
    end;
end;

hover(Verify);

local function u31() -- Line: 328
    -- upvalues: check (copy)
    task.spawn(check, true);
end;

if Verify then
    local u32 = 0;

    local function v33() -- Line: 124
        -- upvalues: u32 (ref), u31 (copy)
        if os.clock() - u32 < 0.15 then
            return;
        end;

        u32 = os.clock();
        u31();
    end;

    Verify.MouseButton1Click:Connect(v33);
    Verify.Activated:Connect(v33);
end;

local Group = List:FindFirstChild("Group");
local v34 = Group and Group:FindFirstChild("Join");

if v34 then
    hover(v34);

    local function u35() -- Line: 339
        -- upvalues: u26 (ref), check (copy)
        task.spawn(function() -- Line: 340
            -- upvalues: u26 (ref), check (ref)
            if not u26 then
                check(false);
            end;

            if u26 then
                pcall(function() -- Line: 345
                    -- upvalues: u26 (ref)
                    game:GetService("GroupService"):PromptJoinAsync(u26);
                end);
            end;

            check(true);
        end);
    end;

    if v34 then
        local u36 = 0;

        local function v37() -- Line: 124
            -- upvalues: u36 (ref), u35 (copy)
            if os.clock() - u36 < 0.15 then
                return;
            end;

            u36 = os.clock();
            u35();
        end;

        v34.MouseButton1Click:Connect(v37);
        v34.Activated:Connect(v37);
    end;
end;

local close2 = Frame:WaitForChild("close");
hover(close2);

if close2 then
    local u38 = 0;

    local function v39() -- Line: 124
        -- upvalues: u38 (ref), close (copy)
        if os.clock() - u38 < 0.15 then
            return;
        end;

        u38 = os.clock();
        close();
    end;

    close2.MouseButton1Click:Connect(v39);
    close2.Activated:Connect(v39);
end;

task.spawn(function() -- Line: 363
    -- upvalues: PlayerGui (copy), hover (copy), Frame (copy), close (copy), open (copy), check (copy)
    local AdminPanelUI = PlayerGui:WaitForChild("Rewards", 30);

    if not AdminPanelUI then
        return;
    end;

    local RightFrame = AdminPanelUI:WaitForChild("Frame", 10);

    if RightFrame then
        RightFrame = RightFrame:WaitForChild("Button", 10);
    end;

    if not RightFrame then
        return;
    end;

    hover(RightFrame);

    local function u40() -- Line: 371
        -- upvalues: Frame (ref), close (ref), open (ref), check (ref)
        if Frame:GetAttribute("RewardsOpen") then
            close();

            return;
        end;

        open();
        task.spawn(check, false);
    end;

    if not RightFrame then
        return;
    end;

    local u41 = 0;

    local function v42() -- Line: 124
        -- upvalues: u41 (ref), u40 (copy)
        if os.clock() - u41 < 0.15 then
            return;
        end;

        u41 = os.clock();
        u40();
    end;

    RightFrame.MouseButton1Click:Connect(v42);
    RightFrame.Activated:Connect(v42);
end);
task.spawn(function() -- Line: 384
    -- upvalues: check (copy)
    task.wait(3);
    check(false);
end);