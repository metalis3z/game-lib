-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local container = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Notifications"):WaitForChild("container");
local Events = script.Parent.Parent.Events;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local notification = script:FindFirstChild("notification");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u2 = {};
local u3 = {};

function u2.Notify(p4, p5, u6) -- Line: 28
    -- upvalues: u3 (copy), notification (copy), container (copy), TweenService (copy), u1 (copy), Debris (copy)
    if typeof(u6) ~= "string" then
        u6 = nil;
    end;

    if u6 then
        local v7 = u3[u6];

        if v7 and v7.Parent then
            v7.label.Text = p4;

            return;
        end;
    end;

    local v8;

    if u6 == nil then
        v8 = false;
    else
        v8 = p5 == nil and true or p5 <= 0;
    end;

    local v9 = p5 or 5;
    local u10 = notification:Clone();
    u10.label.Text = p4;
    u10.BackgroundTransparency = 1;
    u10.label.TextTransparency = 1;
    u10.Size = UDim2.new(0, 0, 0, 0);
    u10.Parent = container;

    if u6 then
        u3[u6] = u10;
        u10.Destroying:Connect(function() -- Line: 47
            -- upvalues: u3 (ref), u6 (ref), u10 (copy)
            if u3[u6] == u10 then
                u3[u6] = nil;
            end;
        end);
    end;

    local v11 = TweenService:Create(u10, u1, {
        Size = UDim2.fromScale(0, 0.135)
    });
    v11:Play();
    v11.Completed:Wait();
    TweenService:Create(u10, u1, {
        BackgroundTransparency = 0.3
    }):Play();
    TweenService:Create(u10.label, u1, {
        TextTransparency = 0
    }):Play();

    if not v8 then
        Debris:AddItem(u10, v9 + 0.1);
        task.delay(v9 - u1.Time, function() -- Line: 63
            -- upvalues: TweenService (ref), u10 (copy), u1 (ref)
            TweenService:Create(u10, u1, {
                BackgroundTransparency = 1
            }):Play();
            TweenService:Create(u10.label, u1, {
                TextTransparency = 1
            }):Play();
        end);
    end;
end;

function u2.Dismiss(p12) -- Line: 70
    -- upvalues: u3 (copy), TweenService (copy), u1 (copy), Debris (copy)
    local v13 = u3[p12];
    u3[p12] = nil;

    if not v13 or v13.Parent == nil then
        return;
    end;

    TweenService:Create(v13, u1, {
        BackgroundTransparency = 1
    }):Play();
    TweenService:Create(v13.label, u1, {
        TextTransparency = 1
    }):Play();
    Debris:AddItem(v13, u1.Time + 0.05);
end;

local function handleNotify(p14, p15, p16) -- Line: 79
    -- upvalues: u2 (copy)
    if p14 == nil and typeof(p16) == "string" then
        u2.Dismiss(p16);

        return;
    end;

    u2.Notify(p14, p15, p16);
end;

Events.Notify.Event:Connect(handleNotify);
Remotes.Notify.OnClientEvent:Connect(handleNotify);

return u2;