<#--
    buttons.ftl: a buttons style for the categories navigation portlet.
    
    Created:    2017-04-14 16:49 by Christian Berndt
    Modified:   2017-09-15 22:46 by Christian Berndt
    Version:    1.0.1
-->

<#assign categoryId = paramUtil.getString(request, "categoryId") />

<#-- Loop over the configured vocabularies -->
<#if entries?has_content>
    <#list entries as entry>
        <#assign categories = entry.getCategories()>

        <@displayCategories categories=categories />
    </#list>
</#if>

<#-- Loop over the vocabulary's categories -->

<#macro displayCategories categories>
    <#if categories?has_content>
        <div class="wrapper">
            <div class="container">
                <div class="span8 offset4">
                    <ul class="categories">
                        <#list categories as category>
                            <li>
                                <#assign categoryURL = renderResponse.createRenderURL() />
                                <#assign cssClass = "" />
                                
                                <#if category.categoryId?string == categoryId >
                                    <#assign cssClass="selected"/>
                                    ${categoryURL.setParameter("categoryId", "")}                                                    
                                <#else>
                                    ${categoryURL.setParameter("categoryId", category.getCategoryId()?string)}                        
                                </#if>
                                
                                ${categoryURL.setParameter("resetCur", "true")}
            
                                <a href="${categoryURL}" class="${cssClass}">${category.getName()}</a>
            
                            </li>
                        </#list>
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="toggle">
            <div class="toggle-button">+</div>
        </div>
    </#if>
</#macro>
