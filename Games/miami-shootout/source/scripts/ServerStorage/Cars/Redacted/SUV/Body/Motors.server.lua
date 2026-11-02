local fl = Instance.new("Motor", script.Parent.Parent.Misc.FL.Door.SS) --doors
local fr = Instance.new("Motor", script.Parent.Parent.Misc.FR.Door.SS)
local rl = Instance.new("Motor", script.Parent.Parent.Misc.RL.Door.SS)
local rr = Instance.new("Motor", script.Parent.Parent.Misc.RR.Door.SS)

local tk = Instance.new("Motor", script.Parent.Parent.Misc.TK.SS) --trunk
local fk = Instance.new("Motor", script.Parent.Parent.Misc.HK.SS) --frunk

local sw = Instance.new("Motor", script.Parent.Parent.Misc.SW.SS) --sw

local wl = Instance.new("Motor", script.Parent.Parent.Misc.FL.Window.SS) --windows
local wr = Instance.new("Motor", script.Parent.Parent.Misc.FR.Window.SS)
local wl2 = Instance.new("Motor", script.Parent.Parent.Misc.RL.Window.SS)
local wr2 = Instance.new("Motor", script.Parent.Parent.Misc.RR.Window.SS)

fl.MaxVelocity = 0.03
fl.Part0 = script.Parent.FL
fl.Part1 = fl.Parent

fr.MaxVelocity = 0.03
fr.Part0 = script.Parent.FR
fr.Part1 = fr.Parent

rl.MaxVelocity = 0.03
rl.Part0 = script.Parent.RL
rl.Part1 = rl.Parent

rr.MaxVelocity = 0.03
rr.Part0 = script.Parent.RR
rr.Part1 = rr.Parent

wl.MaxVelocity = 0.007
wl.Part0 = script.Parent.Parent.Misc.FL.Door.WD
wl.Part1 = wl.Parent

wr.MaxVelocity = 0.007
wr.Part0 = script.Parent.Parent.Misc.FR.Door.WD
wr.Part1 = wr.Parent

wl2.MaxVelocity = 0.007
wl2.Part0 = script.Parent.Parent.Misc.RL.Door.WD
wl2.Part1 = wl2.Parent

wr2.MaxVelocity = 0.007
wr2.Part0 = script.Parent.Parent.Misc.RR.Door.WD
wr2.Part1 = wr2.Parent

sw.MaxVelocity = 0.08
sw.Part0 = script.Parent.SW
sw.Part1 = sw.Parent

tk.MaxVelocity = 0.009
tk.Part0 = script.Parent.TK
tk.Part1 = tk.Parent

fk.MaxVelocity = 0.03
fk.Part0 = script.Parent.HK
fk.Part1 = fk.Parent