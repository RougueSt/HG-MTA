local janela = {}

local function getWindowPosition(width, height)
    local screenWidth, screenHeight = guiGetScreenSize()
    local x = (screenWidth / 2) - (width / 2)
    local y = (screenHeight / 2) - (height / 2)

    return x, y, width, height
end

local function isUsernameValid(username)
    return type(username) == 'string' and string.len(username) > 1
end

local function isPasswordValid(password)
    return type(password) == 'string' and string.len(password) > 1
end


addEventHandler('onClientResourceStart', getResourceRootElement(getThisResource()), function()
    triggerEvent('login-menu:open', localPlayer)
end)

addEvent('login-menu:open', true)
addEventHandler('login-menu:open', root, function()
    local screenW, screenH = guiGetScreenSize()
    setCameraMatrix(0, 0, 100, 0 ,100, 50)
    fadeCamera(true)

    


    showCursor(true, true)

    guiSetInputMode('no_binds')



    local x, y, width, height = getWindowPosition(600,600)
    janela['window'] = guiCreateWindow((screenW - 803) / 2, (screenH - 698) / 2, 803, 698, "LOGIN", false)
    guiWindowSetMovable(janela['window'],false)
    guiWindowSetSizable(janela['window'],false)

    janela['usernameLabel'] = guiCreateLabel(30, 50, 570, 20, "Usuario: ", false, janela['window'])
    janela['erroUsername'] = guiCreateLabel(18, 250, 570, 20, "", false, janela['window'])
    janela['usernameInput'] = guiCreateEdit(30, 74, 234, 30, "", false, janela['window'])

        
    janela['passwordLabel'] = guiCreateLabel(30, 120, 570, 20, "senha: ", false, janela['window'])
    janela['erroSenha'] = guiCreateLabel(18, 265, 570, 20, "", false, janela['window'])
    janela['passwordInput'] = guiCreateEdit(30, 140, 234, 29, "", false, janela['window'])
    janela['salvarSenha'] = guiCreateCheckBox(30, 175, 150, 15, "Salvar usuário e senha", true, false, janela['window'])
    janela['noticia'] = guiCreateMemo(17, 302, 250, 367, "NOTICIAS E NOVIDADES CARALHA:\n\nSEGUE AS NOVIDADES DE HOJE", false, janela['window'])
    guiEditSetMasked(janela['passwordInput'], true)

    if fileExists(':players/username.xml') then 
        local xml = xmlLoadFile(':players/username.xml')
        if xmlNodeGetAttribute(xml, 'checkBox') == 'true' then
            guiSetText(janela['usernameInput'], xmlNodeGetAttribute(xml, 'username'))
            guiSetText(janela['passwordInput'], xmlNodeGetAttribute(xml, 'password'))
            guiCheckBoxSetSelected(janela['salvarSenha'], true)
        end
    end

    janela['registerButton'] = guiCreateButton(148, 205, 119, 50, "Register", false, janela['window'])
    addEventHandler('onClientGUIClick', janela['registerButton'], function(button, state)
        if button ~= 'left' or state ~= 'up' then
            return 
        end

        local username = guiGetText(janela['usernameInput'])
        local password = guiGetText(janela['passwordInput'])
        local inputValid = true

        if not isUsernameValid(username) then 
            guiSetText(janela['erroUsername'], 'Alguma coisa errada com o Usuario')
            guiLabelSetColor(janela['erroUsername'], 255,0,0)
            inputValid = false
        else
            guiSetVisible(janela['erroUsername'],false)
        end

        if not isPasswordValid(password) then  
            guiSetText(janela['erroSenha'], 'Alguma coisa errada com a Senha')
            guiLabelSetColor(janela['erroSenha'], 255,0,0)
            inputValid = false
        else
            guiSetVisible(janela['erroSenha'],false)
        end

        if not inputValid then
            return
        end

        triggerServerEvent('auth:register-attempt', localPlayer, username, password)
    end, false)






    janela['loginButton'] = guiCreateButton(30, 205, 108, 50, "Login", false, janela['window'])
    addEventHandler('onClientGUIClick',janela['loginButton'], function(button, state)
        if button ~= 'left' or state ~= 'up' then
            return 
        end

        local username = guiGetText(janela['usernameInput'])
        local password = guiGetText(janela['passwordInput'])
        local inputValid = true

        if not isUsernameValid(username) then 
            guiSetText(janela['erroUsername'], 'Alguma coisa errada com o Usuario')
            guiLabelSetColor(janela['erroUsername'], 255,0,0)
            inputValid = false
        else
            guiSetVisible(janela['erroUsername'],false)
        end

        if not isPasswordValid(password) then  
            guiSetText(janela['erroSenha'], 'Alguma coisa errada com a Senha')
            guiLabelSetColor(janela['erroSenha'], 255,0,0)
            inputValid = false
        else
            guiSetVisible(janela['erroSenha'],false)
        end

        if not inputValid then
            return
        end
        if guiCheckBoxGetSelected(janela['salvarSenha']) then
            if not fileExists(':players/username.xml') then
                local xml = xmlCreateFile(':players/username.xml', 'login')
                xmlNodeSetAttribute(xml, 'username', username)
                xmlNodeSetAttribute(xml, 'password', password)
                xmlNodeSetAttribute(xml, 'checkBox', 'true')
                xmlSaveFile(xml)
            else
                local xml = xmlLoadFile(':players/username.xml', false)
                xmlNodeSetAttribute(xml, 'username', username)
                xmlNodeSetAttribute(xml, 'password', password)
                xmlNodeSetAttribute(xml, 'checkBox', 'true')
                xmlSaveFile(xml)
            end
        else
            if fileExists(':players/username.xml') then 
                local xml = xmlLoadFile(':players/username.xml', false)
                xmlNodeSetAttribute(xml, 'username', '')
                xmlNodeSetAttribute(xml, 'password', '')
                xmlNodeSetAttribute(xml, 'checkBox', 'false')
                xmlSaveFile(xml)
            end

        end
        

        triggerServerEvent('auth:login-attempt', localPlayer, username, password)
    end, false)



    janela['imagem'] = guiCreateStaticImage(298, 30, 495, 658, "pablo.png", false, janela['window'])

end, true)

addEvent('login-menu:close', true)
addEventHandler('login-menu:close',localPlayer, function()
    destroyElement(janela['window'])
    showCursor(false)
    guiSetInputMode('allow_binds')
end)



addEventHandler('onClientRender',root, function()
    setTime(0,0)
end)