*** Settings ***
Library    Browser
Library    DocTest.VisualTest
Library    doctest.py
Library    OperatingSystem


*** Variables ***
${abdtotal}    https://viewer.optixone.com.br/pacs/viewers/optixDev/?id=10001034&cdi=1&H=37804772cc4d39fc44b038cc392a4d7f&SD=417e2ad06d0dd5b7872d4271d3b552fcb4787b72778f349af502969ecb0be5fe3c68f698163445ab84ae777ef25adb3e2240772837d3db7d9b4df31f7eb8b40fdae7f19ef3f93d3538acf90352398571ba098359e7a166b42bb74a62e13b26f62f5b08edd2398654c51ab046911035a8edbb7345243a9b85b916c9d99ae92db42c6f846f5aadb6d6f5f4cf423760f2dc&r=7538
${mama}    https://viewer.optixone.com.br/pacs/viewers/optixDev/?id=10001021&cdi=1&H=36947ad783829afc000fb6ed8a1a371e&SD=022c6714d0168a2bc32f78dd921a795bbd248ca7f9aa685db8159ef82d40d893191faf787d18788d1267771a1a4a130ab5b209af9b47b7e7927aa32ef2eaec2f9c05438fc3f4758cd10786889cae520498786ee6d99289c2434487b9d2cc802567b875e4036983c78ab1452eacf71eff633d3a835e1da31686d963f059f67a636a6c23de365c410c9f78c92d25b475f4&r=65618
${URLhml}    https://hml.optixone.com.br/pacs/viewers/optixDev/?id=10002019&cdi=54&H=4cd11a7a0e655639657b7996e9da0293&SD=d88338884773375111dc46f3955cf8ea2edc488c5df2b3522b6ded073470e3e39a67aab44c5f6d2666731574a7a3b1cb4c54955c8784503ebb44946cd378c284bb8bf9966711e37715d651cab65b5d3798c6beac9d2ff9138ac71b5e39c31f9d24f71c034483420c1065b2ad891ca9136915c9e13500decb9d40d57ed76457832b97bb1a3c8abb0a1df4c34999468793&r=28239
${URL}    https://viewer.optixone.com.br/pacs/viewers/optixDev/?id=10001048&cdi=1&H=f09cc268a73f2302651c4a6f57e23bc9&SD=94b415d6d6454844b9873dc167a69818402bba273acfe4cdab84ecc61dd50c16b771aa0d1c58eba35b53f6f6b07b601a22f4ea9796205ea9fe3e903643933be45185b1a6afc1b65b46378389176d2a6c97d0f7b144b26e7915ca04211c4675d594511376c2338d8eb23a0030f735acb87d531942ce5a1ff4e128c2c744fa1e7f76d1a6f0450e79b2320614a9edbe1257&r=31146
${URLrx}    https://viewer.optixone.com.br/pacs/viewers/optixDev/?id=10002019&cdi=54&H=4cd11a7a0e655639657b7996e9da0293&SD=d88338884773375111dc46f3955cf8ea2edc488c5df2b3522b6ded073470e3e39a67aab44c5f6d2666731574a7a3b1cb4c54955c8784503ebb44946cd378c284bb8bf9966711e37715d651cab65b5d3798c6beac9d2ff9138ac71b5e39c31f9d24f71c034483420c1065b2ad891ca9136915c9e13500decb9d40d57ed76457832b97bb1a3c8abb0a1df4c34999468793&r=28239
#${URL}    https://viewer.optixone.com.br/pacs/viewers/optixDev/?id=10002010&cdi=54&H=2067b79958f5d69f25b5d506b88cd48b&SD=a236326684ee6e764ed737836fe42652400d51790c8aada99c6cc64cd82589bb0f917da04b7ddbad08675480d7a7b04bf7f4d28ee3587ae8070047761946a64e5a91d90aefb57d6c02d11582579f3511512bbd6e1b59fcd260d7689401df329bdbd25f79897016f04175d0fe0d3d95a47cbd8fc53753ac25ece2b2619447999e685a28d766db0c74d4d339f527cd1a73&r=26889
${image1}    results/browser/screenshot/robotframework-browser-screenshot-1.png
${image2}    results/browser/screenshot/robotframework-browser-screenshot-2.png

*** Test Cases ***
Tirar info de memoria
    [Documentation]
    New Page    ${URL}
    Sleep    4
    Click    xpath=/html/body/header/div[1]/button[4]
    Click    xpath=/html/body/ul[7]/li[4]
    Click    xpath=/html/body/div[4]/table/tbody/tr[14]/td[2]/label[3]
    Click    xpath=/html/body/div[4]/table/tfoot/tr/td/button[2]
    Take Screenshot



*** Test Cases ***
Abrir Webviewer do PACS
    [Documentation]    Abre o Viewer e passa as series
    New Browser     browser=chromium    headless=False
    New Page    ${URL}
    Sleep    3
    #Wait For Elements State  css=canvas[class="noGl"]    timeout=50s
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Click    css=[name="nextSerie"]
    Sleep    2
    Take Screenshot
    Click    css=[name="nextSerie"]
    Sleep    2
     ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Janelamento
    [Documentation]    Aplicar  janelamento na imagem
    #New Browser    chromium    headless=False
    New Page    ${URLrx}
    Sleep    9
    Click    xpath=/html/body/i
    Sleep    1
    Mouse Move    x=574    y=455
    Mouse Button    down
    Mouse Move    x=598    y=225
    Mouse Button    up
    Sleep    1
    Take Screenshot
    New Page    ${URLhml}
    Sleep    9
    Click    xpath=/html/body/i
    Sleep    1
    Mouse Move    x=574    y=455
    Mouse Button    down
    Mouse Move    x=598    y=225
    Mouse Button    up
    Sleep    1
    Take Screenshot
    Compare Images    ${image1}    ${image2}    check_text_content=No



*** Test Cases ***
Medida e resetar
    [Documentation]    Aplicar medida na imagem

    New Page    ${URLrx}
    Sleep    2
    Click    xpath=/html/body/i
    Sleep    1
    Mouse Move    x=574    y=455
    Mouse Button    down    button=right
    Mouse Move    x=598    y=225
    Mouse Button    up
    Sleep    4
    Click    css=[class="ov-reply"]
    Sleep    2
    Take Screenshot
    New Page    ${URLhml}
    Sleep    2
    Click    xpath=/html/body/i
    Sleep    1
    Mouse Move    x=574    y=455
    Mouse Button    down    button=right
    Mouse Move    x=598    y=225
    Mouse Button    up
    Sleep    4
    Click    css=[class="ov-reply"]
    Sleep    2
    Take Screenshot
    Compare Images    ${image1}    ${image2}




*** Test Cases ***
Rotacionar Imagem para esquerda
    [Documentation]
    New Browser    chromium    False
    New Page    ${URL}
    Sleep    4
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Click    [class="ov-undo"]
    Take Screenshot
    ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Rotacionar imagem para a dirita
    [Documentation]
    New Page    ${URL}
    Sleep    4
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Click    [title="Rotacionar à direita (Shift + RIGHT)"]
    Take Screenshot
    ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Inverter cores
    [Documentation]
    New Page    ${URL}
    Sleep    4
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Click    [class="ov-adjust"]
    Take Screenshot
    ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Espelhamento Horizontal
    [Documentation]
    New Page    ${URL}
    Sleep    4
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Click    [class="ov-arrows-alt-h"]
    Take Screenshot
     ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Espelhamento Vertical
    [Documentation]
    New Page    ${URL}
    Sleep    4
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Click    [class="ov-arrows-alt-v"]
    Take Screenshot
    ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Grid 3x3
    [Documentation]
    New Page    ${URL}
    Sleep    4
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Click    [class="ov-table"]
    Click    [title="3 x 3"]
    Sleep    2
    Take Screenshot
    Sleep    3
    ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Atalhos
    [Documentation]
    New Page    ${URL}
    Sleep    4
    Click    xpath=/html/body/i
    Sleep    1
    Keyboard Key    press    Alt+S
    Take Screenshot
    Sleep    2
    Press keys    body    Escape
    Keyboard Key    press    Alt+D
    Take Screenshot
    Press Keys    body    Escape
    Keyboard Key    press    Alt+C
    Take Screenshot
    Sleep    2
    Press Keys    body    Escape
    Keyboard Key    press    Alt+G
    Take Screenshot



*** Test Cases ***
Exames Anteriores
    [Documentation]
    New Browser    chromium    headless=False
    New Page    ${URLrx}
    Sleep    7
    Take Screenshot
    Click    xpath=/html/body/div[1]/h3[2]/i
    Sleep    4
    Take Screenshot
    ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Prod vs Hom
    [Documentation]
    New Page    ${URLrx}
    Sleep    5
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Close Browser
    New Page    ${URLhml}
    Sleep    8
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Close Browser
    Compare Images    reference_image=${image1}    test_image=${image2}



*** Test Cases ***
MPR
    [Documentation]
    New Browser    chromium    headless=False
    New Page    ${URL}
    Sleep    4
    Take Screenshot
    Click    xpath=/html/body/header/button[22]/i[1]
    Sleep    50
    Take Screenshot


*** Test Cases ***
Linhas de referencia
    [Documentation]
    New Browser    chromium
    New Page    ${mama}
    Sleep    5
    Click    xpath=/html/body/i
    Sleep    1
    Click    [class="ov-table"]
    Click    [title="3 x 3"]
    Sleep    2
    Take Screenshot
    Click    xpath=/html/body/header/button[12]
    Take Screenshot
    Click    xpath=/html/body/header/button[12]
    ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Zoom
    [Documentation]

    New Page    ${URLrx}
    Sleep   4
    Click    xpath=/html/body/i
    Sleep    1
    Click    xpath=/html/body/header/button[11]/i
    Take Screenshot
    New Page    ${URLhml}
    Sleep   5
    Click    xpath=/html/body/i
    Sleep    1
    Click    xpath=/html/body/header/button[11]/i
    Take Screenshot
    Compare Images    ${image1}    ${image2}



*** Test Cases ***
Leitura Sincronizada
    [Documentation]
    New Browser    chromium    headless=False
    New Page    ${mama}
    Sleep    4
    Click    xpath=/html/body/i
    Sleep    1
    Click    xpath=/html/body/header/button[2]/i
    Click    xpath=/html/body/div[2]/span[19]
    Sleep    1
    Take Screenshot
    Mouse Move    x=574    y=455
    Mouse Button    down
    Mouse Move    x=598    y=225
    Mouse Button    up
    Click    xpath=/html/body/header/button[12]
    Take Screenshot
    ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail



*** Test Cases ***
Medida Eclipce
    [Documentation]
    New Page    ${URL}
    Sleep    4
    Click    xpath=/html/body/i
    Sleep    1
    Take Screenshot
    Mouse Move    x=574    y=455
    Mouse Button    button=middle    action=down
    Mouse Move    x=598    y=225
    Mouse Button    button=middle    action=up
    Take Screenshot
    ${status}=    Run Keyword And Return Status    Compare Images    reference_image=${image1}    test_image=${image2}
    Run Keyword If    ${status} == False    Pass Execution    Execution Passed: Status is False    ELSE    Fail


*** Test Cases ***
Teste Carregamento
    New Browser    chromium    headless=False
    New Page    ${abdtotal}
    ${time1}=    Get Time
    Wait For Elements State    text=Inicializando...
    Log    Element was on screen for ${Segundos} seconds.
    Close Browser





















