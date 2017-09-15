<#--
    switch.ftl: append current search parameters to
    site-map links.
    
    Created:    2016-06-18 21:54 by Christian Berndt
    Modified:   2016-06-19 13:15 by Christian Berndt
    Version:    1.0.1
-->


<#assign original = portalUtil.getOriginalServletRequest(request) />
<#assign keywords = paramUtil.getString(original, "_3_keywords") />

<#if entries?has_content>
    <ul>
    <#list entries as curLayout>
    
        <#assign cssClass = "" />
        <#if curLayout.layoutId == layout.layoutId>
            <#assign cssClass = "current" />
        </#if>
        
        <#assign layoutURL = portalUtil.getLayoutURL(curLayout, themeDisplay) />
        <#if keywords?has_content>
            <#assign layoutURL = httpUtil.addParameter(layoutURL, "_3_keywords", keywords) />
            <#assign layoutURL = httpUtil.addParameter(layoutURL, "p_p_id", "3") />
            <#assign layoutURL = httpUtil.addParameter(layoutURL, "_3_struts_action", "/search/search") />
        </#if>
        
        <li><a href="${layoutURL}" class="${cssClass}">${curLayout.getName(locale)}</a></li>
    </#list>
    </ul>
</#if>
