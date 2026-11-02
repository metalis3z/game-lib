-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local FunFacts = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("FunFacts"));
local ChickenFooter = Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("UserInterface"):WaitForChild("ChickenFooter");
local u1 = {
    Chicken = "rbxassetid://133917828562858",
    Sensei = "rbxassetid://118135633428557",
    Nosniy = "rbxassetid://132709758724537",
    Neko = "rbxassetid://77873164738983",
    Bandoboy = "rbxassetid://121503061771505"
};
local u2 = { "00bandoboy wuz here", "00nly my followers can play my secret gamemode in Private Servers" };
local u3 = {};
u3.__index = u3;

function u3.new() -- Line: 22
    -- upvalues: u3 (copy), ChickenFooter (copy)
    local v4 = setmetatable({}, u3);
    v4.Frame = ChickenFooter:Clone();
    v4.Picture = v4.Frame:WaitForChild("Picture");
    v4.PictureButton = v4.Picture:WaitForChild("Button");
    v4.TimerText = v4.Frame:WaitForChild("Timer");
    v4.StatusText = v4.Frame:WaitForChild("Status");
    v4.DescriptionFrame = v4.Frame:WaitForChild("Description");
    v4.DescriptionTitle = v4.DescriptionFrame:WaitForChild("Title");
    v4.DescriptionBackground = v4.DescriptionFrame:WaitForChild("Background");
    v4._connections = {};
    v4._description_original_size = v4.DescriptionFrame.Size;
    v4._picture_original_size = v4.Picture.Size;
    v4._timer_hash = 0;
    v4._fun_facts_enabled = false;
    v4._last_fun_fact = nil;
    v4._is_shown = nil;
    v4:_Init();

    return v4;
end;

function u3.SetParent(p5, p6) -- Line: 51
    p5.Frame.Parent = p6;
end;

function u3.SetStatus(p7, p8) -- Line: 55
    p7.StatusText.Text = p8 or "";
end;

function u3.SetTimer(p9, p10) -- Line: 59
    p9.TimerText.Text = p10 or "";
end;

function u3.SetPicture(p11, p12) -- Line: 63
    -- upvalues: u1 (copy)
    p11.Picture.Image = u1[p12] or "";
end;

function u3.SetMessage(p13, p14) -- Line: 67
    -- upvalues: Players (copy)
    local v15 = p14 or "";
    local v16 = v15 == "";
    p13.DescriptionTitle.Text = v15;
    p13.DescriptionFrame.Visible = not v16;
    local _description_original_size = p13._description_original_size;
    local v17;

    if v16 then
        v17 = UDim2.new(0.075, 0, 1.5, 0);
    else
        v17 = UDim2.new(0.075, 0, 1, 0);
    end;

    local _picture_original_size = p13._picture_original_size;

    if p13.Frame:IsDescendantOf(Players) then
        p13.Picture:TweenPosition(v17, "Out", "Quint", 0.25, true);

        if not v16 then
            p13.Picture.Size = UDim2.new(_picture_original_size.X.Scale * 0.8, 0, _picture_original_size.Y.Scale * 1.2, 0);
            p13.Picture:TweenSize(_picture_original_size, "Out", "Back", 0.5, true);
            p13.DescriptionFrame.Size = UDim2.new(_description_original_size.X.Scale * 0.8, 0, _description_original_size.Y.Scale * 1.2, 0);
            p13.DescriptionFrame:TweenSize(_description_original_size, "Out", "Back", 0.25, true);
        end;
    else
        p13.Picture.Position = v17;
        p13.Picture.Size = _picture_original_size;
        p13.DescriptionFrame.Size = _description_original_size;
    end;

    p13:_Update();
end;

function u3.EnableFunFacts(p18) -- Line: 97
    if p18._fun_facts_enabled then
        return;
    end;

    p18._fun_facts_enabled = true;
    p18:_NewFunFact();
end;

function u3.DisableFunFacts(p19) -- Line: 106
    if not p19._fun_facts_enabled then
        return;
    end;

    p19._fun_facts_enabled = false;
end;

function u3.EnableTimer(u20) -- Line: 114
    task.spawn(function() -- Line: 115
        -- upvalues: u20 (copy)
        local v21 = u20;
        v21._timer_hash = v21._timer_hash + 1;
        local _timer_hash = u20._timer_hash;

        for i = 0, (1 / 0) do
            u20:SetTimer(i);
            wait(1);

            if _timer_hash ~= u20._timer_hash then
                return;
            end;

            local _ = i;
        end;
    end);
end;

function u3.DisableTimer(p22) -- Line: 131
    p22._timer_hash = p22._timer_hash + 1;
end;

function u3.Show(p23) -- Line: 135
    if p23._is_shown then
        return;
    end;

    p23._is_shown = true;
    p23.TimerText.Visible = true;
    p23.StatusText.Visible = true;
end;

function u3.Hide(p24) -- Line: 145
    if not p24._is_shown then
        return;
    end;

    p24._is_shown = false;
    p24:DisableFunFacts();
    p24:DisableTimer();
    p24:SetMessage(nil);
    p24.TimerText.Visible = false;
    p24.StatusText.Visible = false;
end;

function u3.Destroy(p25) -- Line: 158
    for _, v in pairs(p25._connections) do
        v:Disconnect();
    end;

    p25:DisableTimer();
    p25.Frame:Destroy();
end;

function u3._RandomPicture(p26) -- Line: 171
    -- upvalues: u1 (copy)
    local v27 = {};

    for i in pairs(u1) do
        table.insert(v27, i);
    end;

    p26:SetPicture(v27[math.random(#v27)]);
end;

function u3._NewFunFact(p28) -- Line: 181
    -- upvalues: FunFacts (copy), u2 (copy)
    if not p28._fun_facts_enabled then
        return;
    end;

    local v29 = nil;

    for i = 1, 10 do
        v29 = FunFacts();

        if v29 and v29 ~= p28._last_fun_fact then
            break;
        end;

        local _ = i;
    end;

    if table.find(u2, v29) then
        p28:SetPicture("Bandoboy");
        p28:SetMessage(v29);

        return;
    end;

    p28:SetPicture("Chicken");

    if string.sub(v29, 1, 19) ~= "Thanks for playing," then
        v29 = "" .. v29;
    end;

    p28:SetMessage(v29);
end;

function u3._Update(u30) -- Line: 205
    task.delay(0, function() -- Line: 207
        -- upvalues: u30 (copy)
        u30.DescriptionBackground.Size = UDim2.new(0.02, u30.DescriptionTitle.TextBounds.X, 1, 0);
    end);
end;

function u3._Init(u31) -- Line: 212
    -- upvalues: UserInputService (copy)
    u31.PictureButton.MouseButton1Click:Connect(function() -- Line: 213
        -- upvalues: u31 (copy)
        u31:_NewFunFact();
    end);
    u31.DescriptionTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 217
        -- upvalues: u31 (copy)
        u31:_Update();
    end);
    u31.DescriptionTitle:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 221
        -- upvalues: u31 (copy)
        u31:_Update();
    end);
    u31.DescriptionTitle:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 225
        -- upvalues: u31 (copy)
        u31:_Update();
    end);
    table.insert(u31._connections, UserInputService.WindowFocused:Connect(function() -- Line: 229
        -- upvalues: u31 (copy)
        u31:_Update();
    end));
    table.insert(u31._connections, UserInputService.WindowFocusReleased:Connect(function() -- Line: 233
        -- upvalues: u31 (copy)
        u31:_Update();
    end));
    u31:_Update();
    u31:SetPicture("Chicken");
    u31:SetMessage(nil);
    u31:SetStatus(nil);
    u31:SetTimer(nil);
    u31:Show();
end;

return u3;