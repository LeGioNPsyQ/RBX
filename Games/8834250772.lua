--[[
	#########################################################################################################################
	#### 	VARIABLES
	#########################################################################################################################
]]
--[[
	##	GLOBALS 
]]
getgenv().Toggle = false
getgenv().EggHatch = false
getgenv().AC = false 

--##	 EGG
_EggDELCommon = false
_EggDELUncommon = false
_EggDELEpic = false
_EggDELLegendary = false
--[[
	##	TIMER
]]
local RebirthTimer = "5"
local HatchTimer = "5"
--[[
	##	GUI LOAD LOCAL
]]
local Player, Rayfield, Click, comma, Notify, CreateWindow, CurrentVersion, CreateToggle = loadstring(game:HttpGet("https://raw.githubusercontent.com/LeGioNPsyQ/LeGioN-Hub/main/Variables/Vari.lua"))()
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/LeGioNPsyQ/OrionLib/main/OrionLib.lua'))()
local emoji = loadstring(game:HttpGet('https://raw.githubusercontent.com/LeGioNPsyQ/OrionLib/main/Icons.lua'))()
local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = game:GetService("Players").LocalPlayer or game:GetService("Players").PlayerAdded:Wait()
local VCurrentVersion
local function CurrentVersion(v)
	if v then VCurrentVersion = v end
end
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
CurrentVersion("v1.0")
local Name = game.Players.LocalPlayer.Name
local P = game:GetService'Players'
local HRP = P.LocalPlayer.Character.HumanoidRootPart
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[[
	##	ABFRAGEN
]]
__AREAS = {"Spawn","Desert","Snow","Youtube","Lava","Ocean","Void","Dino","Cyber","Beach","Graveyard"}
__EGGS = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"}
--[[
	##	WINDOW 
]]
local Window = OrionLib:MakeWindow({
	Name = GameName.." [😈 ÐN "..VCurrentVersion.."]",
	LoadingTitle = "DevilNetWork",
	LoadingSubtitle = "by LeGioN_PsyQ",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "DevilNetWork Orion", 
		FileName = game.PlaceId.."-"..Player.Name
	},

})
--[[
	##	TAB SECTION 
]]
local Main = Window:MakeTab({Name = "Main",Icon = "rbxassetid://7733765398",PremiumOnly = false})
local Pets = Window:MakeTab({Name = "Pets",Icon = "rbxassetid://8997385940",PremiumOnly = false})
-- local Rebirth = Window:MakeTab({Name = "Rebirth",Icon = "rbxassetid://7733942651",PremiumOnly = false})
-- local Teleport = Window:MakeTab({Name = "Teleport",Icon = "rbxassetid://7733954760",PremiumOnly = false})
-- local Keybinds = Window:MakeTab({Name = "Keybinds",Icon = "rbxassetid://4483345998",PremiumOnly = false})
-- local Misc = Window:MakeTab({Name = "Misc",Icon = "rbxassetid://4515645493",PremiumOnly = false})
local Credits = Window:MakeTab({Name = "Credits",Icon = "rbxassetid://4503342956",PremiumOnly = false})
local mr = game.Players.LocalPlayer.Character.HumanoidRootPart

--[[
	##	Auto Farm
]]
Main:AddSection({Name = "Auto Farm"})
Main:AddDropdown({
	Name = "Auto Farm Area",
	Options = __AREAS,
	CurrentOption = "--",
	Callback = function(value)
		_AreaSelected = value
	end,
})
Main:AddSlider({
	Name = "Auto Farm Interval",
	Min = 0.1,
	Max = 10,
	Default = 5,
	Increment = 0.1,
	ValueName = "Speed",
	Color = Color3.fromRGB(255, 100, 150),
	Flag = "SPD",
	Callback = function(Value)
		FarmInterval = Value
	end
})
Main:AddToggle({
	Name = "⭐ Auto Farm",
	CurrentValue = false,
	Flags = "AutoFarm",
	Callback = function(bool)
		getgenv().Toggle = bool
		if bool then
			AutoFarm()
		end
	end,
})
function AutoFarm()
	while Toggle == true do
		if not getgenv then break end
		for i,v in pairs(game:GetService("Workspace")["__AREAS"][_AreaSelected]:GetDescendants()) do
			if v.ClassName == "MeshPart" then
				-- if v.Health.Value < _G.Hp then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
					wait(FarmInterval)
				-- end
			end
		end
	end
end

Main:AddSection({Name = "Auto Chest Claim"})
Main:AddToggle({
	Name = "⭐ Auto Chest",
	CurrentValue = false,
	Flags = "AutoChest",
	Callback = function(bool)
		getgenv().AC = bool
		if bool then
			AChest()
		end
	end,
})
function AChest()
    while AC == true do 
        if not getgenv then break end 
            for i,v in pairs(game.Workspace.__CHEST:GetChildren()) do
                if v:IsA("Touch") then
                local transmitter = v:FindFirstChild("TouchTransmitter") 
                firetouchinterest(mr, v, 0)
                firetouchinterest(mr, v, 1)
                print("Chest Collected..")
                wait(100)
            end
        end
    end
end

Main:AddSection({Name = "Anti Report"})
Main:AddParagraph("Anti-Report", "Changes your Avatar")
Main:AddButton({
	Name = "Anti Report",
	Callback = function()
		Notify("Anti-Report is Enabled","Your Avatar is Black")
		for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if v.ClassName == "BillboardGui" or v.ClassName == "Accessory" or v.ClassName == "Pants" or v.ClassName == "Decal" or v.ClassName == "Shirt" then
				wait()
				v:Destroy()
			end
		end 
	end
})

--[[
	#### PETS
]]
Pets:AddParagraph("Hacth Info","You must be near the Egg")
Pets:AddDropdown({
	Name = "Egg",
	Options = __EGGS,
	CurrentOption = "--",
	Callback = function(value)
		_EggSelected = value
	end,
})
Pets:AddDropdown({
	Name = "Egg Amount",
	Options = {1,3},
	CurrentOption = "--",
	Flag = "EggAmount",
	Callback = function(value)
		_EggAmount = value
	end,
})
Pets:AddSlider({
	Name = "Auto Hatch Interval",
	Min = 2,
	Max = 10,
	Default = 5,
	Increment = 1,
	ValueName = "Hatch Speed",
	Color = Color3.fromRGB(255, 100, 150),
	Flag = "HSPD",
	Callback = function(Value)
		HatchInterval = Value
	end
})
Pets:AddToggle({
	Name = "Auto Hatch",
	CurrentValue = false,
	Flag = "AHatch",
	Callback = function(bool)
		getgenv().EggHatch = bool
		if bool then 
			EggA()
		end
	end,
})
Pets:AddSection({Name = "Auto Delete"})
Pets:AddToggle({Name = "Common",CurrentValue = false,Callback = function(bool)	if bool then _EggDELUnCommon = true else _EggDELCommon = false end end,	})
Pets:AddToggle({Name = "Uncommon",CurrentValue = false,Callback = function(bool)	_EggDELUncommon = true	 else _EggDELUncommon = false	end end,})
Pets:AddToggle({Name = "Epic",CurrentValue = false,Callback = function(bool)	_EggDELEpic = true	else _EggDELEpic = false end	end,})
Pets:AddToggle({Name = "Legendary",CurrentValue = false,Callback = function(bool)	_EggDELLegendary = true	else _EggDELLegendary = false end end,})
function EggA()
    while EggHatch == true do 
        if not getgenv then break end 
		local args = {
			[1] = _EggAmount,
			[2] = _EggSelected,
			[3] = _EggDELCommon,
			[4] = _EggDELUncommon,
			[5] = _EggDELEpic,
			[6] = _EggDELLegendary
		}
		game:GetService("ReplicatedStorage").__REMOTES.__Buy_EGG:FireServer(unpack(args))
		wait(HatchInterval)
    end
end
--[[
Main:AddToggle({
	Name = "🎁 Auto Airdrop",
	Value = false,
	Flags = "AutoAirdrop",
	Callback = function()
		getgenv().AC = bool
		if bool then
			Airdrop()
		end
	end,
})
function Airdrop()
	while AC == true do 
		if not getgenv then break end 
		game:GetService("ReplicatedStorage").GameClient.Events.RemoteEvent["Airdrop Pickup"]
	end
end
]]
--#########################################################################################################
--##	PETS
--#########################################################################################################
-- Pets:AddSection({Name = "Auto Eggs"})

-- local eggLocation = {
	-- ["Basic Egg"] = Vector3.new(797, 887, 110),
	-- ["Wild Egg"] = Vector3.new(820, 887, 104),
	-- ["Galactic Egg (SPAWN)"] = Vector3.new(838.312, 891.717, 124.254),
	-- ["Snowfall Egg"] = Vector3.new(814, 887, -155),
	-- ["Beachball Egg"] = Vector3.new(1094, 889, -344),
	-- ["Sunshine Egg"] = Vector3.new(1095, 889, -333),
	-- ["Pail Egg"] = Vector3.new(1083, 889, -331),
	-- ["Ninja Egg"] = Vector3.new(1216, 887, -687),
	-- ["Glacier Egg"] = Vector3.new(808, 887, -144),
	-- ["Yokai Egg"] = Vector3.new(1233, 887, -706),
	-- ["Busy City Egg"] = Vector3.new(1560, 887, -842),
	-- ["Technology Egg"] = Vector3.new(1578, 888, -854),
	-- ["Village Egg"] = Vector3.new(1731, 888, -1239),
	-- ["Queen's Jewel Egg"] = Vector3.new(1743, 887, -1259),
	-- ["UFO Egg"] = Vector3.new(1660, 888, -1629),
	-- ["Futuristic Egg"] = Vector3.new(1659, 888, -1645),
	-- ["Leprachaun Egg"] = Vector3.new(1672, 887, -1695),
	-- ["Clockwork Egg"] = Vector3.new(1412.24, 891.128, -1823.75),
	-- ["Gingerbread Egg"] = Vector3.new(1225.36, 890.482, -2280.11),
	-- ["Whipped Kitty Egg"] = Vector3.new(1230.54, 890.598, -2254.28),
	-- ["Galactic Egg"] = Vector3.new(1069, 880, -2370),
	-- [""] = Vector3.new(),
	-- [""] = Vector3.new(),
	-- [""] = Vector3.new(),
-- }
-- local selectedEggPosition = eggLocation["Basic Egg"]
-- local selectedEgg
-- Pets:AddDropdown({
   -- Name = "Choose Egg",
   -- Options = {"Basic Egg","Wild Egg","Galactic Egg (Spawn)","Snowfall Egg","Glacier Egg","Beachball Egg","Sunshine Egg","Pail Egg","Ninja Egg","Yokai Egg","Busy City Egg","Technology Egg","Queen's Jewel Egg","Village Egg","UFO Egg","Futuristic Egg","Leprachaun Egg","Galactic Egg"},
   -- CurrentOption = "--",
   -- Callback = function(value)
    -- selectedEgg = value
    -- selectedEggPosition = eggLocation[value] 
   -- end,
-- })
-- Pets:AddDropdown({
	-- Name = "🔢 Select Amount",
	-- Options = {"1","3","8"},
	-- Option = "1",
	-- Flag = "EggAmount",
	-- Callback = function(value)
	-- if value == "1" then
		-- EggAmount = string.gsub(value,"1","Buy1")
	-- elseif value == "3" then
		-- EggAmount = string.gsub(value,"3","Buy3")
	-- elseif value == "8"
		-- then EggAmount = string.gsub(value,"8","Buy8")
	-- end
-- end,
-- })
  
-- function openE()
	-- mr.CFrame = CFrame.new(selectedEggPosition)
	-- while OE == true do if not getgenv() then break end
	-- local args = {
		-- [1] = selectedEgg,
		-- [2] = EggAmount,
	-- }
		-- game:GetService("ReplicatedStorage"):WaitForChild("GameClient"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("BuyEgg"):InvokeServer(unpack(args))     
		-- game:GetService("ReplicatedStorage"):WaitForChild("Marchy"):WaitForChild("PetRemotes"):WaitForChild("Generic"):WaitForChild("CraftAll"):FireServer()
		-- wait(HatchTimer)
	-- end
-- end

-- Pets:AddToggle({
    -- Name = "Auto Open Selected Egg (Stay Close)",
    -- CurrentValue = false,
    -- Callback = function(bool)
     -- getgenv().OE = bool
     -- if bool then
         -- openE()
     -- end
    -- end,
 -- })
-- Pets:AddToggle({
	-- Name = "🛠️ Auto Craft",
	-- CurrentValue = false,
	-- Callback = function(bool)
		-- getgenv().CA = bool
		-- if bool then
			-- openCA()
		-- end
	-- end,
-- })
-- function openCA()
	-- while CA == true do if not getgenv() then break end
		-- game:GetService("ReplicatedStorage"):WaitForChild("Marchy"):WaitForChild("PetRemotes"):WaitForChild("Generic"):WaitForChild("CraftAll"):FireServer() wait(0.5)
	-- end
-- end

-- Pets:AddToggle({
	-- Name = "🏆 Auto Equip Best",
	-- CurrentValue = false,
	-- Callback = function(bool)
		-- getgenv().EB = bool
		-- if bool then
			-- openEB()
		-- end
	-- end,
-- })
-- function openEB()
	-- while EB == true do if not getgenv() then break end
        -- game:GetService("ReplicatedStorage"):WaitForChild("Marchy"):WaitForChild("PetRemotes"):WaitForChild("Generic"):WaitForChild("EquipBest"):FireServer()   
	-- end
-- end
-- ################################################################################################################################################


-- ##	Auto Rebirth
-- local SetRebirth
-- Rebirth:AddSection({Name = "Rebirth"})
-- Rebirth:AddDropdown({
	-- Name = "🔢 Rebirth",
	-- Options = Rebirths,
	-- Default = "33",
	-- Flag = "Rebirths",
	-- Callback = function(value)
		-- SetRebirth = value
	-- end,
-- })	
-- Rebirth:AddToggle({
	-- Name = "🔁 Auto Rebirth",
	-- CurrentValue = false,
	-- Default = false,
	-- Callback = function(bool)
		-- getgenv().DR = bool
		-- if bool then
			-- doR()
		-- end
	-- end,
 -- })
-- function doR()
    -- while DR == true do
      -- if not getgenv then break end
	-- local args = SetRebirth
	-- game:GetService("ReplicatedStorage").Events.Rebirth:FireServer(SetRebirth)
      -- wait(0)        
    -- end
-- end
-- Rebirth:AddButton({
	-- Name = "Remove Alert",
	-- Callback = function()
		-- for _, players in pairs(game:GetService("Players"):GetChildren()) do -- Get the players
			-- players.PlayerGui.AlertUI:Destroy() -- Destroy the Guis
		-- end
		-- game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
	-- end,
 -- })
 --[[
-- Main:AddButton({
	-- Name = "Kill All (Requires Hex Spitter)",
	-- Callback = function()
		-- local HexSpitter = P.LocalPlayer.Character.HexSpitter
		-- local ServerControl = HexSpitter.Remotes.ServerControl
		-- for _ = 1,20 do
			-- for _, Child in next, game.Players:GetPlayers() do
				-- if Child ~= game.Players.LocalPlayer then
					-- ServerControl:InvokeServer('RayHit', {['Position'] = Vector3.new(0, 0, 0), ["Hit"] = Child.Character.Head})
				-- end
			-- end
		-- end
	-- OrionLib:MakeNotification({
		-- Name = "GUI",
		-- Content = "Killed everyone ;)",
		-- Image = "rbxassetid://4483345998",
		-- Time = 3
	-- })
	-- end    
-- })
-- ]]

---//MISC
Misc:AddSlider({
	Name = "Walkspeed",
	Min = 0,
	Max = 500,
	Default = 40,
	Increment = 1,
	ValueName = "Walkspeed",
    Color = Color3.fromRGB(63, 198, 255),
	Callback = function(Value)
		game:GetService('Workspace')[Name].Humanoid.WalkSpeed = Value
	end
})
Misc:AddSlider({
	Name = "JumpPower",
	Min = 0,
	Max = 500,
	Default = 50,
	Increment = 1,
	ValueName = "JumpPower",
    Color = Color3.fromRGB(31, 255, 23),
	Callback = function(Value)
		game:GetService('Workspace')[Name].Humanoid.JumpPower = Value
	end 
})
Misc:AddSlider({
	Name = "HipHeight",
	Min = 3,
	Max = 500,
	Default = 0,
	Increment = 1,
	ValueName = "HipHeight",
    Color = Color3.fromRGB(253, 17, 17),
	Callback = function(Value)
		game:GetService('Workspace')[Name].Humanoid.HipHeight = Value
	end
})
Misc:AddSlider({
	Name = "Gravity",
	Min = 0,
	Max = 500,
	Default = 200,
	Increment = 1,
	ValueName = "Gravity",
    Color = Color3.fromRGB(242, 249, 148),
	Callback = function(Value)
		workspace.Gravity = Value
	end
})
Misc:AddTextbox({
	Name = "Teleport to player",
	Default = "Player Name",
	TextDisappear = true,
	Callback = function(Value)
        local function TPToPlayer()
            HRP.CFrame = workspace[Value].HumanoidRootPart.CFrame
        end
        TPToPlayer()
	end	  
})
Misc:AddButton({
	Name = "Teleport to VoidBlock",
	Callback = function()
        local function GetNiggered()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.CenterBlocks.Givers.VoidGiver.GUI.CFrame
        end
        GetNiggered()
	end
})
Misc:AddButton({
	Name = "Teleport to Safe spot",
	Callback = function()
        local function Cute()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Wedge.CFrame
        end
        Cute()
	end
})
Misc:AddButton({
	Name = "Teleport to Base",
	Callback = function()
		local function Run()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Spawn.Value
		end
		Run()
	end
})
Misc:AddButton({
	Name = "Delete Trees",
	Callback = function()
        for _, Tree in next, game.Workspace:GetChildren() do
            if Tree.Name == 'Tree' then
                Tree:Destroy()
            end
        end
	end
})
--[[
---//Keybinds
Keybinds:AddBind({
	Name = "Lucky Block",
	Default = Enum.KeyCode.Q,
	Callback = function()
		ReplicatedStorage.SpawnLuckyBlock:FireServer()
	end    
})
Keybinds:AddBind({
	Name = "Super Block",
	Default = Enum.KeyCode.E,
	Callback = function()
		ReplicatedStorage.SpawnSuperBlock:FireServer()
	end    
})
Keybinds:AddBind({
	Name = "Diamond Block",
	Default = Enum.KeyCode.R,
	Callback = function()
		ReplicatedStorage.SpawnDiamondBlock:FireServer()
	end    
})
Keybinds:AddBind({
	Name = "Rainbow Block",
	Default = Enum.KeyCode.T,
	Callback = function()
		ReplicatedStorage.SpawnRainbowBlock:FireServer()
	end    
})
Keybinds:AddBind({
	Name = "Galaxy Block",
	Default = Enum.KeyCode.Y,
	Callback = function()
		ReplicatedStorage.SpawnGalaxyBlock:FireServer()
	end    
})
]]

---//Credits 
Credits:AddButton({
	Name = "💭 Copy link to Discord",
	icon = "rbxassetid://7733954760",
	Callback = function()
      	setclipboard('https://discord.gg/5Fy4H82TCq')
	end
})
Credits:AddLabel("Made by LeGioN_PsyQ#3114")
Credits:AddParagraph(
	"Information",
	"[😈 ÐN v1.0] = [😈 DevilNetWork v1.0]"
)
Credits:AddParagraph(
	"DevilNetWork v1.0",
	"Is a Script from Testiing on LUA-Codiung	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 		 	 	 	 	 	 DevilNetWork Owner © LeGioN_PsyQ"
)
Credits:AddParagraph("Paragraph","Paragraph Content")


OrionLib:MakeNotification({
	Name = "GUI",
	Content = "Successfully loaded GUI",
	Image = "rbxassetid://4483345998",
	Time = 5
})
OrionLib:MakeNotification({
	Name = "GUI",
	Content = "Copied link to the Discord server!",
	Image = "rbxassetid://4483345998",
	Time = 5
})
OrionLib:Init()