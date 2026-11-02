--credit to leon games studio
local t = {}
local t2 = {}

function t.Init(p1) --[[ Init | Line: 6 ]]
	for k, v in pairs(script:GetChildren()) do
		require(v)
	end
end
function t.GetMutationModule(p1, p2) --[[ GetMutationModule | Line: 12 | Upvalues: t2 (copy) ]]
	if t2[p2] then
		return t2[p2]
	end

	local v1 = script:FindFirstChild(p2)

	if v1 then
		t2[p2] = require(v1)

		return t2[p2]
	end

	return nil
end
function t.ApplyMutation(p1, p2) --[[ ApplyMutation | Line: 26 ]]
	local v1 = p2:GetAttribute("Mutation")

	if not v1 then
		return
	end

	local v2 = p1:GetMutationModule(v1)

	if not (v2 and v2.ApplyMutationEffect) then
		return
	end

	v2.ApplyMutationEffect(p2)
end
function t.SetupListener(p1, p2) --[[ SetupListener | Line: 36 ]]
	for v1, v2 in p2:GetDescendants() do
		if v2:GetAttribute("Mutation") then
			p1:ApplyMutation(v2)
		end
	end

	p2.DescendantAdded:Connect(function(p12) --[[ Line: 45 | Upvalues: p1 (copy) ]]
		if not p12:GetAttribute("Mutation") then
			return
		end

		p1:ApplyMutation(p12)
	end)
	p2.DescendantAdded:Connect(function(p12) --[[ Line: 52 | Upvalues: p1 (copy) ]]
		p12:GetAttributeChangedSignal("Mutation"):Connect(function() --[[ Line: 53 | Upvalues: p12 (copy), p1 (ref) ]]
			if not p12:GetAttribute("Mutation") then
				return
			end

			p1:ApplyMutation(p12)
		end)
	end)
end
function t.Start(p1) --[[ Start | Line: 61 ]]
	p1:SetupListener(workspace)
end

return t