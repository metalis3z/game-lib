--[[
=============================================================================
    CONFIGURATION GUIDE
=============================================================================

Welcome to your simulator framework! This guide explains how to easily add
new content, modify prices, expand the map, and configure monetization.

-----------------------------------------------------------------------------
1. ADDING NEW ITEMS (OBJECTS/PETS)
-----------------------------------------------------------------------------
Step A: Configure the Stats
- Go to ReplicatedStorage > Modules > ItemConfigurations.
- Add your new item to the 'Items' table using the exact format:
  ["My New Item"] = { Rarity = "Epic", Income = 100, ImageId = "rbxassetid://12345" },

Step B: Add the 3D Model
- Place the 3D Model of your item inside ReplicatedStorage > Items > Normal.
- The model's name must be EXACTLY the same as the name in the config ("My New Item").

-----------------------------------------------------------------------------
2. ADDING NEW WEIGHTS (TRAINING TOOLS)
-----------------------------------------------------------------------------
Step A: Configure the Stats
- Go to ReplicatedStorage > Modules > WeightConfigurations.
- Add to the 'Weights' table:
  ["Huge Weight"] = { Power = 50, Price = 500000, ProductId = 0, ImageId = "rbxassetid://12345" },
  (Note: Leave ProductId as 0 if it's a free/in-game cash weight. Put a real ID if it costs Robux).

Step B: Add the 3D Model
- Place the 3D Model inside ReplicatedStorage > Weights.
- Name it EXACTLY "Huge Weight".

-----------------------------------------------------------------------------
3. ADDING LUCKY BLOCKS & REWARDS
-----------------------------------------------------------------------------
Step A: Configure Power Requirements & Drops
- Go to ReplicatedStorage > Modules > LuckyBlockConfigurations.
- Add your block and assign the items it can drop:
  ["GodlyLuckyBlock"] = { PowerRequirement = 200000, Drops = {"My New Item", "SWAG SODA"} },

Step B: Add the 3D Model
- Place the block model inside ReplicatedStorage > LuckyBlocks.
- Name it EXACTLY "GodlyLuckyBlock".

-----------------------------------------------------------------------------
4. MAP EXPANSION (ZONES & TSUNAMIS)
-----------------------------------------------------------------------------
Adding a New Kick Zone:
- Go to Workspace > Zones. Duplicate an existing folder (e.g., "1") and rename it to the next number (e.g., "5").
- Ensure the new folder contains the following parts:
  > "Detection": The invisible hitbox to trigger the escape sequence.
  > "Collection": The safe zone part at the end where the player successfully claims the item.
  > "Spawn": Where the Tsunami wave spawns when the escape starts.

Configuring the Tsunami:
- Go to ReplicatedStorage > Modules > TsunamiConfigurations.
- Map your new zone number to a wave model and speed:
  ["5"] = { ModelName = "Lava Wave", Speed = 75 }
- Put the actual "Lava Wave" 3D model inside ReplicatedStorage > Tsunamis.

Adding New Plots:
- Go to Workspace > Plots.
- Duplicate an existing locator part (e.g., "1") and rename it to the next number. The game automatically assigns players to free numbers.

-----------------------------------------------------------------------------
5. MONETIZATION (DEV PRODUCTS & GAMEPASSES)
-----------------------------------------------------------------------------
- Go to ReplicatedStorage > Modules > ProductConfigurations.
- Update the IDs for your products:
  > Products (SkipRebirth, RandomItem, Spins, Cash Products)
  > GamePasses (VIP, StarterPack, ProPack)
  > LimitedItem (You can set the MaxStock, StockKey, and the specific Reward item here).

To adjust Daily Spin rewards:
- Go to ReplicatedStorage > Modules > DailySpinConfiguration.
- You can adjust the "Chance" (weights) and what Type of reward (Cash, Spins, Item) each slot gives.

-----------------------------------------------------------------------------
REMINDERS & TROUBLESHOOTING:
- EXACT MATCHING: Always ensure your 3D Model names perfectly match the string names inside your Configuration modules.
- PRIMARY PARTS: Item, Weight, and Tsunami models must have a PrimaryPart so the scripts know how to position and weld them to the player.
- UI NOT UPDATING: If a purchase button isn't showing a price, double-check that your ProductId in ProductConfigurations is correct and published to Roblox.
=============================================================================
]]