-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Util.Assert)
local round = math.round
local floor = math.floor
local clamp = math.clamp
local min = math.min
local max = math.max
local abs = math.abs

local function ToHSL(v1) -- line 30 | captures: Assert, round, clamp, min, max, abs
    Assert.typeOf("ToHSL", "color", "Color3", v1)
    local R = v1.R
    local G = v1.G
    local B = v1.B
    local v2 = min(R, G, B)
    local R_2 = v1.R
    local G_2 = v1.G
    local B_2 = v1.B
    local v3 = max(R_2, G_2, B_2)
    local v4 = v3 - v2
    local v5 = (v3 + v2) / 2
    local v6
    if v4 == 0 then
        v6 = 0
    else
        local v7 = v5 * 2 - 1
        v6 = v4 / (1 - abs(v7))
    end
    local v8
    if v4 == 0 then
        v8 = 0
    elseif v3 == v1.R then
        v8 = (v1.G - v1.B) / v4 % 6
    elseif v3 == v1.G then
        v8 = (v1.B - v1.R) / v4 + 2
    else
        v8 = (v1.R - v1.G) / v4 + 4
    end
    local v9 = v8 * 60
    local v10 = round(v9)
    if v10 < 0 then
        v10 += 360
    end
    local v11 = v6 * 100
    local v12 = round(v11)
    local v13 = abs(v12)
    local v14 = clamp(v13, 0, 100)
    local v15 = v5 * 100
    local v16 = round(v15)
    local v17 = abs(v16)
    return {
        H = v10,
        S = v14,
        L = clamp(v17, 0, 100)
    }
end

return {
    fromHSL = function(v18) -- FromHSL | line 74 | captures: Assert, floor, min, abs
        Assert.typeOf("FromHSL", "hsl", "table", v18)
        Assert.typeOf("FromHSL", "hsl.H", "number", v18.H)
        Assert.typeOf("FromHSL", "hsl.S", "number", v18.S)
        Assert.typeOf("FromHSL", "hsl.L", "number", v18.L)
        local v19 = v18.S / 100
        local v20 = v18.L / 100
        local v21 = v20 * 2 - 1
        local v22 = (1 - abs(v21)) * v19
        local v23 = v18.H / 60 % 2 - 1
        local v24 = v22 * (1 - abs(v23))
        local v25 = v20 - v22 / 2
        local v26
        if not (v18.H >= 0 and v18.H < 60) then
            if not (v18.H >= 60 and v18.H < 120) then
                if not (v18.H >= 120 and v18.H < 180) then
                    if not (v18.H >= 180 and v18.H < 240) then
                        if not (v18.H >= 240 and v18.H < 300) then
                            if v18.H >= 300 then
                                if not (v18.H < 360) then
                                    v22 = 0
                                    v24 = 0
                                end
                            else
                                v22 = 0
                                v24 = 0
                            end
                        else
                            v22, v24 = v24, v22
                        end
                        v26 = 0
                    else
                        v22, v26, v24 = 0, v24, v22
                    end
                else
                    v22, v26 = 0, v22
                end
            else
                v22, v26, v24 = v24, v22, 0
            end
        else
            v26 = v24
            v24 = 0
        end
        local v27 = (v22 + v25) * 255
        local v28 = floor(v27)
        local v29 = min(v28, 255)
        local v30 = (v26 + v25) * 255
        local v31 = floor(v30)
        local v32 = min(v31, 255)
        local v33 = (v24 + v25) * 255
        local v34 = floor(v33)
        local v35 = min(v34, 255)
        return Color3.fromRGB(v29, v32, v35)
    end,
    toHSL = ToHSL
}
