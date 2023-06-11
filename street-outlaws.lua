local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("KeemBandz Street Outlaws GUI", "Ocean")

-- MONEY
local Main = Window:NewTab("Money")
local MainSection = Main:NewSection("Money")

local userInputMoney = 0

MainSection:NewTextBox("Enter Money", "Type amount then click 'Add Money'", function(txt)
	local num = tonumber(txt)
	if num then
		userInputMoney = num
	else
		print("Invalid input, please enter a number.")
	end
end)

MainSection:NewButton("Add Money", "Give entered money", function()
	if userInputMoney > 0 then
		local args = {
			[1] = userInputMoney
		}
		game:GetService("ReplicatedStorage"):WaitForChild("WinningsAdd"):FireServer(unpack(args))
	else
		print("Please enter a valid amount of money.")
	end
end)

MainSection:NewButton("Remove Money", "Remove entered money", function()
	if userInputMoney > 0 then
		local args = {
			[1] = -userInputMoney 
		}
		game:GetService("ReplicatedStorage"):WaitForChild("WinningsAdd"):FireServer(unpack(args))
	else
		print("Please enter a valid amount of money.")
	end
end)


--SELF
	
local Main = Window:NewTab("Self")
local PlayerSection = Main:NewSection("Self")
    
PlayerSection:NewSlider("Walkspeed", "SPEED!!", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewButton("Reset WS", "Resets to default", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)
    
--DONATE

local Main = Window:NewTab("Donate")
local GiveSection = Main:NewSection("Give")

local donateAmount = 0 -- This variable will hold the value to donate

GiveSection:NewTextBox("Donation Amount", "Type the amount to donate", function(txt)
    local num = tonumber(txt)
    if num then
        donateAmount = num -- If the input is a valid number, store it in the variable
    else
        print("Invalid input, please enter a number.")
    end
end)

-- Create a button for each player currently in the game
for _, player in ipairs(game.Players:GetPlayers()) do
    GiveSection:NewButton("Donate to " .. player.Name, "Donate entered amount to " .. player.Name, function()
        if donateAmount > 0 then
            local args = {
                [1] = donateAmount, -- use this value to donate money
                [2] = player.UserId  -- use this UserId to specify the receiver
            }
            game:GetService("ReplicatedStorage"):WaitForChild("GiveDonation"):FireServer(unpack(args))
        else
            print("Please enter a valid amount of money.")
        end
    end)
end
