-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReflectionService = game:GetService("ReflectionService")
local v1 = {}
local v2 = {}
local v3 = {
    Parent = true,
    ClassName = true,
    Name = true,
    ExtentsCFrame = true,
    ExtentsSize = true,
    ResizeIncrement = true,
    ResizeableFaces = true,
    CurrentPhysicalProperties = true,
    Sandboxed = true,
    Capabilities = true,
    PrivateServerId = true,
    PrivateServerOwnerId = true,
    SerializedDefaultAttributes = true
}
local v4 = { Debug = true }
local v5, v6 = pcall(function() -- line 26
    local function v7(...)
        return (tostring(...))
    end

    return v7(SecurityCapabilities.fromCurrent()):split(" | ")
end)
local v8 = if v5 then v6 else {}

local function canRead(v9) -- line 34 | captures: v8
    if v9 then
        local v10 = tostring(v9):split(" | ")
        if v10[1] ~= nil and v10[1] ~= "" then
            for v11, v12 in v10 do
                if not table.find(v8, v12) then
                    return false
                end
            end
        end
    end
    return true
end

function v1.getReadProperties(v13) -- line 52 | captures: ReflectionService, v2, v3, v4, canRead
    local v14 = v2[v13]
    if v14 then
        return v14
    end
    local v15 = {}
    local v16, v17 = pcall(function() -- line 59 | captures: v13, ReflectionService
        return ReflectionService:GetPropertiesOfClass(v13)
    end)
    if v16 and v17 then
        for v18, v19 in v17 do
            local Name = v19.Name
            if not v3[Name] then
                local Display = v19.Display
                if Display then
                    if Display.DeprecationMessage then
                        if Display.DeprecationMessage == "" then
                        end
                    elseif Display.Category and v4[Display.Category] then
                    end
                else
                    local Type = v19.Type
                    if Type then
                        if Type.ScriptType == "Instance" then
                        end
                    else
                        local Permits = v19.Permits
                        local v20 = Permits and Permits.Read
                        if canRead(v20) then
                            table.insert(v15, Name)
                        end
                    end
                end
            end
        end
    end
    v2[v13] = v15
    return v15
end

return v1
