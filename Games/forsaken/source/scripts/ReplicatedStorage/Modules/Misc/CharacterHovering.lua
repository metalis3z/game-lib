-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_25 = {
	["HighlightTweenTime"] = 0.125,
	["HoverRange"] = 30,
	["HoverData"] = {},
	["HoverableCharacters"] = {},
	["Connections"] = {},
	["HoveredCharacter"] = nil,
	["Hovered"] = nil,
	["HoverEnded"] = nil,
	["Clicked"] = nil,
}
v_u_25["AddHoverableCharacter"] = function(_, p1)
	-- upvalues: (copy) v_u_25
	if game.Players.LocalPlayer.Character ~= p1 then
		v_u_25.HoverableCharacters[p1] = true
	end
end
v_u_25["ToggleHoverHighlight"] = function(_, p2, p3, p4)
	-- upvalues: (copy) v_u_25
	if not v_u_25.HoverData[p2] then
		v_u_25.HoverData[p2] = {
			["Hovers"] = {},
			["Highlight"] = nil
		}
	end
	v_u_25.HoverData[p2].Hovers[p3] = p4 or nil
	local v5 = 0
	for _, v6 in pairs(v_u_25.HoverData[p2].Hovers) do
		if v6 then
			v5 = v5 + 1
		end
	end
	if v5 > 0 and not v_u_25.HoverData[p2].Highlight then
		local v7 = Instance.new("Highlight")
		v7.Name = "CharacterHoverHighlight"
		v7.OutlineTransparency = 1
		v7.FillTransparency = 1
		v7.FillColor = Color3.new(1, 1, 1)
		v7.Parent = p2
		v7.Adornee = p2
		game.TweenService:Create(v7, TweenInfo.new(v_u_25.HighlightTweenTime), {
			["OutlineTransparency"] = 0.5,
			["FillTransparency"] = 0.9
		}):Play()
		v_u_25.HoverData[p2].Highlight = v7
		v_u_25.__hoveredEvent:Fire(p2)
	elseif v5 <= 0 and v_u_25.HoverData[p2].Highlight then
		local v8 = v_u_25.HoverData[p2].Highlight
		v8.Name = "Disappearing"
		game.TweenService:Create(v8, TweenInfo.new(v_u_25.HighlightTweenTime), {
			["FillTransparency"] = 1,
			["OutlineTransparency"] = 1
		}):Play()
		game.Debris:AddItem(v8, v_u_25.HighlightTweenTime)
		v_u_25.HoverData[p2] = nil
		v_u_25.__hoverEndedEvent:Fire(p2)
	end
end
v_u_25["Init"] = function(_)
	-- upvalues: (copy) v_u_25
	if not game["Run Service"]:IsServer() then
		for v9, v10 in pairs({
			["Hovered"] = "__hovered",
			["HoverEnded"] = "__hoverEnded",
			["Clicked"] = "__clicked"
			}) do
			local v11 = v10 .. "Event"
			v_u_25[v11] = Instance.new("BindableEvent")
			v_u_25[v11].Name = v10
			v_u_25[v11].Parent = script
			v_u_25[v9] = v_u_25[v11].Event
		end
	end
end
v_u_25["Start"] = function(_)
	-- upvalues: (copy) v_u_25
	if not game["Run Service"]:IsServer() then
		local v12 = game.Players.LocalPlayer
		local v_u_13 = v12:GetMouse()
		local v_u_14 = v12.Character or v12.CharacterAdded:Wait()
		local v_u_15 = v_u_14.Parent
		local v_u_16 = v_u_14 and v_u_14.PrimaryPart or v_u_14:WaitForChild("HumanoidRootPart", 5)
		v12.CharacterAdded:Connect(function(p17)
			-- upvalues: (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_25
			v_u_14 = p17
			v_u_15 = p17.Parent
			v_u_16 = v_u_14 and v_u_14.PrimaryPart or v_u_14:WaitForChild("HumanoidRootPart", 5)
			for _, v18 in pairs(v_u_25.HoverData) do
				if v18.Highlight then
					v18.Highlight:Destroy()
				end
			end
			v_u_25.HoverData = {}
			v_u_25.HoverableCharacters = {}
		end)
		v_u_25.Connections.ClickConnection = game.UserInputService.InputBegan:Connect(function(p19, p20)
			-- upvalues: (ref) v_u_25
			if not p20 then
				local v21 = {
					[Enum.UserInputType.MouseButton1] = true,
					[Enum.UserInputType.Touch] = true,
					[Enum.KeyCode.ButtonA] = true
				}
				if (v21[p19.UserInputType] or v21[p19.KeyCode]) and v_u_25.HoveredCharacter then
					v_u_25.__clickedEvent:Fire(v_u_25.HoveredCharacter)
				end
			end
		end)
		v_u_25.Connections.HoverConnection = game["Run Service"].RenderStepped:Connect(function()
			-- upvalues: (copy) v_u_13, (ref) v_u_25, (ref) v_u_16
			local v22 = v_u_13.Target
			if v22 then
				v22 = v22.Parent
			end
			if v22 ~= v_u_25.HoveredCharacter then
				if v_u_25.HoveredCharacter then
					v_u_25:ToggleHoverHighlight(v_u_25.HoveredCharacter, "DefaultHover", false)
					v_u_25.HoveredCharacter = nil
				end
				local v23 = v_u_13.Hit
				if v23 then
					v23 = v_u_13.Hit.Position - v_u_16.Position
				end
				local v24 = v23 and v23.Magnitude or 9999
				if v_u_25.HoveredCharacter ~= v22 and (v_u_25.HoverableCharacters[v22] and v24 <= v_u_25.HoverRange) then
					v_u_25:ToggleHoverHighlight(v22, "DefaultHover", true)
					v_u_25.HoveredCharacter = v22
				end
			end
		end)
	end
end
return v_u_25
