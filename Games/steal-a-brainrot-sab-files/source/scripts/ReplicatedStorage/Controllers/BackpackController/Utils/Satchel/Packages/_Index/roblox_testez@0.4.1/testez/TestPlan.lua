

local v0 = require(script.Parent.TestEnum);
local v1 = require(script.Parent.Expectation);
local function v37(v2, v3)
    local v4 = {};
    if v3 then
        if type(v3) ~= "table" then
            error(("Bad argument #2 to newEnvironment. Expected table, got %s"):format((typeof(v3))), 2);
        end;
        for v5, v6 in pairs(v3) do
            v4[v5] = v6;
        end;
    end;
    local function v12(v7, v8, v9, v10)
        local v11 = v2:addChild(v7, v9, v10);
        v11.callback = v8;
        if v9 == v0.NodeType.Describe then
            v11:expand();
        end;
        return v11;
    end;
    v4.describeFOCUS = function(v13, v14)
        v12(v13, v14, v0.NodeType.Describe, v0.NodeModifier.Focus);
    end;
    v4.describeSKIP = function(v15, v16)
        v12(v15, v16, v0.NodeType.Describe, v0.NodeModifier.Skip);
    end;
    v4.describe = function(v17, v18, _)
        v12(v17, v18, v0.NodeType.Describe, v0.NodeModifier.None);
    end;
    v4.itFOCUS = function(v20, v21)
        v12(v20, v21, v0.NodeType.It, v0.NodeModifier.Focus);
    end;
    v4.itSKIP = function(v22, v23)
        v12(v22, v23, v0.NodeType.It, v0.NodeModifier.Skip);
    end;
    v4.itFIXME = function(v24, v25)
        local v26 = v12(v24, v25, v0.NodeType.It, v0.NodeModifier.Skip);
        warn("FIXME: broken test", v26:getFullName());
    end;
    v4.it = function(v27, v28, _)
        v12(v27, v28, v0.NodeType.It, v0.NodeModifier.None);
    end;
    local v30 = 0;
    local v31 = {
        [v0.NodeType.BeforeAll] = "beforeAll", 
        [v0.NodeType.AfterAll] = "afterAll", 
        [v0.NodeType.BeforeEach] = "beforeEach", 
        [v0.NodeType.AfterEach] = "afterEach"
    };
    for v32, v33 in pairs(v31) do
        v4[v33] = function(v34)
            v12(v33 .. "_" .. tostring(v30), v34, v32, v0.NodeModifier.None);
            v30 = v30 + 1;
        end;
    end;
    v4.FIXME = function(v35)
        warn("FIXME: broken test", v2:getFullName(), v35 or "");
        v2.modifier = v0.NodeModifier.Skip;
    end;
    v4.FOCUS = function()
        v2.modifier = v0.NodeModifier.Focus;
    end;
    v4.SKIP = function()
        v2.modifier = v0.NodeModifier.Skip;
    end;
    v4.HACK_NO_XPCALL = function()
        warn("HACK_NO_XPCALL is deprecated. It is now safe to yield in an xpcall, so this is no longer necessary. It can be safely deleted.");
    end;
    v4.fit = v4.itFOCUS;
    v4.xit = v4.itSKIP;
    v4.fdescribe = v4.describeFOCUS;
    v4.xdescribe = v4.describeSKIP;
    v4.expect = setmetatable({
        extend = function(...)
            error("Cannot call \"expect.extend\" from within a \"describe\" node.");
        end
    }, {
        __call = function(_, ...)
            return v1.new(...);
        end
    });
    return v4;
end;
local v38 = {};
v38.__index = v38;
v38.new = function(v39, v40, v41, v42)
    local v43 = v42 or v0.NodeModifier.None;
    v43 = {
        plan = v39, 
        phrase = v40, 
        type = v41, 
        modifier = v43, 
        children = {}, 
        callback = nil, 
        parent = nil
    };
    v43.environment = v37(v43, v39.extraEnvironment);
    return (setmetatable(v43, v38));
end;
local function v47(v44, v45, v46)
    if v45 and (v46 == nil or v46 == v0.NodeModifier.None) then
        if v44:match(v45) then
            return v0.NodeModifier.Focus;
        else
            return v0.NodeModifier.Skip;
        end;
    else
        return v46;
    end;
end;
v38.addChild = function(v48, v49, v50, v51)
    if v50 == v0.NodeType.It then
        for _, v53 in pairs(v48.children) do
            if v53.phrase == v49 then
                error("Duplicate it block found: " .. v53:getFullName());
            end;
        end;
    end;
    local v54 = v48:getFullName() .. " " .. v49;
    v51 = v47(v54, v48.plan.testNamePattern, v51);
    local v55 = v38.new(v48.plan, v49, v50, v51);
    v55.parent = v48;
    table.insert(v48.children, v55);
    return v55;
end;
v38.getFullName = function(v56)
    if v56.parent then
        local v57 = v56.parent:getFullName();
        if v57 then
            return v57 .. " " .. v56.phrase;
        end;
    end;
    return v56.phrase;
end;
v38.expand = function(v58)
    local v59 = getfenv(v58.callback);
    local v60 = setmetatable({}, {
        __index = v59
    });
    for v61, v62 in pairs(v58.environment) do
        v60[v61] = v62;
    end;
    v60.script = v59.script;
    setfenv(v58.callback, v60);
    local v64, v65 = xpcall(v58.callback, function(v63)
        return debug.traceback(tostring(v63), 2);
    end);
    if not v64 then
        v58.loadError = v65;
    end;
end;
local v66 = {};
v66.__index = v66;
v66.new = function(v67, v68)
    return (setmetatable({
        children = {}, 
        testNamePattern = v67, 
        extraEnvironment = v68
    }, v66));
end;
v66.addChild = function(v69, v70, v71, v72)
    v72 = v47(v70, v69.testNamePattern, v72);
    local v73 = v38.new(v69, v70, v71, v72);
    table.insert(v69.children, v73);
    return v73;
end;
v66.addRoot = function(v74, v75, v76)
    local l_v74_0 = v74;
    for v78 = #v75, 1, -1 do
        local v79 = nil;
        for _, v81 in ipairs(l_v74_0.children) do
            if v81.phrase == v75[v78] then
                v79 = v81;
                break;
            end;
        end;
        if v79 == nil then
            v79 = l_v74_0:addChild(v75[v78], v0.NodeType.Describe);
        end;
        l_v74_0 = v79;
    end;
    l_v74_0.callback = v76;
    l_v74_0:expand();
end;
v66.visitAllNodes = function(v82, v83, v84, v85)
    v84 = v84 or v82;
    v85 = v85 or 0;
    for _, v87 in ipairs(v84.children) do
        v83(v87, v85);
        v82:visitAllNodes(v83, v87, v85 + 1);
    end;
end;
v66.visualize = function(v88)
    local v89 = {};
    v88:visitAllNodes(function(v90, v91)
        table.insert(v89, (" "):rep(3 * v91) .. v90.phrase);
    end);
    return table.concat(v89, "\n");
end;
v66.findNodes = function(v92, v93)
    local v94 = {};
    v92:visitAllNodes(function(v95)
        if v93(v95) then
            table.insert(v94, v95);
        end;
    end);
    return v94;
end;
return v66;