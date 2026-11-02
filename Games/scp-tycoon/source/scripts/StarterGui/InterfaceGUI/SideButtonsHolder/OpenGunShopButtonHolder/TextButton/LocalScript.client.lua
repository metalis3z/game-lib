script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.Parent.Parent.Parent.WeaponShopFrame.Visible == false then
		script.Parent.Parent.Parent.Parent.WeaponShopFrame.Visible = true
	else
		script.Parent.Parent.Parent.Parent.WeaponShopFrame.Visible = false
	end
end)