-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v0 = {};
local v1 = {};
local v2 = {};
local v3 = {};
local function v9(v4) --[[ Line: 9 ]] --[[ Name: updateStack ]]
    -- upvalues: v1 (copy), v3 (ref), v2 (copy)
    for _, v6 in v1 do
        v6.Visible = false;
    end;
    for v7, v8 in v3 do
        v8.Visible = v7 == #v3;
        if v8.Visible and v2[v8] then
            v2[v8](v4);
        end;
    end;
end;
v0.ToggleFrame = function(_, v11) --[[ Line: 22 ]] --[[ Name: ToggleFrame ]]
    -- upvalues: v1 (copy), v3 (ref), v2 (copy), v9 (copy)
    local v12 = v1[v11] or v11;
    if type(v12) == "string" or v12 == nil then
        warn("Frame not found: " .. tostring(v11));
        return;
    else
        if v12.Visible then
            v12.Visible = false;
            v3 = {};
        else
            v3 = {
                v12
            };
            if v2[v12] then
                v2[v12]();
            end;
        end;
        v9();
        return;
    end;
end;
v0.ViewFrame = function(_, v14, v15) --[[ Line: 44 ]] --[[ Name: ViewFrame ]]
    -- upvalues: v1 (copy), v3 (ref), v9 (copy)
    local v16 = v1[v14] or v14;
    if type(v16) == "string" or v16 == nil then
        warn("Frame not found: " .. tostring(v14));
        return;
    else
        v3 = {
            v16
        };
        v9(v15);
        return;
    end;
end;
v0.CloseAllFrames = function(_) --[[ Line: 62 ]] --[[ Name: CloseAllFrames ]]
    -- upvalues: v3 (ref), v9 (copy)
    v3 = {};
    v9();
end;
v0.Back = function(_) --[[ Line: 67 ]] --[[ Name: Back ]]
    -- upvalues: v3 (ref), v9 (copy)
    if #v3 < 1 then
        return;
    else
        local v19 = #v3;
        v3[v19].Visible = false;
        table.remove(v3, v19);
        v9();
        return;
    end;
end;
v0.AddToStack = function(_, v21, v22) --[[ Line: 80 ]] --[[ Name: AddToStack ]]
    -- upvalues: v1 (copy), v3 (ref), v9 (copy)
    local v23 = v1[v21] or v21;
    if v23 == nil or typeof(v23) == "string" then
        warn("WindowService: Frame not found: " .. tostring(v21));
        return;
    else
        local v24 = table.find(v3, v23);
        if v24 then
            table.remove(v3, v24);
        end;
        table.insert(v3, v23);
        v9(v22);
        return;
    end;
end;
v0.GetFrame = function(_, v26) --[[ Line: 96 ]] --[[ Name: GetFrame ]]
    -- upvalues: v1 (copy)
    return v1[v26];
end;
v0.RegisterFrame = function(_, v28, v29, v30) --[[ Line: 100 ]] --[[ Name: RegisterFrame ]]
    -- upvalues: v1 (copy), v2 (copy)
    if typeof(v28) ~= "Instance" then
        warn("WindowService: First argument must be a GuiObject");
        return;
    elseif not v28:IsA("GuiObject") then
        warn("WindowService: First argument must be a GuiObject");
        return;
    else
        if v1[v29] ~= nil then

        end;
        v1[v29] = v28;
        if v30 then
            v2[v28] = v30;
        end;
        return;
    end;
end;
return v0;