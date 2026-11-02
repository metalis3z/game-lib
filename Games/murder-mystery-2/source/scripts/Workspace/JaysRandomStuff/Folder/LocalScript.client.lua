

if ItemData.RobuxID then
	ViewContents.Container.BuyFrame.PurchaseOptions.Container.Robux.Cost.Text = comma_value(ItemData.RobuxPrice)
end

if ItemData.RobuxID then
	ViewContents.Container.BuyFrame.PurchaseOptions.Container.Robux.Visible = true
	ViewContents.Container.BuyFrame.PurchaseOptions.Container.Coins.Visible = false
	ViewContents.Container.BuyFrame.PurchaseOptions.Container.Gems.Visible = false
	ViewContents.Container.BuyFrame.PurchaseOptions.Container.Key.Visible = false
else
	ViewContents.Container.BuyFrame.PurchaseOptions.Container.Robux.Visible = false
end

elseif ItemData.RobuxID ~= nil then
	FrameContainer.Parent.Container.Classic.Visible = false;
	FrameContainer.Parent.Tags.Coins.Visible = false
	FrameContainer.Parent.Tags.Gems.Visible = false;
	FrameContainer.Parent.Tags.Gems.Container.PriceFrame.PriceLabel.Text = "nil";
	FrameContainer.Parent.Tags.Coins.Container.PriceFrame.PriceLabel.Text = "nil";
	
		--[[[
	
	
	
	HOW TO SET UP ROBUX BOXES.
	
		["RobuxID"] = 1622359016;
		["RobuxPrice"] = 10;
	
	THATS ALL U NEED
	
	
	]]