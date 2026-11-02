-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_string_0 = string;
local l_pairs_0 = pairs;
local function _(v2) --[[ Line: 6 ]]
    local v3 = v2:match("^%s*()");
    if #v2 < v3 then
        return "";
    else
        return (v2:match(".*%S", v3));
    end;
end;
local _ = l_string_0.byte(">", 1);
local v6 = l_string_0.byte("/", 1);
local _ = l_string_0.byte("D", 1);
local v8 = l_string_0.byte("E", 1);
function parse(v9, v10) --[[ Line: 16 ]] --[[ Name: parse ]]
    -- upvalues: l_string_0 (copy), v6 (copy), v8 (copy)
    v9 = v9:gsub("<!%-%-(.-)%-%->", "");
    local v11 = {};
    local v12 = nil;
    if v10 then
        local v13 = v9:find("<[_%w]");
        if v13 then
            v9:sub(1, v13):gsub("<!ENTITY%s+([_%w]+)%s+(.)(.-)%2", function(v14, _, v16) --[[ Line: 25 ]]
                -- upvalues: v11 (copy)
                v11[#v11 + 1] = {
                    name = v14, 
                    value = v16
                };
            end);
            v12 = createEntityTable(v11);
            v9 = replaceEntities(v9:sub(v13), v12);
        end;
    end;
    local v17 = {};
    local v18 = {};
    local function v20(v19) --[[ Line: 35 ]]
        -- upvalues: v17 (ref)
        v19 = v19:match("^%s*(.*%S)") or "";
        if #v19 ~= 0 then
            v17[#v17 + 1] = {
                text = v19
            };
        end;
    end;
    v9:gsub("<([?!/]?)([-:_%w]+)%s*(/?>?)([^<]*)", function(v21, v22, v23, v24) --[[ Line: 41 ]]
        -- upvalues: l_string_0 (ref), v17 (ref), v6 (ref), v18 (copy), v20 (copy), v8 (ref), v11 (copy)
        if #v21 == 0 then
            local v25 = {};
            if #v23 == 0 then
                local v26 = 0;
                for v27, v28, _, v30, v31 in l_string_0.gmatch(v24, "(.-([-_%w]+)%s*=%s*(.)(.-)%3%s*(/?>?))") do
                    v26 = v26 + #v27;
                    v25[v28] = v30;
                    if #v31 ~= 0 then
                        v24 = v24:sub(v26 + 1);
                        v23 = v31;
                        break;
                    end;
                end;
            end;
            v17[#v17 + 1] = {
                tag = v22, 
                attrs = v25, 
                children = {}
            };
            if v23:byte(1) ~= v6 then
                v18[#v18 + 1] = v17;
                v17 = v17[#v17].children;
            end;
            v20(v24);
            return;
        elseif v21 == "/" then
            v17 = v18[#v18];
            v18[#v18] = nil;
            v20(v24);
            return;
        else
            if v21 == "!" and v8 == v22:byte(1) then
                v24:gsub("([_%w]+)%s+(.)(.-)%2", function(v32, _, v34) --[[ Line: 76 ]]
                    -- upvalues: v11 (ref)
                    v11[#v11 + 1] = {
                        name = v32, 
                        value = v34
                    };
                end, 1);
            end;
            return;
        end;
    end);
    return {
        children = v17, 
        entities = v11, 
        tentities = v12
    };
end;
function defaultEntityTable() --[[ Line: 93 ]] --[[ Name: defaultEntityTable ]]
    return {
        quot = "\"", 
        apos = "'", 
        lt = "<", 
        gt = ">", 
        amp = "&", 
        tab = "\t", 
        nbsp = " "
    };
end;
function replaceEntities(v35, v36) --[[ Line: 97 ]] --[[ Name: replaceEntities ]]
    return v35:gsub("&([^;]+);", v36);
end;
function createEntityTable(v37, v38) --[[ Line: 101 ]] --[[ Name: createEntityTable ]]
    -- upvalues: l_pairs_0 (copy)
    entities = v38 or defaultEntityTable();
    for _, v40 in l_pairs_0(v37) do
        v40.value = replaceEntities(v40.value, entities);
        entities[v40.name] = v40.value;
    end;
    return entities;
end;
return getfenv();