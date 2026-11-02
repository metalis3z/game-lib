-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {};
u1.__index = u1;

local function verify_confirm(p2) -- Line: 8
    return p2;
end;

local function verify_boolean(p3) -- Line: 12
    if typeof(p3) == "boolean" then
        return p3;
    end;
end;

local function verify_hotkey(p4) -- Line: 18
    -- upvalues: Utility (copy)
    if p4 == nil or p4 == "nil" then
        return "nil";
    end;

    if Utility:GetInputEnumFromName(p4) then
        return p4;
    end;
end;

local function verify_color(p5) -- Line: 26
    -- upvalues: Utility (copy)
    if Utility:IsValidHex(p5) then
        return p5;
    end;
end;

function u1.new(p6, p7, p8, p9, p10, p11, p12, ...) -- Line: 32
    -- upvalues: u1 (copy), verify_confirm (copy), verify_boolean (copy), verify_hotkey (copy), verify_color (copy)
    local v13;

    if #p11 >= 7 then
        v13 = string.sub(p11, #p11 - 6, #p11) == "Confirm";
    else
        v13 = false;
    end;

    if v13 and p11 ~= "Confirm" then
        p11 = string.sub(p11, 1, #p11 - 7);
    end;

    local u14 = setmetatable({}, u1);
    u14.Section = p6;
    u14.Name = p7;
    u14.DisplayName = p8;
    u14.Image = p9;
    u14.Description = p10;
    u14.DefaultValue = p12;
    u14.InputType = p11;
    u14.IsConfirmSetting = v13;
    u14.VerifyInput = nil;
    u14.Options = nil;
    u14.Min = nil;
    u14.Max = nil;
    u14.Increment = nil;
    u14.IsPercent = nil;
    local v15 = { ... };

    if u14.InputType == "Confirm" then
        u14.VerifyInput = verify_confirm;
    elseif u14.InputType == "Toggle" or (u14.InputType == "ToggleConfirm" or u14.InputType == "Checkbox") then
        u14.VerifyInput = verify_boolean;
    elseif u14.InputType == "Hotkey" then
        u14.VerifyInput = verify_hotkey;
    elseif u14.InputType == "Color" then
        u14.VerifyInput = verify_color;
    elseif u14.InputType == "Options" or (u14.InputType == "OptionsConfirm" or (u14.InputType == "Dropdown" or u14.InputType == "DropdownConfirm")) then
        local table_unpack_ret = table.unpack(v15);
        u14.Options = table_unpack_ret;

        function u14.VerifyInput(p16) -- Line: 70
            -- upvalues: table_unpack_ret (copy)
            if typeof(p16) ~= "string" or not (table.find(table_unpack_ret, p16) and p16) then
                p16 = nil;
            end;

            return p16;
        end;
    elseif u14.InputType == "Slider" or u14.InputType == "SliderConfirm" then
        local table_unpack_ret, v17, v18, v19 = table.unpack(v15);
        u14.Min = table_unpack_ret;
        u14.Max = v17;
        u14.Increment = v18;
        u14.IsPercent = v19;

        function u14.VerifyInput(p20) -- Line: 81
            -- upvalues: u14 (copy)
            local v21;

            if p20 and (typeof(p20) == "string" and (#p20 > 1 and string.sub(p20, #p20) == "%")) then
                local string_sub_ret = string.sub(p20, 1, #p20 - 1);

                if tonumber(string_sub_ret) then
                    local string_sub_ret2 = string.sub(p20, 1, #p20 - 1);
                    v21 = tonumber(string_sub_ret2) / 100;
                else
                    v21 = tonumber(p20);
                end;
            else
                v21 = tonumber(p20);
            end;

            local v22;

            if string.lower((tostring(v21))) == "nan" or typeof(v21) ~= "number" then
                v22 = nil;
            else
                local v23 = math.clamp(v21, u14.Min, u14.Max) * u14.Increment + 0.5;
                v22 = math.floor(v23) / u14.Increment or nil;
            end;

            return v22;
        end;
    end;

    u14:_Init();

    return u14;
end;

function u1._Init(p24) -- Line: 107
end;

return u1;