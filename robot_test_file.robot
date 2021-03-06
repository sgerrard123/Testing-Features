*** Settings ***
Suite Setup       Run keyword    Set Screenshot Directory    ScreenShots
#Suite Teardown  Run keywords    Close All Browsers
Resource          SPPortal_Lib.robot
Resource          ../POM.txt
Resource          ../Common.robot
Variables         SPPortal_Vars.py    # Variables
Variables         SPCreateAndView_Vars.py
*** Variables ***

*** Test Cases ***
RLTOQA-18324:Verify the Cancel Reason Code Drop Down Menu Values
    [documentation]    Regression
    [tags]    Regression
    Login To RialtoSp
    Navigate To Link    Find Orders
    Wait Until Page Is Loaded
    Input Text    //input[@name='companyName']    AutoCust2
    Navigate to Link    Lookup Order(s)
    Wait And Click Element    //table[@class='sortable']//tbody//tr[1]//td[1]
    Wait Until Page Is Loaded
    Wait And Click Element    //table[@class='basic-table']//*[text()='Cancel Order']
    sleep    2
    select window    title=Cancel Order
    Wait Until Element Is Enabled    ${sp_cancelreasonsel}
    Wait And Click Element    id=cancelReasonSel
    Sleep    ${min_sleep}
    ReasonForCancel   C:sdsasaa
    Sleep    ${min_sleep}
    select window    title=Service Provider Portal
    [Teardown]    Close Browser

RLTOQA-18325:Verify the Disconnect Reason Code Drop Down Menu Values
    [documentation]    Regression
    [tags]    Regression
    Login To RialtoSp
    Navigate To Link    Customer Service Tool
    Enter Input    companyName    AutomationCustomerFinal
    Wait And Click Element    //*[text()='Lookup Customer Info']
    Clicking And Verifying    //*[text()='(32761) AutoSipTrunking']    ${sp_cancelservice}    Disconnect Service Items
    Clicking And Verifying    id=cancelServiceItemsHref    //*[text()='Disconnect Order']    Disconnect Order
    Wait Until Element Is Enabled    id=orderDisconReasonCd
    Page Should Contain Element    ${sp_updatebillingaccount}
    Wait And Click Element    ${sp_orderdisconnectreason}
    Page Should Contain Element    //option[contains(text(),'Non-Pay')]
    ReasonForCancel
    select window    title=Service Provider Portal
    [Teardown]    Close Browser

RLTOQA-18333:Cancel an ADD Order
    [Documentation]    Regression
    [Tags]    Regression
    Login To RialtoSp
    CancelAnOrder    typeaddorder
    select window    title=Service Provider Portal
    [Teardown]    Close Browser

*** keywords ***
ListOrder
    [Arguments]    ${CustName}    ${SiteName}
    Navigate To Link    Create Quote
    Input Text    id=customerName    ${CustName}
    Wait And Click Element    //div[text()='${CustName}']
    Wait Until Element Is Visible    id=locationName
    Wait Until Element Is Enabled    id=locationName    100
    Input Text    id=locationName    ${SiteName}
    Wait And Click Element    //div[text()='${SiteName}']
    Wait And Click Element    ${sp_continue}
    Page Should Contain Element    //*[@id='cartUpdate']
    Wait Until Element Is Enabled    ${sp_basicstation}
    Input Text    ${sp_basicstation}    1
    Input Text    ${sp_commonareastation}    1
    Input Text    ${sp_standarduserstation}    1
    Input Text    ${sp_broadtouchmobile}    5
    Input Text    ${sp_broadtouchpc}    10
    #Wait And Click Element    ${sp_Custom}
    #Input Text    ${sp_customergeneric}    1
    Wait And Click Element    ${sp_continue}
    Page Should Contain Element    //*[@id='cartUpdate']
    Input Text    ${sp_quantityat-pc-vvx}    10
    Input Text    ${sp_quantityat-pc-vvxp}    c:khjhh
    sleep    10
    Wait And Click Element    ${sp_continue}

CancelOrder
    Wait And Click Element    ${sp_cancelorder}
    Wait Until Element Is Enabled    ${sp_cancelorder}
    Select Window    title=Cancel Order
    Wait And Click Element    ${sp_cancelreasonsel}
    Wait And Click Element    ${sp_competition-features}
    Wait And Click Element    ${sp_yes}

ReasonForCancel
    Page Should Contain Element    //option[contains(text(),'Competition - Features')]
    Page Should Contain Element    //option[contains(text(),'Competition - Pricing')]
    Page Should Contain Element    //option[contains(text(),'Fix Error - Customer')]
    Page Should Contain Element    //option[contains(text(),'Fix Error - Sales')]
    Page Should Contain Element    //option[contains(text(),'Internet Inadequate')]
    Page Should Contain Element    //option[contains(text(),'No Longer Needed')]
    Page Should Contain Element    //option[contains(text(),'Not as Expected - Features')]
    Page Should Contain Element    //option[contains(text(),'Not as Expected - Pricing')]
    Page Should Contain Element    //option[contains(text(),'Not as Expected - Quality')]
    Page Should Contain Element    //option[contains(text(),'Not as Expected - Usability')]

CancelAnOrder
    [Arguments]    ${TypeOfOrder}
    Navigate to Link    Order List
    Checkbox Should Not Be Selected    //*[@name='typeall']
    Wait And Click Element    //*[@name='typeall']
    Checkbox Should Be Selected    //*[@name='typeall']
    Wait And Click Element    //*[@name='typeall']
    Wait And Click Element    //*[@name='${TypeOfOrder}']
    Wait And Click Element    //*[@name='viewall']
    Wait And Click Element    //input[@name='viewcompleted']
    Wait And Click Element    //input[@name='viewcancelled']
    Wait And Click Element    //*[text()='Find']
    Wait And Click Element    //table[@id='colorCheatSheet']/tbody/tr[1]/td[4]/a
    Wait And Click Element    ${sp_cancelorder}
    Sleep    10
    Select Window    title=Cancel Order
    Wait Until Element Is Enabled    ${sp_cancelreasonsel}
    Wait And Click Element    ${sp_cancelreasonsel}
    ReasonForCancel
