 do
	local checker = pcall(function()
        games = game:HttpGet("https://raw.githubusercontent.com/LeGioNPsyQ/RBX/main/Games/" .. game.PlaceId .. ".lua")
    end)
    if checker then
        loadstring(games)()
    else
        game.StarterGui:SetCore("SendNotification", {
				Title = "[DevilNetWork X] Notify";
				Text = "Script is loaded";
				Duration = 10;
		})
		else
		game.StarterGui:SetCore("SendNotification", {
				Title = "[DevilNetWork X] Notify";
				Text = "Game not supported";
				Duration = 10;
		})
    end
end
