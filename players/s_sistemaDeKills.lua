addEventHandler('onPlayerLogin', root, function(old, logged)
    local kills = getAccountData(getPlayerAccount(source), 'kills')
    local death = getAccountData(getPlayerAccount(source), 'death')
    local points = getAccountData(getPlayerAccount(source), 'points')
    local cash = getAccountData(getPlayerAccount(source), 'cash')
    setElementData(source, 'kills', kills)
    setElementData(source, 'death', death)
    setElementData(source, 'points', points)
    setElementData(source, 'cash', cash)

end)

addEventHandler('onPlayerQuit', root, function(quitType, reason, responsavel)
    local kills = getElementData(source, 'kills')
    local deaths = getElementData(source, 'deaths')
    local points = getElementData(source, 'points')
    local cash = getElementData(source, 'cash')
    local conta = getPlayerAccount(source)

    setAccountData(conta, 'kills', kills)
    setAccountData(conta, 'deaths', deaths)
    setAccountData(conta, 'points', points)
    setAccountData(conta, 'cash', cash)

end)

addEventHandler('onPlayerLogout', root, function(Logada, new)
    local kills = getElementData(source, 'kills')
    local deaths = getElementData(source, 'deaths')
    local points = getElementData(source, 'points')
    local cash = getElementData(source, 'cash')

    setAccountData(Logada, 'kills', kills)
    setAccountData(Logada, 'deaths', deaths)
    setAccountData(Logada, 'points', points)
    setAccountData(Logada, 'cash', cash)
end)

addEventHandler('onResourceStop', getResourceRootElement(), function()
    local players = getElementsByType('player')

    for i, j in pairs(players) do
        local kills = getElementData(j, 'kills')
        local deaths = getElementData(j, 'deaths')
        local points = getElementData(j, 'points')
        local cash = getElementData(j, 'cash')
        local conta = getPlayerAccount(j)

        setAccountData(conta, 'kills', kills)
        setAccountData(conta, 'deaths', deaths)
        setAccountData(conta, 'points', points)
        setAccountData(conta, 'cash', cash)
    end

end)

local function pegarDados(source, comando, player)
    
    if player ~= nil and not isElement(getPlayerFromName(player)) then 
        outputChatBox('Check if the player name you type is online', source, 230, 30, 30)
        return 
    end

    if jogador == nil then
        local dados = getElementData(source, 'points')
        local dados2 = getElementData(source, 'kills')
        local dados3 = getElementData(source, 'death')
        local dados4 = getElementData(source, 'cash')
        outputChatBox('---------------'.. getPlayerName(source)..'---------------', source,30,230,30)
        outputChatBox(dados .. ' points', source)
        outputChatBox(dados2 .. ' kills', source)
        outputChatBox(dados3 .. ' death', source)
        outputChatBox(dados4 .. ' cash', source)
        outputChatBox('---------------------------------------------', source,30,230,30)
        return
    end
end

addCommandHandler('stats', pegarDados, false, false)



