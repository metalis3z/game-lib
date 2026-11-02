-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:18
-- Luau version 6, Types version 3
-- Time taken: 0.000516 seconds

local AutoUIGrid = require(script.Parent.Parent.Parent.Parent.AutoUIGrid)
local tbl = {{
	ResolutionThreshold = 1;
	PerRow = 4;
	Padding = UDim2.new(0, 21, 0, 24);
}, {
	ResolutionThreshold = 1;
	PerRow = 4;
	Padding = UDim2.new(0, 21, 0, 24);
}}
AutoUIGrid(script.Parent)
script.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(AutoUIGrid(script.Parent))
game.Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(AutoUIGrid(script.Parent))