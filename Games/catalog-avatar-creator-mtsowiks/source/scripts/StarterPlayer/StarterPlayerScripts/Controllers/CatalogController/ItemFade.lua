-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local v1 = {};
local Quad = Enum.EasingStyle.Quad;
local Out = Enum.EasingDirection.Out;
local u2 = 0;
local u3 = nil;

function v1.Setup(p4) -- Line: 18
    -- upvalues: u3 (ref)
    u3 = p4;
end;

function v1.Reset() -- Line: 22
    -- upvalues: u2 (ref)
    u2 = u2 + 1;
end;

local function tweenImage(p5) -- Line: 26
    -- upvalues: TweenService (copy), Quad (copy), Out (copy)
    if p5 and (p5.Parent and not p5:GetAttribute("Faded")) then
        TweenService:Create(p5, TweenInfo.new(0.16, Quad, Out), {
            ImageTransparency = 0
        }):Play();
        p5:SetAttribute("Faded", true);
    end;
end;

local function fadeOneImage(p6, p7) -- Line: 33
    -- upvalues: u2 (ref), tweenImage (copy)
    if not (p6 and p6.Parent) then
        return;
    end;

    if p6:GetAttribute("Faded") then
        return;
    end;

    local v8 = os.clock();

    while p7 == u2 and (p6.Parent and (not p6.IsLoaded and os.clock() - v8 < 1)) do
        task.wait(0.05);
    end;

    if p7 ~= u2 or (not p6 or (not p6.Parent or p6:GetAttribute("Faded"))) then
        return;
    end;

    if p6:GetAttribute("IsDisplayingPreview") == true then
        p6:SetAttribute("Faded", true);

        return;
    end;

    tweenImage(p6);
end;

function v1.FadeAllItems(p9) -- Line: 48
    -- upvalues: u3 (ref), u2 (ref), fadeOneImage (copy)
    if not u3 then
        return;
    end;

    local u10 = u2;
    local v11 = {};

    for _, child in u3:GetChildren() do
        if child:GetAttribute("isItem") == true and (typeof(child.LayoutOrder) == "number" and (not p9 or p9 <= child.LayoutOrder)) then
            local preview = child:FindFirstChild("preview");

            if preview then
                preview = preview:FindFirstChild("image");
            end;

            if preview and (preview:IsA("ImageLabel") and not preview:GetAttribute("Faded")) then
                table.insert(v11, child);
            end;
        end;
    end;

    table.sort(v11, function(p12, p13) -- Line: 65
        return (p12.LayoutOrder or 0) < (p13.LayoutOrder or 0);
    end);
    local u14 = #v11;

    if u14 == 0 then
        return;
    end;

    local BindableEvent = Instance.new("BindableEvent");

    for i, v in v11 do
        task.delay((i - 1) * 0.035, function() -- Line: 74
            -- upvalues: v (copy), fadeOneImage (ref), u10 (copy), u14 (ref), BindableEvent (copy)
            local preview = v:FindFirstChild("preview");

            if preview then
                preview = preview:FindFirstChild("image");
            end;

            if preview and preview:IsA("ImageLabel") then
                pcall(fadeOneImage, preview, u10);
            end;

            u14 = u14 - 1;

            if u14 <= 0 then
                BindableEvent:Fire();
            end;
        end);
    end;

    BindableEvent.Event:Wait();
    BindableEvent:Destroy();
end;

return v1;