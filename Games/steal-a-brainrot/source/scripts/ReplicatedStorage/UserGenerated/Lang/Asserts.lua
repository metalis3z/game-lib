-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
LuaString = function(v0) --[[ Line: 22 ]] --[[ Name: LuaString ]]
    local v1, _ = string.format("%q", v0):gsub("\n", "n");
    return v1;
end;
StringRep = function(v3) --[[ Line: 27 ]] --[[ Name: StringRep ]]
    if type(v3) == "string" then
        return LuaString(v3);
    elseif typeof(v3) == "Instance" then
        return v3:GetFullName();
    else
        return (tostring(v3));
    end;
end;
SafeKeyStringRep = function(v4) --[[ Line: 36 ]] --[[ Name: SafeKeyStringRep ]]
    if type(v4) == "number" or type(v4) == "boolean" then
        return (("%*"):format(v4));
    elseif type(v4) == "string" then
        local v5 = utf8.len(v4);
        if not v5 then
            return "InvalidUTF8";
        elseif not IsASCII(v4) then
            return "NonASCII";
        elseif v5 > 30 then
            return (("%*...%*"):format(LuaString((string.sub(v4, 1, 30))), v5 - 30));
        else
            return LuaString(v4);
        end;
    elseif typeof(v4) == "Instance" then
        return v4:GetFullName();
    else
        return (("UnknownType(%*)"):format((typeof(v4))));
    end;
end;
StripErrorSource = function(v6) --[[ Line: 57 ]] --[[ Name: StripErrorSource ]]
    local v7 = tostring(v6);
    local v8, v9 = string.match(v7, "^(.*:%d+): (.+)$");
    if v8 and v9 then
        v7 = v9;
    end;
    return v7;
end;
ParseError = function(v10) --[[ Line: 68 ]] --[[ Name: ParseError ]]
    local v11 = StripErrorSource(v10);
    local v12, v13 = string.match(v11, "^(.+) $(%[.+)$");
    if v12 and v13 then
        v11 = v12;
    end;
    return v11, v13;
end;
MakeError = function(v14, v15) --[[ Line: 80 ]] --[[ Name: MakeError ]]
    return (("%* $%*"):format(v14, v15));
end;
IsEqual = function(v16, v17) --[[ Line: 84 ]] --[[ Name: IsEqual ]]
    if rawequal(v16, v17) then
        return true;
    elseif type(v16) == "number" and type(v17) == "number" and v16 ~= v16 and v17 ~= v17 then
        return true;
    else
        return false;
    end;
end;
IsASCII = function(v18) --[[ Line: 98 ]] --[[ Name: IsASCII ]]
    for v19 = 1, string.len(v18) do
        local v20 = string.byte(v18, v19);
        if v20 < 32 or v20 > 126 then
            return false;
        end;
    end;
    return true;
end;
IsFinite = function(v21) --[[ Line: 110 ]] --[[ Name: IsFinite ]]
    local v22 = false;
    if v21 == v21 then
        v22 = false;
        if v21 ~= 1e999 then
            v22 = v21 ~= -1e999;
        end;
    end;
    return v22;
end;
IsInteger = function(v23) --[[ Line: 116 ]] --[[ Name: IsInteger ]]
    local v24 = false;
    if math.floor(v23) == v23 then
        v24 = false;
        if v23 ~= 1e999 then
            v24 = v23 ~= -1e999;
        end;
    end;
    return v24;
end;
IsFiniteCFrame = function(v25) --[[ Line: 120 ]] --[[ Name: IsFiniteCFrame ]]
    local l_v25_Components_0, v27, v28, v29, v30, v31, v32, v33, v34, v35, v36, v37 = v25:GetComponents();
    return IsFinite(l_v25_Components_0) and IsFinite(v27) and IsFinite(v28) and IsFinite(v29) and IsFinite(v30) and IsFinite(v31) and IsFinite(v32) and IsFinite(v33) and IsFinite(v34) and IsFinite(v35) and IsFinite(v36) and IsFinite(v37);
end;
IsFiniteVector2 = function(v38) --[[ Line: 137 ]] --[[ Name: IsFiniteVector2 ]]
    return IsFinite(v38.X) and IsFinite(v38.Y);
end;
IsFiniteVector3 = function(v39) --[[ Line: 141 ]] --[[ Name: IsFiniteVector3 ]]
    return IsFinite(v39.X) and IsFinite(v39.Y) and IsFinite(v39.Z);
end;
local v40 = {
    IsFiniteCFrame = IsFiniteCFrame, 
    IsFiniteVector2 = IsFiniteVector2, 
    IsFiniteVector3 = IsFiniteVector3
};
v40.Array = function(v41) --[[ Line: 152 ]] --[[ Name: Array ]]
    -- upvalues: v40 (copy)
    v40.Function(v41);
    return function(v42) --[[ Line: 156 ]]
        -- upvalues: v41 (copy)
        if type(v42) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(v42) ~= nil then
            error("metatable", 2);
        end;
        local v43 = rawlen(v42);
        local v44 = 0;
        for v45, v46 in pairs(v42) do
            v44 = v44 + 1;
            if v45 ~= v44 then
                error(MakeError("IndexMismatch", (("[%*]"):format((SafeKeyStringRep(v45))))), 2);
            end;
            if v43 < v44 then
                error(MakeError("IndexOverflow", (("[%*]"):format(v44))), 2);
            end;
            local l_status_0, l_result_0 = pcall(v41, v46);
            if not l_status_0 then
                local v49, v50 = ParseError(l_result_0);
                error(MakeError(v49, (("[%*]%*"):format(v44, v50 or ""))), 2);
            end;
        end;
        if v43 ~= v44 then
            error("LengthMismatch", 2);
        end;
        return v42;
    end;
end;
v40.ArrayCoerce = function(v51) --[[ Line: 186 ]] --[[ Name: ArrayCoerce ]]
    -- upvalues: v40 (copy)
    v40.Function(v51);
    return function(v52) --[[ Line: 190 ]]
        -- upvalues: v51 (copy)
        if type(v52) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(v52) ~= nil then
            error("metatable", 2);
        end;
        local v53 = rawlen(v52);
        local v54 = 0;
        local v55 = {};
        for v56, v57 in pairs(v52) do
            v54 = v54 + 1;
            if v56 ~= v54 then
                error(MakeError("IndexMismatch", (("[%*]"):format((SafeKeyStringRep(v56))))), 2);
            end;
            if v53 < v54 then
                error(MakeError("IndexOverflow", (("[%*]"):format(v54))), 2);
            end;
            local l_status_1, l_result_1 = pcall(v51, v57);
            if not l_status_1 then
                local v60, v61 = ParseError(l_result_1);
                error(MakeError(v60, (("[%*]%*"):format(v54, v61 or ""))), 2);
            end;
            v55[v56] = l_result_1;
        end;
        if v53 ~= v54 then
            error("LengthMismatch", 2);
        end;
        return v55;
    end;
end;
v40.UniqueArray = function(v62) --[[ Line: 222 ]] --[[ Name: UniqueArray ]]
    -- upvalues: v40 (copy)
    v40.Function(v62);
    return function(v63) --[[ Line: 226 ]]
        -- upvalues: v62 (copy)
        if type(v63) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(v63) ~= nil then
            error("metatable", 2);
        end;
        local v64 = {};
        local v65 = rawlen(v63);
        local v66 = 0;
        for v67, v68 in pairs(v63) do
            v66 = v66 + 1;
            if v67 ~= v66 then
                error(MakeError("IndexMismatch", (("[%*]"):format((SafeKeyStringRep(v67))))), 2);
            end;
            if v65 < v66 then
                error(MakeError("IndexOverflow", (("[%*]"):format(v66))), 2);
            end;
            if v64[v68] then
                error(MakeError("UniqueArray", (("[%*]"):format(v66))), 2);
            end;
            v64[v68] = true;
            if not v64[v68] then
                error(MakeError("InvalidKey", (("[%*]"):format(v66))), 2);
            end;
            local l_status_2, l_result_2 = pcall(v62, v68);
            if not l_status_2 then
                local v71, v72 = ParseError(l_result_2);
                error(MakeError(v71, (("[%*]%*"):format(v66, v72 or ""))), 2);
            end;
        end;
        if v65 ~= v66 then
            error("LengthMismatch", 2);
        end;
        return v63;
    end;
end;
v40.UniqueArrayCoerce = function(v73) --[[ Line: 264 ]] --[[ Name: UniqueArrayCoerce ]]
    -- upvalues: v40 (copy)
    v40.Function(v73);
    return function(v74) --[[ Line: 268 ]]
        -- upvalues: v73 (copy)
        if type(v74) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(v74) ~= nil then
            error("metatable", 2);
        end;
        local v75 = {};
        local v76 = rawlen(v74);
        local v77 = 0;
        local v78 = {};
        for v79, v80 in pairs(v74) do
            v77 = v77 + 1;
            if v79 ~= v77 then
                error(MakeError("IndexMismatch", (("[%*]"):format((SafeKeyStringRep(v79))))), 2);
            end;
            if v76 < v77 then
                error(MakeError("IndexOverflow", (("[%*]"):format(v77))), 2);
            end;
            if v75[v80] then
                error(MakeError("UniqueArray", (("[%*]"):format(v77))), 2);
            end;
            v75[v80] = true;
            if not v75[v80] then
                error(MakeError("InvalidKey", (("[%*]"):format(v77))), 2);
            end;
            local l_status_3, l_result_3 = pcall(v73, v80);
            if not l_status_3 then
                local v83, v84 = ParseError(l_result_3);
                error(MakeError(v83, (("[%*]%*"):format(v77, v84 or ""))), 2);
            end;
            v78[v79] = l_result_3;
        end;
        if v76 ~= v77 then
            error("LengthMismatch", 2);
        end;
        return v78;
    end;
end;
v40.Map = function(v85, v86, v87) --[[ Line: 309 ]] --[[ Name: Map ]]
    -- upvalues: v40 (copy)
    v40.Function(v85);
    v40.Function(v86);
    v40.Optional(v40.IntegerPositive)(v87);
    local v88 = v87 or 1e999;
    return function(v89) --[[ Line: 319 ]]
        -- upvalues: v88 (copy), v85 (copy), v86 (copy)
        if type(v89) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(v89) ~= nil then
            error("metatable", 2);
        end;
        local v90 = 0;
        for v91, v92 in pairs(v89) do
            v90 = v90 + 1;
            if v88 < v90 then
                error(("LengthLimit(%*)"):format(v88), 2);
            end;
            local l_status_4, l_result_4 = pcall(v85, v91);
            if not l_status_4 then
                local v95, v96 = ParseError(l_result_4);
                error(MakeError(v95, (("<%*>%*"):format(SafeKeyStringRep(v91), v96 or ""))), 2);
            end;
            local l_status_5, l_result_5 = pcall(v86, v92);
            if not l_status_5 then
                local v99, v100 = ParseError(l_result_5);
                error(MakeError(v99, (("[%*]%*"):format(SafeKeyStringRep(v91), v100 or ""))), 2);
            end;
        end;
        return v89;
    end;
end;
v40.MapCoerce = function(v101, v102, v103) --[[ Line: 354 ]] --[[ Name: MapCoerce ]]
    -- upvalues: v40 (copy)
    v40.Function(v101);
    v40.Function(v102);
    v40.Optional(v40.IntegerPositive)(v103);
    local v104 = v103 or 1e999;
    return function(v105) --[[ Line: 364 ]]
        -- upvalues: v104 (copy), v101 (copy), v102 (copy)
        if type(v105) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(v105) ~= nil then
            error("metatable", 2);
        end;
        local v106 = 0;
        local v107 = {};
        for v108, v109 in pairs(v105) do
            v106 = v106 + 1;
            if v104 < v106 then
                error(("LengthLimit(%*)"):format(v104), 2);
            end;
            local l_status_6, l_result_6 = pcall(v101, v108);
            if not l_status_6 then
                local v112, v113 = ParseError(l_result_6);
                error(MakeError(v112, (("<%*>%*"):format(SafeKeyStringRep(v108), v113 or ""))), 2);
            end;
            local l_status_7, l_result_7 = pcall(v102, v109);
            if not l_status_7 then
                local v116, v117 = ParseError(l_result_7);
                error(MakeError(v116, (("[%*]%*"):format(SafeKeyStringRep(v108), v117 or ""))), 2);
            end;
            v107[l_result_6] = l_result_7;
        end;
        return v107;
    end;
end;
v40.Table = function(v118) --[[ Line: 401 ]] --[[ Name: Table ]]
    -- upvalues: v40 (copy)
    v40.NoMetatable(v118);
    for _, v120 in pairs(v118) do
        v40.Function(v120);
    end;
    v118 = table.clone(v118);
    return function(v121) --[[ Line: 410 ]]
        -- upvalues: v118 (ref)
        if type(v121) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(v121) ~= nil then
            error("metatable", 2);
        end;
        if rawlen(v118) ~= rawlen(v121) then
            error("LengthMismatch", 2);
        end;
        for v122, _ in pairs(v121) do
            if not v118[v122] then
                error(MakeError("UnknownKey", (("[%*]"):format((SafeKeyStringRep(v122))))), 2);
            end;
        end;
        for v124, v125 in pairs(v118) do
            local v126 = v121[v124];
            local l_status_8, l_result_8 = pcall(v125, v126);
            if not l_status_8 then
                local v129, v130 = ParseError(l_result_8);
                error(MakeError(v129, (("[%*]%*"):format(StringRep(v124), v130 or ""))), 2);
            end;
        end;
        return v121;
    end;
end;
v40.TableCoerce = function(v131) --[[ Line: 439 ]] --[[ Name: TableCoerce ]]
    -- upvalues: v40 (copy)
    v40.NoMetatable(v131);
    for _, v133 in pairs(v131) do
        v40.Function(v133);
    end;
    v131 = table.clone(v131);
    return function(v134) --[[ Line: 448 ]]
        -- upvalues: v131 (ref)
        if type(v134) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(v134) ~= nil then
            error("metatable", 2);
        end;
        if rawlen(v131) ~= rawlen(v134) then
            error("LengthMismatch", 2);
        end;
        local v135 = {};
        for v136, _ in pairs(v134) do
            if not v131[v136] then
                error(MakeError("UnknownKey", (("[%*]"):format((SafeKeyStringRep(v136))))), 2);
            end;
        end;
        for v138, v139 in pairs(v131) do
            local v140 = v134[v138];
            local l_status_9, l_result_9 = pcall(v139, v140);
            if not l_status_9 then
                local v143, v144 = ParseError(l_result_9);
                error(MakeError(v143, (("[%*]%*"):format(StringRep(v138), v144 or ""))), 2);
            end;
            v135[v138] = l_result_9;
        end;
        return v135;
    end;
end;
v40.IsASCII = function(v145) --[[ Line: 478 ]] --[[ Name: IsASCII ]]
    local v146 = false;
    if type(v145) == "string" then
        v146 = IsASCII(v145);
    end;
    return v146;
end;
v40.IsFinite = function(v147) --[[ Line: 481 ]] --[[ Name: IsFinite ]]
    local v148 = false;
    if type(v147) == "number" then
        v148 = IsFinite(v147);
    end;
    return v148;
end;
v40.IsInteger = function(v149) --[[ Line: 484 ]] --[[ Name: IsInteger ]]
    local v150 = false;
    if type(v149) == "number" then
        v150 = IsInteger(v149);
    end;
    return v150;
end;
v40.IsFiniteCFrame = function(v151) --[[ Line: 487 ]] --[[ Name: IsFiniteCFrame ]]
    local v152 = false;
    if typeof(v151) == "CFrame" then
        v152 = IsFiniteCFrame(v151);
    end;
    return v152;
end;
v40.IsFiniteVector2 = function(v153) --[[ Line: 490 ]] --[[ Name: IsFiniteVector2 ]]
    local v154 = false;
    if typeof(v153) == "Vector2" then
        v154 = IsFiniteVector2(v153);
    end;
    return v154;
end;
v40.Optional = function(v155) --[[ Line: 494 ]] --[[ Name: Optional ]]
    if type(v155) ~= "function" then
        error("function", 2);
    end;
    return function(v156) --[[ Line: 496 ]]
        -- upvalues: v155 (copy)
        if v156 == nil then
            return nil;
        else
            local l_status_10, l_result_10 = pcall(v155, v156);
            if not l_status_10 then
                error(StripErrorSource(l_result_10), 2);
            end;
            return l_result_10;
        end;
    end;
end;
v40.Default = function(v159, v160) --[[ Line: 508 ]] --[[ Name: Default ]]
    if type(v159) ~= "function" then
        error("function", 2);
    end;
    local v161 = v159(v160);
    return function(v162) --[[ Line: 514 ]]
        -- upvalues: v161 (copy), v159 (copy)
        if v162 == nil then
            return v161;
        else
            local l_status_11, l_result_11 = pcall(v159, v162);
            if not l_status_11 then
                error(StripErrorSource(l_result_11), 2);
            end;
            return l_result_11;
        end;
    end;
end;
v40.AnyOf = function(...) --[[ Line: 526 ]] --[[ Name: AnyOf ]]
    local v165 = table.pack(...);
    for v166 = 1, v165.n do
        assert(type(v165[v166]) == "function", "function");
    end;
    assert(v165.n > 0);
    return function(v167) --[[ Line: 532 ]]
        -- upvalues: v165 (copy)
        for v168 = 1, v165.n do
            local l_status_12, l_result_12 = pcall(v165[v168], v167);
            if l_status_12 then
                return l_result_12;
            end;
        end;
        error("AnyOf", 2);
    end;
end;
v40.AllOf = function(...) --[[ Line: 543 ]] --[[ Name: AllOf ]]
    local v171 = table.pack(...);
    for v172 = 1, v171.n do
        assert(type(v171[v172]) == "function", "function");
    end;
    assert(v171.n > 0);
    return function(v173) --[[ Line: 549 ]]
        -- upvalues: v171 (copy)
        for v174 = 1, v171.n do
            local l_status_13, l_result_13 = pcall(v171[v174], v173);
            if not l_status_13 then
                error(StripErrorSource(l_result_13), 2);
            end;
        end;
        return v173;
    end;
end;
v40.AnyTable = function(v177) --[[ Line: 561 ]] --[[ Name: AnyTable ]]
    if type(v177) ~= "table" then
        error("table", 2);
    end;
    return v177;
end;
v40.Number = function(v178) --[[ Line: 567 ]] --[[ Name: Number ]]
    if type(v178) ~= "number" then
        error("number", 2);
    end;
    return v178;
end;
v40.Boolean = function(v179) --[[ Line: 573 ]] --[[ Name: Boolean ]]
    if type(v179) ~= "boolean" then
        error("boolean", 2);
    end;
    return v179;
end;
v40.Buffer = function(v180) --[[ Line: 579 ]] --[[ Name: Buffer ]]
    if type(v180) ~= "buffer" then
        error("buffer", 2);
    end;
    return v180;
end;
v40.Function = function(v181) --[[ Line: 585 ]] --[[ Name: Function ]]
    if type(v181) ~= "function" then
        error("function", 2);
    end;
    return v181;
end;
v40.Thread = function(v182) --[[ Line: 591 ]] --[[ Name: Thread ]]
    if type(v182) ~= "thread" then
        error("thread", 2);
    end;
    return v182;
end;
v40.String = function(v183) --[[ Line: 598 ]] --[[ Name: String ]]
    if type(v183) ~= "string" then
        error("string", 2);
    end;
    if not utf8.len(v183) then
        error("UTF8", 2);
    end;
    return v183;
end;
v40.RawString = function(v184) --[[ Line: 608 ]] --[[ Name: RawString ]]
    if type(v184) ~= "string" then
        error("string", 2);
    end;
    return v184;
end;
v40.Any = function(v185) --[[ Line: 615 ]] --[[ Name: Any ]]
    return v185;
end;
v40.Equals = function(v186) --[[ Line: 619 ]] --[[ Name: Equals ]]
    return function(v187) --[[ Line: 620 ]]
        -- upvalues: v186 (copy)
        if not IsEqual(v187, v186) then
            error("Equals", 2);
        end;
        return v187;
    end;
end;
v40.Set = function(v188) --[[ Line: 626 ]] --[[ Name: Set ]]
    -- upvalues: v40 (copy)
    v40.Array(v40.Any);
    local v189 = {};
    for _, v191 in ipairs(v188) do
        if v191 ~= v191 then
            error("InvalidKeyNaN", 2);
        end;
        v189[v191] = true;
        if not v189[v191] then
            error("InvalidKey", 2);
        end;
    end;
    return function(v192) --[[ Line: 638 ]]
        -- upvalues: v189 (copy)
        if not v189[v192] then
            error("Set", 2);
        end;
        return v192;
    end;
end;
v40.Pattern = function(v193) --[[ Line: 644 ]] --[[ Name: Pattern ]]
    -- upvalues: v40 (copy)
    v40.String(v193);
    return function(v194) --[[ Line: 646 ]]
        -- upvalues: v193 (copy)
        if type(v194) ~= "string" then
            error("string", 2);
        end;
        if not utf8.len(v194) then
            error("UTF8", 2);
        end;
        if not string.find(v194, v193) then
            error("Pattern", 2);
        end;
        return v194;
    end;
end;
v40.NoMetatable = function(v195) --[[ Line: 654 ]] --[[ Name: NoMetatable ]]
    if type(v195) ~= "table" then
        error("table", 2);
    end;
    if getmetatable(v195) ~= nil then
        error("metatable", 2);
    end;
    return v195;
end;
v40.Finite = function(v196) --[[ Line: 661 ]] --[[ Name: Finite ]]
    if type(v196) ~= "number" then
        error("number", 2);
    end;
    if not IsFinite(v196) then
        error("Finite", 2);
    end;
    return v196;
end;
v40.FinitePositive = function(v197) --[[ Line: 668 ]] --[[ Name: FinitePositive ]]
    if type(v197) ~= "number" then
        error("number", 2);
    end;
    if not IsFinite(v197) then
        error("Finite", 2);
    end;
    if v197 <= 0 then
        error("Positive", 2);
    end;
    return v197;
end;
v40.FiniteNonNegative = function(v198) --[[ Line: 676 ]] --[[ Name: FiniteNonNegative ]]
    if type(v198) ~= "number" then
        error("number", 2);
    end;
    if not IsFinite(v198) then
        error("Finite", 2);
    end;
    if v198 < 0 then
        error("NonNegative", 2);
    end;
    return v198;
end;
v40.Positive = function(v199) --[[ Line: 684 ]] --[[ Name: Positive ]]
    if type(v199) ~= "number" then
        error("number", 2);
    end;
    if v199 <= 0 then
        error("Positive", 2);
    end;
    return v199;
end;
v40.NonNegative = function(v200) --[[ Line: 691 ]] --[[ Name: NonNegative ]]
    if type(v200) ~= "number" then
        error("number", 2);
    end;
    if v200 < 0 then
        error("NonNegative", 2);
    end;
    return v200;
end;
v40.Real = function(v201) --[[ Line: 698 ]] --[[ Name: Real ]]
    if type(v201) ~= "number" then
        error("number", 2);
    end;
    if v201 ~= v201 then
        error("Real", 2);
    end;
    return v201;
end;
v40.Range = function(v202, v203) --[[ Line: 705 ]] --[[ Name: Range ]]
    -- upvalues: v40 (copy)
    v40.Real(v202);
    v40.Real(v203);
    if v202 > v203 then
        error("a<=b", 2);
    end;
    return function(v204) --[[ Line: 709 ]]
        -- upvalues: v202 (copy), v203 (copy)
        if type(v204) ~= "number" then
            error("number", 2);
        end;
        if v202 > v204 or v204 > v203 then
            error(("Range(%*,%*)"):format(v202, v203), 2);
        end;
        return v204;
    end;
end;
v40.Integer = function(v205) --[[ Line: 717 ]] --[[ Name: Integer ]]
    if type(v205) ~= "number" then
        error("number", 2);
    end;
    if not IsInteger(v205) then
        error("Integer", 2);
    end;
    return v205;
end;
v40.Unsigned32 = function(v206) --[[ Line: 724 ]] --[[ Name: Unsigned32 ]]
    if bit32.band(v206, -1) ~= v206 then
        error("Unsigned32", 2);
    end;
    return v206;
end;
v40.IntegerPositive = function(v207) --[[ Line: 731 ]] --[[ Name: IntegerPositive ]]
    if type(v207) ~= "number" then
        error("number", 2);
    end;
    if not IsInteger(v207) then
        error("Integer", 2);
    end;
    if v207 < 1 then
        error("Positive", 2);
    end;
    return v207;
end;
v40.Index = function(v208) --[[ Line: 739 ]] --[[ Name: Index ]]
    if type(v208) ~= "number" then
        error("number", 2);
    end;
    if not IsInteger(v208) then
        error("Integer", 2);
    end;
    if v208 < 1 then
        error("Positive", 2);
    end;
    return v208;
end;
v40.IntegerNonNegative = function(v209) --[[ Line: 747 ]] --[[ Name: IntegerNonNegative ]]
    if type(v209) ~= "number" then
        error("number", 2);
    end;
    if not IsInteger(v209) then
        error("Integer", 2);
    end;
    if v209 < 0 then
        error("NonNegative", 2);
    end;
    return v209;
end;
v40.IntegerRange = function(v210, v211) --[[ Line: 755 ]] --[[ Name: IntegerRange ]]
    -- upvalues: v40 (copy)
    v40.Integer(v210);
    v40.Integer(v211);
    if v210 > v211 then
        error("a<=b", 2);
    end;
    return function(v212) --[[ Line: 759 ]]
        -- upvalues: v210 (copy), v211 (copy)
        if type(v212) ~= "number" then
            error("number", 2);
        end;
        if not IsInteger(v212) then
            error("Integer", 2);
        end;
        if v210 > v212 or v212 > v211 then
            error(("Range(%*,%*)"):format(v210, v211), 2);
        end;
        return v212;
    end;
end;
v40.UInt32 = function() --[[ Line: 767 ]] --[[ Name: UInt32 ]]
    return function(v213) --[[ Line: 768 ]]
        if type(v213) ~= "number" then
            error("number", 2);
        end;
        if bit32.bor(v213, 0) ~= v213 then
            error("UInt32", 2);
        end;
        return v213;
    end;
end;
v40.StringRange = function(v214, v215) --[[ Line: 776 ]] --[[ Name: StringRange ]]
    -- upvalues: v40 (copy)
    v40.Integer(v214);
    v40.Integer(v215);
    if v214 > v215 then
        error("a<=b", 2);
    end;
    return function(v216) --[[ Line: 780 ]]
        -- upvalues: v214 (copy), v215 (copy)
        if type(v216) ~= "string" then
            error("string", 2);
        end;
        local v217 = utf8.len(v216);
        if not v217 then
            error("UTF8", 2);
        end;
        if v214 > v217 or v217 > v215 then
            error(("StringRange(%*,%*)"):format(v214, v215), 2);
        end;
        return v216;
    end;
end;
v40.ASCII = function(v218) --[[ Line: 793 ]] --[[ Name: ASCII ]]
    if type(v218) ~= "string" then
        error("string", 2);
    end;
    for v219 = 1, string.len(v218) do
        local v220 = string.byte(v218, v219);
        if v220 < 32 or v220 > 126 then
            error("ASCII", 2);
        end;
    end;
    return v218;
end;
v40.ASCIIRange = function(v221, v222) --[[ Line: 805 ]] --[[ Name: ASCIIRange ]]
    -- upvalues: v40 (copy)
    v40.Integer(v221);
    v40.Integer(v222);
    if v221 > v222 then
        error("a<=b", 2);
    end;
    return function(v223) --[[ Line: 809 ]]
        -- upvalues: v221 (copy), v222 (copy)
        if type(v223) ~= "string" then
            error("string", 2);
        end;
        local v224 = string.len(v223);
        if v221 > v224 or v224 > v222 then
            error(("ASCIIRange(%*,%*)"):format(v221, v222), 2);
        end;
        for v225 = 1, v224 do
            local v226 = string.byte(v223, v225);
            if v226 < 32 or v226 > 126 then
                error("ASCII", 2);
            end;
        end;
        return v223;
    end;
end;
v40.CFrame = function(v227) --[[ Line: 825 ]] --[[ Name: CFrame ]]
    if typeof(v227) ~= "CFrame" then
        error("CFrame", 2);
    end;
    return v227;
end;
v40.CFrameFinite = function(v228) --[[ Line: 831 ]] --[[ Name: CFrameFinite ]]
    if typeof(v228) ~= "CFrame" then
        error("CFrame", 2);
    end;
    if not IsFiniteCFrame(v228) then
        error("FiniteCFrame", 2);
    end;
    return v228;
end;
v40.Vector2 = function(v229) --[[ Line: 840 ]] --[[ Name: Vector2 ]]
    if typeof(v229) ~= "Vector2" then
        error("Vector2", 2);
    end;
    return v229;
end;
v40.Vector2Finite = function(v230) --[[ Line: 846 ]] --[[ Name: Vector2Finite ]]
    if typeof(v230) ~= "Vector2" then
        error("Vector2", 2);
    end;
    if not IsFiniteVector2(v230) then
        error("FiniteVector2", 2);
    end;
    return v230;
end;
v40.Vector3 = function(v231) --[[ Line: 855 ]] --[[ Name: Vector3 ]]
    if typeof(v231) ~= "Vector3" then
        error("Vector3", 2);
    end;
    return v231;
end;
v40.Vector3Finite = function(v232) --[[ Line: 861 ]] --[[ Name: Vector3Finite ]]
    if typeof(v232) ~= "Vector3" then
        error("Vector3", 2);
    end;
    if not IsFiniteVector3(v232) then
        error("FiniteVector3", 2);
    end;
    return v232;
end;
v40.Vector3int16 = function(v233) --[[ Line: 870 ]] --[[ Name: Vector3int16 ]]
    if typeof(v233) ~= "Vector3int16" then
        error("Vector3int16", 2);
    end;
    return v233;
end;
v40.Vector2int16 = function(v234) --[[ Line: 876 ]] --[[ Name: Vector2int16 ]]
    if typeof(v234) ~= "Vector2int16" then
        error("Vector2int16", 2);
    end;
    return v234;
end;
v40.Region3 = function(v235) --[[ Line: 882 ]] --[[ Name: Region3 ]]
    if typeof(v235) ~= "Region3" then
        error("Region3", 2);
    end;
    return v235;
end;
v40.Region3int16 = function(v236) --[[ Line: 888 ]] --[[ Name: Region3int16 ]]
    if typeof(v236) ~= "Region3int16" then
        error("Region3int16", 2);
    end;
    return v236;
end;
v40.UDim = function(v237) --[[ Line: 894 ]] --[[ Name: UDim ]]
    if typeof(v237) ~= "UDim" then
        error("UDim", 2);
    end;
    return v237;
end;
v40.UDim2 = function(v238) --[[ Line: 900 ]] --[[ Name: UDim2 ]]
    if typeof(v238) ~= "UDim2" then
        error("UDim2", 2);
    end;
    return v238;
end;
v40.Rect = function(v239) --[[ Line: 906 ]] --[[ Name: Rect ]]
    if typeof(v239) ~= "Rect" then
        error("Rect", 2);
    end;
    return v239;
end;
v40.Storable = function(v240, v241) --[[ Line: 916 ]] --[[ Name: Storable ]]
    -- upvalues: v40 (copy)
    if type(v240) == "boolean" then
        return v240;
    elseif type(v240) == "number" then
        return v240;
    else
        if type(v240) == "string" then
            if not utf8.len(v240) then
                error("UTF8", 2);
                return v240;
            end;
        elseif type(v240) == "buffer" then
            return v240;
        elseif type(v240) == "table" then
            if type(v240) ~= "table" then
                error("table", 2);
            end;
            if getmetatable(v240) ~= nil then
                error("metatable", 2);
            end;
            local v242 = v241 or {};
            if v242[v240] then
                error("Loop", 2);
            end;
            v242[v240] = true;
            local v243 = rawlen(v240);
            if v243 > 0 then
                local v244 = 0;
                for v245, v246 in pairs(v240) do
                    v244 = v244 + 1;
                    if v245 ~= v244 then
                        error(MakeError("IndexMismatch", (("[%*]"):format((SafeKeyStringRep(v245))))), 2);
                    end;
                    if v243 < v244 then
                        error(MakeError("IndexOverflow", (("[%*]"):format(v244))), 2);
                    end;
                    local l_status_14, l_result_14 = pcall(v40.Storable, v246, v242);
                    if not l_status_14 then
                        local v249, v250 = ParseError(l_result_14);
                        error(MakeError(v249, (("[%*]%*"):format(v244, v250 or ""))), 2);
                    end;
                end;
                if v243 ~= v244 then
                    error("LengthMismatch", 2);
                    return v240;
                end;
            else
                for v251, v252 in pairs(v240) do
                    if type(v251) ~= "string" then
                        error(MakeError("KeyString", (("[%*]"):format((SafeKeyStringRep(v251))))), 2);
                    end;
                    if not utf8.len(v251) then
                        error(MakeError("KeyUTF8", (("[%*]"):format((SafeKeyStringRep(v251))))), 2);
                    end;
                    local l_status_15, l_result_15 = pcall(v40.Storable, v252, v242);
                    if not l_status_15 then
                        local v255, v256 = ParseError(l_result_15);
                        error(MakeError(v255, (("[%*]%*"):format(SafeKeyStringRep(v251), v256 or ""))), 2);
                    end;
                end;
                return v240;
            end;
        else
            error("Storable", 2);
        end;
        return v240;
    end;
end;
local v257 = {
    boolean = true, 
    number = true, 
    string = true, 
    buffer = true, 
    Color3 = true, 
    Instance = true, 
    NumberRange = true, 
    Rect = true, 
    Region3 = true, 
    Region3int16 = true, 
    UDim = true, 
    UDim2 = true, 
    CFrame = true, 
    Vector2 = true, 
    Vector2int16 = true, 
    Vector3 = true, 
    Vector3int16 = true, 
    EnumItem = true
};
table.freeze(v257);
v40.Networkable = function(v258, v259) --[[ Line: 1012 ]] --[[ Name: Networkable ]]
    -- upvalues: v40 (copy), v257 (copy)
    if type(v258) == "string" then
        if not utf8.len(v258) then
            error("UTF8", 2);
            return v258;
        end;
    elseif type(v258) == "table" then
        if type(v258) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(v258) ~= nil then
            error("metatable", 2);
        end;
        local v260 = v259 or {};
        if v260[v258] then
            error("Loop", 2);
        end;
        v260[v258] = true;
        local v261 = rawlen(v258);
        if v261 > 0 then
            local v262 = 0;
            for v263, v264 in pairs(v258) do
                v262 = v262 + 1;
                if v263 ~= v262 then
                    error(MakeError("IndexMismatch", (("[%*]"):format((SafeKeyStringRep(v263))))), 2);
                end;
                if v261 < v262 then
                    error(MakeError("IndexOverflow", (("[%*]"):format(v262))), 2);
                end;
                local l_status_16, l_result_16 = pcall(v40.Networkable, v264, v260);
                if not l_status_16 then
                    local v267, v268 = ParseError(l_result_16);
                    error(MakeError(v267, (("[%*]%*"):format(v262, v268 or ""))), 2);
                end;
            end;
            if v261 ~= v262 then
                error("LengthMismatch", 2);
                return v258;
            end;
        else
            for v269, v270 in pairs(v258) do
                if type(v269) ~= "string" then
                    error(MakeError("KeyString", (("[%*]"):format((SafeKeyStringRep(v269))))), 2);
                end;
                if not utf8.len(v269) then
                    error(MakeError("KeyUTF8", (("[%*]"):format((SafeKeyStringRep(v269))))), 2);
                end;
                local l_status_17, l_result_17 = pcall(v40.Networkable, v270, v260);
                if not l_status_17 then
                    local v273, v274 = ParseError(l_result_17);
                    error(MakeError(v273, (("[%*]%*"):format(SafeKeyStringRep(v269), v274 or ""))), 2);
                end;
            end;
            return v258;
        end;
    elseif not v257[typeof(v258)] then
        error("Networkable", 2);
    end;
    return v258;
end;
v40.Enum = function(v275) --[[ Line: 1078 ]] --[[ Name: Enum ]]
    if typeof(v275) ~= "Enum" then
        error("Enum", 2);
    end;
    return function(v276) --[[ Line: 1080 ]]
        -- upvalues: v275 (copy)
        if typeof(v276) ~= "EnumItem" then
            error("EnumItem", 2);
        end;
        if v276.EnumType ~= v275 then
            error(tostring(v275), 2);
        end;
        return v276;
    end;
end;
v40.EnumValue = function(v277) --[[ Line: 1087 ]] --[[ Name: EnumValue ]]
    if typeof(v277) ~= "Enum" then
        error("Enum", 2);
    end;
    local v278 = {};
    for _, v280 in ipairs(v277:GetEnumItems()) do
        v278[v280.Value] = v280;
    end;
    return function(v281) --[[ Line: 1093 ]]
        -- upvalues: v278 (copy)
        if typeof(v281) ~= "number" then
            error("number", 2);
        end;
        if not v278[v281] then
            error("EnumValue", 2);
        end;
        return v281;
    end;
end;
v40.Player = function(v282) --[[ Line: 1100 ]] --[[ Name: Player ]]
    if typeof(v282) ~= "Instance" or not v282:IsA("Player") then
        error("Player", 2);
    end;
    return v282;
end;
v40.BasePart = function(v283) --[[ Line: 1106 ]] --[[ Name: BasePart ]]
    if typeof(v283) ~= "Instance" or not v283:IsA("BasePart") then
        error("BasePart", 2);
    end;
    return v283;
end;
v40.Part = function(v284) --[[ Line: 1112 ]] --[[ Name: Part ]]
    if typeof(v284) ~= "Instance" or not v284:IsA("Part") then
        error("Part", 2);
    end;
    return v284;
end;
v40.MeshPart = function(v285) --[[ Line: 1118 ]] --[[ Name: MeshPart ]]
    if typeof(v285) ~= "Instance" or not v285:IsA("MeshPart") then
        error("MeshPart", 2);
    end;
    return v285;
end;
v40.Model = function(v286) --[[ Line: 1124 ]] --[[ Name: Model ]]
    if typeof(v286) ~= "Instance" or not v286:IsA("Model") then
        error("Model", 2);
    end;
    return v286;
end;
v40.Animation = function(v287) --[[ Line: 1130 ]] --[[ Name: Animation ]]
    if typeof(v287) ~= "Instance" or not v287:IsA("Animation") then
        error("Animation", 2);
    end;
    return v287;
end;
v40.Humanoid = function(v288) --[[ Line: 1136 ]] --[[ Name: Humanoid ]]
    if typeof(v288) ~= "Instance" or not v288:IsA("Humanoid") then
        error("Humanoid", 2);
    end;
    return v288;
end;
v40.ParticleEmitter = function(v289) --[[ Line: 1142 ]] --[[ Name: ParticleEmitter ]]
    if typeof(v289) ~= "Instance" or not v289:IsA("ParticleEmitter") then
        error("ParticleEmitter", 2);
    end;
    return v289;
end;
v40.Sound = function(v290) --[[ Line: 1148 ]] --[[ Name: Sound ]]
    if typeof(v290) ~= "Instance" or not v290:IsA("Sound") then
        error("Sound", 2);
    end;
    return v290;
end;
v40.Instance = function(v291) --[[ Line: 1154 ]] --[[ Name: Instance ]]
    if typeof(v291) ~= "Instance" then
        error("Instance", 2);
    end;
    return v291;
end;
v40.InstanceOf = function(v292) --[[ Line: 1162 ]] --[[ Name: InstanceOf ]]
    -- upvalues: v40 (copy)
    v40.String(v292);
    return function(v293) --[[ Line: 1164 ]]
        -- upvalues: v292 (copy)
        if typeof(v293) ~= "Instance" then
            error("Instance", 2);
        end;
        if not v293:IsA(v292) then
            error(v292, 2);
        end;
        return v293;
    end;
end;
v40.InstanceClass = function(v294) --[[ Line: 1171 ]] --[[ Name: InstanceClass ]]
    -- upvalues: v40 (copy)
    v40.String(v294);
    return function(v295) --[[ Line: 1173 ]]
        -- upvalues: v294 (copy)
        if typeof(v295) ~= "Instance" then
            error("Instance", 2);
        end;
        if v295.ClassName ~= v294 then
            error(v294, 2);
        end;
        return v295;
    end;
end;
v40.HexLower = function(v296) --[[ Line: 1181 ]] --[[ Name: HexLower ]]
    if type(v296) ~= "string" then
        error("string", 2);
    end;
    for v297 = 1, string.len(v296) do
        local v298 = string.byte(v296, v297);
        if (v298 < 48 or v298 > 57) and (v298 < 97 or v298 > 102) then
            error("HexLower", 2);
        end;
    end;
    return v296;
end;
v40.HexUpper = function(v299) --[[ Line: 1195 ]] --[[ Name: HexUpper ]]
    if type(v299) ~= "string" then
        error("string", 2);
    end;
    for v300 = 1, string.len(v299) do
        local v301 = string.byte(v299, v300);
        if (v301 < 48 or v301 > 57) and (v301 < 65 or v301 > 70) then
            error("HexUpper", 2);
        end;
    end;
    return v299;
end;
v40.UUIDStripped = function(v302) --[[ Line: 1209 ]] --[[ Name: UUIDStripped ]]
    if type(v302) ~= "string" then
        error("string", 2);
    end;
    local v303 = string.len(v302);
    if v303 ~= 32 then
        error("Length32", 2);
    end;
    for v304 = 1, v303 do
        local v305 = string.byte(v302, v304);
        if (v305 < 48 or v305 > 57) and (v305 < 97 or v305 > 102) then
            error("HexLower", 2);
        end;
    end;
    return v302;
end;
v40.UUID = function(v306) --[[ Line: 1223 ]] --[[ Name: UUID ]]
    if type(v306) ~= "string" then
        error("string", 2);
    end;
    if string.len(v306) ~= 36 then
        error("Length36", 2);
    end;
    if not v306:find("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
        error("UUID", 2);
    end;
    return v306;
end;
v40.Base64 = function(v307) --[[ Line: 1234 ]] --[[ Name: Base64 ]]
    if type(v307) ~= "string" then
        error("string", 2);
    end;
    if string.len(v307) % 4 ~= 0 then
        error("Base64Length", 2);
    end;
    if not string.match(v307, "^[A-Za-z0-9+/]*=?=?$") or string.match(v307, "[^=]=+[^=]") then
        error("Base64", 2);
    end;
    return v307;
end;
v40.ToNumber = function(v308) --[[ Line: 1245 ]] --[[ Name: ToNumber ]]
    return function(v309) --[[ Line: 1248 ]]
        -- upvalues: v308 (copy)
        local v310 = tonumber(v309);
        if not v310 then
            error("tonumber", 2);
        end;
        local l_status_18, l_result_18 = pcall(v308, v310);
        if not l_status_18 then
            error(StripErrorSource(l_result_18), 2);
        end;
        return l_result_18;
    end;
end;
return table.freeze(v40);