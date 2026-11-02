-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Util)

local function unescapeOperators(v1) -- line 7
    local v2 = { "%.", "%?", "%*", "%*%*" }
    local v3 = v1
    for v4, v5 in ipairs(v2) do
        v3 = v3:gsub("\\" .. v5, v5:gsub("%%", ""))
    end
    return v3
end

local v7 = {}

v7.__index = v7

function v7.new(v8, v9, v10) -- line 17 | captures: Util, v7
    local v11 = {
        Prefix = "",
        TextSegmentInProgress = "",
        RawSegmentsAreAutocomplete = false,
        Command = v8,
        Name = v9.Name,
        Object = v9
    }
    if v9.Default == nil then
        v11.Required = v9.Optional ~= true
    else
        v11.Required = false
    end
    v11.Executor = v8.Executor
    v11.RawValue = v10
    v11.RawSegments = {}
    v11.TransformedValues = {}
    local Type = v9.Type
    if type(Type) == "table" then
        v11.Type = v9.Type
    else
        local v12 = v8.Cmdr.Registry:GetTypeName(v9.Type)
        local v13, v14, v15 = Util.ParsePrefixedUnionType(v12, v10)
        v11.Type = v8.Dispatcher.Registry:GetType(v13)
        v11.RawValue = v14
        v11.Prefix = v15
        if v11.Type == nil then
            error(string.format("%s has an unregistered type %q", v11.Name or "<none>", v13 or "<none>"))
        end
    end
    setmetatable(v11, v7)
    v11:Transform()
    return v11
end

local function GetDefaultAutocomplete(v16) -- line 50
    if v16.Type.Autocomplete then
        local v17, v18 = v16.Type.Autocomplete(v16:TransformSegment(""))
        return v17, v18 or {}
    end
    return {}
end

v7.GetDefaultAutocomplete = GetDefaultAutocomplete

function v7.Transform(v19) -- line 62 | captures: Util, unescapeOperators
    local function v20(v21, ...)
        table.insert(v21, ...)
    end

    if #v19.TransformedValues ~= 0 then
        return
    end
    local RawValue = v19.RawValue
    local v22 = v19.Type.ArgumentOperatorAliases and v19.Type.ArgumentOperatorAliases[RawValue] or RawValue
    if v22 == "." and v19.Type.Default then
        v22 = v19.Type.Default(v19.Executor) or ""
        v19.RawSegmentsAreAutocomplete = true
    end
    if v22 == "?" and v19.Type.Autocomplete then
        local v23, v24 = v19:GetDefaultAutocomplete()
        if not v24.IsPartial and #v23 > 0 then
            v22 = v23[math.random(1, #v23)]
            v19.RawSegmentsAreAutocomplete = true
        end
    end
    if v19.Type.Listable then
        if #v19.RawValue <= 0 then
            local v25 = unescapeOperators(v22)
            v19.RawSegments[1] = unescapeOperators(v25)
            v19.TransformedValues[1] = { v19:TransformSegment(v25) }
            v19.TextSegmentInProgress = v19.RawValue
        else
            local v26 = v22:match("^%?(%d+)$")
            if v26 then
                local v27 = tonumber(v26)
                if v27 and v27 > 0 then
                    local v28 = {}
                    local v29, v30 = v19:GetDefaultAutocomplete()
                    if not v30.IsPartial and #v29 > 0 then
                        local v31 = #v29
                        local v32 = math.min(v27, v31)
                        for v33 = 1, v32 do
                            v20(v28, table.remove(v29, math.random(1, #v29)))
                        end
                        v22 = table.concat(v28, ",")
                        v19.RawSegmentsAreAutocomplete = true
                    end
                end
            elseif v22 == "*" then
                local v34, v35 = v19:GetDefaultAutocomplete()
                if not v35.IsPartial and #v34 > 0 then
                    if v22 == "**" and v19.Type.Default then
                        for v36, v37 in ipairs(v34) do
                            if v37 == v19.Type.Default(v19.Executor) then
                            end
                            table.remove(v34, v36)
                        end
                    end
                    v22 = table.concat(v34, ",")
                    v19.RawSegmentsAreAutocomplete = true
                end
            end
            local v38 = unescapeOperators(v22)
            local v39 = Util.SplitStringSimple(v38, ",")
            if #v39 == 0 then
                v39 = { "" }
            end
            if v38:sub(#v38, #v38) == "," then
                v39[#v39 + 1] = ""
            end
            for v40, v41 in ipairs(v39) do
                v19.RawSegments[v40] = v41
                v19.TransformedValues[v40] = { v19:TransformSegment(v41) }
            end
            v19.TextSegmentInProgress = v39[#v39]
        end
    else
        local v42 = unescapeOperators(v22)
        v19.RawSegments[1] = unescapeOperators(v42)
        v19.TransformedValues[1] = { v19:TransformSegment(v42) }
        v19.TextSegmentInProgress = v19.RawValue
    end
end

local function TransformSegment(v43, v44) -- line 150
    if v43.Type.Transform then
        return v43.Type.Transform(v44, v43.Executor)
    end
    return v44
end

v7.TransformSegment = TransformSegment

local function GetTransformedValue(v45, v46) -- line 156
    local v47 = v45.TransformedValues[v46]
    return unpack(v47)
end

v7.GetTransformedValue = GetTransformedValue

local function Validate(v48, v49) -- line 159
    if v48.RawValue == nil then
        return true
    end
    if #v48.RawValue == 0 then
        if v48.Required == false then
            return true
        end
    elseif v48.Required then
        if v48.RawSegments[1] == nil or #v48.RawSegments[1] == 0 then
            return false, "This argument is required."
        end
    else
        if v48.Type.Validate then
            local v50 = #v48.TransformedValues
            for v51 = 1, v50 do
                local Validate = v48.Type.Validate
                local v52, v53
                if Validate then
                    v52, v53 = v48.Type.Validate(v48:GetTransformedValue(v51))
                end
                if not Validate or v52 then
                    if v6 and v48.Type.ValidateOnce then
                        local v54, v55 = v48.Type.ValidateOnce(v48:GetTransformedValue(v51))
                        if not v54 then
                            return v54, v55
                        end
                    end
                else
                    return v52, v53 or "Invalid value"
                end
            end
            return true
        end
        if not v48.Type.ValidateOnce then
            return true
        end
    end
end

v7.Validate = Validate

local function GetAutocomplete(v56) -- line 196
    if v56.Type.Autocomplete then
        return v56.Type.Autocomplete(v56:GetTransformedValue(#v56.TransformedValues))
    end
    return {}
end

v7.GetAutocomplete = GetAutocomplete

local function ParseValue(v57, v58) -- line 202
    if v57.Type.Parse then
        return v57.Type.Parse(v57:GetTransformedValue(v58))
    end
    return v57:GetTransformedValue(v58)
end

v7.ParseValue = ParseValue

local function GetValue(v59) -- line 208
    if #v59.RawValue == 0 then
        if v59.Required or v59.Object.Default == nil then
            return
        end
        return v59.Object.Default
    end
    if v59.Type.Listable then
        local v60 = {}
        local v61 = #v59.TransformedValues
        for v62 = 1, v61 do
            local v63 = v59:ParseValue(v62)
            if type(v63) ~= "table" then
                error(("Listable types must return a table from Parse (%s)"):format(v59.Type.Name))
            end
            for v64, v65 in pairs(v63) do
                v60[v65] = true
            end
        end
        local v66 = {}
        for v67 in pairs(v60) do
            v66[#v66 + 1] = v67
        end
        return v66
    end
    return v59:ParseValue(1)
end

v7.GetValue = GetValue
return v7
