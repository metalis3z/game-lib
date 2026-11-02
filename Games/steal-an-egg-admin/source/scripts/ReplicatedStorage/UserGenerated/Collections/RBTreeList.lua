-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function insertRight2(v1, v2) -- line 7
    local Right2 = v1.Right2
    v2.Right2 = Right2
    v2.Left2 = v1
    v1.Right2 = v2
    Right2.Left2 = v2
end

local function unlink2(v3) -- line 14
    v3.Left2.Right2 = v3.Right2
    v3.Right2.Left2 = v3.Left2
end

local function unlink(v4) -- line 18
    v4.Left2.Right2 = v4.Right2
    v4.Right2.Left2 = v4.Left2
    v4.Left1 = nil
    v4.Right1 = nil
    v4.Left2 = nil
    v4.Right2 = nil
end

local function isRed(v5) -- line 26
    if v5 then
        return v5.Color1
    end
    return false
end

local function rotateLeft(v6) -- line 32
    local Right1 = v6.Right1
    v6.Right1 = Right1.Left1
    Right1.Left1 = v6
    Right1.Color1 = v6.Color1
    v6.Color1 = true
    return Right1
end

local function rotateRight(v7) -- line 40
    local Left1 = v7.Left1
    v7.Left1 = Left1.Right1
    Left1.Right1 = v7
    Left1.Color1 = v7.Color1
    v7.Color1 = true
    return Left1
end

local function flipColors(v8) -- line 48
    v8.Color1 = not v8.Color1
    local Left1 = v8.Left1
    Left1.Color1 = not Left1.Color1
    local Right1 = v8.Right1
    Right1.Color1 = not Right1.Color1
end

local function moveRedLeft(v9) -- line 55
    v9.Color1 = not v9.Color1
    local Left1 = v9.Left1
    Left1.Color1 = not Left1.Color1
    local Right1 = v9.Right1
    Right1.Color1 = not Right1.Color1
    local Left1_2 = v9.Right1.Left1
    if Left1_2 and Left1_2.Color1 then
        local Right1 = v9.Right1
        local Left1 = Right1.Left1
        Right1.Left1 = Left1.Right1
        Left1.Right1 = Right1
        Left1.Color1 = Right1.Color1
        Right1.Color1 = true
        v9.Right1 = Left1
        local Right1_2 = v9.Right1
        v9.Right1 = Right1_2.Left1
        Right1_2.Left1 = v9
        Right1_2.Color1 = v9.Color1
        v9.Color1 = true
        Right1_2.Color1 = not Right1_2.Color1
        local Left1_2 = Right1_2.Left1
        Left1_2.Color1 = not Left1_2.Color1
        local Right1_3 = Right1_2.Right1
        Right1_3.Color1 = not Right1_3.Color1
        return nil
    end
    return v9
end

local function moveRedRight(v10) -- line 94
    v10.Color1 = not v10.Color1
    local Left1 = v10.Left1
    Left1.Color1 = not Left1.Color1
    local Right1 = v10.Right1
    Right1.Color1 = not Right1.Color1
    local Left1_2 = v10.Left1.Left1
    if Left1_2 and Left1_2.Color1 then
        local Left1 = v10.Left1
        v10.Left1 = Left1.Right1
        Left1.Right1 = v10
        Left1.Color1 = v10.Color1
        v10.Color1 = true
        Left1.Color1 = not Left1.Color1
        local Left1_2 = Left1.Left1
        Left1_2.Color1 = not Left1_2.Color1
        local Right1 = Left1.Right1
        Right1.Color1 = not Right1.Color1
        return nil
    end
    return v10
end

local function balance(v11) -- line 126
    local Right1 = v11.Right1
    local Right1_2
    if Right1 and Right1.Color1 then
        Right1_2 = v11.Right1
        v11.Right1 = Right1_2.Left1
        Right1_2.Left1 = v11
        Right1_2.Color1 = v11.Color1
        v11.Color1 = true
    else
        Right1_2 = v11
    end
    local Left1 = Right1_2.Left1
    local Left1_2
    if Left1 and Left1.Color1 then
        local Left1 = Right1_2.Left1.Left1
        if Left1 and Left1.Color1 then
            Left1_2 = Right1_2.Left1
            Right1_2.Left1 = Left1_2.Right1
            Left1_2.Right1 = Right1_2
            Left1_2.Color1 = Right1_2.Color1
            Right1_2.Color1 = true
        else
            Left1_2 = Right1_2
        end
    else
        Left1_2 = Right1_2
    end
    local Left1_3 = Left1_2.Left1
    if Left1_3 and Left1_3.Color1 then
        local Right1 = Left1_2.Right1
        if Right1 and Right1.Color1 then
            Left1_2.Color1 = not Left1_2.Color1
            local Left1 = Left1_2.Left1
            Left1.Color1 = not Left1.Color1
            local Right1 = Left1_2.Right1
            Right1.Color1 = not Right1.Color1
        end
    end
    return Left1_2
end

local v12

function v12(v13) -- line 194 | captures: v12, balance
    if v13.Left1 then
        local Left1 = v13.Left1
        if not (Left1 and Left1.Color1) then
            local Left1 = v13.Left1.Left1
            if not (Left1 and Left1.Color1) then
                v13.Color1 = not v13.Color1
                local Left1 = v13.Left1
                Left1.Color1 = not Left1.Color1
                local Right1 = v13.Right1
                Right1.Color1 = not Right1.Color1
                local Left1_2 = v13.Right1.Left1
                if Left1_2 and Left1_2.Color1 then
                    local Right1 = v13.Right1
                    local Left1 = Right1.Left1
                    Right1.Left1 = Left1.Right1
                    Left1.Right1 = Right1
                    Left1.Color1 = Right1.Color1
                    Right1.Color1 = true
                    v13.Right1 = Left1
                    local Right1_2 = v13.Right1
                    v13.Right1 = Right1_2.Left1
                    Right1_2.Left1 = v13
                    Right1_2.Color1 = v13.Color1
                    v13.Color1 = true
                    Right1_2.Color1 = not Right1_2.Color1
                    local Left1_2 = Right1_2.Left1
                    Left1_2.Color1 = not Left1_2.Color1
                    local Right1_3 = Right1_2.Right1
                    Right1_3.Color1 = not Right1_3.Color1
                end
            end
        end
        local v14, v15 = v12(v13.Left1)
        v13.Left1 = v14
        return balance(v13), v15
    end
    return nil, v13
end

local v16

function v16(v17) -- line 261 | captures: v16, balance
    local Left1 = v17.Left1
    local Left1_2
    if Left1 and Left1.Color1 then
        Left1_2 = v17.Left1
        v17.Left1 = Left1_2.Right1
        Left1_2.Right1 = v17
        Left1_2.Color1 = v17.Color1
        v17.Color1 = true
    else
        Left1_2 = v17
    end
    if Left1_2.Right1 then
        local Right1 = Left1_2.Right1
        if not (Right1 and Right1.Color1) then
            local Left1 = Left1_2.Right1.Left1
            if not (Left1 and Left1.Color1) then
                Left1_2.Color1 = not Left1_2.Color1
                local Left1 = Left1_2.Left1
                Left1.Color1 = not Left1.Color1
                local Right1 = Left1_2.Right1
                Right1.Color1 = not Right1.Color1
                local Left1_3 = Left1_2.Left1.Left1
                if Left1_3 and Left1_3.Color1 then
                    local Left1 = Left1_2.Left1
                    Left1_2.Left1 = Left1.Right1
                    Left1.Right1 = Left1_2
                    Left1.Color1 = Left1_2.Color1
                    Left1_2.Color1 = true
                    Left1.Color1 = not Left1.Color1
                    local Left1_3 = Left1.Left1
                    Left1_3.Color1 = not Left1_3.Color1
                    local Right1 = Left1.Right1
                    Right1.Color1 = not Right1.Color1
                end
            end
        end
        local v18, v19 = v16(Left1_2.Right1)
        Left1_2.Right1 = v18
        return balance(Left1_2), v19
    end
    return nil, Left1_2
end

local v20

function v20(v21) -- line 334 | captures: v20
    local function v22(v23, ...)
        return (math.max(v23, ...))
    end

    if v21 then
        return v22(v20(v21.Left1), v20(v21.Right1)) + 1
    end
    return -1
end

local v24

function v24(v25, v26, v27, v28) -- line 341 | captures: v24
    if v26 then
        if v27 == nil then
            if v28 == nil then
                return v24(v25, v26.Left1, v27, v26.Key) and v24(v25, v26.Right1, v26.Key, v28)
            end
            if v25(v26.Key, v28) >= 0 then
                return false
            end
            return v24(v25, v26.Left1, v27, v26.Key) and v24(v25, v26.Right1, v26.Key, v28)
        end
        if v25(v26.Key, v27) <= 0 then
            return false
        end
    else
        return true
    end
end

local v29

function v29(v30, v31, v32) -- line 371 | captures: v29, v12, balance
    if v31 then
        if v30(v31.Key, v32) > 0 then
            local Left1 = v31.Left1
            if not (Left1 and Left1.Color1) then
                local Left1 = v31.Left1.Left1
                if not (Left1 and Left1.Color1) then
                    v31.Color1 = not v31.Color1
                    local Left1 = v31.Left1
                    Left1.Color1 = not Left1.Color1
                    local Right1 = v31.Right1
                    Right1.Color1 = not Right1.Color1
                    local Left1_2 = v31.Right1.Left1
                    if Left1_2 and Left1_2.Color1 then
                        local Right1 = v31.Right1
                        local Left1 = Right1.Left1
                        Right1.Left1 = Left1.Right1
                        Left1.Right1 = Right1
                        Left1.Color1 = Right1.Color1
                        Right1.Color1 = true
                        v31.Right1 = Left1
                        local Right1_2 = v31.Right1
                        v31.Right1 = Right1_2.Left1
                        Right1_2.Left1 = v31
                        Right1_2.Color1 = v31.Color1
                        v31.Color1 = true
                        Right1_2.Color1 = not Right1_2.Color1
                        local Left1_2 = Right1_2.Left1
                        Left1_2.Color1 = not Left1_2.Color1
                        local Right1_3 = Right1_2.Right1
                        Right1_3.Color1 = not Right1_3.Color1
                    end
                end
            end
            local v33, v34 = v29(v30, v31.Left1, v32)
            v31.Left1 = v33
            return balance(v31), v34
        end
        local Left1 = v31.Left1
        local Left1_2
        if Left1 and Left1.Color1 then
            Left1_2 = v31.Left1
            v31.Left1 = Left1_2.Right1
            Left1_2.Right1 = v31
            Left1_2.Color1 = v31.Color1
            v31.Color1 = true
        else
            Left1_2 = v31
        end
        if v30(Left1_2.Key, v32) == 0 then
            if Left1_2.Right1 then
                return
            end
            Left1_2.Left2.Right2 = Left1_2.Right2
            Left1_2.Right2.Left2 = Left1_2.Left2
            Left1_2.Left1 = nil
            Left1_2.Right1 = nil
            Left1_2.Left2 = nil
            Left1_2.Right2 = nil
            return nil, Left1_2
        end
        if Left1_2.Right1 then
            local Right1 = Left1_2.Right1
            if not (Right1 and Right1.Color1) then
                local Left1 = Left1_2.Right1.Left1
                if not (Left1 and Left1.Color1) then
                    Left1_2.Color1 = not Left1_2.Color1
                    local Left1 = Left1_2.Left1
                    Left1.Color1 = not Left1.Color1
                    local Right1 = Left1_2.Right1
                    Right1.Color1 = not Right1.Color1
                    local Left1_3 = Left1_2.Left1.Left1
                    if Left1_3 and Left1_3.Color1 then
                        local Left1 = Left1_2.Left1
                        Left1_2.Left1 = Left1.Right1
                        Left1.Right1 = Left1_2
                        Left1.Color1 = Left1_2.Color1
                        Left1_2.Color1 = true
                        Left1.Color1 = not Left1.Color1
                        local Left1_3 = Left1.Left1
                        Left1_3.Color1 = not Left1_3.Color1
                        local Right1 = Left1.Right1
                        Right1.Color1 = not Right1.Color1
                    end
                end
            end
        end
        local v35
        if v30(Left1_2.Key, v32) == 0 then
            local Left1 = Left1_2.Left1
            local Right1 = Left1_2.Right1
            local Color1 = Left1_2.Color1
            Left1_2.Left2.Right2 = Left1_2.Right2
            Left1_2.Right2.Left2 = Left1_2.Left2
            Left1_2.Left1 = nil
            Left1_2.Right1 = nil
            Left1_2.Left2 = nil
            Left1_2.Right2 = nil
            if Left1 and Right1 then
                local v36
                v36, v35 = v12(Right1)
                v35.Right1 = v36
                v35.Left1 = Left1
            else
                v35 = Left1 or Right1
            end
            v35.Color1 = Color1
        else
            local v37, v38 = v29(v30, Left1_2.Right1, v32)
            Left1_2.Right1 = v37
            Left1_2, v35 = v38, Left1_2
        end
        return balance(v35), Left1_2
    end
    return v31, nil
end

local v39

function v39(v40, v41, v42, v43, v44) -- line 554 | captures: v39, balance
    if v41 then
        local v45 = v40(v41.Key, v43)
        if v45 == 0 then
            v41.Value = v44
            return v41, v41, false
        end
        local v46, v47
        if v45 <= 0 then
            local v48
            v48, v46, v47 = v39(v40, v41.Right1, v41, v43, v44)
            v41.Right1 = v48
        else
            local v49
            v49, v46, v47 = v39(v40, v41.Left1, v41.Left2, v43, v44)
            v41.Left1 = v49
        end
        if v47 then
            return balance(v41), v46, v47
        end
        return v41, v46, v47
    end
    local v50 = {
        Color1 = true,
        Key = v43,
        Value = v44
    }
    local Right2 = v42.Right2
    v50.Right2 = Right2
    v50.Left2 = v42
    v42.Right2 = v50
    Right2.Left2 = v50
    return v50, v50, true
end

local v51

function v51(v52, v53) -- line 592 | captures: v51
    if v52 then
        local v54 = if v52.Color1 then v53 else v53 - 1
        return v51(v52.Left1, v54) and v51(v52.Right1, v54)
    end
    return v53 == 0
end

local v55

function v55(v56) -- line 614 | captures: v55
    if v56 then
        return 0 + 1 + v55(v56.Left1) + v55(v56.Right1)
    end
    return 0
end

local v57

function v57(v58, v59) -- line 622 | captures: v57, v55
    if v58 then
        local Left1 = v58.Left1
        local v60 = if Left1 then 0 + 1 + v55(Left1.Left1) + v55(Left1.Right1) else 0
        if v59 < v60 then
            return v57(v58.Left1, v59)
        end
        if v60 < v59 then
            return v57(v58.Right1, v59 - v60 - 1)
        end
        return v58.Key
    end
    return nil
end

local v61

function v61(v62, v63, v64) -- line 641 | captures: v61, v55
    if v64 then
        local v65 = v62(v64.Key, v63)
        if v65 > 0 then
            return v61(v62, v63, v64.Left1)
        end
        if v65 < 0 then
            local Left1 = v64.Left1
            local v66 = if Left1 then 0 + 1 + v55(Left1.Left1) + v55(Left1.Right1) else 0
            return v66 + 1 + v61(v62, v63, v64.Right1)
        end
        local Left1 = v64.Left1
        if Left1 then
            return 0 + 1 + v55(Left1.Left1) + v55(Left1.Right1)
        end
        return 0
    end
    return 0
end

local v67

function v67(v68, v69) -- line 666 | captures: v67
    if v69 then
        local Right1 = v69.Right1
        if Right1 and Right1.Color1 then
            return false
        end
        if v69 == v68 then
            return v67(v68, v69.Left1) and v67(v69.Right1)
        end
        if v69.Color1 then
            local Left1 = v69.Left1
            if Left1 and Left1.Color1 then
                return false
            end
            return v67(v68, v69.Left1) and v67(v69.Right1)
        end
        return v67(v68, v69.Left1) and v67(v69.Right1)
    end
    return true
end

local v70 = {}
local v71 = table.freeze({ __index = v70 })

function v70.Insert(v72, v73, v74) -- line 716 | captures: v39
    local v75, v76, v77 = v39(v72.Comparator, v72.Root, v72.List, v73, v74)
    v75.Color1 = false
    v72.Root = v75
    if v77 then
        v72.Size += 1
    end
    return v76, v77
end

function v70.Remove(v78, v79) -- line 726 | captures: v29
    local Root = v78.Root
    local v80
    if Root then
        local Left1 = Root.Left1
        if not (Left1 and Left1.Color1) then
            local Right1 = Root.Right1
            if not (Right1 and Right1.Color1) then
                Root.Color1 = true
            end
        end
        local v81
        v81, v80 = v29(v78.Comparator, Root, v79)
        if v81 then
            v81.Color1 = false
        end
        v78.Root = v81
        if v80 then
            v78.Size -= 1
        end
    end
    return v80
end

function v70.RemoveMin(v82) -- line 762 | captures: v12
    local Root = v82.Root
    local v83
    if Root then
        local Left1 = Root.Left1
        if not (Left1 and Left1.Color1) then
            local Right1 = Root.Right1
            if not (Right1 and Right1.Color1) then
                Root.Color1 = true
            end
        end
        local v84
        v84, v83 = v12(Root)
        if v84 then
            v84.Color1 = false
        end
        v82.Root = v84
        if v83 then
            v82.Size -= 1
        end
    end
    return v83
end

function v70.RemoveMax(v85) -- line 798 | captures: v16
    local Root = v85.Root
    local v86
    if Root then
        local Left1 = Root.Left1
        if not (Left1 and Left1.Color1) then
            local Right1 = Root.Right1
            if not (Right1 and Right1.Color1) then
                Root.Color1 = true
            end
        end
        local v87
        v87, v86 = v16(Root)
        if v87 then
            v87.Color1 = false
        end
        v85.Root = v87
        if v86 then
            v85.Size -= 1
        end
    end
    return v86
end

function v70.Min(v88) -- line 834
    local List = v88.List
    local Left1 = List.Left1
    if Left1 == List then
        return nil
    end
    return Left1
end

function v70.Max(v89) -- line 842
    local List = v89.List
    local Right1 = List.Right1
    if Right1 == List then
        return nil
    end
    return Right1
end

function v70.GetSize(v90) -- line 850
    return v90.Size
end

function v70.ForEach(v91, v92) -- line 853
    local v93 = type(v92) == "function"
    assert(v93)
    local List = v91.List
    local v94 = List
    while true do
        v94 = v94.Right2
        if v94 == List then
            break
        end
        v92(v94.Key, v94.Value)
    end
end

function v70.Next(v95, v96) -- line 866
    local v97 = if v96 == nil then v95.List else v96
    local Right2 = v97.Right2
    if Right2 == v95.List then
        return nil, nil
    end
    return Right2, Right2
end

function v70.Iterator(v98) -- line 879
    return v98.Next, v98
end

function v70.IsBST(v99) -- line 882 | captures: v24
    local Comparator = v99.Comparator
    local Root = v99.Root
    if Root then
        return v24(Comparator, Root.Left1, nil, Root.Key) and v24(Comparator, Root.Right1, Root.Key, nil)
    end
    return true
end

function v70.IsSizeConsistent(v100) -- line 894 | captures: v55
    local Size = v100.Size
    local Root = v100.Root
    local v101 = if Root then 0 + 1 + v55(Root.Left1) + v55(Root.Right1) else 0
    if Size == v101 then
        local List = v100.List
        local v102 = 0
        local v103 = List
        while true do
            v103 = v103.Right2
            if v103 == List then
                break
            end
            v102 += 1
        end
        return Size == v102
    end
    return false
end

function v70.IsRankConsistent(v104) -- line 920 | captures: v61, v57, v55
    local v105 = v104.Size - 1
    for v106 = 0, v105 do
        local Root = v104.Root
        local v107
        if Root then
            local Left1 = Root.Left1
            local v108 = if Left1 then 0 + 1 + v55(Left1.Left1) + v55(Left1.Right1) else 0
            if v106 < v108 then
                v107 = v57(Root.Left1, v106)
            elseif v106 <= v108 then
                v107 = Root.Key
            else
                v107 = v57(Root.Right1, v106 - v108 - 1)
            end
        end
        if v106 ~= v61(v104.Comparator, v107, v104.Root) then
            return false
        end
    end
    local v109 = {}
    v104:ForEach(function(v110, v111) -- line 950 | captures: v104, v61, v57, v55
        local v112 = v61(v104.Comparator, v110, v104.Root)
        local Root = v104.Root
        local v113
        if Root then
            local Left1 = Root.Left1
            local v114 = if Left1 then 0 + 1 + v55(Left1.Left1) + v55(Left1.Right1) else 0
            if v112 < v114 then
                v113 = v57(Root.Left1, v112)
            elseif v112 <= v114 then
                v113 = Root.Key
            else
                v113 = v57(Root.Right1, v112 - v114 - 1)
            end
        end
        if v104.Comparator(v113, v110) == 0 then
            return
        end
        return false
    end)
    return true
end

function v70.Is23(v115) -- line 978 | captures: v67
    return (v67(v115.Root, v115.Root))
end

function v70.IsBalanced(v116) -- line 981 | captures: v51
    local Root = v116.Root
    local v117 = 0
    local v118 = Root
    while v118 do
        if not v118.Color1 then
            v117 += 1
        end
        v118 = v118.Left1
    end
    if Root then
        if not Root.Color1 then
            v117 -= 1
        end
        return v51(Root.Left1, v117) and v51(Root.Right1, v117)
    end
    return v117 == 0
end

function v70.Check(v119) -- line 1017
    if v119:IsBST() then
        if v119:IsSizeConsistent() then
            if v119:IsRankConsistent() then
                if v119:Is23() then
                    if v119:IsBalanced() then
                        return true
                    end
                    return false, "Not balanced"
                end
                return false, "Not a 2-3 tree"
            end
            return false, "Ranks not consistent"
        end
        return false, "Subtree counts not consistent"
    end
    return false, "Not in symmetric order"
end

table.freeze(v70)
local freeze = table.freeze
local v120 = {
    Compare = function(v121, v122) -- Compare | line 1037
        if v121 < v122 then
            return -1
        end
        if v122 < v121 then
            return 1
        end
        return 0
    end
}

function v120.new(v123, v124, v125) -- line 1046 | captures: v71
    local v126 = type(v123) == "function"
    assert(v126)
    local v127 = { Color1 = false }
    v127.Left2 = v127
    v127.Right2 = v127
    local v128 = {
        Size = 0,
        Comparator = v123,
        List = v127
    }
    return (setmetatable(v128, v71))
end

return freeze(v120)
