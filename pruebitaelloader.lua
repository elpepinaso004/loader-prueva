nextCorner.Parent = nextButton

local pageLabel = Instance.new("TextLabel")
pageLabel.Size = UDim2.new(0.1, 0, 1, 0)
pageLabel.Position = UDim2.new(0.45, 0, 0, 0)
pageLabel.BackgroundTransparency = 1
pageLabel.Text = "1/1"
pageLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
pageLabel.TextScaled = true
pageLabel.Font = Enum.Font.Gotham
pageLabel.Parent = navFrame

prevButton.MouseButton1Click:Connect(function()
    if currentPage > 1 then
        currentPage = currentPage - 1
        UpdatePage()
        pageLabel.Text = currentPage .. "/" .. math.ceil(#allButtons / scriptsPerPage)
    end
end)

nextButton.MouseButton1Click:Connect(function()
    local maxPage = math.ceil(#allButtons / scriptsPerPage)
    if currentPage < maxPage then
        currentPage = currentPage + 1
        UpdatePage()
        pageLabel.Text = currentPage .. "/" .. maxPage
    end
end)

CreateButton("SpeedHub", function()
    print("oh yeah el script se ejecuto osi osi")
   loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
end)

CreateButton("God Mode", function()
    print("God Mode activado")
    -- Pon aquí tu código
end)

CreateButton("Infinite Jump", function()
    print("Infinite Jump activado")
    -- Pon aquí tu código
end)

CreateButton("No Clip", function()
    print("No Clip activado")
    -- Pon aquí tu código
end)

CreateButton("Teleport to Spawn", function()
    print("Teletransportado")
    -- Pon aquí tu código
end)

CreateButton("ESP Players", function()
    print("ESP activado")
    -- Pon aquí tu código
end)

CreateButton("Auto Farm", function()
    print("Auto Farm activado")
    -- Pon aquí tu código
end)

CreateButton("Fly", function()
    print("Fly activado")
    -- Pon aquí tu código
end)

-- Inicializar
UpdatePage()
pageLabel.Text = "1/" .. math.ceil(#allButtons / scriptsPerPage)
```