
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if RunService:IsServer() then
	return {
		apply = function(p1, s1: string)
			local v15 = `Gradients_{ s1 }`

			p1:AddTag(v15)

			return function()
				p1:RemoveTag(v15)
			end
		end
	}
end

local Observers = require(ReplicatedStorage.Packages.Observers)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local t1 = {}
local t2 = {}
local t3 = {}

for _, child in script.Effects:GetChildren() do
	t1[child.Name] = require(child)
	t2[child.Name] = {}
	table.insert(t3, child.Name)
end

local function apply(p2, s2: string)
	assert(typeof(s2) == "string", "effect is not a string")

	local u18 = assert(t1[s2], "Effect not found").apply(p2, s2)
	local t4 = {
		enabled = true,
		main = u18.main,
		stroke = u18.stroke
	}

	table.insert(t2[s2], t4)

	local u20 = nil
	local u21 = nil

	local function cleanup()
		if u20 then
			u20:Disconnect()
			u20 = nil
		end

		if u21 then
			u21:Disconnect()
			u21 = nil
		end

		local v37 = table.find(t2[s2], t4)

		if v37 then
			table.remove(t2[s2], v37)
		end

		if u18 and u18.cleanup then
			u18.cleanup()
			u18 = nil
		end
	end

	local u23 = nil

	local function onAncestryUpdate()
		if u23 then
			u23:Disconnect()
			u23 = nil
		end

		local LayerCollector = p2:FindFirstAncestorWhichIsA("LayerCollector")

		if not LayerCollector then
			t4.enabled = true

			return
		end

		t4.enabled = LayerCollector.Enabled
		u23 = LayerCollector:GetPropertyChangedSignal("Enabled"):Connect(function()
			t4.enabled = LayerCollector.Enabled
		end)
	end

	u21 = p2.AncestryChanged:Connect(onAncestryUpdate)
	onAncestryUpdate()
	u20 = p2.Destroying:Connect(cleanup)

	return cleanup
end

local n1 = 1

RunService.PostSimulation:Connect(function(p3)
	local Instant = FFlags:GetInstant("Gradients.DistributeLoad", true)
	local Instant2 = FFlags:GetInstant("Gradients.DistributeLoadBudget", 0.001)

	debug.profilebegin("Gradients:Simulate")

	local v28 = not Instant and 1e999 or Instant2
	local n2 = 1

	while n2 < #t3 and v28 > 0 do
		local v30 = t3[n1]

		n2 += 1
		n1 += 1

		if n1 > #t3 then
			n1 = 1
		end

		local v31 = t2[v30]

		if #v31 ~= 0 then
			debug.profilebegin(v30)
			debug.profilebegin("Simulate")

			local elapsed = os.clock()
			local v33 = t1[v30].simulate(p3)

			debug.profileend()
			debug.profilebegin("Apply")

			for _, v35 in v31 do
				if v35.enabled then
					v35.main.Color = v33.main

					if v33.mainTransparency then
						v35.main.Transparency = v33.mainTransparency
					end

					if v35.stroke and v33.stroke then
						v35.stroke.Color = v33.stroke

						if v33.strokeTransparency then
							v35.stroke.Transparency = v33.strokeTransparency
						end
					end
				end
			end

			v28 -= os.clock() - elapsed
			debug.profileend()
			debug.profileend()
		end
	end

	debug.profileend()
end)

for v12 in t2 do
	Observers.observeTag(`Gradients_{ v12 }`, function(p4)
		return (apply(p4, v12))
	end)
end

return {
	apply = apply
}
