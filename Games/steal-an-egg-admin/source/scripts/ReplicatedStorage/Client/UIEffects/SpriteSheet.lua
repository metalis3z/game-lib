-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local v1 = {}
local v2 = {}
local v3 = 0
local v4

local function drawFrame(v5) -- line 11
    local ImageRectSize = v5.Image.ImageRectSize
    local v6 = v5.Frame % v5.Cells.X
    local v7 = v5.Frame / v5.Cells.X
    local v8 = math.floor(v7)
    v5.Image.ImageRectOffset = Vector2.new(ImageRectSize.X * v6, ImageRectSize.Y * v8)
end

local function step(v9) -- line 17 | captures: v2
    for v10, v11 in pairs(v2) do
        v11.Elapsed += v9
        local Elapsed = v11.Elapsed
        if v11.SecondsPerFrame <= Elapsed then
            local v12 = v11.Elapsed / v11.SecondsPerFrame
            local v13 = math.floor(v12)
            v11.Elapsed -= v13 * v11.SecondsPerFrame
            v11.Frame = (v11.Frame + v13) % (v11.Cells.X * v11.Cells.Y)
            local ImageRectSize = v11.Image.ImageRectSize
            local v14 = v11.Frame % v11.Cells.X
            local v15 = v11.Frame / v11.Cells.X
            local v16 = math.floor(v15)
            v11.Image.ImageRectOffset = Vector2.new(ImageRectSize.X * v14, ImageRectSize.Y * v16)
        end
    end
end

function v1.Bind(v17) -- line 32 | captures: v3, v4, RunService, v2, step
    local v18 = v17:IsA("ImageLabel") or v17:IsA("ImageButton")
    local v19 = ("%* must be an ImageLabel or ImageButton to play a sprite sheet"):format((v17:GetFullName()))
    assert(v18, v19)
    local SpriteCells = v17:GetAttribute("SpriteCells")
    local v20 = if typeof(SpriteCells) == "Vector2" and SpriteCells.X >= 1 then SpriteCells.Y >= 1 else false
    local v21 = ("%* needs a SpriteCells Vector2 attribute holding (columns, rows)"):format((v17:GetFullName()))
    assert(v20, v21)
    local v22 = v17:GetAttribute("SpriteFPS") or 24
    local v23 = if typeof(v22) == "number" then v22 > 0 else false
    local v24 = ("%* SpriteFPS must be a number above zero"):format((v17:GetFullName()))
    assert(v23, v24)
    local v25 = {
        Elapsed = 0,
        Frame = 0,
        Cells = SpriteCells,
        Image = v17,
        OriginalOffset = v17.ImageRectOffset,
        SecondsPerFrame = 1 / v22
    }
    v2[v17] = v25
    v3 += 1
    local ImageRectSize = v25.Image.ImageRectSize
    local v26 = v25.Frame % v25.Cells.X
    local v27 = v25.Frame / v25.Cells.X
    local v28 = math.floor(v27)
    v25.Image.ImageRectOffset = Vector2.new(ImageRectSize.X * v26, ImageRectSize.Y * v28)
    if v4 == nil then
        v4 = RunService.Heartbeat:Connect(step)
    end
    return function() -- line 62 | captures: v17, v25, v3, v4, v2
        if v2[v17] == nil then
            return
        end
        v2[v17] = nil
        v3 -= 1
        v17.ImageRectOffset = v25.OriginalOffset
        if v3 == 0 and v4 ~= nil then
            v4:Disconnect()
            v4 = nil
        end
    end
end

return v1
