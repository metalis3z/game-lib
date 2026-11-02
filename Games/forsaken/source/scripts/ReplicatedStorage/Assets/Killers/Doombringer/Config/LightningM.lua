
local v_u_1 = game:GetService("Debris")
local v_u_2 = require(script.Class)()
local v_u_3 = Instance.new("Part")
v_u_3.Anchored = true
v_u_3.CanCollide = false
v_u_3.TopSurface = Enum.SurfaceType.Smooth
v_u_3.BottomSurface = Enum.SurfaceType.Smooth
function v_u_2.init(p4, p5, p6, p7)
    if typeof(p5) ~= "Vector3" then
        error("LightningBolt: `from` must be a Vector3")
    end
    if typeof(p6) ~= "Vector3" then
        error("LightningBolt: `to` must be a Vector3")
    end
    p4.options = p7 or {}
    if p4.options.seed then
        p4.random = Random.new(p4.options.seed)
    else
        p4.random = Random.new()
    end
    p4.depth = p4.options.depth or 0
    p4.origin = p5
    p4.goal = p6
    p4.rep = p4.options.bends or 6
    if p4.options.color then
        local v8 = p4.options.color
        if typeof(v8) == "Color3" then
            p4.color = p4.options.color
        else
            local v9 = p4.options.color
            if typeof(v9) == "BrickColor" then
                p4.color = p4.options.color.Color
            else
                error("LightningBolt: `Options.color` must be a Color3 or BrickColor")
            end
        end
    else
        p4.color = BrickColor.new("White").Color
    end
    p4.material = p4.options.material or Enum.Material.Neon
    p4.branches = {}
    p4.lines = {
        {
            ["origin"] = p5,
            ["goal"] = p6,
            ["transparency"] = p4.options.transparency or 0.4,
            ["depth"] = p4.depth
        }
    }
    p4:generateBolt()
end
function v_u_2.GetOptions(p10)
    local v11 = {}
    for v12, v13 in pairs(p10.options) do
        v11[v12] = v13
    end
    return v11
end
function v_u_2.GetLines(p14)
    local v15 = {}
    for v16 = 1, #p14.lines do
        v15[v16] = p14.lines[v16]
    end
    for v17 = 1, #p14.branches do
        local v18 = p14.branches[v17]:GetLines()
        for v19 = 1, #v18 do
            v15[#v15 + 1] = v18[v19]
        end
    end
    return v15
end
function v_u_2.IsDestroyed(p20)
    return p20.destroyed or false
end
function v_u_2.IsDrawn(p21)
    return p21.drew or false
end
function v_u_2.generateBolt(p22)
    for _ = 1, p22.rep do
        p22:bend()
    end
end
function v_u_2.displace(_, p23, p24, p25, p26)
    local v27 = CFrame.new(p23, p24)
    local v28 = CFrame.new
    local v29 = 3.141592653589793 * p26 * 2
    local v30 = math.sin(v29) * p25
    local v31 = 3.141592653589793 * p26 * 2
    return (v27 * v28(v30, math.cos(v31) * p25, 0)).p
end
function v_u_2.bend(p32)
    -- upvalues: (copy) v_u_2
    for v33 = 1, #p32.lines do
        local v34 = p32.lines[v33]
        local v35 = v34.goal
        v34.goal = p32:displace(v34.origin + (v34.goal - v34.origin).unit * (v34.goal - v34.origin).magnitude * p32.random:NextInteger(40, 60) / 100, v34.goal, p32.random:NextInteger(-530, 530) / 100, p32.random:NextNumber())
        p32.lines[#p32.lines + 1] = {
            ["origin"] = v34.goal,
            ["goal"] = v35,
            ["transparency"] = v34.transparency,
            ["depth"] = v34.depth
        }
        if v34.depth <= (p32.options.max_depth or 3) then
            local v36 = (p32.origin - v34.goal).magnitude / (p32.origin - p32.goal).magnitude
            if p32.random:NextInteger(1, 100) < (p32.options.fork_chance or 50) * v36 then
                local v37 = p32:GetOptions()
                v37.depth = v34.depth + 1
                v37.bends = v37.fork_bends or 2
                local v38 = v_u_2(v34.goal, v34.goal + (v34.goal - v34.origin).unit * p32.random:NextInteger(20, 40), v37)
                p32.branches[#p32.branches + 1] = v38
            end
        end
    end
end
function v_u_2.Draw(p39, p40)
    -- upvalues: (copy) v_u_3, (copy) v_u_1
    local v41 = Instance.new("Model")
    p39.model = v41
    v41.Name = "LightningBolt"
    local v42 = v_u_3:Clone()
    v42.Material = p39.material
    v42.Color = p39.color
    local v43 = p39:GetLines()
    for v44 = 1, #v43 do
        local v45 = v43[v44]
        local v46 = v42:Clone()
        local v47 = 1 - v45.depth * 2 * 0.1
        local v48 = 1 - v45.depth * 2 * 0.1
        local v49 = (v45.origin - v45.goal).magnitude + 0.5
        v46.Size = Vector3.new(v47, v48, v49)
        v46.CFrame = CFrame.new((v45.goal + v45.origin) / 2, v45.goal)
        v46.Transparency = v45.transparency
        v46.Parent = v41
    end
    v41.Parent = p40 or workspace
    p39.drew = true
    if p39.options.decay then
        local v50 = v_u_1
        local v51 = p39.options.decay
        v50:AddItem(v41, tonumber(v51) or 0)
        p39.destroyed = true
    end
end
function v_u_2.Destroy(p52)
    if p52.model then
        p52.model:Destroy()
        p52.destroyed = true
    end
end
return setmetatable({
    ["new"] = v_u_2
}, {
    ["__call"] = function(_, ...)
        -- upvalues: (copy) v_u_2
        return v_u_2(...)
    end
})