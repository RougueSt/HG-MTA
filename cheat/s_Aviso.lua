addEventHandler('onResourceStart', getResourceRootElement(getThisResource()), function()
    local jogadores = getElementsByType('Player')
    outputServerLog('\n\n\n\nMonitoramento de cheater LIGADO.')
    for i,j in ipairs(jogadores) do
        local conta = getAccountName(getPlayerAccount(j))
        if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
            outputChatBox('\n\n\n\nMonitoramento de cheater LIGADO.', j, 30, 229, 30)
            outputChatBox('Script desenvolvido para auxiliar staff, não leve ao pé da letra', j, 30, 230, 230)
            outputChatBox('Abriu e fechou na mensagens significam que suposto menu do cheater foi aberto ou fechado, fique atento a essas mensagens', j, 230, 30, 30)
        end
    end
end)

addEventHandler('onResourceStop', getResourceRootElement(getThisResource()), function()
    outputServerLog('\n\n\n\nMonitoramento de cheater DESLIGADO.')
    local jogadores = getElementsByType('Player')
    for i,j in ipairs(jogadores) do
        local conta = getAccountName(getPlayerAccount(j))
        if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
            outputChatBox('\n\n\n\nMonitoramento de cheater DESLIGADO.', j, 230, 30, 30)
            --outputChatBox('Script desenvolvido para auxiliar staff, não leve ao pé da letra\n\n\n', j, 30, 230, 230)
        end
    end

end)

addEvent('cheater:aviso',true)
addEventHandler('cheater:aviso',root, function(cheater, botao, status)
    
    local jogadores = getElementsByType('Player')
    for i,j in ipairs(jogadores) do
        local conta = getAccountName(getPlayerAccount(j))
        if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
            outputChatBox(getPlayerName(cheater) .. ' | Possível Cheat -- ' .. ' '.. status .. ' cheater | Serial: '.. getPlayerSerial(cheater), j, 243, 29, 227)
        end
    end
    outputServerLog(getPlayerName(cheater) .. ' | Possível Cheat -- ' .. ' '.. status .. ' cheater | Serial: '.. getPlayerSerial(cheater))
end)