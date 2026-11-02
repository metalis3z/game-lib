-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Modules = Library:WaitForChild("Modules")
local Functions = Library:WaitForChild("Functions")
local v1 = require(Modules.Event)
local ResolutionScale = require(Functions.ResolutionScale)
local BindToRenderStep = require(ReplicatedStorage.Library.Functions.BindToRenderStep)
local CurrentCamera = workspace.CurrentCamera
local ViewportSize = CurrentCamera.ViewportSize
local v2 = ResolutionScale(ViewportSize)
local v3 = ViewportSize
local v4 = v2
local v5 = 0
local t = {
	Changed = v1.new(),
	GetViewportSize = function() --[[ GetViewportSize | Line: 20 | Upvalues: v3 (ref) ]]
		return v3
	end,
	GetScale = function() --[[ GetScale | Line: 25 | Upvalues: v4 (ref) ]]
		return v4
	end
}

CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 30 | Upvalues: ViewportSize (ref), CurrentCamera (copy), v2 (ref), ResolutionScale (copy), v5 (ref) ]]
	ViewportSize = CurrentCamera.ViewportSize
	v2 = ResolutionScale(ViewportSize)
	v5 = 0.15
end)
BindToRenderStep("ScreenResolution", Enum.RenderPriority.First.Value, function(p1) --[[ Line: 36 | Upvalues: ViewportSize (ref), v3 (ref), v5 (ref), v4 (ref), v2 (ref), t (copy) ]]
	local v1 = ViewportSize

	if v3 == v1 then
		return
	end

	if v5 <= 0 then
		v3 = v1
		v4 = v2
		t.Changed:FireAsync(v1, v2)
	end

	v5 = v5 - p1
end)

return t