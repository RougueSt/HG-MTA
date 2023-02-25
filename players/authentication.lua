local MINIMUN_PASSWORD_LENGHT = 6

local function isPasswordValid(password)
    return string.len(password) >= MINIMUN_PASSWORD_LENGHT
end

addEvent('auth:register-attempt', true)
addEventHandler('auth:register-attempt', root, function (username, password)
    if not username or not password then
        return outputChatBox("SYNTAX "..comando.." [usuario] [senha]", source, 200,20,20)
    end

    if getAccount(username) then
        return outputChatBox("Usuario ja existe!",source, 255,100,100)
    end

    if not isPasswordValid(password) then
        return outputChatBox("Senha não é valida!",source, 255,100,100)
    end

    passwordHash(password, 'bcrypt', {}, function (hashedPassword)
        local account = addAccount(username,hashedPassword)
        setAccountData(account,'hashed_password',hashedPassword)
        setAccountData(account, 'password', password)
        setAccountData(account, 'kills', 0)
        setAccountData(account, 'death', 0)
        setAccountData(account, 'points', 0)
        setAccountData(account, 'cash', 0)
    end)


end)

addEvent('auth:login-attempt',true)
addEventHandler('auth:login-attempt', root, function (username, password)

    local account = getAccount(username)
    if not account then 
        return outputChatBox("Conta não existente ou senha errada", source, 255,100,100)
    end

    local hashedPasword =  getAccountData(account, 'hashed_password')
    local player = source
    passwordVerify(password, hashedPasword, function (isValid)
        if not isValid then 
            return outputChatBox("Conta não existente ou senha errada", player, 255,100,100)
        end

        if logIn(player, account, hashedPasword) then 
            spawnPlayer(player, 203.3330078125, 1889.501953125, 17.648057937622) -- SPAWN DO LOBBY 
            setCameraTarget(player, player)
            local kills = getAccountData(getPlayerAccount(player), 'kills')
            local death = getAccountData(getPlayerAccount(player), 'death')
            local points = getAccountData(getPlayerAccount(player), 'points')
            local cash = getAccountData(getPlayerAccount(player), 'cash')
            if not kills and not death and not points and not cash then
                setAccountData(account, 'kills', 0)
                setAccountData(account, 'death', 0)
                setAccountData(account, 'points', 0)
                setAccountData(account, 'cash', 0)
            end
            
            return triggerClientEvent('login-menu:close',player)
        end

    return outputChatBox("Ocorreu um erro não indentificado, contate um ADMIN",player, 255,100,100)
end)
end)



addEventHandler('onResourceStop',getResourceRootElement(), function()
    local players = getElementsByType('player')
    for i,j in pairs(players) do 
        logOut(j)
    end
end)