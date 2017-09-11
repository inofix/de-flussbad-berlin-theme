<#--
    popover.ftl: application display template for the language portlet.
    
    Created:    2017-09-11 23:20 by Christian Berndt
    Modified:   2017-09-11 23:20 by Christian Berndt
    Version:    1.0.0
-->

<#if entries?has_content>
    <span class="">
        <#list entries as curLanguage>
            <#if curLanguage.selected>
                <a class="dropdown-toggle" data-toggle="dropdown" role="menuitem">${curLanguage.shortDisplayName}</a>
            </#if>    
        </#list>
        <a class="dropdown-toggle" data-toggle="dropdown" role="menuitem"><span class="icon-angle-down"></span></a>    
        <ul class="dropdown-menu">
            <#list entries as curLanguage>
            
                <li>
                    <#if !curLanguage.isDisabled()>
                        <@liferay_aui["a"]
                            cssClass=""
                            href=curLanguage.getURL()
                            label=curLanguage.getShortDisplayName()
                            lang=curLanguage.getW3cLanguageId()
                        />
                    </#if>
                </li>
                
            </#list>
        </ul>
    </span>
</#if>