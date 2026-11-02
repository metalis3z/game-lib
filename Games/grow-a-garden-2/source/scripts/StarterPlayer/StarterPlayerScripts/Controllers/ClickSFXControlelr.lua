--credit to leon games studio
local t = {}
local SfxController = require(script.Parent.SfxController)
local CollectionService = game:GetService("CollectionService")
local t2 = {}

local function hook(p1) --[[ hook | Line: 9 | Upvalues: t2 (copy), SfxController (copy) ]]
	if t2[p1] then
		return
	end

	if p1:IsA("GuiButton") then
		t2[p1] = true
		p1.Activated:Connect(function() --[[ Line: 19 | Upvalues: SfxController (ref) ]]
			SfxController:PlaySFX("Click")
		end)
	end
end

function t.Init(p1) --[[ Init | Line: 24 ]] end
function t.Start(p1) --[[ Start | Line: 27 | Upvalues: CollectionService (copy), t2 (copy), SfxController (copy), hook (copy) ]]
	for v1, v2 in CollectionService:GetTagged("ClickSFX") do
		if not t2[v2] and v2:IsA("GuiButton") then
			t2[v2] = true
			v2.Activated:Connect(function() --[[ Line: 19 | Upvalues: SfxController (ref) ]]
				SfxController:PlaySFX("Click")
			end)
		end
	end

	CollectionService:GetInstanceAddedSignal("ClickSFX"):Connect(hook)
end

return t