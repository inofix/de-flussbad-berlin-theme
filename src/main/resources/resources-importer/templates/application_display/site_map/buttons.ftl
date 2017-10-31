<#--
    buttons.ftl: a buttons style for the site-map portlet.
    
    Created:    2017-04-16 14:53 by Christian Berndt
    Modified:   2017-10-31 23:01 by Christian Berndt
    Version:    1.0.3
-->

<#-- Loop over the configured layouts -->
<#if entries?has_content>
    <div class="buttons wrapper">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-4">
                    <ul>
                    <#list entries as curLayout>
                    
                        <#assign cssClass = "" />
                        <#if curLayout.layoutId == layout.layoutId>
                            <#assign cssClass = "current selected" />
                        </#if>
                        
                        <#assign layoutURL = portalUtil.getLayoutURL(curLayout, themeDisplay) />
                        <#if keywords?has_content>
                            <#assign layoutURL = httpUtil.addParameter(layoutURL, "_3_keywords", keywords) />
                            <#assign layoutURL = httpUtil.addParameter(layoutURL, "p_p_id", "3") />
                            <#assign layoutURL = httpUtil.addParameter(layoutURL, "_3_struts_action", "/search/search") />
                        </#if>                  
                        
                        <#if !curLayout.hidden>                    
                            <li><a href="${layoutURL}" class="${cssClass}">${curLayout.getName(locale)}</a></li>
                        </#if>
                    </#list>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <div class="toggle">
        <div class="toggle-button">+</div>
    </div>
</#if>
