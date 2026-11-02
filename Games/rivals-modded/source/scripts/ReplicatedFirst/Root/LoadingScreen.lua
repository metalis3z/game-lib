-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local RenderstepForLoop = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Utility"):WaitForChild("RenderstepForLoop"));
local BetterDebris = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("BetterDebris"));
local EventLibrary = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("EventLibrary"));
local Signal = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Signal"));
local GlowyBackground = require(Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Modules"):WaitForChild("GlowyBackground"));
local ChickenFooter = require(Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Modules"):WaitForChild("ChickenFooter"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 21
    -- upvalues: u1 (copy), Signal (copy), ChickenFooter (copy), GlowyBackground (copy)
    local v2 = setmetatable({}, u1);
    v2.DeviceSelected = Signal.new();
    v2.LoadingScreen = script:WaitForChild("LoadingScreen");
    v2.MainFrame = v2.LoadingScreen:WaitForChild("MainFrame");
    v2.Device = v2.MainFrame:WaitForChild("Device");
    v2.DeviceTitle = v2.Device:WaitForChild("Title");
    v2.ConfirmDeviceButton = v2.Device:WaitForChild("Confirm");
    v2.Controls = v2.Device:WaitForChild("Controls");
    v2.DesktopButton = v2.Controls:WaitForChild("Desktop");
    v2.ConsoleButton = v2.Controls:WaitForChild("Console");
    v2.MobileButton = v2.Controls:WaitForChild("Mobile");
    v2.GameLogo = v2.MainFrame:WaitForChild("GameLogo");
    v2.Logo = v2.MainFrame:WaitForChild("Logo");
    v2.LogoN = v2.Logo:WaitForChild("N");
    v2.ContainerN = v2.LogoN:WaitForChild("Container");
    v2.WhiteN = v2.ContainerN:WaitForChild("White");
    v2.BlackN = v2.ContainerN:WaitForChild("Black");
    v2.LogoG = v2.Logo:WaitForChild("G");
    v2.ContainerG = v2.LogoG:WaitForChild("Container");
    v2.WhiteG = v2.ContainerG:WaitForChild("White");
    v2.BlackG = v2.ContainerG:WaitForChild("Black");
    v2._blur = Instance.new("BlurEffect");
    v2._connection = nil;
    v2._chosen_device = nil;
    v2._chicken_footer = ChickenFooter.new();
    v2._glowy_background = GlowyBackground.new("LoadingScreen");
    v2:_Init();

    return v2;
end;

function u1.Activate(p3) -- Line: 61
    -- upvalues: Players (copy), Lighting (copy)
    p3.LoadingScreen.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
    p3._blur.Parent = Lighting;
end;

function u1.PlayLogoAnimation(p4, p5) -- Line: 67
    -- upvalues: BetterDebris (copy)
    local v6 = typeof(p5) == "number";
    local v7 = "Argument 1 invalid, expected a number, got " .. tostring(p5);
    assert(v6, v7);
    p4:_ResetLogo();
    p4.Logo.Visible = true;
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://6384899588";
    Sound.Volume = 1;
    Sound.Parent = script;
    Sound:Play();
    BetterDebris:AddItem(Sound, 20);
    p4:_SpiralAnimation(p5);
end;

function u1.SplitLogo(u8) -- Line: 84
    -- upvalues: RenderstepForLoop (copy)
    u8.Logo:TweenPosition(UDim2.new(0.5, 0, 1, 0), "In", "Back", 0.75, true);
    u8.LogoN:TweenPosition(UDim2.new(-0.5, 0, 0.5, 0), "InOut", "Sine", 1.5, true);
    u8.LogoG:TweenPosition(UDim2.new(1.5, 0, 0.5, 0), "InOut", "Sine", 1.5, true);
    RenderstepForLoop(0, 100, 2, function(p9) -- Line: 92
        -- upvalues: u8 (copy)
        local v10 = (0 + 720 * (p9 / 100) ^ 2) % 360;
        u8.LogoN.Rotation = -v10;
        u8.LogoG.Rotation = v10;
    end);
end;

function u1.SetProgress(p11, p12, p13) -- Line: 102
    local v14 = typeof(p12) == "number";
    local v15 = "Argument 1 invalid, expected a number, got " .. tostring(p12);
    assert(v14, v15);
    local v16 = typeof(p13) == "number";
    local v17 = "Argument 2 invalid, expected a number, got " .. tostring(p13);
    assert(v16, v17);
    local UDim2_new_ret = UDim2.new(1, 0, p12, 0);
    local UDim2_new_ret2 = UDim2.new(1, 0, 1 - p12, 0);
    p11.WhiteN:TweenSize(UDim2_new_ret, "Out", "Quint", p13, true);
    p11.BlackN:TweenSize(UDim2_new_ret2, "Out", "Quint", p13, true);
    p11.WhiteG:TweenSize(UDim2_new_ret, "Out", "Quint", p13, true);
    p11.BlackG:TweenSize(UDim2_new_ret2, "Out", "Quint", p13, true);
end;

function u1.PickDevice(p18, p19) -- Line: 116
    -- upvalues: GuiService (copy)
    local v20 = typeof(p19) == "table";
    local v21 = "Argument 1 invalid, expected a table, got " .. tostring(p19);
    assert(v20, v21);
    p18.Device.Position = UDim2.new(0.5, 0, -0.5, 0);
    p18.Device:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 1, true);
    p18.Device.Visible = true;
    p18.DesktopButton.Visible = table.find(p19, "Desktop");
    p18.ConsoleButton.Visible = table.find(p19, "Console");
    p18.MobileButton.Visible = table.find(p19, "Mobile");
    local v22;

    if p18.ConsoleButton.Visible then
        v22 = p18.ConsoleButton or nil;
    else
        v22 = nil;
    end;

    GuiService.SelectedObject = v22;
    local v23 = p18.DeviceSelected:Wait();
    GuiService.SelectedObject = nil;
    p18.Device.Visible = false;

    return v23;
end;

function u1.PreRequireClient(p24) -- Line: 137
    -- upvalues: BetterDebris (copy)
    p24.GameLogo.Visible = true;
    p24.GameLogo.Size = UDim2.new(1, 0, 1, 0);
    p24.GameLogo:TweenSize(UDim2.new(0.6, 0, 0.6, 0), "Out", "Back", 0.5, true);
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://8483887957";
    Sound.Volume = 1;
    Sound.Parent = script;
    Sound:Play();
    BetterDebris:AddItem(Sound, 20);
    wait(0.5);
end;

function u1.Close(u25) -- Line: 152
    -- upvalues: ReplicatedStorage (copy), RenderstepForLoop (copy)
    u25._connection:Disconnect();
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    u25.MainFrame.Active = false;
    u25.GameLogo:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quint", 1.5, true);
    u25.GameLogo:TweenPosition(UDim2.new(0.5, 0, 1, 0), "In", "Quint", 1.5, true);
    ReplicatedStorage.Remotes.Data.LoadingScreenDone:FireServer();
    u25._chicken_footer:Hide();
    u25._glowy_background:SetEnabled(false);
    wait(0.5);
    RenderstepForLoop(0, 100, 2, function(p26) -- Line: 167
        -- upvalues: u25 (copy)
        u25.GameLogo.ImageTransparency = (p26 / 100) ^ 3;
        u25._blur.Size = 56 * (1 - (1 - (1 - p26 / 100) ^ 3));
    end);
    u25:Destroy();
end;

function u1.Update(p27, p28) -- Line: 177
    local v29 = tick() * 2 % 6.283185307179586;
    local v30 = math.sin(v29) * 0.05;
    local v31 = math.sin(v29 - 0.7853981633974483) * 0.05;
    p27.ContainerN.Position = UDim2.new(0.5, 0, v30 + 0.5, 0);
    p27.ContainerG.Position = UDim2.new(0.5, 0, v31 + 0.5, 0);
    p27:_ApplyFill();
end;

-- The logo fills from the bottom as White grows (SetProgress tweens it): a hard step in each
-- letter image's vertical gradient, dark above and white below. The Nosniy Games image is square
-- with the letters between LOGO_TOP and LOGO_BOTTOM of its height; the step moves only there.
local FILL_EMPTY = Color3.fromRGB(58, 58, 66);
local FILL_FULL = Color3.fromRGB(255, 255, 255);
local LOGO_TOP = 0.262;
local LOGO_BOTTOM = 0.738;

function u1._ApplyFill(p70)
    for _, v71 in pairs({ { p70.ContainerN, p70.WhiteN }, { p70.ContainerG, p70.WhiteG } }) do
        local v72 = v71[1]:FindFirstChild("Half");
        local v73 = v72 and v72:FindFirstChild("Image");
        local v74 = v73 and v73:FindFirstChild("Fill");

        if v74 then
            local v75 = math.clamp(v71[2].Size.Y.Scale, 0, 1);
            local v76 = LOGO_BOTTOM - v75 * (LOGO_BOTTOM - LOGO_TOP);

            if v75 <= 0.001 then
                v74.Color = ColorSequence.new(FILL_EMPTY);
            elseif v75 >= 0.999 then
                v74.Color = ColorSequence.new(FILL_FULL);
            else
                v74.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, FILL_EMPTY),
                    ColorSequenceKeypoint.new(math.max(0.0005, v76 - 0.0005), FILL_EMPTY),
                    ColorSequenceKeypoint.new(math.min(0.9995, v76 + 0.0005), FILL_FULL),
                    ColorSequenceKeypoint.new(1, FILL_FULL),
                });
            end;
        end;
    end;
end;

function u1.Destroy(p32) -- Line: 186
    p32._blur:Destroy();
    p32._chicken_footer:Destroy();
    p32._glowy_background:Destroy();
    p32.LoadingScreen:Destroy();
    p32.DeviceSelected:Destroy();
end;

function u1._ClientAlert(p33) -- Line: 198
    -- upvalues: Players (copy)
    Players.LocalPlayer:WaitForChild("ClientAlert"):FireServer();
end;

function u1._ChooseDevice(p34, p35) -- Line: 202
    p34._chosen_device = p35;

    for _, v in pairs({ "Desktop", "Mobile", "Console" }) do
        p34[v .. "Button"].Chosen.Visible = v == p34._chosen_device;
        p34[v .. "Button"].Icon.ImageColor3 = v == p34._chosen_device and Color3.fromRGB(60, 226, 31) or Color3.fromRGB(255, 255, 255);
    end;

    p34.ConfirmDeviceButton.Visible = true;
end;

function u1._SpiralAnimation(u36, p37) -- Line: 217
    -- upvalues: RenderstepForLoop (copy)
    local v38 = typeof(p37) == "number";
    local v39 = "Argument 1 invalid, expected a number, got " .. tostring(p37);
    assert(v38, v39);
    u36.LogoN:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", p37 * 1.5, true);
    u36.LogoG:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", p37 * 1.5, true);
    RenderstepForLoop(0, 100, 1.667 / p37, function(p40) -- Line: 226
        -- upvalues: u36 (copy)
        local v41 = (math.sqrt(1 - (p40 / 100 - 1) ^ 2) * 540 + 180) % 360;
        u36.Logo.Rotation = v41;
        u36.LogoN.Rotation = -v41;
        u36.LogoG.Rotation = -v41;
    end);
end;

function u1._ResetLogo(p42) -- Line: 236
    p42.LogoN.Position = UDim2.new(-1, 0, 0.5, 0);
    p42.LogoG.Position = UDim2.new(2, 0, 0.5, 0);
    p42.WhiteN.Size = UDim2.new(1, 0, 0, 0);
    p42.BlackN.Size = UDim2.new(1, 0, 1, 0);
    p42.WhiteG.Size = UDim2.new(1, 0, 0, 0);
    p42.BlackG.Size = UDim2.new(1, 0, 1, 0);
    p42:_ApplyFill();
end;

function u1._Setup(p43) -- Line: 246
    -- upvalues: EventLibrary (copy)
    p43._blur.Name = "LoadingScreen";
    p43._blur.Size = 56;
    p43._chicken_footer:Show();
    p43._chicken_footer:EnableTimer();
    p43._chicken_footer:EnableFunFacts();
    p43._chicken_footer:SetStatus("Loading");
    p43._chicken_footer:SetParent(p43.MainFrame);
    p43._glowy_background:SetParent(p43.MainFrame);
    p43._glowy_background:SetEnabled(true, true);
    p43.GameLogo.Image = EventLibrary.IS_ACTIVE and EventLibrary.EVENT_DETAILS.LOADING_SCREEN_LOGO or p43.GameLogo.Image;
end;

function u1._Init(u44) -- Line: 262
    -- upvalues: RunService (copy)
    u44.DesktopButton.MouseButton1Click:Connect(function() -- Line: 263
        -- upvalues: u44 (copy)
        u44:_ChooseDevice("Desktop");
    end);
    u44.MobileButton.MouseButton1Click:Connect(function() -- Line: 267
        -- upvalues: u44 (copy)
        u44:_ChooseDevice("Mobile");
    end);
    u44.ConsoleButton.MouseButton1Click:Connect(function() -- Line: 271
        -- upvalues: u44 (copy)
        u44:_ChooseDevice("Console");
    end);
    u44.ConfirmDeviceButton.MouseButton1Click:Connect(function() -- Line: 275
        -- upvalues: u44 (copy)
        u44.DeviceSelected:Fire(u44._chosen_device);
    end);
    u44._connection = RunService.RenderStepped:Connect(function() -- Line: 279
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    end);
    u44:_Setup();
    u44:_ResetLogo();
    task.defer(u44._ClientAlert, u44);
end;

return u1._new();